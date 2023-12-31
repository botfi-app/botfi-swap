require("@nomicfoundation/hardhat-toolbox");

//require("@nomiclabs/hardhat-waffle");

require("@nomiclabs/hardhat-ethers");

require('hardhat-contract-sizer', { runOnCompile: true });

require('hardhat-deploy');

require('hardhat-abi-exporter',{ path: 'data/abi', clear: true });

const {
  accounts,
  noderealApiKey,
  buildBearApiKey
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

    eth_mainnet: {
      url: `https://ethereum.publicnode.com`,
      chainId: 1,
      accounts
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
    
    bnbchain_mainnet: {
      url:  `https://bsc.publicnode.com`,
      chainId: 56,
      accounts
    },

    bnbchain_fork: {
      url:  `https://rpc.tenderly.co/fork/74914579-a14a-4054-ba3a-7cd616136ef7`,
      chainId: 56,
      accounts
    },

    avax_mainnet: {
      url:  `https://api.avax.network/ext/bc/C/rpc`,
      chainId: 43114,
      accounts
    },

    buildbear_avax: {
      url: `https://rpc.buildbear.io/${buildBearApiKey}`,
      chainId: 12602,
      accounts
    },

    polygon_mainnet: {
      url: `https://polygon-bor.publicnode.com`,
      chainId: 137,
      accounts
    },


    arb_one: {
      url: `https://arbitrum-one.publicnode.com`,
      chainId: 42161,
      accounts
    },

    op: {
      url: `https://optimism.publicnode.com`,
      chainId: 10,
      accounts
    },

    base: {
      url: `https://base.publicnode.com`,
      chainId: 8453,
      accounts
    },

    gnosis: {
      url: `https://gnosis.publicnode.com`,
      chainId: 100,
      accounts
    },

    zksync_era: {
      url: `https://mainnet.era.zksync.io`,
      chainId: 324,
      accounts
    },

    linea: {
      url: `https://rpc.linea.build`,
      chainId: 59144,
      accounts
    },

  },

  etherscan: { // npx hardhat --network buildbear_avax  verify 0x4Bf3208528D51c1323dbE243cDD0b69f0a9bc5eD
    apiKey: {
      buildbear: "verifyContract",
    },
    customChains: [
      {
        network: "buildbear",
        chainId: 12602,
        urls: {
          apiURL: "https://rpc.buildbear.io/verify/etherscan/accepted-tarfful-669a5ec0",
          browserURL: "https://explorer.buildbear.io/accepted-tarfful-669a5ec0",
        },
      },
    ],
  },

  solidity: "0.8.20",
};
