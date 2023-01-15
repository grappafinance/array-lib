// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title BubbleSort
 * @author dsshap
 */
library BubbleSort {
    /**
     * @dev sort an uint256 array in place with bubble sort
     */
    function sort(uint256[] memory arr) internal pure {
        unchecked {
            if (arr.length <= 1) return;
            for (uint256 i; i < arr.length; ++i) {
                for (uint256 j = i + 1; j < arr.length; ++j) {
                    if (arr[i] > arr[j]) {
                        (arr[i], arr[j]) = (arr[j], arr[i]);
                    }
                }
            }
        }
    }
}
