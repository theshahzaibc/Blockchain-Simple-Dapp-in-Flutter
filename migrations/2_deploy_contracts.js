const Drug = artifacts.require("Drug");
  
module.exports = function (deployer) {
  deployer.deploy(Drug);
};