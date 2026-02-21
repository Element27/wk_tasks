const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
require("dotenv").config();

module.exports = buildModule("Mgt", (m) => {
    const tokenAddress = process.env.TOKEN_ADDRESS;
    const mgt = m.contract("Mgt", [tokenAddress]);
    return { mgt };
});