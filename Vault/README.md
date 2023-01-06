# Vault Solution

To solve this you have to understand smart contract fundamentals and how their storage works.

Smart contracts all have storage for their variables and functions which are in the format of an array.

So storage for the Vault contract at index 0 would be equal to whatever locked is equal to in hexadecimal form... since it is a bool it would end in either 0 or 1

For password it will be at index 1

We can use web3 to get the storage at index 1 for the contract by running 
```
web3.eth.getStorageAt("address of instance of contract", 1)
```

Then we can take the hexadecimal it returns and insert it into the unlock function call
```
await contract.unlock("password hexadecimal string")
```

Then the contract should be unlocked and you can check by running 
```
web3.eth.getStorageAt("address of instance of contract", 0)
```
To get the value of locked which should now be a hexadecimal ending in 0 meaning its false so its not locked

Now something extra you can do is run the following to see what the password was in a ascii format
```
web3.utils.hexToAscii("password hexadecimal string")
```
and you will see A very strong secret password :)


Submit your instance!