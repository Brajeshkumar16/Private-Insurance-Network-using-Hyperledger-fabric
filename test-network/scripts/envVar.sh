#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

# This is a collection of bash functions used by different scripts

# imports
. scripts/utils.sh

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
export PEER0_Ace_CA=${PWD}/organizations/peerOrganizations/AceHospitals/tlsca/tlsca.AceHospitals-cert.pem
export PEER0_Oak_CA=${PWD}/organizations/peerOrganizations/OakHospitals/tlsca/tlsca.OakHospitals-cert.pem
export PEER0_Akansha_CA=${PWD}/organizations/peerOrganizations/AkanshaInsurance/tlsca/tlsca.AkanshaInsurance-cert.pem
export PEER0_Lifecare_CA=${PWD}/organizations/peerOrganizations/LifecareInsurance/tlsca/tlsca.LifecareInsurance-cert.pem
export PEER0_Diagnostic_CA=${PWD}/organizations/peerOrganizations/DiagnosticCentre/tlsca/tlsca.DiagnosticCentre-cert.pem
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

# Set environment variables for the peer org
setGlobals() {
  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  infoln "Using organization ${USING_ORG}"
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_LOCALMSPID="AceMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Ace_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/AceHospitals/users/Admin@AceHospitals/msp
    export CORE_PEER_ADDRESS=localhost:7055

  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_LOCALMSPID="OakMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Oak_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/OakHospitals/users/Admin@OakHospitals/msp
    export CORE_PEER_ADDRESS=localhost:9051

  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_LOCALMSPID="AkanshaMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Akansha_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/AkanshaInsurance/users/Admin@AkanshaInsurance/msp
    export CORE_PEER_ADDRESS=localhost:6051
  
  elif [ $USING_ORG -eq 4 ]; then
    export CORE_PEER_LOCALMSPID="LifecareMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Lifecare_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/LifecareInsurance/users/Admin@LifecareInsurance/msp
    export CORE_PEER_ADDRESS=localhost:4051

  elif [ $USING_ORG -eq 5 ]; then
    export CORE_PEER_LOCALMSPID="DiagnosticMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_Diagnostic_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/DiagnosticCentre/users/Admin@DiagnosticCentre/msp
    export CORE_PEER_ADDRESS=localhost:3051

  else
    errorln "ORG Unknown"
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

# Set environment variables for use in the CLI container
setGlobalsCLI() {
  setGlobals $1

  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_ADDRESS=DoctorPeer:7055
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_ADDRESS=OakDoctorPeer:9051
  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_ADDRESS=AkanshaEndorser:6051
  elif [ $USING_ORG -eq 4 ]; then
    export CORE_PEER_ADDRESS=LifecareEndorser:4051
  elif [ $USING_ORG -eq 5 ]; then
    export CORE_PEER_ADDRESS=DiagnosticEndorser:3051
  else
    errorln "ORG Unknown"
  fi
}

# parsePeerConnectionParameters $@
# Helper function that sets the peer connection parameters for a chaincode
# operation
parsePeerConnectionParameters() {
  PEER_CONN_PARMS=()
  PEERS=""
  while [ "$#" -gt 0 ]; do
    setGlobals $1
    PEER="DoctorPeer$1"
    ## Set peer addresses
    if [ -z "$PEERS" ]
    then
	PEERS="$PEER"
    else
	PEERS="$PEERS $PEER"
    fi
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" --peerAddresses $CORE_PEER_ADDRESS)
    ## Set path to TLS certificate
    CA=Ace_CA
    TLSINFO=(--tlsRootCertFiles "${!CA}")
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" "${TLSINFO[@]}")
    # shift by one to get to the next organization
    shift
  done
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}
