// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AccessControl {
    uint public numberOfAttempts;
    address public owner;

    // Event to notify policy updates
    event PolicyUpdated(uint newPolicyValue);
    event AccessGranted(address user);
    event AccessDenied(address user, string reason);

    constructor(uint initialAttempts) {
        require(initialAttempts >= 0, "Initial attempts must be non-negative");
        numberOfAttempts = initialAttempts;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function updatePolicy() internal {
        if (numberOfAttempts > 0) {
            numberOfAttempts -= 1;
            emit PolicyUpdated(numberOfAttempts);
        }
    }

    function checkAccess(uint V, bool manualReviewOutcome) public {
        if (V > 75) {
            emit AccessGranted(msg.sender);
        } else if (V > 50 && V <= 75) {
            if (manualReviewOutcome) {
                emit AccessGranted(msg.sender);
            } else {
                emit AccessDenied(msg.sender, "Manual review failed");
                updatePolicy();
            }
        } else if (V <= 50) {
            emit AccessDenied(msg.sender, "V too low, access denied");
            updatePolicy();
        }
    }

    function getNumberOfAttempts() public view returns (uint) {
        return numberOfAttempts;
    }
}

contract SimpleTest {
    uint public value;

    constructor(uint _value) {
        value = _value;
    }
}
