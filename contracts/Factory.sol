// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./ContractBase.sol";

contract Factory is ContractBase {

    constructor(
        uint    protocolFee,
        address uniV2Router,
        address univ3Router,
        address univ3Factory 
    ) {
        
        __initContractBase(
            protocolFee, 
            uniV2Router, 
            univ3Router, 
            univ3Factory
        );
    }
    
}