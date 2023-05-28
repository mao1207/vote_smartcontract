pragma solidity ^0.8.0;

import "./Proposal.sol";
import "./User.sol";

contract Voter is User{
    Proposal[] votedProposal; //投过票的proposal
    bool public voted; //是否投过票
    address delegateAccount; //代理的地址
    bool isDelegated;

    User public user;

    constructor(){
        user = new User(); //实例化user
    }

    mapping(address => Voter) public delegateVoters; //根据address找到delegateUser

    // // 指定to为自己的代表
    // function delegate(Proposal _proposal,address toDelegate) external {
    //     // 从“已投票地址”voters数组 - 获取Voter选民  
    //     Voter sender = voter;
    //     require(!sender.voted, "Your already voted"); // 检查是否已参与过投票

    //     require(toDelegate != msg.sender, "Self-delegation is disallowed.");// 不允许指定自己为代表 

    //     // 一般来说使用此类循环是很危险的
    //     // 如果运行的时间过长，可能会需要消耗更多的gas
    //     // 甚至有可能会导致死循环
    //     // 此While是向上寻找顶层delegate（代表）
    //     while(delegateVoters[toDelegate].delegateAccount != address(0)) { // 地址不为空
    //         // 此处意思是比如有多级delegate（代表），那么就需要不断向上寻找
    //         toDelegate = delegateVoters[toDelegate].delegateAccount; 
    //         // 再向上寻找过程不允许“to”和“请求发起人”msg.sender重合
    //         require(toDelegate != msg.sender, "Found loop in delegation.");
    //     }

    //     Voter delegate_ = delegateVoters[toDelegate];

    //     // 检查是否又投票权
    //     require(delegate_.weight >= 1);
    //     // 更改发起人的投票状态和代理
    //     sender.voted = true;
    //     sender.delegate = toDelegate;
    //     // 检查代理的投票状态
    //     // 如果已经投票则直接为提案增加投票数、反之则增加delegate_代表的投票权重
    //     if(delegate_.voted) {
    //         _proposal.voteCount += sender.weight;
    //     } else {
    //         delegate_.weight += sender.weight;
    //     }
    // }

    // // 为提案投票
    // function vote(uint proposal) external {
    //     // 获取选民
    //     Voter storage sender = voters[msg.sender];
    //     // 判断是否有投票权
    //     require(sender.weight >= 0, "Has no rigth to vote.");
    //     // 判断是否已经投过票
    //     require(sender.voted, "Already vote.");

    //     // 通过校验后，则改变其自身状态
    //     sender.voted = true;
    //     sender.vote = proposal;

    //     // 为指定提案增加支持数量
    //     // 如果proposal超出数组范围，则会停止执行
    //     proposals[proposal].voteCount += sender.weight;
    // }
}