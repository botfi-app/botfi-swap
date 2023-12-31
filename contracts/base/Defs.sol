// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Defs {

    // the protocol fee 
    uint PROTOCOL_FEE;

    // the fee address, for taking fees 
    address FEE_WALLET;

    bytes32 UNI_V3 = bytes32("uni_v3");

    // native token 
    address constant NATIVE_TOKEN = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;


    // id  =>  RouteParams 
    mapping (bytes32 => RouteParams) public routes;
    bytes32[] public routesIds;

    struct RouteParams {
        bytes32             id;
        bytes32             group; //adapter name uni_v2, uni_v3 and 1inch, balancer
        address   payable   router;
        address             factory;
        address             weth;
        address             quoter;
        uint256             createdAt;
        bool                enabled; 
    }

    struct SwapGasInfo {
        uint256    gasUsed;
        uint256    gasPrice; 
        uint256    gasLimit; 
    }

    /**
     * @dev convert percentage in basis point of a value 
     * @param amount the amount to be calculated on
     * @param bps percentage value in basis point
     */
    function calPercentage(uint amount, uint bps) 
        public 
        pure 
        returns (uint256)
    {
        require((amount * bps) >= 10_000);
        return (amount * bps) / 10_000;
    }

}