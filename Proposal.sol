//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Proposal{

    uint256 ID; //id
    string title; //标题
    string classification; //类型（当前规划了8种类型）
    string short_description; // 短描述
    string long_description; //长描述 （在正式发表前需要填写）
    uint256 timestamp; //产生提案的时间节点
    //bool isTeamOrPerson; //是团队还是自己编写的，true表示团队，false表示个人
    address[] teamMemberAccount; //用于之后奖励
    string[] teamMembersResposibilities;
    address public releasedAccount; //谁提交的就记录谁的account
    bool public isReleased; //是否是发表状态
    bool public isReviewed; //是否是reviewed状态
    bool public isReject; //提案被驳回
    bool public isApprove; //提案通过，可以发表
    bool public isSecondReleased; //二次发布(用于即将发表给公众)
    bool public isPublic;
    bool isOver; //提案过期
    bool isTechnology; //是否是与技术相关
    bool public isFund; //是否需要资金支持
    uint256 public voteApprove; //多少投票人员赞成
    uint256 voteReject; //多少用户拒绝

    //开始投票时间，结束投票时间
    //......

    //初始化
    constructor(){
        isReleased = false;
        isReviewed = false;
        isPublic = false;
        isOver = false;
        isTechnology = false;
        isFund = false;
        voteApprove = 0;
        voteReject = 0;
    }

    //Q1: ID怎样随机产生？
    function storeID(uint256 _ID) public {
        ID = _ID;
    }

    function getID() public view returns(uint256){
        return ID;
    }

    function storeTitle(string memory _title) public {
        title = _title;
    }
    
    function getTitle() public view returns(string memory){
        return title;
    }

    function storeClassfication(string memory _classification) public{
        classification = _classification;
    }

    function getClassfication() public view returns(string memory){
        return classification;
    }

    function storeShortDescription(string memory _short_description) public{
        short_description = _short_description;
    }

    function getShortDescription() public view returns(string memory){
        return short_description;
    }

    function storeLongDescription(string memory _long_description) public{
        long_description = _long_description;
    }

    function getLongDescription() public view returns(string memory){
        return long_description;
    }

    function storeTimeStamp(uint256 _timestamp) public{
        timestamp = _timestamp;
    }

    function getTimeStamp() public view returns(uint256){
        return timestamp;
    }

    //获取团队的accounts
    function storeTeamMembersAccount(address[] memory _teamMemberAccount) public {
        teamMemberAccount = _teamMemberAccount;
    }

    //返回团队的account
    function getTeamMemberAccount() public view returns(address[] memory){
        return teamMemberAccount;
    }

    //获取团队之间的responsibilities
    function storeTeamMemberResponsibilities(string[] memory _teamMembersResposibilities) public {
        teamMembersResposibilities = _teamMembersResposibilities;
    }

    //返回团队的responsibilities
    function getTeamMemberResponsibilities() public view returns(string[] memory){
        return teamMembersResposibilities;
    }

    //获取发布proposal的account
    function storeReleasedAccount(address _releasedAccount) public{
        releasedAccount = _releasedAccount;
    }

    //返回发布proposal的account
    function getReleasedAccount() public view returns(address){
        return releasedAccount;
    }

    function storeIsReleased(bool _isReleased) public {
        isReleased = _isReleased;
    }

    function getIsReleased() public view returns(bool){
        return isReleased;
    }

    function storeIsReviwed(bool _isReviwed) public {
        isReviewed = _isReviwed;
    }

    function getIsReviwed() public view returns(bool){
        return isReviewed;
    }

    function storeIsFund(bool _isFund) public {
        isFund = _isFund;
    }

    function getIsFund() public view returns(bool){
        return isFund;
    }

    function storeIsSecondReleased(bool _isSecondReleased) public {
        isSecondReleased = _isSecondReleased;
    } 

    function getIsSecondReleased() public view returns(bool){
        return isSecondReleased;
    }

    function storeIsTechnology(bool _isTechnology) public {
        isTechnology = _isTechnology;
    } 

    function getIsTechnology() public view returns(bool){
        return isTechnology;
    }

    function storeIsApprove(bool _isApprove) public {
        isApprove = _isApprove;
    } 

    function getIsApprove() public view returns(bool){
        return isApprove;
    }

    function storeIsReject(bool _isReject) public {
        isReject = _isReject;
    } 

    function getIsReject() public view returns(bool){
        return isReject;
    }


}