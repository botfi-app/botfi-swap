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
        router: "0xE3Ffc583dC176575eEA7FD9dF2A7c65F7E23f4C3",
        factory: "0x6E77932A92582f504FF6c4BdbCef7Da6c198aEEf", 
        weth:    "0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7", 
        group:   "tjoe_v21"
    },

    traderjoe_v2_0: {
        router: "0xE3Ffc583dC176575eEA7FD9dF2A7c65F7E23f4C3",
        factory: "0x6E77932A92582f504FF6c4BdbCef7Da6c198aEEf", 
        weth:    "0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7", 
        group:   "tjoe_v20"
    },

    uniswap_v3: {
        router:  "0xbb00FF08d01D300023C629E8fFfFcb65A5a578cE",
        factory: "0x740b1c1de25031C31FF4fC9A62f554A55cdC1baD",
        weth:    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7",
        group:   "uni_v3"
    },

}