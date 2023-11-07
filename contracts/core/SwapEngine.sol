// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../ContractBase.sol";

contract SwapEngine is ContractBase {

     bool initialized; 

    // the protocol fee 
    uint protocolFee;

    IUniswapV2Router02 uniV2Router;
    IUniswapV2Factory  uniV2Factory; 
    IERC20Metadata     uniV2WETH;

    IUniswapV3Factory uniV3Factory; 
    ISwapRouter uniV3Router;

    DexParams[] public dexes;
    
    function __initSwapEngine (
        uint256      _protocolFee,
        address       _uniV2Router,
        address      _uniV3Router,
        address      _uniV3Factory
    ) internal {

        require(!initialized, "BotFi: ALREADY_INITIALIZED");

        protocolFee = _protocolFee;
        
        //setup uniswap v2 contract
        __setUpUniV2(_uniV2Router);

        // setup uniswap v3 contract
        __setUpUniV3(_uniV3Router, _uniV3Factory);

        initialized = true; 
    }

    /**
     * @dev set up uniswap v2 contract
     * @param _uniV2Router uniswap v2 router address
     */
    function __setUpUniV2( address _uniV2Router)
        private 
    {

        uniV2Router = IUniswapV2Router02(_uniV2Router);

        if(_uniV2Router != address(0)){
            uniV2Factory = IUniswapV2Factory(uniV2Router.factory());
        }

        uniV2WETH = IERC20Metadata(uniV2Router.WETH());
    }

    /**
     * 
     * @param _uniV3Router uniswap v3 router address
     */
    function __setUpUniV3( 
        address _uniV3Router,
        address _uniV3Factory
    )
        private 
    {

        if()
    }

}