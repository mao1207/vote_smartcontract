//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";

contract reviewer is User{
    address guildMembersAccount = 0x060848d7a790ac7302b122a7Ba843CFA72829458;
    address technologyAccount = 0x060848d7a790ac7302b122a7Ba843CFA72829458;
    Proposal[] reviewedProposal;

    User private user;

    constructor(){
        user = new User(); //实例化user
    }

    function reviewProposal(Proposal _proposal,bool isFundOrNot,bool isTechnologyOrNot,string memory passOrNot) public {
        _proposal.storeIsFund(isFundOrNot);
        _proposal.storeIsTechnology(isTechnologyOrNot);
        if(passOrNot == "pass"){
            _proposal.storeIsApprove(true);
        }else if(passOrNot == "reject"){
            _proposal.storeIsReject(true);
        }
        _proposal.storeIsReviwed(true); //表示看过了，但是还需要修改提案才能发布。
    }

    function viewReviewedProposal() public returns(Proposal[] memory){
        return reviewedProposal;
    }

    // //查看该proposal
    // function viewThisProposal(Proposal _proposal) public returns(string memory,string memory,address){
    //     return (_proposal.getClassfication(), _proposal.getLongDescription(), _proposal.getReleasedAccount());
    // }

}