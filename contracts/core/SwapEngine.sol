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
    * @dev get the swap amount out for uni v2 
    * @param amountIn the amount to be swapped 
    * @param pairToken the pair token to swap
    * @param router the swap router
    * @param slippageBps the slipage tolerance in basis point
    */
    function __getV2AmountOut(
        uint256 amountIn, 
        address pairToken,
        IUniswapV2Router02 router, 
        uint256 slippageBps
    )
        internal 
        returns(uint256)
    {

        uint slipageAm
        IUniswapV2Pair pairToken = IUniswapV2Pair(pairToken);

        return 
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
        uint    slippage,
        bool    tokenSupportingFee
    ) 
        public 
        payable
    {

        require(tokenA != tokenB, "BotFi: TOKEN_A_B_SAME");
        require(amount > 0, "BotFi: ZERO_AMOUNT");
        require(slippage > 0, "BotFi: ZERO_SLIPPAGE");

        DexParams memory _dexInfo = dexesParams[dex];

        require(_dexInfo.createdAt > 0, "BotFi: UNSUPPORTED_DEX");
        require(address(_dexInfo.v2Router) != address(0), "BotFi: V2_SWAP_UNSUPPORTED");

        uint feeAmt;
        address weth = _dexInfo.v2Router.WETH();
        address recipient = address(this);

        if(tokenA == nativeToken) {
            
            //validate native token input
            require(msg.value == amount, "BotFi: INSUFFICIENT_BALANCE");

            tokenA = weth;

        } else {

            // lets transfer the tokens from the user
            require(IERC20(tokenA).transferFrom(_msgSender(), address(this), amount), "BotFi: TOKENA_TRANSFER_FAILED");

        }
        
        // if token B is native, then we use weth
        if(tokenB == nativeToken){
            tokenB = weth;
        }

        address[2] memory pair = [tokenA, tokenB];

        uint feeAmt = calPercentage(amount, protocolFee);
        
        uint256 amountWithFee = amount - feeAmt;

        uint256 slippageAmt = calPercentage(amountWithFee, slippage);

     
    } //end swap v2


}