// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

contract Multicall {

    function multicall(bytes[] calldata data, bool revertOnError) 
        public 
        payable  
        returns 
        (bytes[] memory results) 
    {

        results = new bytes[](data.length);

        for (uint256 i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);

            if (!success) {
               
                // Next 5 lines from https://ethereum.stackexchange.com/a/83577
                if (result.length < 68) revert();

                assembly {
                    result := add(result, 0x04)
                }

                if(revertOnError) {
                    revert(abi.decode(result, (string)));
                }
            }

            results[i] = result;
        }
    }
}