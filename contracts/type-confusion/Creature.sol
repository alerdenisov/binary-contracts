pragma solidity 0.4.19;

contract Creature {
  uint public health;

  event TakeDamage(address indexed _attacker, uint amount);
  event Die(address indexed _killer);

  function takeDamage(uint amount) public {
    if (health > amount) {
      health -= amount;
      TakeDamage(msg.sender, amount);
    } else {
      health = 0;
      Die(msg.sender);
    }
  }
}