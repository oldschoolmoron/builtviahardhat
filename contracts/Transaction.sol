// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.28;

contract Transaction {
  string public mytoken = 'spacecoin';
  string public symbol = 'SPACEX';
  uint256 public totalSupply = 10000; 
  uint public user1 = 100;
  uint currentTimestamp = block.timestamp;
  uint public profit = 1;
  
  address public owner; 
  mapping(address => uint) balances;

  constructor(){
    balances[msg.sender] = totalSupply;
    owner=msg.sender;
  }
  function balances_increment_bySec(address _current) public{
    

  }
  function withdraw(address _address) public {
    
  }
}


