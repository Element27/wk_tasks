const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("DelionNodule", (m) => {

  const delion = m.contract("Delion", []); 

  return { delion };

});