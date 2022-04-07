// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


// Si se genera un error las operaciones al punto del error se revierten
// El Gas no se retorna
contract ManejoError {

    string public state = "onSale";

    error StateNotDefined(uint unit);

    function changeState( uint8 newState ) public {

        require( newState == 0 || newState == 1, "NO se acepta el estado" );

        if(newState == 0){
            state = "onSale";
        } else if (newState == 1){
            state = "notForSale";
        } 
        // else {
            // revert StateNotDefined(newState);
        // }
    }

}