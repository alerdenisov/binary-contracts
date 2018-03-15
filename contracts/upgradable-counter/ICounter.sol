pragma solidity 0.4.19;

interface ICounter {
  function increaseCounter() public returns (uint);
  function getCounter() public view returns (uint);
}