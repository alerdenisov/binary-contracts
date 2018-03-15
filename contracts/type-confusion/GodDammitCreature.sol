pragma solidity 0.4.19;

interface Creature {
  function takeDamage(uint amount) public;
}

contract GodDammitCreature {
  function () public {
    Creature(msg.sender).takeDamage(9000);
  }
}