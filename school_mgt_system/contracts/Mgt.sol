// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "../interfaces/IERC20.sol";

contract Mgt {
    address public admin;
    IERC20 public token;

    struct Student {
        string name;
        uint8 grade;
        uint256 totalFees;
        uint256 paidFees;
        bool isRegistered;
    }

    mapping(address => Student) public students;
    mapping(uint8 => uint256) public gradeFees; // Grade => Amount in Delion Tokens

    event StudentRegistered(address student, string name, uint8 grade);
    event FeesUpdated(uint8 grade, uint256 newAmount);
    event PaymentMade(address student, uint256 amount, uint256 remaining);

    modifier Admin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    constructor(address _tokenAddress) {
        admin = msg.sender;
        token = IERC20(_tokenAddress);
    }

    // 1. Set fees for a specific grade (Admin Only)
    function setGradeFee(uint8 _grade, uint256 _amount) external Admin {
        gradeFees[_grade] = _amount;
        emit FeesUpdated(_grade, _amount);
    }

    // 2. Register or Update Student Data
    function registerStudent(address _studentAddr, string memory _name, uint8 _grade) external Admin {
        uint256 fee = gradeFees[_grade];
        require(fee > 0, "Fee not set for grade");

        students[_studentAddr] = Student({
            name: _name,
            grade: _grade,
            totalFees: fee,
            paidFees: 0,
            isRegistered: true
        });

        emit StudentRegistered(_studentAddr, _name, _grade);
    }

    // 3. Pay Fees (Either immediate or later)
    // The student must call 'approve(schoolAddress, amount)' on the Delion contract first!
    function payFees(uint256 _amount) external {
        Student storage s = students[msg.sender];
        require(s.isRegistered, "Not a registered student");
        require(s.paidFees + _amount <= s.totalFees, "Overpaying fees");

        // Execute token transfer
        bool success = token.transferFrom(msg.sender, address(this), _amount);
        require(success, "Token transfer failed");

        s.paidFees += _amount;
        emit PaymentMade(msg.sender, _amount, s.totalFees - s.paidFees);
    }
}