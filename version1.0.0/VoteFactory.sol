//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";

//proposal, user, reviewer, voter相互交互的contract
contract VoteFactory{

    User[] users;
    Proposal[] proposals; //所有的proposals(包括未发布的，发布的，审核的)
    mapping(address => User) addressToUser;
}