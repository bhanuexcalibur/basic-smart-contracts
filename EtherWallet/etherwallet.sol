// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract EtherBasicWallet {
    address payable owner; //To make the owner to able to pay

    event Added(address receiver, uint indexed value);
    // An event created to check the added amount in the contract

    constructor(){
        // typecasting the msg.sender to payable as it isn't default
        owner = payable(msg.sender); 
    }

    receive() external payable{}
    fallback() external payable{}
    
    // Since fallback  and recieve functions are available, we
    // don't need to create a recieving function.

    function withdraw(uint _amount) public {
        require(msg.sender == owner, "Owner dusra hai babu");
        require(_amount < address(this).balance,"paisa nhi h");
        (bool pay,) = payable(msg.sender).call{value: _amount}("");
        require(pay,"Tx fail");
        emit Added(msg.sender, _amount);
    }

    function getBalance() view public returns(uint){
        return address(this).balance;
    }
}