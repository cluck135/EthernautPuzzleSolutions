# Re-entrancy Solution

It's important to aknowledge that solidity is Asynchronous. so when the line ```(bool result,) = msg.sender.call{value:_amoun("");``` is hit it has to run that call and run fully through till it's done then it will go to the next line... which means we can put whatever we want on the other end of that call ;)

So copy and paste the code from Re-entrancy.sol into remixIDE. and Deploy Draino with a value of 0.001 ether(for the donateIt function to run) and with the address of your Reentrance contract instance inputed where it says ```INSERT_YOUR_INSTANCE_ADDRESS```... you could also deploy it with no value sent along and instead just seed it after deployment. Now this will trigger the fallback function but it won't succeed in a reentrancy attack since you haven't made a donation yet and the ```if(balances[msg.sender] >= _amount) ``` will fail.

Then run the donateIt function from the deployed Draino contract in Remix to make it so you do pass the above if statement

Then send some ether or none (since it will trigger the fallback with or without any ether sent) to your Draino contract address to trigger the fallback function which will then call the withdraw function from the Reentrance contract. In the withdraw function it will hit ```(bool result,) = msg.sender.call{value:_amoun("");``` and trigger the Draino fallback function again thus causing a recursive attack of draining the Reentrance contract till the balance reaches 0  ```if(address(reenter).balance != 0) ```

Submit your instance!

Sooo what we can learn from this is that in the future .call method should not be used to withdraw funds as it doesnt have a gas limit to just run the transfer of funds like a .transfer method would. In the future it is much more safe to use .send or .transfer

edit: after further reasearch it looks like transfer/send may not be the best solution as the gas limit is set to 2300 which in the future may not be enough to cover a transfer of funds. so using the solution from [here](https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/) would be better as it sets the msg.sender balance to 0 after getting the amount to send. this means that if reentrancy occurs the amount sent back to the malicious contract will be 0 on the second time around. Thus stopping a reentrancy attack from occuring.


