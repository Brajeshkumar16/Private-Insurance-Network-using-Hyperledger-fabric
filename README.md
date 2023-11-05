# Private-Healthcare-Insurance-Network-using-Hyperledger-fabric

## How to run this network 

First, you have to download all the pre-requisite for hyperledger fabric

Here I am using docker contener. 

sudo service --status-all 

sudo service docker start

./network.sh up createChannel -ca -c InsuranceChain -s couchdb

./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go

and accourding to use you can use
