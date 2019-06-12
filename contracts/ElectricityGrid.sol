pragma solidity ^0.5.0;

contract SmartGrid {
    
    //State Variables
    uint public nodeCount;
    address public VPaddress;
    uint private temp_power;
     uint private temp_power2;
    
    //Structure for storing Node Info
    struct Node {
        string name;
        address nodeAddress;
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
    
    mapping(address => Node) public nodeInfo;
    
    mapping(address => NodePowerGive) public giveRequest;
    
    mapping(address => NodePowerNeed) public needRequest;
    
    mapping(address => VP) VPinfo;
    
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
    
    //Function to request to donate power
    function donatePower(address _address, uint _power) public returns(bool) {
        require(msg.sender == _address);
        temp_power = giveRequest[_address].powerUnits;
        if(temp_power!=0){_power = temp_power+_power;
            giveRequest[_address] = NodePowerGive(_address, _power);
        }
        else{
        giveRequest[_address] = NodePowerGive(_address, _power);}
        return true;
    } 
    
    //Function to request for power
    function requirePower(address _address, uint _power) public returns(bool) {
        require(msg.sender == _address);
        temp_power2 = needRequest[_address].powerUnits;
        if(temp_power2!=0){
            _power = _power + temp_power2;
            needRequest[_address] = NodePowerNeed(_address, _power);}else{
        needRequest[_address] = NodePowerNeed(_address, _power);}
        return true;
    }
    
    //Function to transfer the power
    function transferPower(address _senderAddress, address _recipientAddress, uint _power) public onlyVP returns(bool) {
        require(_senderAddress != _recipientAddress);
        require(giveRequest[_senderAddress].powerUnits >= _power);
        giveRequest[_senderAddress].powerUnits = giveRequest[_senderAddress].powerUnits - _power;
        needRequest[_recipientAddress].powerUnits = needRequest[_recipientAddress].powerUnits - _power;
        return true;
    }
    
}