// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function gm() public {
        totalGms += 1;
        console.log("%s has gmd!", msg.sender);
    }

    function getTotalGms() public view returns (uint256) {
        console.log("We have %d total gms!", totalGms);
        return totalGms;
    }
}