
const hre = require("hardhat")
const secrets = require("../.secrets")
const Utils = require("../classes/Utils")
const dappArgs = require("../dappArgs")
const { utils: ethersUtils } = require("ethers")
const fsp = require("fs/promises")
const _lodash = require("lodash")
const path = require("path")


module.exports = async ({getUnnamedAccounts, deployments, ethers, network}) => {

    try{

        console.log("getUnnamedAccounts===>", getUnnamedAccounts)

        let deployedData = {}
        let deployedContractsAddresses = {}

        const {deploy} = deployments;
        const [owner, proxyAdmin] = await getUnnamedAccounts();
        let networkName = network.name;
        let chainId = (await ethers.provider.getNetwork()).chainId;

        let signer = await ethers.getSigner(owner)

        Utils.successMsg(`owner: ${owner}`)
        Utils.successMsg(`networkName: ${networkName}`) 
        Utils.successMsg(`chainId: ${chainId}`)

        Utils.infoMsg("Deploying Factory Contract")

        let deployedFactory = await deploy('Factory', {
            from: owner,
            args: [dappArgs.protocolFeeBasisPoint, dappArgs.feeWallet],
            log: true
        });
        

        Utils.successMsg(`Factory Deloyed: ${deployedFactory.address}`);

        deployedContractsAddresses["factory"] = deployedFactory.address;

        /*
        Utils.infoMsg("Deploying Multicall3 Contract")

        let deployedMuticall3 = await deploy('Multicall3', {
            from: owner,
            args: [],
            log: true
        });
        
        Utils.successMsg(`Multicall3 Deloyed: ${deployedMuticall3.address}`);

        deployedContractsAddresses["multicall3"] = deployedMuticall3.address;
        */

        //initialize factory contract
        let factoryContract = new ethers.Contract(
                                deployedFactory.address,
                                deployedFactory.abi,
                                signer
                            )

        let factoryIface = new ethers.utils.Interface(deployedFactory.abi);
        
        // lets set up the dexes 
        let routes = require(`../data/chains/${networkName}/routes.js`)
        

        let routesInputs = []

        for(let routeId of Object.keys(routes)){
            
            let routeInfo = routes[routeId]

            let routeIdByte32 = ethersUtils.formatBytes32String(
                                routeId.trim().toLowerCase()
                            );

            let groupByte32 = ethersUtils.formatBytes32String(
                                    routeInfo.group.trim().toLowerCase()
                                );

            let data =  factoryIface.encodeFunctionData(
                            "addRoute", 
                            [
                                routeIdByte32, 
                                groupByte32,
                                routeInfo.router,
                                routeInfo.factory, 
                                routeInfo.weth,
                                true 
                            ]
                        );

            routesInputs.push(data)
        }

        Utils.infoMsg("adding routes with multicall")
        
        let factoryMcall = await factoryContract.multicall(routesInputs, true)

        //lets wait for tx to complete 
        await factoryMcall.wait();

        Utils.successMsg("addRoute multicall success: "+ factoryMcall.hash)
        
        // export contract addresses
        await exportContractAddresses({ chainId, deployedContractsAddresses })

        let deployedContracts = {
            factory: deployedFactory,
            //multicall3: deployedMuticall3
        }

        // export contract abis 
        await exportContractABIs({ chainId, networkName, deployedContracts })

        await addChainToSupportSwapRegistry({ chainId, networkName })

    }  catch(e) {
        console.log(e,e.stack)
    }

}


const exportContractAddresses = async ({ 
    chainId, 
    networkName,
    deployedContractsAddresses
}) => {

    // export contract info to the provide paths
    Utils.infoMsg("Exporting contract addresses")

    let contractAddrsExportPaths = secrets.contractAddressesExportPaths || []

    for(let configDirPath of contractAddrsExportPaths){
        
        //lets create the path 
        await fsp.mkdir(configDirPath, {recursive: true})

        let configFilePath = `${configDirPath}/${chainId}.json`;

        // lets now fetch the data 
        let contractInfoData = {}

        try {
            contractInfoData = require(configFilePath)
        } catch(e){}

        let swapData =  contractInfoData["swap"] || {}

        swapData =  _lodash.merge({}, swapData, deployedContractsAddresses)

        contractInfoData["swap"] = swapData

        //contractInfoData = _lodash.merge({}, , )

        Utils.infoMsg(`New Config For ${networkName} - ${JSON.stringify(contractInfoData, null, 2)}`)

        Utils.successMsg(`Saving ${chainId} contract info to ${configFilePath}`)
        console.log()

        //lets save it back
        await fsp.writeFile(configFilePath, JSON.stringify(contractInfoData, null, 2));
    }
}

//export contract abis 
const exportContractABIs = async ({ 
    chainId, 
    deployedContracts
}) => {

    let {
        factory,
        multicall3
    } = deployedContracts

    Utils.successMsg(`Exporting abi files`);

    await hre.run("export-abi");

     // let export the abi
     let abiExportsPathsArray = secrets.abiExportPaths || []

     for(let exportPath of abiExportsPathsArray) {

         let exportDir = `${exportPath}/`
         
         let swapExportDir = `${exportDir}/swap/`

         await fsp.mkdir(swapExportDir, {recursive: true})
         
         Utils.successMsg(`Exporting factory.json to ${exportPath}/factory.json`);
         await fsp.writeFile(`${swapExportDir}/factory.json`, JSON.stringify(factory.abi, null, 2));

         /*
         Utils.successMsg(`Exporting multicall3.json to ${exportPath}/multicall3.json`);
         await fsp.writeFile(`${swapExportDir}/multicall3.json`, JSON.stringify(multicall3.abi, null, 2));
        */
     }

}

const addChainToSupportSwapRegistry = async ({
    chainId,
    networkName
}) => {

    const swapSupportedChainsRegistry = secrets.swapSupportedChainsRegistry || []

    for(let configPath of swapSupportedChainsRegistry) {
        
        let dirPath =  path.dirname(configPath)

        Utils.successMsg(`Registering ${chainId} as supported chain for swap as ${configPath}`)

        await Utils.mkdir(dirPath)

        // lets now fetch the data 
        let configData = {}

        try {
            configData = require(configPath)
        } catch(e){}

        configData[chainId] = true 

        Utils.successMsg(`Writing swapSupportedChainsRegistry data  to ${configPath}`)
        console.log()

        //lets save it back
        await fsp.writeFile(configPath, JSON.stringify(configData, null, 2))
    }
}