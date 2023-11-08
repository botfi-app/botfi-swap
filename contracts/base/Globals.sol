// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../interfaces/@uniswap/v2/v2-periphery/interfaces/IUniswapV2Router02.sol";
import "../interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Factory.sol";
import "../interfaces/@uniswap/v3/v3-core/interfaces/IUniswapV3Factory.sol";
import "../interfaces/@uniswap/v3/v3-periphery/interfaces/ISwapRouter.sol";

contract Globals {

    // the protocol fee 
    uint protocolFee;

    // native token 
    address nativeToken = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    struct DexParams {
        bytes32             dex;
        IUniswapV2Router02  v2Router;
        IUniswapV2Factory   v2Factory;
        ISwapRouter         v3Router; 
        IUniswapV3Factory   v3Factory;
        uint256             createdAt;
        bool                enabled; 
    }

}