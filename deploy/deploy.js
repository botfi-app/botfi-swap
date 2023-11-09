
const hre = require("hardhat")
const secrets = require("../.secrets")
const Utils = require("../classes/Utils")
const dappArgs = require("../dappArgs")
const { utils: ethersUtils } = require("ethers")

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

        // lets set up the dexes 
        let routers = require(`../data/chains/${networkName}/routers.js`)
        
        //console.log("dexesInfo===>", dexesInfo)

        let factoryContract = new ethers.Contract(
                                deployedFactory.address,
                                deployedFactory.abi,
                                signer
                            )

        let factoryIface = new ethers.utils.Interface(deployedFactory.abi);


        let dexesInputs = []

        for(let routerId of Object.keys(routers)){
            
            let routerInfo = routers[routerId]

            let routerIdByte32 = ethersUtils.formatBytes32String(
                                routerId.trim().toLowerCase()
                            );

            let adapterByte32 = ethersUtils.formatBytes32String(
                                    routerInfo.adapter.trim().toLowerCase()
                                );

            let data =  factoryIface.encodeFunctionData(
                            "addRouter", 
                            [
                                routerIdByte32, 
                                adapterByte32,
                                routerInfo.router,
                                routerInfo.factory, 
                                routerInfo.weth,
                                true 
                            ]
                        );

            dexesInputs.push(data)
        }

        Utils.infoMsg("adding dexes with multicall")
        
        let factoryMcall = await factoryContract.multicall(dexesInputs)

        //lets wait for tx to complete 
        await factoryMcall.wait();

        Utils.successMsg("addDex multicall success: "+ factoryMcall.hash)

    }  catch(e) {
        console.log(e,e.stack)
    }

}


/**
 * setUpDexes
 */
const setUpDexes = async () => {

}