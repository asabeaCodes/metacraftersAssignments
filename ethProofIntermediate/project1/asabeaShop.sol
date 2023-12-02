// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract asabeaShop {

    mapping (address => possessions) users;

    struct possessions {
        uint bags;
        uint shoes;
    }
    
    function buyBag() payable public {
        require(msg.value >= 2 ether, "The bag costs more than the amount you paid");
        users[msg.sender].bags +=1;
    }

    function buyShoe() payable public {
        if (msg.value <= 4 ether) {
            revert("you can't get a shoe this cheap");
        }
        users[msg.sender].shoes += 1;
    }

    function checkPossessions() public view returns (possessions memory) {
        return users[msg.sender];
    }


    address payable public shopOwner;

    constructor() {
        shopOwner = payable(msg.sender);
    }

    function withdrawSales() public returns (bool sent) {
        assert(msg.sender == shopOwner);
        
        sent = shopOwner.send(address(this).balance);
    }
}

