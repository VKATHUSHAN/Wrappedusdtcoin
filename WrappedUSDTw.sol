/*
██╗  ██╗ █████╗ ████████╗
██║ ██╔╝██╔══██╗╚══██╔══╝
█████╔╝ ███████║   ██║   
██╔═██╗ ██╔══██║   ██║   
██║  ██╗██║  ██║   ██║   
╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
        K   A   T
*/

pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT

contract WrappedUSDTw {
    string public name = "Wrapped USDT";
    string public symbol = "WUSDT";
    uint8 public decimals = 6;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        allowance[from][msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    // Mint function for demonstration (no access control, add onlyOwner if needed)
    function mint(address to, uint256 value) public {
        totalSupply += value;
        balanceOf[to] += value;
        emit Transfer(address(0), to, value);
    }

    // Burn function for demonstration (no access control, add onlyOwner if needed)
    function burn(address from, uint256 value) public {
        require(balanceOf[from] >= value, "Insufficient balance");
        balanceOf[from] -= value;
        totalSupply -= value;
        emit Transfer(from, address(0), value);
    }
}