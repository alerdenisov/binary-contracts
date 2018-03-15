pragma solidity 0.4.19;

contract Parent {
  event ParentPick();

  function pickFromKindergarten() internal {
    ParentPick();
  }
}

contract Mother is Parent {
  event MomPick();

  function pickFromKindergarten() internal {
    MomPick();
    super.pickFromKindergarten();
  }
}

contract Dad is Parent {
  event DadPick();

  function pickFromKindergarten() internal {
    DadPick();
    super.pickFromKindergarten();
  }
}

contract Son is Mother, Dad {
  function goToHome() public {
    super.pickFromKindergarten();
  }
}