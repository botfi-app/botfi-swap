// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./ContractBase.sol";

contract Factory is ContractBase {

    constructor(
        uint    protocolFee
    ) {     
        __setProtocolFee(protocolFee);
    }
    
}