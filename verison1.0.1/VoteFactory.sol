// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";
import "./Reviewer.sol";
import "./Voter.sol";

// Proposal, User, Reviewer, Voter 相互交互的合约
contract VoteFactory {
    User[] users; // 所有用户
    Proposal[] proposals; // 所有提案（包括未发布的、发布的和审核的）
    Voter[] voters; // 所有投票人员
    Reviewer[] reviewers; // 所有审稿人

    mapping(address => User) addressToUser; // 地址映射到用户

    // 创建一个新用户并将其添加到用户数组中
    function createUser() public {
        User user = new User();
        users.push(user);
        addressToUser[address(user)] = user;
    }

    // 创建一个新提案并将其添加到提案数组中
    function createProposal(string memory classification, string memory longDescription, address releasedAccount) public {
        Proposal proposal = new Proposal(classification, longDescription, releasedAccount);
        proposals.push(proposal);
    }

    // 创建一个新的投票人员并将其添加到投票人员数组中
    function createVoter() public {
        Voter voter = new Voter();
        voters.push(voter);
    }

    // 创建一个新的审稿人并将其添加到审稿人数组中
    function createReviewer() public {
        Reviewer reviewer = new Reviewer();
        reviewers.push(reviewer);
    }

    // 返回所有用户
    function getUsers() public view returns (User[] memory) {
        return users;
    }

    // 返回所有提案
    function getProposals() public view returns (Proposal[] memory) {
        return proposals;
    }

    // 返回所有投票人员
    function getVoters() public view returns (Voter[] memory) {
        return voters;
    }

    // 返回所有审稿人
    function getReviewers() public view returns (Reviewer[] memory) {
        return reviewers;
    }

    // 根据地址返回用户
    function getUserByAddress(address userAddress) public view returns (User) {
        return addressToUser[userAddress];
    }

    // 投票人员为提案投票
    function voteForProposal(address voterAddress, uint proposalIndex) public {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        Voter voter = Voter(voterAddress);
        Proposal proposal = proposals[proposalIndex];
        voter.vote(proposal);
    }

    // 审稿人审查提案
    function reviewProposal(address reviewerAddress, uint proposalIndex, bool isFundOrNot, bool isTechnologyOrNot, string memory passOrNot) public {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        Reviewer reviewer = Reviewer(reviewerAddress);
        Proposal proposal = proposals[proposalIndex];
        reviewer.reviewProposal(proposal, isFundOrNot, isTechnologyOrNot, passOrNot);
    }

    // 获取特定提案的详细信息
    function getProposalDetails(uint proposalIndex) public view returns (string memory, string memory, address) {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        Proposal proposal = proposals[proposalIndex];
        return proposal.getDetails();
    }
}
