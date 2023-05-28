//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./Proposal.sol";

contract User{

    string[] classification;

    string public class1 = "governance_structure";
    string public class2 = "promotion & rep_score";
    string public class3 = "voting";
    string public class4 = "salary system";
    string public class5 = "community";
    string public class6 = "tokenomics system";
    string public class7 = "carbon reduction system";
    string public class8 = "UI/UX design";


    address accountAddressID;
    uint256 reputation_score;
    uint256 weight;
    Proposal[] releasedProposal;


    Proposal[] publicProposal; //已经发布过的proposal
    string[] publicProposalOfString;
    Proposal[] voteProposals; //投过票的proposal
    mapping(address => Voter) voters; //根据address来获得Voter的信息
    mapping(address => User) addressToUser; //根据address来获得User的信息

    //mapping(address => Proposal[]) getUserReleasedProposals; //查看当前用户发表过的proposal
    //address public immutable chairperson;

    constructor(){
        accountAddressID = msg.sender;
        weight = 1;
        classification.push(class1);
        classification.push(class2);
        classification.push(class3);
        classification.push(class4);
        classification.push(class5);
        classification.push(class6);
        classification.push(class7);
        classification.push(class8);

    }

    struct Voter{
        bool voted; //是否投过票
        address delegateAccount; //代理的地址
        bool isDelegated;
    }

    //user写新的proposals
    function writeNewProposal(string memory _title, 
                                string memory _short_description,
                                string memory _classification,
                                address[] memory _teamMemberAccount,
                                string[] memory _teamMembersResponsibilities,
                                address _userAccount) public returns(bool){
        Proposal proposal = new Proposal(); //实例化一个proposal
        proposal.storeTitle(_title); //输入title
        proposal.storeShortDescription(_short_description);//输入short_description
        proposal.storeClassfication(_classification); //输入classification
        //判断teamAccount是否为空
        if(_teamMemberAccount[0] != address(0)){
            proposal.storeTeamMembersAccount(_teamMemberAccount);
            proposal.storeTeamMemberResponsibilities(_teamMembersResponsibilities);
        }

        proposal.storeReleasedAccount(_userAccount); //存储发表的account
        proposal.storeIsReleased(true); //存储为true,不能直接proposal.isRelease = true 赋值
        //proposals.push(proposal); //添加新的proposal
        releasedProposal.push(proposal);//添加自己编写的proposlas
        return proposal.isReleased();
    }

    //proposal准备即将发布，返回给用户再次修改proposal的机会
    function modifyTheProposal(Proposal _proposal,Proposal[] memory proposals,
                                string memory _title,
                                string memory _short_description,
                                string memory _classification,
                                string memory _long_description,
                                address[] memory _teamMembersAccount,
                                string[] memory _teamMembersResponsibilities,
                                address _userAccount) public returns(bool){

        for(uint i = 0; i < proposals.length; i++){
            if(proposals[i].getID() == _proposal.getID()){
                //_proposal.storeIsReviwed(false); //二次发布的时候，reviewed的第一个位置
                _proposal.storeTitle(_title);
                _proposal.storeClassfication(_classification);
                _proposal.storeShortDescription(_short_description);
                _proposal.storeLongDescription(_long_description);

                //判断teamAccount是否为空
                if(_teamMembersAccount[0] != address(0)){
                    _proposal.storeTeamMembersAccount(_teamMembersAccount);
                    _proposal.storeTeamMemberResponsibilities(_teamMembersResponsibilities);
                }

                _proposal.storeReleasedAccount(_userAccount); //存储发表的account
                _proposal.storeIsSecondReleased(true); //第二次发布

                return _proposal.getIsSecondReleased();
            }
        }
    }

    //删除未被审阅的proposal
    function withdrawProposal(Proposal _proposal, Proposal[] memory proposals) public {
        require(_proposal.getReleasedAccount() == msg.sender, "you are not owner!");
        require(_proposal.getIsReviwed() == false,"this proposal cannot be withdrawn!");
        for(uint i = 0; i < releasedProposal.length; i++){
            if(releasedProposal[i] == _proposal){
                delete releasedProposal[i];
                break;
            }
        }
        for(uint i = 0; i < proposals.length; i++){
            if(proposals[i] == _proposal){
                delete proposals[i];
                break;
            }
        }
    }

    //自己release后的proposals都能够查看
    //怎么样定义dynamic size in string array to view the releasedProposal
    //暂时不确定返回值是什么
    function viewReleasedProposal() public view returns (Proposal[] memory){
        return releasedProposal;
    }

    //查看全部发布了的proposal
    function viewPublicProposal() public view returns (Proposal[] memory){
        return publicProposal;
    }

    //设置发表方案的时间
    function setNewProposalTime(Proposal _proposal,uint day) public{
        uint currentTime = block.timestamp;
        _proposal.storeStartTime(currentTime);
        _proposal.storeEndTime(currentTime + day);
    }

    // 指定to为自己的代表
    function delegate(address to, Proposal _proposal) external {
        // 从“已投票地址”voters数组 - 获取Voter选民  
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Your already voted"); // 检查是否已参与过投票

        require(to != msg.sender, "Self-delegation is disallowed.");// 不允许指定自己为代表 

        // 一般来说使用此类循环是很危险的
        // 如果运行的时间过长，可能会需要消耗更多的gas
        // 甚至有可能会导致死循环
        // 此While是向上寻找顶层delegate（代表）
        while(voters[to].delegateAccount != address(0)) { // 地址不为空
            // 此处意思是比如有多级delegate（代表），那么就需要不断向上寻找
            to = voters[to].delegateAccount; 
            // 再向上寻找过程不允许“to”和“请求发起人”msg.sender重合
            require(to != msg.sender, "Found loop in delegation.");
        }

        User delegate_ = addressToUser[to];

        // 检查是否又投票权
        require(delegate_.getWeight() >= 1);
        // 更改发起人的投票状态和代理
        sender.voted = true;
        sender.delegateAccount = to;
        // 检查代理的投票状态
        // 如果已经投票则直接为提案增加投票数、反之则增加delegate_代表的投票权重

        //这个部分还需要修改
        // if(delegate_.voted) {
        //     _proposal.storeVoteCount(sender.weight);
        // } else {
        //     delegate_.weight += sender.weight;
        // }
    }

    // 为提案投票
    //还有一些问题，该function
    function vote(Proposal _proposal) external {
        // 获取选民
        Voter storage sender = voters[msg.sender];
        // 判断是否有投票权
        require(sender.weight >= 0, "Has no rigth to vote.");
        // 判断是否已经投过票
        require(sender.voted, "Already vote.");

        // 通过校验后，则改变其自身状态
        sender.voted = true;
        voteProposals.push(_proposal);

        // 为指定提案增加支持数量
        // 如果proposal超出数组范围，则会停止执行
        _proposal.storeVoteCount(sender.weight);
    }

    function getWeight() public returns (uint){
        return weight;
    }


}