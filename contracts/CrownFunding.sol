// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract CrowdFunding {

    enum StateProject { Active, Inactive }

    struct Project {
        string id;
        string name;
        string description;
        address payable author;
        StateProject isComplete;
        uint funds;
        uint fundraisingGoal;
    }

    struct Contribution {
        address contributor;
        uint value;
    }

    Project[] public listProjects;
    mapping( string =>  Contribution[] ) public contributions;

    function createProject ( 
        string calldata id,
        string calldata name,
        string calldata description,
        uint256 fundraisingGoal
    ) public {
        Project memory project = Project(
            id,
            name,
            description,
            payable(msg.sender),
            StateProject.Active,
            0,
            fundraisingGoal
        );
        listProjects.push(project);
    }

    function fundProject( uint indexProject ) public payable canAddFund(indexProject) {
        Project memory project  = listProjects[indexProject];
        require( project.isComplete == StateProject.Active, "Proyecto cerrado" );
        require( msg.value > 0, "Agregue un valor valido" );
        project.author.transfer(msg.value);
        project.funds += msg.value;

        contributions[project.id].push(Contribution(msg.sender, msg.value));
        
        emit EventAddFunds( msg.sender, msg.value);
    }

    function changeProjectState ( StateProject newState, uint indexProject ) public canChangeState(indexProject) {
        Project memory project  = listProjects[indexProject];
        if(project.isComplete == newState){
            revert CannotChangeState(project.isComplete);
        }else{
            project.isComplete = newState;
            emit EventStateChange( newState, "Se cambio el estado" );
        }
    }

    // Only author can change the state
    modifier canChangeState ( uint indexProject ) {
        require (
            msg.sender == listProjects[indexProject].author,
            "Solo el autor puede cambiar el stado"
        );
        _;
    }

    // The Author cannot add funds
    modifier canAddFund ( uint indexProject ) {
        require(
            msg.sender != listProjects[indexProject].author,
            "El autor no puede agregar fondos"
        );
        _;
    }

    // Notify Status change
    event EventStateChange (
        StateProject newState,
        string currentDate
    );

    // Notify add funds
    event EventAddFunds (
        address addressSender,  
        uint amount
    );

    // Handles Errors
    error CannotAddFund( address sender );

    error CannotChangeState( StateProject currentState );

}