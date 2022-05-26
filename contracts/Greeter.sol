//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    address private owner;

    string private greeting;
    uint256 public favoriteNumber;

    struct FriendInfo {
        bool isFriend;
        string greeting;
        uint256 favoriteNumber; 
    }

    mapping (address => FriendInfo) public friends;

    modifier ownerOnly() {
        require(owner == msg.sender, "Sorry, only the owner can call this function!");
        _;
    }

    modifier evenOnly(uint256 num) {
        require(num % 2  == 0, "Sorry, only even numbers allowed!");
        _;
    }

    constructor(string memory _greeting, uint256 _favoriteNumber) {
        console.log("Deploying a Greeter with greeting:", _greeting);

        owner = msg.sender;
        greeting = _greeting;
        favoriteNumber = _favoriteNumber;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public ownerOnly {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }

    function setFavoriteNumber(uint256 _favoriteNumber) public ownerOnly evenOnly(_favoriteNumber) {
        favoriteNumber = _favoriteNumber;
    }

    function addFriend(address friend, string memory _greeting, uint256 _favoriteNumber) external ownerOnly {
        friends[friend] = FriendInfo(true, _greeting, _favoriteNumber);
    }
}
