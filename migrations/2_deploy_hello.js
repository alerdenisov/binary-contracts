const Greetener = artifacts.require('./Greetener.sol')

module.exports = function (deployer) {
  deployer.deploy(Greetener)
}
