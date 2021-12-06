// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;

    event NewGm(address indexed from, uint256 timestamp, string nickname);

    struct Gm {
        address gmer; // The address of the user who gmed.
        string nickname; // The nickanme of the user who gmed.
        uint256 timestamp; // The timestamp when the user gmed.
    }

    /*
     * I declare a variable waves that lets me store an array of structs.
     * This is what lets me hold all the waves anyone ever sends to me!
     */
    Gm[] gms;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function gm(string memory _nickname) public {
        totalGms += 1;
        console.log("%s has gmd!", msg.sender);
        gms.push(Gm(msg.sender, _nickname, block.timestamp));
        emit NewGm(msg.sender, block.timestamp, _nickname);
    }

    function getAllGms() public view returns (Gm[] memory) {
        return gms;
    }

    function getTotalGms() public view returns (uint256) {
        console.log("We have %d total gms!", totalGms);
        return totalGms;
    }
}