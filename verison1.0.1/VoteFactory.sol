//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";
import "./reviewer.sol";
import "./Voter.sol";

//proposal, user, reviewer, voter相互交互的contract
contract VoteFactory{
    User[] users; //所有users
    Proposal[] proposals; //所有的proposals(包括未发布的，发布的，审核的)
    Voter[] voters; //所有投票人员
    reviewer[] reviewers;
    mapping(address => User) addressToUser;
}