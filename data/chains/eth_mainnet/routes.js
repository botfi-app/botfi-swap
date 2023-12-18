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

let weth = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"

module.exports = {

    uniswap_v2: {
        factory: "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f",
        router:  "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

    uniswap_v3: {
        factory: "0x1F98431c8aD98523631AE4a59f267346ea31F984",
        router:  "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45",
        weth,
        quoter:  "0x61fFE014bA17989E743c5F6cB21bF9697530B21e",
        group:   "uni_v3"
    },

    /*/ Start Pancakeswap //
    pancakeswap_v2: {
        factory: "0x1097053Fd2ea711dad45caCcc45EfF7548fCB362",
        router:  "0xEfF92A263d31888d860bD50809A8D171709b7b1c",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

    pancakeswap_v3: {
        factory: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865",
        router:  "0x1b81D678ffb9C0263b24A97847620C99d213eB14",
        weth,
        quoter:  "0xB048Bbc1Ee6b733FFfCFb9e9CeF7375518e25997",
        group:   "uni_v3"
    },
    ///End Pancakeswap ///


    // start sushi swap 
    sushi_v2: {
        factory: "0xC0AEe478e3658e2610c5F7A4A2E1777cE9e4f2Ac",
        router:  "0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

    traderjoe_v2_1: {
        factory: "0xDC8d77b69155c7E68A95a4fb0f06a71FF90B943a", 
        router:  "0x9A93a421b74F1c5755b83dD2C211614dC419C44b",
        weth, 
        quoter:  "0x4d6Dbd1b52807C71b9a148E222b167247a7cA789",
        group:   "tjoe_v21"
    },
    */
}