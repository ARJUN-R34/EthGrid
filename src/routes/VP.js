var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/login', function (req, res, next) {
    res.render('vplogin');
});

router.post('/vpdashboard', function (req, res, next) {

    var name = req.body.name;
    var address = req.body.address;

    console.log("The name is : ", name);
    console.log("The address is : ", address);

    Contract.methods.getVP(address).call({from: coinbase}).then((val) => {
        console.log("The transaction details are : ", val);

        if (name == val._name && address == val._addressVP) {
            console.log("Login Successful");
            res.render('vpdashboard');
        } else {
            console.log("Error");
            res.render('vplogin');
        }
    });
});

router.get('/addnode' , function (req, res) {
    res.render('addnode');
});

router.get('/transfer' , function (req, res) {
    res.render('transfer');
});

router.post('/addnode' , function (req, res) {
    var nodeaddress = req.body.nodeaddress;
    var name = req.body.name;
    
    console.log("The address of the node to be added is : " , nodeaddress);
    console.log("The name of the node to be added is : " , name);

    Contract.methods.createNode(name, nodeaddress).send({from : coinbase , gas: 6000000}).then((val) => {
        console.log("The transaction details are : " , val);
        console.log("");
        console.log("The node is added successfully");
        res.render('vpdashboard');
    });

});

router.post('/transfer' , function (req, res) {

    var recepient = req.body.recepient;
    var transferer = req.body.transferer;
    var power = req.body.power;

    console.log("The Transferer's Address is : " , transferer);
    console.log("The Receiver's Address is : " , recepient);
    console.log("The amount of power transferred is : " , power);

    Contract.methods.transferPower(transferer,recepient, power).send({from : coinbase, gas: 600000}).then((val) => {
        console.log("The transaction details are : " , val);
        console.log("");
        console.log("The power is transferred successfully....!!");
        res.render('vpdashboard');
    });

});

router.get('/transferreq' , function (req, res) {
    res.render('transferreq');
});

router.post('/giver' , function (req, res) {

    var giver = req.body.giver;
    console.log("The Giver's address is : " , giver);

    Contract.methods.giveRequest(giver).call({from : coinbase}).then((val) => {
        console.log("The transaction details are : " , val);
        res.render('transferreq' , { giverAdd: val.nodeAddress, giverPower: val.powerUnits, receiverAdd: " ", receiverPower: " " });
        console.log("Giver Query Successful");
    });

});

router.post('/receiver', function (req, res) {

    var receiver = req.body.receiver;
    console.log("The Receiver's address is : ", receiver);

    Contract.methods.needRequest(receiver).call({
        from: coinbase
    }).then((val) => {
        console.log("The transaction details are : ", val);
        res.render('transferreq', {
            receiverAdd: val.nodeAddress,
            receiverPower: val.powerUnits,
            giverAdd : " ",
            giverPower : " "
        });
        console.log("Receiver Query Successful");
    });

});

module.exports = router;
