// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../ContractBase.sol";
import "../base/TransferHelper.sol";
//import "hardhat/console.sol";
import "../interfaces/@uniswap/v3/v3-periphery/interfaces/external/IWETH9.sol";


contract SwapEngine is 
    TransferHelper, 
    ContractBase,
    IWETH9
{

    event Swap(
        bytes32 routerId, 
        uint256 amount,
        address tokenA,
        uint    feeBps,
        address account  
    );

    using Address for address;
    using Address for address payable;

    bool private isPaused;

    receive() external payable{}
    fallback() external payable{}

    modifier notPaused() {
        require(!isPaused, "BotFi#swapNotPaused: SWAP_PAUSED");
        _;
    }

    /**
     * @dev addRouter add a router params
     * @param id       router id
     * @param group    router group - uni_v2, uni_v3 ....
     * @param router   the router address 
     * @param factory  the factory address
     * @param weth     wrapped ether or wrapped native token
     * @param quoter  swap quoter 
     * @param enabled  is the router enabled or not
     */
    function addRoute(
        bytes32             id,
        bytes32             group, // uni_v2, uni_v3, 1inch, ...                  
        address  payable    router, 
        address             factory,
        address             weth,
        address             quoter,
        bool                enabled
    ) 
        external 
        onlyOwner 
    {

        require(router != address(0), "BotFi#SwapEngine#addRouter: ZERO_ROUTER_ADDRESS");

        require(Utils.isContract(router), "BotFi#SwapEngine#addRouter: ROUTER_NOT_A_CONTRACT");
        require(Utils.isContract(factory), "BotFi#SwapEngine#addRouter: FACTORY_NOT_A_CONTRACT");
        require(Utils.isContract(weth), "BotFi#SwapEngine#addRouter: WETH_NOT_A_CONTRACT");

        if(quoter != address(0)){
            require(Utils.isContract(quoter), "BotFi#SwapEngine#addRouter: QUOTER_NOT_A_CONTRACT");
        }

        bool isNew = (routes[id].createdAt == 0);
        uint createdAt = (isNew) ? block.timestamp : routes[id].createdAt;


        routes[id] = RouteParams(
            id,
            group, 
            router,
            factory,
            weth,
            quoter,
            createdAt,
            enabled
        );

        if(isNew) routesIds.push(id);
    }

    /**
     * @dev enable or disable a route
     * @param id the router id
     * @param opt true or false
     */
    function enableRoute(bytes32 id, bool opt)
        external
    {
        require(routes[id].createdAt > 0, "BotFi:SwapEngine#enableRouter: INVALID_ROUTE");

        routes[id].enabled = opt;
    }

    /**
     * @dev getAllRoutes get all the routers
     * returns array 
     */
    function getAllRoutes()
        external
        view 
        returns (RouteParams[] memory rp)
    {
       rp = new RouteParams[](routesIds.length); 

        for(uint i=0; i < routesIds.length; i++){
            rp[i] = routes[routesIds[i]];
        }
    }

    /**
     * @dev pause the swap operation for the contract
     * @param opt true or false 
     */
    function pauseSwap(bool opt) 
        external
        onlyOwner 
    {
        isPaused = opt;
    }

    modifier validateRouter(bytes32 routeId) {
        require(routes[routeId].createdAt > 0, "BotFi#SwapEngine#validateRouter: UNKNOWN_ROUTER_ID");

        require(routes[routeId].enabled, "BotFi#SwapEngine#validateRouter: ROUTER_NOT_ENABLED");

        _;
    }


    /**
     * @dev perform a swap
     * @param routeId the identifier of the router to use
     * @param amount the total amount including the protocol fee for the swap
     * @param tokenA the token to swap into another token (tokenB)
     * @param payload the encoded swap data to foward to the router
     */ 
    function swap(
        bytes32 routeId,
        uint256 amount, 
        address tokenA, 
        bytes calldata payload
    ) 
        external 
        payable
        validateRouter(routeId)
        nonReentrant()
        notPaused()
    {   

        RouteParams route = routes[routeId];

        require(route.createdAt > 0, "BotFi#Swap: UNSUPPORTED_DEX");
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

        uint256 swapAmt = amount - feeAmt;

        if(tokenA == NATIVE_TOKEN && route.group == UNI_V3){
            IWETH9(tokenA).deposit{value: swapAmt}();
        }

        if(tokenA == NATIVE_TOKEN && route.group != UNI_V3){
            route.router.functionCallWithValue(payload, swapAmt);
        } else {

            address tokenAddr = (tokenA == NATIVE_TOKEN) ? route.weth : tokenA;

            require(IERC20(tokenAddr).approve(router, swapAmt), 
                "BotFi#SwapEngine: TOKENA_APPROVAL_FAILED"
            );

            route.router.functionCallWithValue(payload, 0);
        }

        emit Swap(routeId, amount, tokenA, PROTOCOL_FEE, _msgSender());
    }
    
    /**
     * @dev withdraw any stucked tokens in the contract
     * @param token the token address to withdraw
     * @param amount the amount to move out
     */
    function sweep(address token, uint256 amount) 
        external 
        onlyOwner 
    {
        transferAsset(token, address(this), _msgSender(), amount);
    }

}   