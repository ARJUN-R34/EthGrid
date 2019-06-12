var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var Web3 = require('web3');

var web3 = new Web3('http://localhost:8545');

var MyContractJSON = require(path.join(__dirname, '../build/contracts/SmartGrid.json'));

var app = express();

coinbase = "0x154329140528858d58d969f1f0f0503d95a60154";

const contractAddress = MyContractJSON.networks['12345'].address;

console.log("The Contract Address is : " , contractAddress);

const abi = MyContractJSON.abi;

Contract = new web3.eth.Contract(abi, contractAddress);

var indexRouter = require('./routes/index');
var nodeRouter = require('./routes/node');
var vpRouter = require('./routes/VP');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/node', nodeRouter);
app.use('/vp' , vpRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
