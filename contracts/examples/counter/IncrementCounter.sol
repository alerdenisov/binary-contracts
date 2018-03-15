pragma solidity ^0.4.18;

import "./ICounter.sol";
import "../../base/UIntStorage.sol";

/// @title Incremental implementation of counter for explanation external storage pattern
/// @author Aler Denisov
contract IncrementCounter is ICounter, Ownable {
  /// @notice Method modifier to ensure providen storage is UIntStorage
  /// @param _storage Instance of uint storage of counter
  /// @dev Throw error if storage isn't valid
  modifier validStorage(address _storage) {
    require(validateStorage(_storage));
    _;
  }
  function increaseCounter(address _storage) onlyOwner validStorage(_storage) public returns (uint) {
    UIntStorage counter = UIntStorage(_storage);
    return counter.setValue(counter.getValue() + 1);
  }
  function getCounter(address _storage) validStorage(_storage) public view returns (uint) {
    UIntStorage counter = UIntStorage(_storage);
    return counter.getValue();
  }
  function validateStorage(address _storage) public view returns (bool) {
    return UIntStorage(_storage).isUIntStorage();
  }
  function transferStorage(address _storage, address _counter) onlyOwner validStorage(_storage) public returns (bool) {
    UIntStorage(_storage).transferOwnership(_counter);
    return true;
  }
}