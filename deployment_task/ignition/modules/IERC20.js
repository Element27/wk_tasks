const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("IERC20Module", (m) => {
    const ierc20 = m.contract("IERC20");
    return { ierc20 };
});