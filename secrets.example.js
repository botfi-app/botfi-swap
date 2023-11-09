const path = require("path")

module.exports = {

    accounts: [
        "xxxx",
    ],

    noderealApiKey: "xxx",
    
    etherscanAPIKey: "xxx",
    

    abiExportPaths: [
        path.resolve("../botfi-wallet/src/data/abi/botfi_swap"),
        path.resolve("../botfi-backend/src/data/abi/botfi_swap")
    ],

    contractAddressesExportPaths: [
        path.resolve("../botfi-wallet/src/config/contracts/botfi_swap"),
        path.resolve("../botfi-backend/src/config/contracts/botfi_swap")
    ]
}