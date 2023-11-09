// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IWETH.sol";
import "@openzeppelin/contracts/utils/Multicall.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IUniswapV2Router02.sol";
import "./interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Factory.sol";
import "./interfaces/@uniswap/v3/v3-core/interfaces/IUniswapV3Factory.sol";
import "./interfaces/@uniswap/v3/v3-periphery/interfaces/ISwapRouter.sol";
import "./interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Pair.sol";

import "./base/Utils.sol";
import "./base/Defs.sol";

contract ContractBase is 
    Defs, 
    Context, 
    Ownable, 
    Multicall, 
    ReentrancyGuard 
{


    event SetProtocolFee(uint256);
    event SetFeeWallet(address addr);

    constructor() Ownable(_msgSender()) {}

    /**
     * @dev protocol fee in basis point
     * @param _feeBps the fee in percentage basis point
     */
    function __setProtocolFee (uint256 _feeBps)
        internal
    {
        PROTOCOL_FEE = _feeBps;

        emit SetProtocolFee(_feeBps);
    }

    /**
     * @dev protocol fee in basis point
     * @param _feeBps the fee in percentage basis point
     */
    function setProtocolFee(uint _feeBps)
        public 
        onlyOwner 
    {
        __setProtocolFee(_feeBps);
    }

    
    function __setFeeWallet(address addr)
        internal 
    {
        FEE_WALLET = addr;
        emit SetFeeWallet(addr);
    }

    /**
     * @dev set the address for taking the protocol fees
     * @param addr the fee in percentage basis point
     */
    function setFeeWallet(address addr)
        public 
        onlyOwner 
    {
        __setFeeWallet(addr);
    }
}
