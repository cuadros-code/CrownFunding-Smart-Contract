// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Permission {

    address private owner;
    string public projectName = "The best";

    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Solo el fundador puede cambiar el nombre del projecto"
        );
        _;
    }

    function changeProjectName ( string memory newName ) public onlyOwner {
        projectName = newName;
    }

}