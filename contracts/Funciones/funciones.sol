// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Identity {

    string  nombreApp = "Cuadros";
    uint    public idNumber;
    bool    public isWorking;
    string  public name;
    address public wallet;

    constructor (
        uint    _idNumber,
        bool    _isWorking,
        string  memory _name
    ){
        idNumber    = _idNumber;
        isWorking   = _isWorking;
        name        = _name;
        wallet      = msg.sender;
    }

    // Funciones Publicas (public)
    function multiplication(uint a, uint b) public pure returns ( uint product ) {
        product = a * b;
    }


    //Funciones Privadas (private)
    function obtenerFecha() private pure returns ( uint date ) {
        date = 3;
    }

    
    // Funciones de pago Solidity solo envia ether si pa funciones es (payable)
    function enviarDinero( address payable receptor ) public payable {
        receptor.transfer(msg.value);
    }

    
    // Funciones de solo lectura de propiedades (view)
    function soloLeer() public view returns (string memory) {
        return nombreApp;
    }

    
    // Funcion de no lee ni modifica ninguna varibale de estado y tampoco usa 
    // variables globales (pure)
    function resta(uint a, uint b) public pure returns(uint result) {
        result = a - b;
    }

}