// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

contract ErrorContract{

    uint public aNumber;

    error NotOne(uint value, address user);

    function setNumber (uint anotherNumber) public {
        // require(anotherNumber == 1, "Not One");
        if (anotherNumber != 1) {
            revert NotOne(anotherNumber, msg.sender);
        }
        aNumber = anotherNumber;
    }

    function getUser() public view returns (address usp){
             return msg.sender;
    }

    function setUser() public view returns (address user){
        user = msg.sender;
    }
}
