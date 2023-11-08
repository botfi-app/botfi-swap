// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";
import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IWETH.sol";
import "@openzeppelin/contracts/utils/Multicall.sol";
import "./base/Globals.sol";

contract ContractBase is Globals, Context, Ownable, Multicall {


    event SetProtocolFee(uint256);

    constructor() Ownable(_msgSender()) {}

    /**
     * @dev protocol fee in basis point
     * @param _feeBps the fee in percentage basis point
     */
    function __setProtocolFee (uint256 _feeBps)
        internal
    {
        protocolFee = _feeBps;

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
}