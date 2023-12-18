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

let weth = "0x4200000000000000000000000000000000000006"

module.exports = {

    uniswap_v3: {
        factory: "0x1F98431c8aD98523631AE4a59f267346ea31F984",
        router:  "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45",
        weth,
        quoter:  "0x61fFE014bA17989E743c5F6cB21bF9697530B21e",
        group:   "uni_v3"
    },

    zipswap_v2: {
        factory: "0x8BCeDD62DD46F1A76F8A1633d4f5B76e0CDa521E",
        router:  "0xE6Df0BB08e5A97b40B21950a0A51b94c4DbA0Ff6",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

    velodrome_v2: {
        factory: "0xF1046053aa5682b4F9a81b5481394DA16BE5FF5a",
        router:  "0xa062aE8A9c5e11aaA026fc2670B0D65cCc8B2858",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

}