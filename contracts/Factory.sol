// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./ContractBase.sol";
import "./swap/SwapEngine.sol";

contract Factory is ContractBase, SwapEngine {

    constructor(
        uint    protocolFee,
        address feeAddress
    ) {     
        __setProtocolFee(protocolFee);
        __setFeeAddress(feeAddress);
    }
    
}