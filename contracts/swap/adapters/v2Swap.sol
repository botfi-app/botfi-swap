// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../ContractBase.sol";
import "../../base/TransferHelper.sol";
import "../SwapEngine.sol";

contract v2Swap is SwapEngine {


    /**
     * @dev swap router v2
     * @param dex the name of the dex in bytes32
     * @param amount the input amount
     * @param tokenFrom the input token address 
     
    function swapV2(
        bytes32 dexId,
        uint256 amount, 
        address tokenFrom, 
        bytes calldata data
    ) 
        public 
        payable
    {

        
        require(address(dexes[dexId].v2Router) != address(0), 
            "BotFi: V2_SWAP_UNSUPPORTED"
        );

        if(tokenFrom == nativeToken) {
            //validate native token input
            require(msg.value == amount, "BotFi: INSUFFICIENT_BALANCE");
        } else {
            
            // lets transfer the tokens from the user
            transferAsset(tokenFrom, _msgSender(), address(this), amount);
        }

        //get fee amt
        uint feeAmt = amount - calPercentage(amount, protocolFee);
    }*/

}