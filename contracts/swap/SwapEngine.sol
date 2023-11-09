// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ContractBase.sol";
import "../base/TransferHelper.sol";

contract SwapEngine is TransferHelper, ContractBase {

    bool initialized; 

    // dexId Uint => Dex Params 
    mapping (bytes32 => RouterParams) public routers;
    bytes32[] public routersIds;

    
      function addRouter(
        bytes32             id,
        bytes32             adapter, // uni_v2, uni_v3, 1inch, ...                  
        address  payable    router, 
        address             factory,
        address             weth,
        bool                enabled
    ) 
        public 
        onlyOwner 
    {

        require(router != address(0), "BotFi: ZERO_ROUTER_ADDRESS");

        bool isNew = (routers[id].createdAt == 0);
        uint createdAt = (isNew) ? block.timestamp : routers[id].createdAt;

        routers[id] = RouterParams(
            id,
            adapter, 
            router,
            factory,
            weth,
            createdAt,
            enabled
        );

        if(isNew) routersIds.push(id);
    }


    /**
     * @dev perform a swap
     * @param routerId the identifier of the router to use
     * @param amount the total amount including the protocol fee for the swap
     * @param tokenA the token to swap into another token (tokenB)
     * @param data the encoded swap data to foward to the router
     */ 
    function swap(
        bytes32 routerId,
        uint256 amount, 
        address tokenA, 
        bytes calldata data
    ) 
        public 
        payable
    {   

        require(routers[routerId].createdAt > 0, "BotFi: UNSUPPORTED_DEX");
        require(data.length > 0, "BotFi: DATA_ARG_REQUIRED");
        require(tokenA != address(0), "BotFi: ZERO_TOKENA_ADDR");

        if(tokenA == nativeToken) {
            //validate native token input
            require(msg.value == amount, "BotFi: INSUFFICIENT_BALANCE");
        } else {
            
            // lets transfer the tokens from the user
            transferAsset(tokenA, _msgSender(), address(this), amount);
        }

        //get fee amt
        uint feeAmt = amount - calPercentage(amount, protocolFee);

        // lets perform fee transfer 
        transferAsset(tokenA, _msgSender(), feeAddress, feeAmt);


        
    }
    
}   