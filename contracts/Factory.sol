// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./Base.sol";

contract Factory is Base {

    constructor(
        uint    protocolFee,
        address uniV2Router,
        address univ3Router,
        address univ3Factory 
    ) Base(protocolFee, uniV2Router, univ3Router, univ3Factory) {}
    
}