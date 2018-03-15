pragma solidity ^0.4.18;

import "./IncrementCounter.sol";
contract IncrementCounterPhaseTwo is IncrementCounter {
  function increaseCounter(address _storage) validStorage(_storage) public returns (uint) {
    UIntStorage counter = UIntStorage(_storage);
    return counter.setValue(counter.getValue() + 10);
  }
}