// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../ContractBase.sol";
import "../base/TransferHelper.sol";
import "hardhat/console.sol";


contract SwapEngine is TransferHelper, ContractBase {

    event Swap(
        bytes32 routerId, 
        uint256 amount,
        address tokenA,
        uint    feeBps,
        address account  
    );

    using Address for address;
    using Address for address payable;

    bool swapPaused;

    receive() external payable{}
    fallback() external payable{}

    modifier swapNotPaused() {
        require(!swapPaused, "BotFi#swapNotPaused: SWAP_PAUSED");
        _;
    }

    /**
     * @dev fecth uniswap v2 router info
     * @param uniV2Router the router address
     * @return factory the factory contract address
     * @return weth the wrapped ether address
     */
    function getUniV2RouterInfo(address uniV2Router) 
        public 
        pure 
        returns ( address factory, address weth) 
    {

        IUniswapV2Router02 irouter = IUniswapV2Router02(uniV2Router);

        string memory revertErrMsg = "BotFi#SwapEngine#getUniV2RouterInfo: Failed to fetch uni_v2 factory and weth from router, kindly check if the router is valid";

        try  irouter.factory() returns(address _f) {
            factory = _f;
        } catch {
            revert(revertErrMsg);
        }

        try  irouter.WETH() returns(address _f) {
            weth = _f;
        } catch {
            revert(revertErrMsg);
        }
    }


    function addRouter(
        bytes32             id,
        bytes32             adapter, // uni_v2, uni_v3, 1inch, ...                  
        address  payable    route, 
        address             factory,
        address             weth,
        bool                enabled
    ) 
        public 
        onlyOwner 
    {

        require(route != address(0), "BotFi: ZERO_ROUTER_ADDRESS");

        bool isNew = (routers[id].createdAt == 0);
        uint createdAt = (isNew) ? block.timestamp : routers[id].createdAt;

        if(adapter == bytes32("uni_v2")){
            (factory, weth) = getUniV2RouterInfo(route);
        }

        routers[id] = RouterParams(
            id,
            adapter, 
            route,
            factory,
            weth,
            createdAt,
            enabled
        );

        if(isNew) routersIds.push(id);
    }


    /**
     * @dev pause the swap operation for the contract
     * @param opt true or false 
     */
    function pauseSwap(bool opt) 
        external
        onlyOwner 
    {
        swapPaused = opt;
    }

    /**
     * @dev perform a swap
     * @param routerId the identifier of the router to use
     * @param amount the total amount including the protocol fee for the swap
     * @param tokenA the token to swap into another token (tokenB)
     * @param payload the encoded swap data to foward to the router
     */ 
    function swap(
        bytes32 routerId,
        uint256 amount, 
        address tokenA, 
        bytes calldata payload
    ) 
        external 
        payable
        nonReentrant()
        swapNotPaused()
    {   

        require(routers[routerId].createdAt > 0, "BotFi#Swap: UNSUPPORTED_DEX");
        require(payload.length > 0, "BotFi#Swap: DATA_ARG_REQUIRED");
        require(tokenA != address(0), "BotFi#Swap: ZERO_TOKENA_ADDR");

        if(tokenA == NATIVE_TOKEN) {
            //validate native token input
            require(msg.value == amount, "BotFi#Swap: INSUFFICIENT_BALANCE");
        } else {
            
            // lets transfer the tokens from the user
            transferAsset(tokenA, _msgSender(), address(this), amount);
        }

        //get fee amt
        uint feeAmt = amount - calPercentage(amount, PROTOCOL_FEE);

        // lets perform fee transfer 
        transferAsset(tokenA, _msgSender(), FEE_WALLET, feeAmt);

        address route = routers[routerId].route;
        uint256 swapAmt = amount - feeAmt;

        if(tokenA == NATIVE_TOKEN){
            route.functionCallWithValue(payload, swapAmt);
        } else {

            require(IERC20(tokenA).approve(route, swapAmt), "BotFi#Swap: TOKENA_APPROVAL_FAILED");

            route.functionCallWithValue(payload, msg.value);
        }

        emit Swap(routerId, amount, tokenA, PROTOCOL_FEE, _msgSender());
    }
    
    /**
     * @dev withdraw any stucked tokens in the contract
     * @param token the token address to withdraw
     * @param amount the amount to move out
     */
    function withdraw(address token, uint256 amount) 
        external 
        onlyOwner 
    {
        transferAsset(token, address(this), _msgSender(), amount);
    }

}   