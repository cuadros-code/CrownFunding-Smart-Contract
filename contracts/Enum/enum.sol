// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Struct {
    // Manejo en enteros (0, 1)
    enum State { Active, Inactive }
    
    State public state = State.Active;

    function changeState ( State newState ) public {
        state = newState;
    }

}