// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // The owner of the contract
    address private owner;

    // Mapping of candidate addresses to their vote count
    mapping(address => uint256) private votes;

    // List of candidate addresses
    address[] private candidates;

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to ensure only the owner can perform certain actions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Add a candidate to the list
    function addCandidate(address _candidate) public onlyOwner {
        candidates.push(_candidate);
    }

    // Vote for a candidate
    function vote(address _candidate) public {
        require(isCandidate(_candidate), "Invalid candidate address");
        votes[_candidate] += 1;
    }

    // Check if an address is a valid candidate
    function isCandidate(address _candidate) public view returns (bool) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i] == _candidate) {
                return true;
            }
        }
        return false;
    }

    // Get the vote count for a candidate
    function getVoteCount(address _candidate) public view returns (uint256) {
        require(isCandidate(_candidate), "Invalid candidate address");
        return votes[_candidate];
    }
}
