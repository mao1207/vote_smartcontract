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

    Proposal[] public proposals; //所有的proposals(包括未发布的，发布的，审核的),这个必须是全局变量
    //mapping(address => User) addressToUser;

    //smapping(address => Proposal[]) getUserReleasedProposals; //查看当前用户发表过的proposal
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
        //timestamp怎么获取?
        //.....获取timestamp代码

        proposal.storeReleasedAccount(_userAccount); //存储发表的account
        proposal.storeIsReleased(true); //存储为true,不能直接proposal.isRelease = true 赋值
        proposals.push(proposal); //添加新的proposal
        releasedProposal.push(proposal);//添加自己编写的proposlas
        return proposal.isReleased();
    }

    //proposal准备即将发布，返回给用户再次修改proposal的机会
    function modifyTheProposal(Proposal _proposal,
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
                //timestamp怎么获取?

                _proposal.storeReleasedAccount(_userAccount); //存储发表的account
                _proposal.storeIsSecondReleased(true); //第二次发布

                return _proposal.getIsSecondReleased();
            }
        }
    }

    //删除未被审阅的proposal
    function withdrawProposal(Proposal _proposal) public {
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
    function viewReleasedProposal() public returns (Proposal[] memory){
        return releasedProposal;
    }

    //查看全部发布了的proposal
    function viewPublicProposal() public returns (Proposal[] memory){
        return publicProposal;
    }

    //可以发表proposal，设置投票时间
    function publicNewProposal(Proposal _proposal) public{
        //。。。。。
    }

}