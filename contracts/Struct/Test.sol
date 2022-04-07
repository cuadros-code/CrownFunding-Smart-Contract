// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract CrowdFundingTest {
    
    string public id;
    string public name;
    string public description;
    address payable public author;
    bool public isComplete = false;
    uint public funds;
    uint public fundraisingGoal;

    constructor (
        string memory _id, 
        string memory _name, 
        string memory _description, 
        uint _fundraisingGoal
    ){
        id              = _id;
        name            = _name;
        description     = _description;
        fundraisingGoal = _fundraisingGoal;
        author          = payable(msg.sender);
    }

    function fundProject() public payable canAddFund {
        require( isComplete == false, "Proyecto cerrado" );
        require( msg.value > 0, "Agregue un valor valido" );
        
        author.transfer(msg.value);
        funds += msg.value;
        emit EventAddFunds( msg.sender, msg.value);
    }

    function changeProjectState ( bool newState ) public canChangeState {
        if(isComplete == newState){
            revert CannotChangeState(isComplete);
        }else{
            isComplete = newState;
            emit EventStateChange( newState, "Se cambio el estado" );
        }
    }

    // Only author can change the state
    modifier canChangeState () {
        require (
            msg.sender == author,
            "Solo el autor puede cambiar el stado"
        );
        _;
    }

    // The Author cannot add funds
    modifier canAddFund () {
        require(
            msg.sender != author,
            "El autor no puede agregar fondos"
        );
        _;
    }

    // Notify Status change
    event EventStateChange (
        bool newState,
        string currentDate
    );

    // Notify Status change
    event EventAddFunds (
        address addressSender,  
        uint amount
    );

    // Handles Errors
    error CannotAddFund( address sender );

    error CannotChangeState( bool currentState );

}