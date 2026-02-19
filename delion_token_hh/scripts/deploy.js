const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Define your token parameters
  const name = "Delion";
  const symbol = "DLN";
  const totalSupply = hre.ethers.parseUnits("1000000", 18); // 1 million tokens

  const delion = await hre.ethers.deployContract("Delion", [name, symbol, totalSupply]);

  await delion.waitForDeployment();

  console.log(`Delion deployed to: ${delion.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});