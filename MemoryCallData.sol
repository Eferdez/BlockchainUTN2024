// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract MemoryCallData {

    string myValue;

    function setMyValue (string anotherValue) public{
        myValue = anotherValue;
    }

}
