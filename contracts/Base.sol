// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IUniswapV2Router02.sol";
import "./interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Factory.sol";
import "./interfaces/@uniswap/v3/v3-core/interfaces/IUniswapV3Factory.sol";
import "./interfaces/@uniswap/v3/v3-periphery/interfaces/ISwapRouter.sol";

contract Base {

    // the protocol fee 
    uint protocolFee;

    IUniswapV2Router02 uniV2Router;
    IUniswapV2Factory  uniV2Factory; 

    IUniswapV3Factory uniV3Factory; 
    ISwapRouter uniV3Router;

    constructor(
        uint256      _protocolFee,
        address      _uniV2Router,
        address      _uniV3Router
    ) {

        protocolFee = _protocolFee;

        uniV2Router = IUniswapV2Router02(_uniV2Router);
        uniV3Router = ISwapRouter(_uniV3Router);


        if(_uniV2Router != address(0)){
            uniV2Factory = IUniswapV2Factory(uniV2Router.factory());
        }

        if(_uniV3Router != address(0)) {
            
        }
    }


}
