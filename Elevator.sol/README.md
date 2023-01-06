# Elevator Solution

So this one is pretty simple as long as you understand [interfaces](https://medium.com/coinmonks/solidity-tutorial-all-about-interfaces-f547d2869499#:~:text=.Status%20kitchen%3B%7D-,Interfaces%20and%20Inheritance,with%20their%20own%20function%20definitions.) which in very basic terms are like the setup for what should be inputted into a function and what the output of the function will be. But they do not define what the function will do, so kinda like a light switch where you input a motion to flip the switch (bool input) and expect an output of the light being turned on which would be a boolean return value. But you have no idea how it did it since you can't see the wiring behind it. All the interface cares about is that contracts that inherits it follows the template, but it doesn't care how it's done. 

Since this is the case we can take advantage of this and manipulate the isLastFloor function to our needs. 

In the goTo function of the Elevator contract we can see it sets up the building variable as an instance of the Building Interface ```Building building = Building(msg.sender);```, so we need to make sure that when we call goTo it's origin is from a malicious smart contract that inherits the Building Interface. Thus we created the HackElevator contract.

So copy and paste the code into remix and deploy the HackElevator contract.

Then simply just call goToFloor with the address of your Elevator contract instance as the input

This will call the goTo function which will then call back to our funcition at isLastFloor where we have some basic logic that will return false on the first call for ``` if (! building.isLastFloor(_floor)) ``` then on the second call ```top = building.isLastFloor(floor);```  it will return true and set top = true;

Then run 
``` await contract.top()``` 
To see if top is equal to true

If it is then it worked!

Submit your instance!