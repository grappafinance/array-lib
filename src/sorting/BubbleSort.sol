// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title BubbleSort
 * @author antoncoding
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

    /**
     * @dev sort an uint256 array in place with bubble sort and return indexes
     */
    function argSort(uint256[] memory arr) internal pure returns (uint256[] memory idxs) {
        idxs = new uint256[](arr.length);
        unchecked {
            uint256 i;
            for (i; i < arr.length; ++i) idxs[i] = i;
            if (arr.length <= 1) return(idxs);
            for (i = 0; i < arr.length; ++i) {
                for (uint256 j = i + 1; j < arr.length; ++j) {
                    if (arr[i] > arr[j]) {
                        (arr[i], arr[j]) = (arr[j], arr[i]);
                        (idxs[i], idxs[j]) = (idxs[j], idxs[i]);
                    }
                }
            }
        }
    }

    /**
     * @dev sort an int256 array in place with bubble sort
     */
    function sort(int256[] memory arr) internal pure {
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

    /**
     * @dev sort an int256 array in place with bubble sort and return indexes
     */
    function argSort(int256[] memory arr) internal pure returns (uint256[] memory idxs) {
        idxs = new uint256[](arr.length);
        unchecked {
            uint256 i;
            for (i; i < arr.length; ++i) idxs[i] = i;
            if (arr.length <= 1) return(idxs);
            for (i = 0; i < arr.length; ++i) {
                for (uint256 j = i + 1; j < arr.length; ++j) {
                    if (arr[i] > arr[j]) {
                        (arr[i], arr[j]) = (arr[j], arr[i]);
                        (idxs[i], idxs[j]) = (idxs[j], idxs[i]);
                    }
                }
            }
        }
    }
}
