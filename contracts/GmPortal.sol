// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract GmPortal {
    uint256 totalGms;
    uint256 private seed;

    event NewGm(address indexed from, uint256 timestamp, string nickname);

    struct Gm {
        address gmer; // The address of the user who gmed.
        string nickname; // The nickanme of the user who gmed.
        uint256 timestamp; // The timestamp when the user gmed.
    }

    mapping(address => uint256) public lastGmedAt;

    Gm[] gms;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function gm(string memory _nickname) public {
        require(
            lastGmedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastGmedAt[msg.sender] = block.timestamp;

        totalGms += 1;
        console.log("%s has gmd!", msg.sender);
        gms.push(Gm(msg.sender, _nickname, block.timestamp));
        emit NewGm(msg.sender, block.timestamp, _nickname);

        seed = (block.difficulty + block.timestamp + seed) % 100;
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function getAllGms() public view returns (Gm[] memory) {
        return gms;
    }

    function getTotalGms() public view returns (uint256) {
        console.log("We have %d total gms!", totalGms);
        return totalGms;
    }
}