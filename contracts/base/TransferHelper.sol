// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "./Defs.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract TransferHelper is Defs {

    /**
     * @dev safeTransfer eth or token 
     * @param token, the token contract
     * @param from the sender's address 
     * @param to the recipient's address
     * @param value the value to send
    */
    function transferAsset(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        
        if(token == NATIVE_TOKEN){
            safeTransferETH(to, value);
        } else {
            safeTransferFrom(token, from, to, value);
        }
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        if(from == address(this)){
            require(IERC20(token).transfer(to, value), 
                "BotFi#TransferHelper: ERC20_TOKEN_TRANSFER_FAILED"
            );
        } else {
            require(IERC20(token).transferFrom(from, to, value), 
                'BotFi#TransferHelper: ERC20_TOKEN_TRANSFER_FAILED'
            );
        }
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'BotFi#TransferHelper: NATIVE_TOKEN_TRANSFER_FAILED');
    }
}