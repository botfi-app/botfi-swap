const Utils = require("../../../classes/Utils");

const _0x = Utils.zeroAddress;

/**
 * groups:
 * 1. uni_v1 - uniswap based code v1
 * 2. uni_v2 - uniswap based code v2
 * 3. uni_v3 - uniswap based code v3
 * 4. tjoe_v20 - traderjoe v2.0
 * 5. tjoe_v21 - traderjoe v2.1
 */

module.exports = {

   /// Start uniswap v3
    uniswap_v3: {
        factory: "0xdB1d10011AD0Ff90774D0C6Bb92e5C5c8b4461F7",
        router:  "0xB971eF87ede563556b2ED4b1C0b0019111Dd85d2",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  "0x78D78E420Da98ad378D7799bE8f4AF69033EB077",
        group:   "uni_v3"
    },
    // END Uniswap v3 ////

    // Start Pancakeswap //
    pancakeswap_v2: {
        factory: "0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73",
        router:  "0x10ED43C718714eb63d5aA57B78B54704E256024E",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  _0x,
        group:   "uni_v2"
    },

    pancakeswap_v3: {
        factory: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865",
        router:  "0x1b81D678ffb9C0263b24A97847620C99d213eB14",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  "0xB048Bbc1Ee6b733FFfCFb9e9CeF7375518e25997",
        group:   "uni_v3"
    },
    ///End Pancakeswap ///

    // Start Biswap //
    biswap_v2: {
        factory: "0x858E3312ed3A876947EA49d572A7C42DE08af7EE",
        router:  "0x3a6d8cA21D1CF76F653A67577FA0D27453350dD8",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  _0x,
        group:   "uni_v2"
    },
    
    ///End Biswap ///

    // start sushi swap 
    sushi_v2: {
        factory: "0xc35DADB65012eC5796536bD9864eD8773aBc74C4",
        router:  "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  _0x,
        group:   "uni_v2"
    },

    // end sushi 
    
    // babyswap 
    babyswap_v2: {
        factory: "0x325e343f1de602396e256b67efd1f61c3a6b38bd",
        router:  "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  _0x,
        group:   "uni_v2"
    },
    // end baby swap

    // mdex v2 
    mdex_v2: {
        factory: "0x3CD1C46068dAEa5Ebb0d3f55F6915B10648062B8",
        router:  "0x7DAe51BD3E3376B8c7c4900E9107f12Be3AF1bA8",
        weth:    "0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c",
        quoter:  _0x,
        group:   "uni_v2"
    }
    // end mdex v2
}