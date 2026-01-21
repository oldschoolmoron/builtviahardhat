// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Counter} from "./Counter.sol";
import {Test} from "forge-std/Test.sol";

// Solidity tests are compatible with foundry, so they
// use the same syntax and offer the same functionality.

contract CounterTest is Test {
  Counter counter;

  function setUp() public {
    counter = new Counter(102);
  }

  function test_Increament() public {
    counter.Increament();
    counter.Increament();
    require(counter.num() == 104, "Initial value should be 104");
  }

 function test_Decreament() public {
  counter.Decreament();
  require(counter.num() == 101, "Initial value should be 101");
 }
}
