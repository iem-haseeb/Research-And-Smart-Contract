// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract PolicyUpdation {
    uint public numberOfAttempts;
    address public owner;

    // Event to notify policy updates
    event PolicyUpdated(uint newPolicyValue);

    constructor(uint initialAttempts) {
        require(initialAttempts >= 0, "Initial attempts must be non-negative");
        numberOfAttempts = initialAttempts;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function updatePolicy() public onlyOwner {
        if (numberOfAttempts > 0) {
            numberOfAttempts -= 1;
            emit PolicyUpdated(numberOfAttempts);
        }
    }

    function getNumberOfAttempts() public view returns (uint) {
        return numberOfAttempts;
    }
}
