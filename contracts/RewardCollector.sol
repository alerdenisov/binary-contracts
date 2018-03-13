pragma solidity 0.4.19;
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract RewardCollector {
  using SafeMath for uint256;

  uint public part;
  address public lawyer;
  address public beneficiaries;
  uint public totalyRecovered;

  uint public lawyerConsumed;
  uint public beneficiariesConsumed;

  function RewardCollector(uint _lawyerPart, address _lawyerWallet, address _beneficiariesWallet) public {
    require(_lawyerPart < 10000);
    // Pro bono isn't require smart contract
    require(_lawyerPart > 0);
    
    part = _lawyerPart;
    lawyer = _lawyerWallet;
    beneficiaries = _beneficiariesWallet;
  }

  function () public payable {
    totalyRecovered = totalyRecovered.add(msg.value);
  }

  function withdraw (address _who) public {
    require(_who == lawyer || _who == beneficiaries);
    if (_who == lawyer) {
      withdrawLawyer();
    } else {
      withdrawBeneficiaries();
    }
  }

  function withdrawLawyer () public {
    uint left = totalyRecovered.sub(lawyerConsumed);
    require(left > 0);
    lawyerConsumed = totalyRecovered;
    lawyer.transfer(left.mul(part).div(10000));
  }

  function withdrawBeneficiaries () public {
    uint left = totalyRecovered.sub(beneficiariesConsumed);
    require(left > 0);
    beneficiariesConsumed = totalyRecovered;
    beneficiaries.transfer(left.mul(10000 - part).div(10000));
  }
}