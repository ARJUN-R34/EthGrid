# EthGrid

## Application of the project

EthGrid is an Electricity Grid application built on Blockchain with a centrally controlled entity called VP who has higher privileges than other nodes which helps maintain some control on the entire system.

## Getting Started

### Prerequisites

Ensure you install the following prerequisites before running the app.
Run these commands from the project root directory.

```
sudo apt-get update
```
```
sudo apt-get install nodejs
```
```
npm install -g nodemon
```
Go to project folder
```
cd EthGrid
```
```
npm install web3@1.0.0-beta.48
```
```
npm install -g ganache-cli
```
```
npm install -g truffle
```
Install the required dependencies using 
```
npm install
```
To start our private chain using ganache-cli with 10 accounts in the "node" folder, run,
```
ganache-cli -i 12345
```
Open another console in the root directory and run the below command to start the node server,
```
nodemon start
```

Open your browser and go to localhost:3000 to interact with the app.