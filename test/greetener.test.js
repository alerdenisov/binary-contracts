const Greetener = artifacts.require('./Greetener.sol')

contract('Greetener', accounts => {
  it('Should be deployed', async() => {
    assert(await Greetener.deployed())
  })

  describe('Manipulate with contract', async() => {
    let GreetenerInstance
    beforeEach(async () => {
      GreetenerInstance = await Greetener.new()
    })

    it('Should allow to greet', async() => {
      assert(await GreetenerInstance.greet({ from: accounts[0] }))
    })

    it('Should change greeter', async() => {
      await GreetenerInstance.greet({ from: accounts[0] })
      assert.equal(accounts[0], await GreetenerInstance.lastestGreeter())
      await GreetenerInstance.greet({ from: accounts[1] })
      assert.equal(accounts[1], await GreetenerInstance.lastestGreeter())
    })

    it('Shoud fire event when greeter changes', async() => {
      const greetWatcher = GreetenerInstance.Greet()
      await GreetenerInstance.greet({ from: accounts[0] })
      const events = greetWatcher.get()
      assert.equal(1, events.length)
      assert.equal(accounts[0], events[0].args._who)
    })
  })
})