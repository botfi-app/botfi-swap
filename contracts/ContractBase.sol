// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import "./base/Utils.sol";
import "./base/Defs.sol";
import "./base/Multicall.sol";

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
