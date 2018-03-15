const Son = artifacts.require('./Son.sol')

module.exports = async function () {
  const son = await Son.new()
  const tx = await son.goToHome()

  console.log(tx.logs.map(log => log.event).join('\n'))
}