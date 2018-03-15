const Creature = artifacts.require('./Creature.sol')
const DumbOrc = artifacts.require('./DumbOrc.sol')
const GodDammitCreature = artifacts.require('./GodDammitCreature.sol')

const { Interface, utils } = require('ethers')

module.exports = function () {
  const creatureInterface = new Interface(Creature.abi)
  const takeDamageDescription = creatureInterface.functions.takeDamage(150)
  console.log('output takeDamage description with amount 150:')
  console.log(takeDamageDescription)
  console.log('')
  console.log('')
  console.log(`output keccak256 of signature [${takeDamageDescription.signature}]`)
  console.log(utils.keccak256(utils.toUtf8Bytes(takeDamageDescription.signature)))
  console.log(utils.keccak256(utils.toUtf8Bytes(takeDamageDescription.signature)).substr(0, 10))

  console.log(`output hex of uint256 equals to 150:`)
  console.log(utils.solidityPack(['uint256'], [150]))
}