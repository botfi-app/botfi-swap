// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Defs {

    // the protocol fee 
    uint PROTOCOL_FEE;

    // the fee address, for taking fees 
    address FEE_WALLET;

    // native token 
    address constant NATIVE_TOKEN = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    // adapters 
    bytes32 constant ADAPTER_UNI_V2 = bytes32("uni_v2");
    bytes32 constant ADAPTER_UNI_V3 = bytes32("uni_v3");

    // id  =>  RouteParams 
    mapping (bytes32 => RouterParams) public routers;
    bytes32[] public routersIds;

    struct RouterParams {
        bytes32             id;
        bytes32             adapter; //adapter name uni_v2, uni_v3 and 1inch, balancer
        address   payable   route;
        address             factory;
        address             weth;
        uint256             createdAt;
        bool                enabled; 
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