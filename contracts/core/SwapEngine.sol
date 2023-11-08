// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../ContractBase.sol";

contract SwapEngine is ContractBase {

    bool initialized; 

    // dexId Uint => Dex Params 
    mapping (bytes32 => DexParams) public dexesParams;
    bytes32[] public dexes;
    

    function addDex(
        bytes32 dex,
        IUniswapV2Router02 uniV2Router, 
        ISwapRouter        uniV3Router,
        address            uniV3Factory,
        bool               enabled
    ) 
        public 
        onlyOwner 
    {

        bool isNew = (dexesParams[dex].createdAt == 0);

        address v2FactoryAddr = (address(uniV2Router) == address(0))
                                ? address(0) 
                                : uniV2Router.factory();

        uint createdAt = (isNew) ? block.timestamp : dexesParams[dex].createdAt;

        dexesParams[dex] = DexParams(
            dex,
            uniV2Router,
            IUniswapV2Factory(v2FactoryAddr),
            ISwapRouter(uniV3Router),
            IUniswapV3Factory(uniV3Factory),
            createdAt,
            enabled
        );

        if(isNew) dexes.push(dex);
    
    }
    

    /**
     * @dev swap uniswap v2
     * @param amount the input amount
     * @param tokenIn the input token address 
     * @param tokenOut the output token address
     */
    function swapV2(
        bytes32 dex,
        uint256 amount, 
        address tokenA, 
        address tokenB,
        bool    tokenSupportingFee
    ) 
        public 
        payable
    {

        DexParams memory _dex = dexesParams[dex];

        require(_dexInfo.createdAt > 0, "BotFi: UNSUPPORTED_DEX");
        require(address(_dex.v2Router) != address(0), "BotFi: V2_SWAP_UNSUPPORTED");

        if(tokenA == nativeToken) {
            
            //validate native token input
            require(msg.value == amount, "BotFi: INSUFFICIENT_BALANCE");

            tokenA = _dex.v2Router.WETH();
        }
        
        if(tokenB == nativeToken){
            tokenB = _dex.v2Router.WETH();
        }

        address[] memory pair = [tokenA, tokenB];
    }


}