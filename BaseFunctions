// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract BaseFunctions {

    function privateFunction() public pure returns(uint) {
        return 3;
    }

    function testPrivateFunction() public pure returns(uint) {
        return privateFunction();
    }
}

contract functions is BaseFunctions {

    function testPrivateFunction2() public pure returns(uint){
        return privateFunction();
    }

}
