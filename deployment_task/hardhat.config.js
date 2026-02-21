require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */



const LISK_PRIVATE_KEY = process.env.LISK_PRIVATE_KEY;
const LISK_RPC_URL = process.env.LISK_RPC_URL;
const LISK_CHAIN_ID = Number(process.env.LISK_CHAIN_ID);

module.exports = {
  solidity: "0.8.28",
  networks: {
    lisk_sepolia: {
      url: LISK_RPC_URL,
      accounts: LISK_PRIVATE_KEY ? [LISK_PRIVATE_KEY.startsWith("0x") ? LISK_PRIVATE_KEY : `0x${LISK_PRIVATE_KEY}`] : [],
      chainId: LISK_CHAIN_ID,
    },
  },
};
