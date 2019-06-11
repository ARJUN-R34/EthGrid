const Contract = artifacts.require("SmartGrid");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(Contract);
};
