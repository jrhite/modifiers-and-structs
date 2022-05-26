//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    address private owner;

    string private greeting;
    uint256 public favoriteNumber;

    // TODO: implement ownerOnly modifier

    // TODO: implement evenOnly modifier

    // TODO: add FriendInfo struct

    // TODO: add friends mapping

    constructor(string memory _greeting, uint256 _favoriteNumber) {
        console.log("Deploying a Greeter with greeting:", _greeting);

        owner = msg.sender;
        greeting = _greeting;
        favoriteNumber = _favoriteNumber;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    // TODO: add ownerOnly modifier
    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }

    // TODO: add ownerOnly and evenOnly modifiers
    function setFavoriteNumber(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // TODO: implement addFriend() function with ownerOnly modifier
}
