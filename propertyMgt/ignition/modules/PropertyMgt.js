const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("PropertyMgtModule", (m) => {
    const PropertyMgt = m.contract("PropertyMgt", ["0xEd3916649611c6b123358c36604aaF9F38149D6D"]);
    return { PropertyMgt };
});