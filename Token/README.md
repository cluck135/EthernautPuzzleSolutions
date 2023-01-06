# Token solution

Since uint cannot be negative you can run 
```
await contract.transfer("random wallet address thats not yours","21")
```

This will pass the require statement ```require(balances[msg.sender] - _value >= 0);```. since when you minus uint 21 from uint 20(your token balance) it will overflow and start at the top of the maximum value allowed for a uint which can be explained [here](https://ethereum.stackexchange.com/questions/29946/what-is-uint256)

Then when it hits ```balances[msg.sender] -= _value;``` it will give you the overflow amount which is some ridiculously high number

Then when it hits ```balances[_to] += _value;``` it will only give them 21 tokens so you obviously win a lot more.

Check your balance and see your ridiculous amount of tokens!
```
await contract.balanceOf(player)
```

Submit your instance!

