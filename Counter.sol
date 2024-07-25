// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;


contract Counter {
         // uint => entero sin signo. ES NECESARIO PONER VIEW Y EL TIPO DE VARIABLE QUE RETORNA
         uint count;
         function get() public view returns (uint) {
             return count;
         }
         function inc() public {
            count = count + 1;

         }
         function dec() public{
            count = count - 1;
         }
}
