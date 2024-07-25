// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

contract Mappings {
//Mapping: quiero que la clave sea un address y el valor un uint
// 0x5B3 ----17
// 0xAb8 ----15
    mapping(address => uint) public myMapping;


function setMyMapping(uint aNumber) public {
    // (address => uint) la clave es un address y el valor es un entero sin signo
    myMapping [msg.sender]= aNumber;
}
    
    function getMynumber () public view returns (uint) {
        return myMapping [msg.sender];
        //asi ninguna address podria acceder al valor de otra address
    }

}
