var transaction = artifacts.require("Transaction");

module.exports = function(deployer) {
  deployer.deploy(transaction);
};