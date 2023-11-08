// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../ContractBase.sol";
import "../base/TransferHelper.sol";

contract SwapEngine is TransferHelper, ContractBase {

    event SwapV2(
        uint256 amount, 
        address tokenA, 
        address tokenB,
        address recipient, 
        uint    fee, 
        uint    slippage
    );

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
    * @param path the array path of tokenA and B
    * @param router the swap router
    * @param slippageBps the slipage tolerance in basis point
    */
    function __getV2AmountOutMin(
        uint256 amountIn, 
        address[] memory path, 
        IUniswapV2Router02 router, 
        uint256 slippageBps
    )
        internal 
        view
        returns(uint256)
    {
        uint256[] memory amounts = router.getAmountsOut(amountIn, path);

        uint256 amountOut = amounts[1];

        // lets get the slippage amount 
        if(amountOut > 0 && slippageBps > 0){
            uint slippageAmt = calPercentage(amountOut, slippageBps);
            amountOut -= slippageAmt;
        }

        return amountOut;
    } 

    /**
     * @dev swap uniswap v2
     * @param dex the name of the dex in bytes32
     * @param amount the input amount
     * @param tokenB the input token address 
     * @param tokenB the output token address
     * @param slippageBps the slippage in basis point
     * @param supportsFeeOnTransfer wether the token supports fee on transfer
     */
    function swapV2(
        bytes32 dex,
        uint256 amount, 
        address tokenA, 
        address tokenB,
        uint    slippageBps,
        bool    supportsFeeOnTransfer
    ) 
        public 
        payable
    {

        require(tokenA != tokenB, "BotFi: TOKEN_A_B_SAME");
        require(amount > 0, "BotFi: ZERO_AMOUNT");
        require(slippageBps > 0, "BotFi: ZERO_SLIPPAGE");

        DexParams memory _dexInfo = dexesParams[dex];

        require(_dexInfo.createdAt > 0, "BotFi: UNSUPPORTED_DEX");
        require(address(_dexInfo.v2Router) != address(0), "BotFi: V2_SWAP_UNSUPPORTED");

        address weth = _dexInfo.v2Router.WETH();
        address recipient = address(this);
        uint deadline = block.timestamp + 60; // 1min

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

        address[] memory path = new address[](2);
        path[0] = tokenA;
        path[1] = tokenB;

        uint feeAmt = calPercentage(amount, protocolFee);
        
        uint256 amountIn = amount - feeAmt;

        uint256 amountOutMin = __getV2AmountOutMin(
                                    amountIn, 
                                    path,
                                    _dexInfo.v2Router, 
                                    slippageBps
                                );

        if(tokenA == weth){

            if(supportsFeeOnTransfer){
                _dexInfo.v2Router
                    .swapExactETHForTokensSupportingFeeOnTransferTokens{ value: amountIn }(
                        amountOutMin,
                        path,
                        recipient, 
                        deadline
                    );
            } else {
                _dexInfo.v2Router
                        .swapETHForExactTokens{ value: amountIn }(
                            amountOutMin,
                            path,
                            recipient,
                            deadline
                        );
                }
        }

        emit SwapV2(amount, tokenA, tokenB, recipient, protocolFee, slippageBps);
    } //end swap v2


}