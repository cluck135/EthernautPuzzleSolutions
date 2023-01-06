# King solution

After observing that the only way to make your address the king is by sending eth to trigger the receive function we can also assume that when we submit our instance they must use the same method. 

Since they are the owner too they can pass ```require(msg.value >= prize || msg.sender == owner);``` every time since it's an "or" statement which we can tell since it uses || operator

Then the owner can regain kingship by hitting the ```king = msg.sender```. This means we have to stop the it from hitting this line since this is certain to make it regain kingship as we cannot manipulate msg.sender

This means that the only point at which we have influence is at ```payable(king).transfer(msg.value);``` 

Well the issue here is our wallet will accept that transfer everytime since well its a wallet haha

BUTTT the problem is too break it so they can't regain kingship, we don't need to keep the position of king technically nor do we need to receive money since that isn't the problem to solve.

SOOOO we can create our own contract which will cause ```payable(king).transfer(msg.value);``` to fail thus it will never run ```king = msg.sender```

So to solve this do the following 

Copy King.sol into Remix

Deploy KingIsMine

Then Deploy AtAddress for the King contract with the address of your instance of the King contract as the input

Send some ether to the KingIsMine contract you deployed to seed it so it has funds to run claimKing and send more eth than the prize as well as cover gas. I sent in 0.01 and it worked for me

Then copy that same address of the King Contract and paste it into the input for the Deployed KingIsMine function call claimKing

Make sure to set the value to 1100000000000000 Wei (0.0011 ether) so that way we are sending more than the prize which is 0.001 eth

Then run the claimKing function by clicking it.

Make sure the gas limit is a bit higher I noticed 0.01 ether pretty much gurantee it to run as long as your contract does have funds more than the prize.

Check etherscan to see if your transaction went through on your King contract instance.

Then submit the instance and you should pass as long as you have a fallback setup to gurantee a fail. 
