// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Counter {
  uint public num = 0;
  constructor (uint _num)  {
    num = _num;
  }
  function Increament() public {
    num ++;
  }
  function  Decreament() public{
    num --;
  }
}
