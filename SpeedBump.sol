// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract SpeedBump {

    struct RequestedWithdrawal{
        uint time;
    }

    mapping(address => RequestedWithdrawal) private requestedWithdrawal;
    uint withdrawWaitPeriod = 2 minutes;

    //si voy a usar para controlar en tiempo menores o iguales a 15 segundos, no usar Timestamp. 
    //el timestamp del bloque puede ser manipulado por el mnero 15 segundos antes o dps.

    function requestWithdraw() public{
             requestedWithdrawal[msg.sender] = RequestedWithdrawal({time:block.timestamp});
    }

    function withdraw() public view returns (bool){
        if (block.timestamp > requestedWithdrawal[msg.sender].time + withdrawWaitPeriod){
        return true; //puedo realizar withdraw
        }else {
        return false; // no puedo realizar withdraw
    }
    }
}
