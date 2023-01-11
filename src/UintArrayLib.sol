// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeCast} from "openzeppelin/utils/math/SafeCast.sol";

library UintArrayLib {
    using SafeCast for uint256;

    /**
     * @dev Returns maximal element in array
     */
    function max(uint256[] memory x) internal pure returns (uint256 m) {
        m = x[0];
        uint256 len = x.length;
        for (uint256 i; i < len;) {
            if (x[i] > m) {
                m = x[i];
            }

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev Returns minimum element in array
     */
    function min(uint256[] memory x) internal pure returns (uint256 m) {
        m = x[0];
        uint256 len = x.length;
        for (uint256 i = 1; i < len;) {
            if (x[i] < m) {
                m = x[i];
            }
            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return the min and max for an array.
     */
    function minMax(uint256[] memory x) internal pure returns (uint256 min_, uint256 max_) {
        if (x.length == 1) {
            return (x[0], x[0]);
        }
        (min_, max_) = (x[0], x[0]);

        uint256 len = x.length;
        for (uint256 i = 1; i < len;) {
            if (x[i] < min_) {
                min_ = x[i];
            } else if (x[i] > max_) {
                max_ = x[i];
            }
            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev Return a new array that removes element at index z.
     * @return y new array
     */
    function remove(uint256[] memory x, uint256 z) internal pure returns (uint256[] memory y) {
        if (z >= x.length) {
            return x;
        }
        y = new uint256[](x.length - 1);

        uint256 len = x.length;
        for (uint256 i; i < len;) {
            unchecked {
                if (i < z) {
                    y[i] = x[i];
                } else if (i > z) {
                    y[i - 1] = x[i];
                }
                ++i;
            }
        }
    }

    /**
     * @dev Return index of the first element in array x with value v
     * @return found set to true if found
     * @return i index in the array
     */
    function indexOf(uint256[] memory x, uint256 v) internal pure returns (bool, uint256) {
        uint256 len = x.length;
        for (uint256 i; i < len;) {
            if (x[i] == v) {
                return (true, i);
            }

            unchecked {
                ++i;
            }
        }
        return (false, 0);
    }

    /**
     * @dev Compute sum of all elements
     * @return s sum
     */
    function sum(uint256[] memory x) internal pure returns (uint256 s) {
        uint256 len = x.length;
        for (uint256 i; i < len;) {
            s += x[i];

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev get the sorted array and index order used to sort.
     * @return y copy of x but sorted
     * @return idxs indexes of input array used for sorting.
     */
    function argSort(uint256[] memory x) internal pure returns (uint256[] memory y, uint256[] memory idxs) {
        uint256 len = x.length;
        idxs = new uint256[](len);

        // fill in index array
        for (uint256 i; i < len;) {
            idxs[i] = i;
            unchecked {
                ++i;
            }
        }
        // initialize copy of x
        y = new uint256[](len);
        populate(y, x);
        // sort
        quickSort(y, int256(0), int256(y.length - 1), idxs);
    }

    /**
     * @dev return a new sorted copy of array x
     */
    function sort(uint256[] memory x) internal pure returns (uint256[] memory y) {
        y = new uint256[](x.length);
        populate(y, x);
        quickSort(y, int256(0), int256(y.length - 1));
    }

    /**
     * @dev sort array x in place with quick sort algorithm
     */
    function quickSort(uint256[] memory x) internal pure {
        quickSort(x, int256(0), int256(x.length - 1));
    }

    /**
     * @dev sort arr[left:right] in place with quick sort algorithm
     */
    function quickSort(uint256[] memory arr, int256 left, int256 right) internal pure {
        if (left == right) {
            return;
        }
        int256 i = left;
        int256 j = right;
        unchecked {
            uint256 pivot = arr[uint256(left + right) / 2];
            while (i <= j) {
                while (arr[uint256(i)] < pivot) {
                    ++i;
                }
                while (pivot < arr[uint256(j)]) {
                    --j;
                }
                if (i <= j) {
                    (arr[uint256(i)], arr[uint256(j)]) = (arr[uint256(j)], arr[uint256(i)]);
                    ++i;
                    --j;
                }
            }
        }
        if (left < j) {
            quickSort(arr, left, j);
        }
        if (i < right) {
            quickSort(arr, i, right);
        }
    }

    /**
     * @dev quicksort implementation with indexes, sorts input arr and indexArray IN PLACE
     */
    function quickSort(uint256[] memory arr, int256 left, int256 right, uint256[] memory indexArray) internal pure {
        if (left == right) {
            return;
        }
        int256 i = left;
        int256 j = right;
        unchecked {
            uint256 pivot = arr[uint256((left + right) / 2)];
            while (i <= j) {
                while (arr[uint256(i)] < pivot) {
                    ++i;
                }
                while (pivot < arr[uint256(j)]) {
                    --j;
                }
                if (i <= j) {
                    (arr[uint256(i)], arr[uint256(j)]) = (arr[uint256(j)], arr[uint256(i)]);
                    (indexArray[uint256(i)], indexArray[uint256(j)]) = (indexArray[uint256(j)], indexArray[uint256(i)]);
                    ++i;
                    --j;
                }
            }
            if (left < j) {
                quickSort(arr, left, j, indexArray);
            }
            if (i < right) {
                quickSort(arr, i, right, indexArray);
            }
        }
    }

    /**
     * @dev return a new array that append element v at the end of array x
     */
    function append(uint256[] memory x, uint256 v) internal pure returns (uint256[] memory y) {
        uint256 len = x.length;
        y = new uint256[](len + 1);
        uint256 i;
        for (i; i < len;) {
            y[i] = x[i];

            unchecked {
                ++i;
            }
        }
        y[i] = v;
    }

    /**
     * @dev return a new array that's the result of concatting a and b
     */
    function concat(uint256[] memory a, uint256[] memory b) internal pure returns (uint256[] memory y) {
        uint256 aLen = a.length;
        uint256 bLen = b.length;
        y = new uint256[](aLen + bLen);
        uint256 v;
        uint256 i;
        for (i; i < aLen;) {
            y[v] = a[i];

            unchecked {
                ++i;
                ++v;
            }
        }
        for (i = 0; i < bLen;) {
            y[v] = b[i];

            unchecked {
                ++i;
                ++v;
            }
        }
    }

    /**
     * @dev Populates array a with values from b
     * @dev modifies array a in place.
     */
    function populate(uint256[] memory a, uint256[] memory b) internal pure {
        uint256 aLen = a.length;
        for (uint256 i; i < aLen;) {
            a[i] = b[i];

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return the element at index i
     * if i is positive, it's the same as requesting x[i]
     * if i is negative, return the value positioned at -i from the end
     * @param i can be positive or negative
     */
    function at(uint256[] memory x, int256 i) internal pure returns (uint256) {
        if (i >= 0) {
            // will revert with out of bound error if i is too large
            return x[uint256(i)];
        } else {
            // will revert with underflow error if i is too small
            return x[x.length - uint256(-i)];
        }
    }

    /**
     * @dev return a new array y with y[i] = z - x[i]
     */
    function subEachFrom(uint256[] memory x, uint256 z) internal pure returns (int256[] memory y) {
        uint256 len = x.length;
        y = new int256[](len);
        int256 intZ = z.toInt256();
        for (uint256 i; i < len;) {
            y[i] = intZ - x[i].toInt256();

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return a new array y with y[i] = x[i] - z
     */
    function subEachBy(uint256[] memory x, uint256 z) internal pure returns (int256[] memory y) {
        uint256 len = x.length;
        y = new int256[](len);
        int256 intZ = z.toInt256();
        for (uint256 i; i < len;) {
            y[i] = x[i].toInt256() - intZ;

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return dot of 2 vectors
     * will revert if 2 vectors has different length
     * @param a uint256 array
     * @param b uint256 array
     */
    function dot(uint256[] memory a, uint256[] memory b) internal pure returns (uint256 s) {
        uint256 len = a.length;
        for (uint256 i; i < len;) {
            s += a[i] * b[i];
            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return dot of 2 vectors
     * will revert if 2 vectors has different length
     * @param a uint256 array
     * @param b int256 array
     */
    function dot(uint256[] memory a, int256[] memory b) internal pure returns (int256 s) {
        uint256 len = a.length;
        for (uint256 i; i < len;) {
            s += int256(a[i]) * b[i];

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev converting array of variable types
     */
    function toInt256(uint256[] memory x) internal pure returns (int256[] memory y) {
        uint256 len = x.length;
        y = new int256[](len);
        for (uint256 i; i < len;) {
            y[i] = x[i].toInt256();

            unchecked {
                ++i;
            }
        }
    }

    /**
     * @dev return a new array contains the copy from x[start] to x[end]
     * if i is positive, it's the same as requesting x[i]
     * if i is negative, return the value positioned at -i from the end
     * @param x array to copy
     * @param _start starting index, can be negative
     * @param _start ending index, can be negative
     */
    function slice(uint256[] memory x, uint256 _start, uint256 _end) internal pure returns (uint256[] memory a) {
        // add checks for _start,_end
        if (_end < _start) {
            return new uint256[](0);
        }
        a = new uint256[](_end - _start);
        uint256 y;
        for (uint256 i = _start; i < _end;) {
            a[y] = x[i];

            unchecked {
                ++i;
                ++y;
            }
        }
    }
}
