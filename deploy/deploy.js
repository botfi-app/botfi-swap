
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
            args: [dappArgs.protocolFeeBasisPoint],
            log: true
        });
        

        Utils.successMsg(`Factory Deloyed: ${deployedFactory.address}`);

        deployedContractsAddresses["factory"] = deployedFactory.address;

        // lets set up the dexes 
        let dexesInfo = require(`../data/chains/${networkName}/dexes.js`)
        
        //console.log("dexesInfo===>", dexesInfo)

        let factoryContract = new ethers.Contract(
                                deployedFactory.address,
                                deployedFactory.abi,
                                signer
                            )

        let factoryIface = new ethers.utils.Interface(deployedFactory.abi);


        let inputs = []

        for(let dexName of Object.keys(dexesInfo)){
            
            let dexInfo = dexesInfo[dexName]

            let nameBytes32 = ethersUtils.formatBytes32String(dexName.toLowerCase());

            let data =  factoryIface.encodeFunctionData(
                            "addDex", 
                            [
                                nameBytes32, 
                                dexInfo.v2.router,
                                dexInfo.v3.router, 
                                dexInfo.v3.factory,
                                true 
                            ]
                        );

            inputs.push(data)
        }

        console.log("inputs===>", inputs)
    }  catch(e) {
        console.log(e,e.stack)
    }

}


/**
 * setUpDexes
 */
const setUpDexes = async () => {

}