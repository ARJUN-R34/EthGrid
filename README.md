# EthGrid

## Application of the project

EthGrid is an Electricity Grid application built on Blockchain with a centrally controlled entity called VP who has higher privileges than other nodes which helps maintain some control on the entire system.

## Getting Started

### Prerequisites

Open a terminal in any directory and run
```
git clone https://github.com/ARJUN-R34/EthGrid.git 
```

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
```
npm install -g ganache-cli
```
```
npm install -g truffle
```

Go to project folder
```
cd EthGrid
```
To start our private chain using ganache-cli with 10 accounts in the "node" folder, run,
```
ganache-cli -i 12345
```

Open another terminal in the root directory and run
```
cd src
```
Install the required dependencies using 
```
npm install
```
```
nodemon start
```

Open another terminal and run
```
truffle migrate
```

Open your browser and go to localhost:3000 to interact with the app.