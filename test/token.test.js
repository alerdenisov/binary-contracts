const DistrictToken = artifacts.require('./DistrictToken.sol')
const { expectThrow } = require('./utils.js')

function toToken (number) {
  return web3.toWei(number, 'ether')
}

contract('DistrictToken', accounts => {
  let token

  beforeEach(async () => {
    token = await DistrictToken.new()
  })

  describe('Hardcap test', async () => {
    it('Should have a hard cap', async () => {
      const hardCap = await token.HARDCAP()
      assert(hardCap.eq(toToken(1e9)))
    })

    it('Shouldnt mint more than hard cap', async () => {
      await token.mint(accounts[0], await token.HARDCAP(), { from: accounts[0] })
      await expectThrow(token.mint(accounts[0], 1, { from: accounts[0] }))
    })

    it('Shouldnt allow to mint non owner', async () => {
      await expectThrow(token.mint(accounts[0], 100000, { from: accounts[1] }))
    })

    it('Transfer tokens test', async () => {
      assert.fail()
    })
  })
})
