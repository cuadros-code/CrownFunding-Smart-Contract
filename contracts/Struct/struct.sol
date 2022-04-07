// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Struct {

    struct Hero {
        string name;
        uint age;
        string power;
        string team;
    }
    
    Hero batman = Hero("Batman", 30, "Mucho dinero", "Liga de la justicia");

}


// batman.name
// batman.age
