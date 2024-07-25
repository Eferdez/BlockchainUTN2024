// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EthWallet is Ownable{

    event EthReceive (uint amount);

    constructor (address initialAddress) Ownable(initialAddress) {}

    receive() external payable {
        emit EthReceive(msg.value); //variable de contexto especial de donde sacamos la address de la account que esta interatuando. Es la cantidad de ethrs que recibe la funcion en la primera parte de remix.
     } 
    
    //receive es una funcion especial de Solidity por eso no lleva el prefijo "function"
    // Tiene un cuerpo, es especial porque cuando realizamos una transaccion contra el contrato sin llamar a ninguna funcion en especial y sin pasar ninguna cantidad de datos, 
    //si esa transaccion viene con un valor de Ethers, la blockchain va a buscar esta funcion definida en el contrato. 
    //si esta funcion no existe, me da a errores, como la funcion receive y fallback no estan definidas
    //si dice payable es un modificar de funcion y significa que tiene la habilidad de recibir ethers.
    //Es una buena practica generar un evento que diga que recibimos ethers.
    //lo que hice fue compliar y deployar sin poner valor en el value, luego pongo valor y toco transact en el calldata de abajo de todo
    // o sea hago una call vacia pero que tenga un value


    //la forma 1 es con la funcion especial Receive, la forma 2 de fondear es hacer una funcion ReceiveEth

    function receiveEth() external payable {}


    function withdraw (uint amount) external onlyOwner{
        (bool success,) = owner().call {value:amount}("");
        require (success, "ETH transfer fail");
    }

    function getBalance() external view returns(uint){
         return address (this) .balance; // 
    }


}
