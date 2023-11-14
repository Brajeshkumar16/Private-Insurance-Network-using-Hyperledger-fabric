# Private-Healthcare-Insurance-Network-using-Hyperledger-fabric

## How to run this network 

First, you have to download all the pre-requisite for hyperledger fabric

Here I am using docker contener, so insure that your system have docker container.

sudo service --status-all 

sudo service docker start

./network.sh up createChannel -ca -c InsuranceChain -s couchdb

./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go

### when you run this command their are five organization are created

AceHospitals,
OakHospitals,
AkanshaInsurance,
LifecareInsurance,
DiagnosticCentre

Two hospital two insurance and one digonistic center are created

## Under the hospital 
five peers are created 
DoctorPeer,
NursePeer,
AnchDoctor,
EndorsStaff,
AdmissionsPeer,

## Under the Insurance organization ther are three peers are created
InsuranceEndorser
InsuranceCommitters
InsuranceAnchors


Accourding to your useas you can write your own chaincode and deploy on this network

Thank you
