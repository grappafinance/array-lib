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
     * @dev sort an uint256 array with bubble sort and return indices
     * @return sorted new sorted array
     * @return indices based on the original array positions
     */
    function argSort(uint256[] memory arr) internal pure returns (uint256[] memory sorted, uint256[] memory indices) {
        indices = new uint256[](arr.length);
        sorted = new uint256[](arr.length);
        unchecked {
            uint256 i;
            for (i; i < arr.length; ++i) {
                indices[i] = i;
                sorted[i] = arr[i];
            }
            if (sorted.length <= 1) return (sorted, indices);
            for (i = 0; i < sorted.length; ++i) {
                for (uint256 j = i + 1; j < sorted.length; ++j) {
                    if (sorted[i] > sorted[j]) {
                        (sorted[i], sorted[j]) = (sorted[j], sorted[i]);
                        (indices[i], indices[j]) = (indices[j], indices[i]);
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
     * @dev indirect sort an int256 array with bubble sort and return indexes
     * @return sorted new sorted array
     * @return indices based on the original array positions
     */
    function argSort(int256[] memory arr) internal pure returns (int256[] memory sorted, uint256[] memory indices) {
        indices = new uint256[](arr.length);
        sorted = new int256[](arr.length);
        unchecked {
            uint256 i;
            for (i; i < arr.length; ++i) {
                indices[i] = i;
                sorted[i] = arr[i];
            }
            if (sorted.length <= 1) return (sorted, indices);
            for (i = 0; i < sorted.length; ++i) {
                for (uint256 j = i + 1; j < sorted.length; ++j) {
                    if (sorted[i] > sorted[j]) {
                        (sorted[i], sorted[j]) = (sorted[j], sorted[i]);
                        (indices[i], indices[j]) = (indices[j], indices[i]);
                    }
                }
            }
        }
    }
}
