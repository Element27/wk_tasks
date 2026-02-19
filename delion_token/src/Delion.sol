// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Delion {

    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 private _totalSupply;

    mapping(address => uint256) private balances;

    mapping(address => mapping(address => uint256)) private allowances;


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        _mint(msg.sender, initialSupply);
    }


    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }


    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }


    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }


    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowances[owner][spender];
    }


    function approve(address spender, uint256 amount) public returns (bool) {
        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }


    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {

        uint256 currentAllowance = allowances[from][msg.sender];
        require(currentAllowance >= amount, "ERC20: insufficient allowance");

        allowances[from][msg.sender] = currentAllowance - amount;

        _transfer(from, to, amount);

        return true;
    }


    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {

        require(from != address(0), "ERC20: transfer from zero address");
        require(to != address(0), "ERC20: transfer to zero address");

        uint256 senderBalance = balances[from];
        require(senderBalance >= amount, "ERC20: insufficient balance");

        balances[from] = senderBalance - amount;
        balances[to] += amount;

        emit Transfer(from, to, amount);
    }


    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "ERC20: mint to zero address");

        _totalSupply += amount;
        balances[to] += amount;

        emit Transfer(address(0), to, amount);
    }


    function _burn(address from, uint256 amount) internal {
        require(from != address(0), "ERC20: burn from zero address");

        uint256 balance = balances[from];
        require(balance >= amount, "ERC20: burn exceeds balance");

        balances[from] = balance - amount;
        _totalSupply -= amount;

        emit Transfer(from, address(0), amount);
    }
}
