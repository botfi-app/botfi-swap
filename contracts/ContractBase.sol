// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./interfaces/@uniswap/v2/v2-periphery/interfaces/IUniswapV2Router02.sol";
import "./interfaces/@uniswap/v2/v2-core/interfaces/IUniswapV2Factory.sol";
import "./interfaces/@uniswap/v3/v3-core/interfaces/IUniswapV3Factory.sol";
import "./interfaces/@uniswap/v3/v3-periphery/interfaces/ISwapRouter.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";
import "./base/Globals.sol";

contract ContractBase is Context, Ownable {

    constructor() Ownable(_msgSender()) {}

}
