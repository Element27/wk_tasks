const hre = require("hardhat");

async function main() {



  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with account:", deployer.address);

  // --- STEP 1: Deploy (or identify) the Delion Token ---
  // If you already deployed Delion, replace the address below.
  // Otherwise, this script will deploy a fresh one.
  let delionAddress = "0x6717F5eDb69B90a1Aba14B2Ad0F8B8D0995d2805"; 

  
  // --- STEP 2: Deploy SchoolSystem ---
  const Mgt = await hre.ethers.getContractFactory("Mgt");
  const school = await Mgt.deploy(delionAddress);
  await school.waitForDeployment();
  const schoolAddress = await school.getAddress();

  console.log("Mgt deployed to:", schoolAddress);

  // --- STEP 3: Initial Setup (Optional but helpful) ---
  // Let's set the fee for Grade 1 to 50 DLN tokens automatically
  const feeAmount = hre.ethers.parseUnits("50", 18);
  await school.setGradeFee(1, feeAmount);
  console.log("Set Grade 1 fee to 50 DLN");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});