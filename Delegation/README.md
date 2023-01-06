# Delegation Solution

First run the following
```
web3.utils.soliditySha3("pwn()")
```
Or you can run 
``` 
web3.utils.sha3("pwn()")
```
To get the hexadecimal of the function call for the pwn() function which should look like this ```0xdd365b8b15d5d78ec041b851b68c8b985bee78bee0b87c4acf261024d8beabab``` or a shortened version of only the first 4 bytes```0xdd365b8b```

We can then take the first 4 bytes(8 digits/characters) of the hexadecimal not including the ```0x``` at the beginning

And set this as the ```msg.data``` that we will send along with our transaction in the following code that we will run. 

msg.data will be readable as a function call by what i believe is the EVM, and it will then know that pwn() is the function that we want to run from our delegatecall which will be explained later...

Run the following

```
await contract.sendTransaction({from: player, data: "0xdd365b8b"})
``` 
What this does is call the fallback function since there is no function pwn() in Delegation contract and the rule of a fallback function is that it will be called when
* contract received ether and no data
* contract received data but no function matched the function called <--- this is the reason for why the fallback function is getting called in this situation

 After hitting the fallback function it will run ```(bool result,) = address(delegate).delegatecall(msg.data);``` which will call the Delegate contract.

 It's important to not that it uses ```.delegatecall``` here since it's slightly different from ```.call``` 

Explanation of [delegate call](https://docs.soliditylang.org/en/v0.8.0/types.html?highlight=delegatecall#members-of-addresses)

The only difference between ```call``` and ```delegatecall``` is that the delegate call function sends in a different msg context meaning if we used call above for the Delegation fallback() function, ```msg.sender``` would equal the address of the Delegation contract not the address of player from ```await contract.sendTransaction({from: player, data: "0xdd365b8b"})``` 

This means that that delegate call keeps the context of the first Contract( in this case Delegation ) including (storage, balance, msg.sender...)... IMPORTANT it doesnt include msg.value as a value that can be sent with delegatecall()

From [soliditylang](https://docs.soliditylang.org/en/v0.8.0/types.html?highlight=delegatecall#members-of-addresses): the difference is that only the code of the given address is used, all other aspects (storage, balance, …) are taken from the current contract. The purpose of delegatecall is to use library code which is stored in another contract. The user has to ensure that the layout of storage in both contracts is suitable for delegatecall to be used.

Run 
```
await contract.owner()
``` 
To check if you are the owner. Then submit your instance!