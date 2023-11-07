
const hre = require("hardhat")
const secrets = require("../.secrets")
const Utils = require("../classes/Utils")

module.exports = async ({getUnnamedAccounts, deployments, ethers, network}) => {

    try{

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

        
    }  catch(e) {
        console.log(e,e.stack)
    }
    
}