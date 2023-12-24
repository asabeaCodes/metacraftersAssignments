// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.8.0/contracts/token/ERC20/IERC20.sol";

contract ERC20 is IERC20 {

    // Contract Ownership
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only the contract Owner is allowed to perform this operation");
        _;
    }

    function transferOwnership(address _newOwner) external onlyOwner() {
        owner = _newOwner;
    }



    // Token details

    function name() public pure returns (string memory) {
        return "DEGEN";
    }

    function symbol() public pure returns (string memory) {
        return "DGN";
    }

    uint public decimals = 0;
    uint public totalSupply;


    // user balances

    mapping (address => uint) internal balances;

    function balanceOf(address _tokenHolder) public view returns (uint256 balance) {
        return balances[_tokenHolder];
    }

    // transfer JBmoney

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf(msg.sender) >= _value, " sender balance is lesser than transfer amount");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        success = true;
    }

    // permission to transfer

    mapping (address => mapping(address => uint)) private allowances;

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 spendingCap) {
        return allowances[_owner][_spender];
    }

    // Transfer after authorization

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(allowances[_from][msg.sender] >= _value, " Agent has not been approved to transfer that amount of DEGEN tokens");
        require(balanceOf(_from) >= _value, "The DEGEN holder doesn't have enough funds");
        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        success = true;
    }


}



contract DEGEN is ERC20 {
    function mint(address _receipient, uint256 _value) public onlyOwner() {
        balances[_receipient] += _value;
        totalSupply += _value;
        emit Transfer(address(0), _receipient, _value);
    }
    function burn(uint256 _value) public {
        require(balanceOf(msg.sender) >= _value, "token holder doesn't have enough DEGEN");
        totalSupply -= _value;
        balances[msg.sender] -= _value;
        emit Transfer(msg.sender, address(0), _value);
    }


    mapping (address => possessions) users;

    struct possessions {
        uint bags;
        uint shoes;
    }

    function buyBag() public {
        require(balanceOf(msg.sender) >= 200, "your sim can't afford a bag"); 
        burn(200);
        users[msg.sender].bags += 1;
    }
    function buyShoe() public {
        require(balanceOf(msg.sender) >= 400, "your sim can't afford a shoe");
        burn(400);
        users[msg.sender].shoes += 1;
    }

    function checkPossessions() public view returns (possessions memory) {
        return users[msg.sender];
    }

}
