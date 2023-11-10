require("@nomicfoundation/hardhat-toolbox");

//require("@nomiclabs/hardhat-waffle");

require("@nomiclabs/hardhat-ethers");

require('hardhat-contract-sizer', { runOnCompile: true });

require('hardhat-deploy');

require('hardhat-abi-exporter',{ path: 'data/abi', clear: true });

const {
  accounts,
  noderealApiKey
} = require("./.secrets")


module.exports = {

  networks: {

    hardhat: {
      accounts: accounts.map( privateKey => ({ 
          privateKey, 
          "balance": "991229544000000000000"
      })),
      forking: {
        url: `https://eth-mainnet.nodereal.io/v1/${noderealApiKey}`,
      },
      chainId: 1337
    },

    goerli: {
      url: `https://ethereum-goerli.publicnode.com`,
      chainId: 5,
      accounts
    },   
    
    bsc_testnet: {
      url: `https://data-seed-prebsc-2-s1.binance.org:8545/`,
      chainId: 97,
      accounts
    },   
    
    bsc_mainnet: {
      url:  `https://bsc-dataseed4.binance.org/`,
      chainId: 56,
      accounts
    }

  },
  solidity: "0.8.20",
};
