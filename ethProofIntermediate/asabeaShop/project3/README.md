# JBmoney ERC-20 Token
JBmoney is an ERC-20 token implemented in Solidity. 

It follows the Ethereum ERC-20 standard and provides basic functionalities for a standard fungible token on the Ethereum blockchain.

## Token Details
Name: JBmoney
Symbol: JBM
Decimals: 2
Total Supply: Dynamic (minted by the contract owner)


## Smart Contracts

### ERC20.sol
This contract implements the ERC-20 interface and includes the following features:

Ownership transfer using the transferOwnership function.
Token details such as name, symbol, decimals, and total supply.
User balances and functions to check balances (balanceOf).
Token transfer functions (transfer, approve, allowance, and transferFrom).
Ownership modifier to restrict certain functions to the contract owner.

### JBmoney.sol

This contract inherits from ERC20.sol and introduces additional functionalities:

Minting: The contract owner can create new JBmoney tokens using the mint function.
Burning: Token holders can destroy a specified amount of their own JBmoney using the burn function.

## Usage
Deploy the JBmoney contract to the Ethereum blockchain.
The deployer becomes the initial owner of the contract.
Interact with the contract to transfer tokens, authorize transfers, mint new tokens, and burn existing tokens.

## Security Considerations
Ensure that ownership transfers are performed securely and only by authorized parties.
Use caution with minting, as it increases the total supply and affects token economics.
Be mindful of burning, as it permanently removes tokens from circulation.

## References
Ethereum ERC-20 Standard
Solidity Documentation
Note: This README provides a high-level overview. It is recommended to review the contract code and thoroughly test it before deployment.
