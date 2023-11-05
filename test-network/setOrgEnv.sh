#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using Org1
ORG=${1:-Ace}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
PEER0_Ace_CA=${DIR}/test-network/organizations/peerOrganizations/AceHospitals/tlsca/tlsca.AceHospitals-cert.pem
PEER0_Oak_CA=${DIR}/test-network/organizations/peerOrganizations/OakHospitals/tlsca/tlsca.OakHospitals-cert.pem
PEER0_Akansha_CA=${DIR}/test-network/organizations/peerOrganizations/AkanshaInsurance/tlsca/tlsca.AkanshaInsurance-cert.pem
PEER0_Lifecare_CA=${DIR}/test-network/organizations/peerOrganizations/LifecareInsurance/tlsca/tlsca.LifecareInsurance-cert.pem
PEER0_Diagnostic_CA=${DIR}/test-network/organizations/peerOrganizations/DiagnosticCentre/tlsca/tlsca.DiagnosticCentre-cert.pem


if [[ ${ORG,,} == "Ace" || ${ORG,,} == "AceHospitals" ]]; then

   CORE_PEER_LOCALMSPID=AceMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/AceHospitals/users/Admin@AceHospitals/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/AceHospitals/tlsca/tlsca.AceHospitals-cert.pem

elif [[ ${ORG,,} == "Oak" || ${ORG,,} == "OakHospitals" ]]; then

   CORE_PEER_LOCALMSPID=OakMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/OakHospitals/users/Admin@OakHospitals/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/OakHospitals/tlsca/tlsca.OakHospitals-cert.pem

elif [[ ${ORG,,} == "Akansha" || ${ORG,,} == "AkanshaInsurance" ]]; then

   CORE_PEER_LOCALMSPID=AkanshaMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/AkanshaInsurance/users/Admin@AkanshaInsurance/msp
   CORE_PEER_ADDRESS=localhost:6051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/AkanshaInsurance/tlsca/tlsca.AkanshaInsurance-cert.pem

elif [[ ${ORG,,} == "Lifecare" || ${ORG,,} == "LifecareInsurance" ]]; then

   CORE_PEER_LOCALMSPID=LifecareMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/LifecareInsurance/users/Admin@LifecareInsurance/msp
   CORE_PEER_ADDRESS=localhost:4051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/LifecareInsurance/tlsca/tlsca.LifecareInsurance-cert.pem

elif [[ ${ORG,,} == "Diagnostic" || ${ORG,,} == "DiagnosticCentre" ]]; then

   CORE_PEER_LOCALMSPID=DiagnosticMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/DiagnosticCentre/users/Admin@DiagnosticCentre/msp
   CORE_PEER_ADDRESS=localhost:3051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/DiagnosticCentre/tlsca/tlsca.DiagnosticCentre-cert.pem


else
   echo "Unknown \"$ORG\", please choose any of the organizations"
   echo "For example to get the environment variables to set up an Org shell environment run:  ./setOrgEnv.sh Oak or ./setOrgEnv.sh Akansha or ./setOrgEnv.sh Lifecare or ./setOrgEnv.sh Diagnostic"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo 'export $(./setOrgEnv.sh Oak | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_Ace_CA=${PEER0_Ace_CA}"
echo "PEER0_Oak_CA=${PEER0_Oak_CA}"
echo "PEER0_Akansha_CA=${PEER0_Akansha_CA}"
echo "PEER0_Lifecare_CA=${PEER0_Lifecare_CA}"
echo "PEER0_Diagnostic_CA=${PEER0_Diagnostic_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
