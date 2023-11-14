// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

contract Multicall {

    struct Call {
        address payable target;
        bytes   data; 
    }

    struct Result {
        bool   success;
        bytes  data;
    }

    function multicall(Call[] calldata calls, bool revertOnError) 
        public 
        payable  
        returns 
        (Result[] memory results) 
    {

        results = new Result[](calls.length);

        for (uint256 i = 0; i < calls.length; i++) {

            (bool success, bytes memory result) = calls[i].target.delegatecall(calls[i].data);

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

            results[i] = Result (
                success,
                result
            );
        }
    }
}