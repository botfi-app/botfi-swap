// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../interfaces/@uniswap/v2/v2-periphery/interfaces/IUniswapV2Router02.sol";
import "../interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Factory.sol";
import "../interfaces/@uniswap/v3/v3-core/interfaces/IUniswapV3Factory.sol";
import "../interfaces/@uniswap/v3/v3-periphery/interfaces/ISwapRouter.sol";
import "../interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Pair.sol";

contract Globals {

    // the protocol fee 
    uint protocolFee;

    // the fee address, for taking fees 
    address feeAddress;

    // native token 
    address nativeToken = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    struct RouterParams {
        bytes32             id;
        bytes32             adapter; //adapter name uni_v2, uni_v3 and 1inch, balancer
        address             router;
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