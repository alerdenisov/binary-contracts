pragma solidity 0.4.19;

import "./Creature.sol";

contract DumbOrc is Creature {
  uint public damage = 500;

  function DumbOrc() public {
    health = 150;
  }

  function Attack(address _victim) public {
    Creature(_victim).takeDamage(damage);
  }
}