pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";

contract Voter is User{
    Proposal[] votedProposal; //投过票的proposal
    bool isDelegated;
    address delegateAccount;

    User private user;

    constructor(){
        user = new User(); //实例化user
    }
}