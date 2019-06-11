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

    Contract.methods.getVP(address).call({
        from: coinbase
    }).then((val) => {
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

module.exports = router;
