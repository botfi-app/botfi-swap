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

    traderjoe_v2_1: {
        factory: "0x8e42f2F4101563bF679975178e880FD87d3eFd4e", 
        router: "0xb4315e873dBcf96Ffd0acd8EA43f689D8c20fB30",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7", 
        quoter:  "0xd76019A16606FDa4651f636D9751f500Ed776250",
        group:   "tjoe_v21"
    },

    traderjoe_v2_0: {
        factory: "0x6E77932A92582f504FF6c4BdbCef7Da6c198aEEf", 
        router:  "0xE3Ffc583dC176575eEA7FD9dF2A7c65F7E23f4C3",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7", 
        quoter:  "0x9dbf1706577636941ab5f443d2aebe251ccd1648",
        group:   "tjoe_v20"
    },

    uniswap_v3: {
        factory: "0x740b1c1de25031C31FF4fC9A62f554A55cdC1baD",
        router:  "0xbb00FF08d01D300023C629E8fFfFcb65A5a578cE",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7",
        quoter:  "0xbe0F5544EC67e9B3b2D979aaA43f18Fd87E6257F",
        group:   "uni_v3"
    },


    // pangolin exchange ///
    pangolin_v2: {
        factory: "0xefa94DE7a4656D787667C749f7E1223D71E9FD88",
        router:  "0xE54Ca86531e17Ef3616d22Ca28b0D458b6C89106",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7",
        quoter:  _0x,
        group:   "png_v20"
    },

    // end pangolin exchange ///

    // sushi 
    sushi_v2: {
        factory: "0xc35DADB65012eC5796536bD9864eD8773aBc74C4",
        router:  "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7",
        quoter:  _0x,
        group:   "uni_v2"
    }
    //end sushi

}