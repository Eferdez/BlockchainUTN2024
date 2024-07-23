// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Counter3 {
   uint anotherNumber;
   bool paused;
   address owner;
   mapping (address=> uint) counts;

   error NotOwner();
   error NotOne();
   error ContractPaused();

   constructor() {
       owner = msg.sender;
   }

     modifier onlyOwner(){
        if (msg.sender != owner){
            revert NotOwner();
        }
        _;
     }
     
     modifier notOne(){
        if (anotherNumber != 1){
            revert NotOne() ;
        }
        _;
        }
        

        modifier notPaused(){
            if (paused == true){
                revert ContractPaused();
            }
            _;
        }

    function pause() public onlyOwner notPaused{
        paused = true;
    }

     function unpause() public onlyOwner{
        paused = false;
    }     

    function getCount() public view notOne returns (uint) {
        return counts[msg.sender];
    }

   
    function inc() public {
        counts[msg.sender] += 1;
    }

  
    function dec() public {
        counts[msg.sender] -= 1;
    }
}
