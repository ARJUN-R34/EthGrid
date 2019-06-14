pragma solidity ^0.5.0;

contract SmartGrid {
    
    //State Variables
    uint public nodeCount;
    address public VPaddress;
    uint private givePowerAmount;
    uint private requestPowerAmount;
    
    //Structure for storing Node Info
    struct Node {
        string name;
        address nodeAddress;
    }
    
    struct nodeDetails{
        uint count;
        address fromAddress;
        address toAddress;
        uint amount;
    }
    
    //Structure for storing VP Info
    struct VP {
        string name;
        address VPaddress;
    }
    
    //Structure for storing information of the nodes giving power
    struct NodePowerGive {
        address nodeAddress;
        uint powerUnits;
    }
    
    //Structure for storing information of the nodes requesting for power
    struct NodePowerNeed {
        address nodeAddress;
        uint powerUnits;
    }
    
    //Mappings
    mapping(uint => Node) public nodes;
    
    mapping(address => Node) nodeInfo;
    
    mapping(address => NodePowerGive) public giveRequest;
    
    mapping(address => NodePowerNeed) public needRequest;
    
    mapping(address => VP) VPinfo;
    
    mapping(address => mapping(uint => nodeDetails)) nodeDetailsList;
    
    //Modifiers
    modifier onlyVP() {
        require(msg.sender == VPaddress);
        _;
    }
    
    //Constructor to assign the contract initialising address as the VP
    constructor() public {
        VPaddress = msg.sender;
        VPinfo[VPaddress].name = "Grid_Admin";
        VPinfo[VPaddress].VPaddress = VPaddress;
    }
    
    //Function to create a node
    function createNode(string memory _name, address _nodeAddress) public onlyVP returns(bool) {
        nodeCount++;
        nodes[nodeCount] = Node(_name, _nodeAddress);
        nodeInfo[_nodeAddress] = Node(_name, _nodeAddress);
        return true;
    }
    
    //Function to get the Node details
    function getNode(address _address) public view returns(string memory _name, address _addressNode) {
        return (_name = nodeInfo[_address].name, _addressNode = nodeInfo[_address].nodeAddress);
    }
    
    //Function to get VP details
    function getVP(address _address) public view returns(string memory _name, address _addressVP) {
        return (_name = VPinfo[_address].name, _addressVP = VPinfo[_address].VPaddress);
    }
    
    //Function to donate power
    function donatePower(address _address, uint _power) public returns(bool) {
        require(msg.sender == _address);
        givePowerAmount = giveRequest[_address].powerUnits;
        if(givePowerAmount != 0) {
            _power = givePowerAmount + _power;
            giveRequest[_address] = NodePowerGive(_address, _power);
        }
        else {
            giveRequest[_address] = NodePowerGive(_address, _power);
        }
        
        return true;
    } 
    
    //Function to request for power
    function requirePower(address _address, uint _power) public returns(bool) {
        require(msg.sender == _address);
        requestPowerAmount = needRequest[_address].powerUnits;
        if(requestPowerAmount != 0) {
            _power = _power + requestPowerAmount;
            needRequest[_address] = NodePowerNeed(_address, _power);
        }
        else {
        needRequest[_address] = NodePowerNeed(_address, _power);
        }
        
        return true;
    }
    
    //Function to transfer the power
    function transferPower(address _senderAddress, address _recipientAddress, uint _power) public onlyVP returns(bool) {
        require(_senderAddress != _recipientAddress);
        require(giveRequest[_senderAddress].powerUnits >= _power);
        require(needRequest[_recipientAddress].powerUnits != 0);
        uint temp_count;
        giveRequest[_senderAddress].powerUnits = giveRequest[_senderAddress].powerUnits - _power;
        needRequest[_recipientAddress].powerUnits = needRequest[_recipientAddress].powerUnits - _power;
        temp_count = nodeDetailsList[_senderAddress][0].count;
        temp_count++;
        nodeDetailsList[_senderAddress][temp_count].fromAddress = _senderAddress;
        nodeDetailsList[_senderAddress][temp_count].toAddress = _recipientAddress;
        nodeDetailsList[_senderAddress][temp_count].amount = _power;
        nodeDetailsList[_senderAddress][0].count++;
        
        return true;
    }
    
    //Function to retrieve Node Details
    function getNodeDetailsList(address _fromAddress, uint temp) public view returns(address fromAddress, address toAddress, uint amount,uint count) {
        count = nodeDetailsList[_fromAddress][0].count;
        fromAddress = nodeDetailsList[_fromAddress][temp].fromAddress;
        toAddress = nodeDetailsList[_fromAddress][temp].toAddress;
        amount = nodeDetailsList[_fromAddress][temp].amount;
        
    }
    
}