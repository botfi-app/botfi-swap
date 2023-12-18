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

    uniswap_v3: {
        factory: "0x1F98431c8aD98523631AE4a59f267346ea31F984",
        router:  "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  "0x61fFE014bA17989E743c5F6cB21bF9697530B21e",
        group:   "uni_v3"
    },

    pancakeswap_v2: {
        factory: "0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E",
        router:  "0x8cFe327CEc66d1C090Dd72bd0FF11d690C33a2Eb",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  _0x,
        group:   "uni_v2"
    },

    pancakeswap_v3: {
        factory: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865",
        router:  "0x1b81D678ffb9C0263b24A97847620C99d213eB14",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  "0xB048Bbc1Ee6b733FFfCFb9e9CeF7375518e25997",
        group:   "uni_v3"
    },

    sushi_v3: {
        factory: "0x1af415a1EbA07a4986a52B6f2e7dE7003D82231e",
        router:  "0x8A21F6768C1f8075791D08546Dadf6daA0bE820c",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  "0x0524E833cCD057e4d7A296e3aaAb9f7675964Ce1",
        group:   "uni_v3"
    },

    traderjoe_v2_1: {
        factory: "0x8e42f2F4101563bF679975178e880FD87d3eFd4e", 
        router:  "0xb4315e873dBcf96Ffd0acd8EA43f689D8c20fB30",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1", 
        quoter:  "0xd76019A16606FDa4651f636D9751f500Ed776250",
        group:   "tjoe_v21"
    },

    traderjoe_v2_0: {
        factory: "0x1886D09C9Ade0c5DB822D85D21678Db67B6c2982", 
        router:  "0x7BFd7192E76D950832c77BB412aaE841049D8D9B",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1", 
        quoter:  "0x7f281f22eDB332807A039073a7F34A4A215bE89e",
        group:   "tjoe_v20"
    },

    zyberswap_v2: {
        factory: "0xaC2ee06A14c52570Ef3B9812Ed240BCe359772e7",
        router:  "0x16e71B13fE6079B4312063F7E81F76d165Ad32Ad",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  _0x,
        group:   "uni_v2"
    },

    camelot_v2: {
        factory: "0x6EcCab422D763aC031210895C81787E87B43A652",
        router:  "0xc873fEcbd354f5A56E00E710B90EF4201db2448d",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  _0x,
        group:   "uni_v2"
    },

    spartadex_v2: {
        factory: "0xFe8EC10Fe07A6a6f4A2584f8cD9FE232930eAF55",
        router:  "0x89AE36E3B567b914a5E97E6488C6EB5b9C5d0231",
        weth:    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1",
        quoter:  _0x,
        group:   "uni_v2"
    },
}