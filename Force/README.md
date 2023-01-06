# Force Solution

Create the ForceEtherIn in Contract as a way to attack the Force Contract

So copy and paste the code from Force.sol into remix and deploy the ForceEtherIn contract with the address of your instance of the Force Contract as the argument for the contstructor

Then once it's deployed send any amount of ether to the ForceEtherIn contract. 

Then call the sendEther() function so that way we selfdestruct the ForceEtherIn contract and force ether to be sent to the Force contract. 

How selfdestruct [works](https://docs.soliditylang.org/en/develop/units-and-global-variables.html) scroll to the bottom of the link for the selfdestruct description.


