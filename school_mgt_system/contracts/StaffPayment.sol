// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../interfaces/IERC20.sol";

// Pay staffs
// Suspend staffs
// And employ new staffs

contract StaffPayment {
    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    struct Staff {
        address wallet;
        uint256 salary;
        bool isActive;
        string name;
    }

    mapping(address => Staff) public staff;

    // add staff
    function addStaff(
        address _wallet,
        uint256 _salary,
        string memory _name
    ) external {
        require(staff[_wallet].wallet == address(0), "Staff already exists");
        staff[_wallet] = Staff({
            wallet: _wallet,
            salary: _salary,
            isActive: true,
            name: _name
        });
    }

    // remove staff
    function removeStaff(address _wallet) external {
        require(staff[_wallet].wallet != address(0), "Staff does not exist");
        staff[_wallet].isActive = false;
    }

    // update staff
    function updateStaff(
        address _wallet,
        uint256 _salary,
        string memory _name
    ) external {
        require(staff[_wallet].wallet != address(0), "Staff does not exist");
        staff[_wallet].salary = _salary;
        staff[_wallet].name = _name;
    }

    // pay staff
    function payStaff(address _wallet) external {
        require(staff[_wallet].wallet != address(0), "Staff does not exist");
        require(staff[_wallet].isActive, "Staff is not active");
        require(
            token.transferFrom(msg.sender, _wallet, staff[_wallet].salary),
            "Transfer failed"
        );
        staff[_wallet].salary = 0;
    }
}
