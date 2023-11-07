const Utils = require("../../../classes/Utils");

module.exports = {
    uniswap: {
        v2: {
            router: "0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45"
        },
        v3: {
            router: "0xE592427A0AEce92De3Edee1F18E0157C05861564",
            factory: "0x1F98431c8aD98523631AE4a59f267346ea31F984"
        }
    },
    pancakeswap: {
        v2: {
            router: "0xEfF92A263d31888d860bD50809A8D171709b7b1c"
        },
        v3: {
            router: "0x1b81D678ffb9C0263b24A97847620C99d213eB14",
            factory: "0x0BFbCF9fa4f9C56B0F40a671Ad40E0805A091865"
        }
    },

    sushi: {
        v2: {
            router: "0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F"
        },
        v3: {
            router: Utils.zeroAddress,
            factory: Utils.zeroAddress
        }
    }
}