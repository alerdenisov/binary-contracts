const RewardCollector = artifacts.require('./RewardCollector.sol')

contract('Reward Collector', ([lawyer, benef, layer]) => {
  describe('creation', () => {
    it('should create contract', async () => {
      const rewardInstance = await RewardCollector.new(
        3000,
        lawyer,
        benef
      )
      assert(rewardInstance.address)
    })

    it('should reject more than 100%', async () => {
      assert.fail() // home work
    })

    // TODO: Другие тесты проверки результатов создания контракта
  })

  describe('execution', () => {
    let rewardInstance
    beforeEach(async () => {
      rewardInstance = await RewardCollector.new(3000, lawyer, benef)
    })

    it('should allow to send reward from layer', async () => {
      const balanceBefore = await web3.eth.getBalance(rewardInstance.address)
      assert(await rewardInstance.sendTransaction({
        value: web3.toWei(1, 'ether'),
        from: layer
      }))

      const balanceAfter = await web3.eth.getBalance(rewardInstance.address)
      assert.equal(balanceAfter.sub(balanceBefore).toNumber(), web3.toWei(1, 'ether'))

      assert.equal((await rewardInstance.totalyRecovered()).toNumber(), balanceAfter.toNumber())
    })

    it('should allow to withdraw laywer part', async () => {

      await rewardInstance.sendTransaction({
        value: web3.toWei(10, 'ether'),
        from: layer
      })
      
      const balanceBefore = await web3.eth.getBalance(lawyer)
      assert(await rewardInstance.withdrawLawyer())
      const balanceAfter = await web3.eth.getBalance(lawyer)
      assert.equal(balanceAfter.sub(balanceBefore).toNumber(), web3.toWei(3, 'ether'))
    })
  })
})