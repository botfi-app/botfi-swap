// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";
import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IWETH.sol";
import "@openzeppelin/contracts/utils/Multicall.sol";
import "./base/Globals.sol";

contract ContractBase is Globals, Context, Ownable, Multicall {

    constructor() Ownable(_msgSender()) {}

    function __setProtocolFee (uint256 _fee)
        internal
    {
        protocolFee = _fee;
    }

    function setProtocolFee(uint _fee)
        public 
        onlyOwner 
    {
        __setProtocolFee(_fee);
    }
}
