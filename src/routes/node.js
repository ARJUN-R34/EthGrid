var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/login', function (req, res, next) {
    res.render('nodelogin');
});

router.post('/nodedashboard', function (req, res, next) {
    var name = req.body.name;
    var address = req.body.address;

    console.log("The name is : " , name);
    console.log("The address is : " , address);

    Contract.methods.getNode(address).call({from: address}).then((val) => {
        console.log("The transaction details are : " , val);

        if(name == val._name && address == val._addressNode) {
            console.log("Login Successful");
            res.render('nodedashboard', {address : address});
        }
        else {
            console.log("Error");
            res.render('nodelogin');
        }
    });
});

router.get('/send', function (req, res, next) {
    res.render('nodesend');
});

router.get('/request', function (req, res, next) {
    res.render('noderequest');
});

router.post('/send' , function (req, res) {

    var power = req.body.unit;
    var address = req.body.address;

    console.log("The amount of power ready to send is : " , power);

    Contract.methods.donatePower(address, power).send({from : address , gas : 600000}).then((val) => {
        console.log("The transaction details are : " , val);
        console.log("");
        console.log("The power donation request is sent successfully");
        res.render('nodedashboard' , { address });
    });

});

router.post('/request', function (req, res) {

    var power = req.body.unit;
    var address = req.body.address;

    console.log("The amount of power ready to send is : ", power);

    Contract.methods.requirePower(address, power).send({
        from: address,
        gas: 600000
    }).then((val) => {
        console.log("The transaction details are : ", val);
        console.log("");
        console.log("The power requirement request is sent successfully");
        res.render('nodedashboard', { address });
    });

});

router.get('/viewtx' , function(req, res) {
    res.render('nodeviewtx' , { from : "" , to : "" , amount : "" });
});

router.post('/viewtx' , function(req, res) {
    var address = req.body.from;
    var number = req.body.number;

    console.log("The sender address of the transaction is : " , address);
    console.log("The index number of this transaction is : " , number);

    Contract.methods.getNodeDetailsList(address,number).call({from : address}).then((val) => {
        console.log("The transaction details are : " , val);

        res.render('nodeviewtx' , {from : val.fromAddress , to : val.toAddress , amount : val.amount})
    });
});

module.exports = router;
