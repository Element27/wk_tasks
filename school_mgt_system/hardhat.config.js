require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

// We pull the key from .env
const PK = process.env.PRIVATE_KEY;

// This check helps us debug without showing the key
if (!PK) {
  console.warn("⚠️ WARNING: PRIVATE_KEY not found in .env file!");
}

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.ALCHEMY_API_URL || "",
      // If PK exists, we put it in the array. 
      // If not, we leave it empty so Hardhat doesn't crash on startup.
      accounts: PK ? [PK] : [],
    },
  },
};