pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./ICounter.sol";
import "../../base/UIntStorage.sol";
contract CounterController is Ownable {
  UIntStorage public store = new UIntStorage();
  ICounter public counter;
  event CounterUpdate(address previousCounter, address nextCounter);
  function updateCounter(address _counter) 
    onlyOwner
    public returns (bool) 
  {
    if (address(counter) != 0x0) {
      counter.transferStorage(store, _counter);
    } else {
      store.transferOwnership(_counter);
    }

    CounterUpdate(counter, _counter);
    counter = ICounter(_counter);
  }
  function increaseCounter() public returns (uint) {
    return counter.increaseCounter(store);
  }
  function getCounter() public view returns (uint) {
    return counter.getCounter(store);
  }
}