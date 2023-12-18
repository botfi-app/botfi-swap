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

   
    sushi_v3: {
        factory: "0xc35DADB65012eC5796536bD9864eD8773aBc74C4",
        router:  "0xb1E835Dc2785b52265711e17fCCb0fd018226a6e",
        weth:    "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f",
        quoter:  "0xFB7eF66a7e61224DD6FcD0D7d9C3be5C8B049b9f",
        group:   "uni_v3"
    },

    pancakeswap_v2: {
        factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
        router:  "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
        weth:    "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f",
        quoter:  _0x,
        group:   "uni_v2"
    },

    pancakeswap_v3: {
        factory: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865",
        router:  "0x1b81D678ffb9C0263b24A97847620C99d213eB14",
        weth:    "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f",
        quoter:  "0xB048Bbc1Ee6b733FFfCFb9e9CeF7375518e25997",
        group:   "uni_v3"
    },
 
    echodex_v2: {
        factory: "0x6D1063F2187442Cc9adbFAD2f55A96B846FCB399",
        router:  "0xc66149996d0263C0B42D3bC05e50Db88658106cE",
        weth:    "0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f",
        quoter:  _0x,
        group:   "uni_v2"
    },
 
}