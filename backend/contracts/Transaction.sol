pragma solidity ^0.5.0;

contract Transaction {
    function getBalance() public view returns (uint) { //view means this function will not change the state of the contract (whatever the hell that means)
        return msg.sender.balance;
    }
}