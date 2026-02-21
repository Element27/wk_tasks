const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("SaveAssetModule", (m) => {
    const saveAsset = m.contract("SaveAsset", ["0xEd3916649611c6b123358c36604aaF9F38149D6D"]);
    return { saveAsset };
});