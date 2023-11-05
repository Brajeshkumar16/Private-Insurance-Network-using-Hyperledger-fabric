#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp1 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/AceHospitals.json
}

function yaml_ccp1 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-templateAce.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

function json_ccp2 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/OakHospitals.json
}

function yaml_ccp2 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-templateOak.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

function json_ccp3 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/AkanshaInsurance.json
}

function yaml_ccp3 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-templateAkansha.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

function json_ccp4 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/LifecareInsurance.json
}

function yaml_ccp4 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-templateLifecare.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

function json_ccp5 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/DiagnosticCentre.json
}

function yaml_ccp5 {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-templateDiagnostic.yaml | sed -e $'s/\\\\n/\\\n          /g'
}


ORG=1
P0PORT=7055
CAPORT=7054
PEERPEM=organizations/peerOrganizations/AceHospitals/tlsca/tlsca.AceHospitals-cert.pem
CAPEM=organizations/peerOrganizations/AceHospitals/ca/ca.AceHospitals-cert.pem

echo "$(json_ccp1 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/AceHospitals/connection-Ace.json
echo "$(yaml_ccp1 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/AceHospitals/connection-Ace.yaml

ORG=2
P0PORT=9051
CAPORT=9054
PEERPEM=organizations/peerOrganizations/OakHospitals/tlsca/tlsca.OakHospitals-cert.pem
CAPEM=organizations/peerOrganizations/OakHospitals/ca/ca.OakHospitals-cert.pem

echo "$(json_ccp2 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/OakHospitals/connection-Oak.json
echo "$(yaml_ccp2 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/OakHospitals/connection-Oak.yaml


ORG=3
P0PORT=6051
CAPORT=6054
PEERPEM=organizations/peerOrganizations/AkanshaInsurance/tlsca/tlsca.AkanshaInsurance-cert.pem
CAPEM=organizations/peerOrganizations/AkanshaInsurance/ca/ca.AkanshaInsurance-cert.pem

echo "$(json_ccp3 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/AkanshaInsurance/connection-Akansha.json
echo "$(yaml_ccp3 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/AkanshaInsurance/connection-Akansha.yaml

ORG=4
P0PORT=4051
CAPORT=4054
PEERPEM=organizations/peerOrganizations/LifecareInsurance/tlsca/tlsca.LifecareInsurance-cert.pem
CAPEM=organizations/peerOrganizations/LifecareInsurance/ca/ca.LifecareInsurance-cert.pem

echo "$(json_ccp4 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/LifecareInsurance/connection-Lifecare.json
echo "$(yaml_ccp4 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/LifecareInsurance/connection-Lifecare.yaml


ORG=5
P0PORT=3051
CAPORT=3054
PEERPEM=organizations/peerOrganizations/DiagnosticCentre/tlsca/tlsca.DiagnosticCentre-cert.pem
CAPEM=organizations/peerOrganizations/DiagnosticCentre/ca/ca.DiagnosticCentre-cert.pem

echo "$(json_ccp5 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/DiagnosticCentre/connection-Diagnostic.json
echo "$(yaml_ccp5 $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/DiagnosticCentre/connection-Diagnostic.yaml


