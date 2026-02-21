const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
require("dotenv").config();

module.exports = buildModule("StaffPayment", (m) => {
    const tokenAddress = process.env.TOKEN_ADDRESS;
    const staffPayment = m.contract("StaffPayment", [tokenAddress]);
    return { staffPayment };
});