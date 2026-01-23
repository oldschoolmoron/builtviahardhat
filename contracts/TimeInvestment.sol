// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './MyToken.sol';

// interface IERC20 {
//     function transferFrom(address from, address to, uint256 amount) external returns (bool);
//     function transfer(address to, uint256 amount) external returns (bool);
// }

contract TimeInvestment {
    IERC20 public immutable token;

    uint256 public constant MAX_SUPPLY = 10_000 ether; // 10k tokens (18 decimals)
    uint256 public remainingSupply;

    struct UserInfo {
        uint256 balance;
        uint256 lastUpdated;
    }

    mapping(address => UserInfo) public users;

    constructor(address _token) {
        token = IERC20(_token);
        remainingSupply = MAX_SUPPLY;
    }


    function _updateRewards(address user) internal {
        UserInfo storage u = users[user];

        if (u.balance == 0) {
            u.lastUpdated = block.timestamp;
            return;
        }

        uint256 minutesPassed = (block.timestamp - u.lastUpdated) / 60;
        if (minutesPassed == 0) return;

        uint256 reward = minutesPassed * 1 ether;

        if (reward > remainingSupply) {
            reward = remainingSupply;
        }

        u.balance += reward;
        remainingSupply -= reward;
        u.lastUpdated = block.timestamp;
    }


    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");

        _updateRewards(msg.sender);

        token.transferFrom(msg.sender, address(this), amount);

        users[msg.sender].balance += amount;
        users[msg.sender].lastUpdated = block.timestamp;
    }

    function checkBalance(address user) external view returns (uint256) {
        UserInfo memory u = users[user];

        if (u.balance == 0) return 0;

        uint256 minutesPassed = (block.timestamp - u.lastUpdated) / 60;
        uint256 reward = minutesPassed * 1 ether;

        if (reward > remainingSupply) {
            reward = remainingSupply;
        }

        return u.balance + reward;
    }

    function withdraw(uint256 amount) external {
        UserInfo storage u = users[msg.sender];
        require(amount > 0, "Invalid amount");

        _updateRewards(msg.sender);
        require(u.balance >= amount, "Insufficient balance");

        u.balance -= amount;
        token.transfer(msg.sender, amount);

        if (u.balance > 0) {
            u.lastUpdated = block.timestamp;
        }
    }
}
