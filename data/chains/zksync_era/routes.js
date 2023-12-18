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

let weth = "0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91"

module.exports = {


    pancakeswap_v2: {
        factory: "0xd03D8D566183F0086d8D09A84E1e30b58Dd5619d",
        router:  "0x5aEaF2883FBf30f3D62471154eDa3C0c1b05942d",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },

    pancakeswap_v3: {
        factory: "0x1BB72E0CbbEA93c08f535fc7856E0338D7F7a8aB",
        router:  "0xD70C70AD87aa8D45b8D59600342FB3AEe76E3c68",
        weth,
        quoter:  "0x3d146FcE6c1006857750cBe8aF44f76a28041CCc",
        group:   "uni_v3"
    },


    spacefi_v2: {
        factory: "0x0700Fb51560CfC8F896B2c812499D17c5B0bF6A7",
        router:  "0xbE7D1FD1f6748bbDefC4fbaCafBb11C6Fc506d1d",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },


    mute_v2: {
        factory: "0x40be1cBa6C5B47cDF9da7f963B6F761F4C60627D",
        router:  "0x8B791913eB07C32779a16750e3868aA8495F5964",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },
    
    zkswap_v2: {
        factory: "0x3a76e377ED58c8731F9DF3A36155942438744Ce3",
        router:  "0x18381c0f738146Fb694DE18D1106BdE2BE040Fa4",
        weth,
        quoter:  _0x,
        group:   "uni_v2"
    },
}