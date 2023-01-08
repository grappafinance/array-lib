// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {UintArrayLib} from "../../UintArrayLib.sol";

contract UintArrayLibTester {
    function max(uint256[] memory x) external pure returns (uint256) {
        uint256 m = UintArrayLib.max(x);
        return m;
    }

    function min(uint256[] memory x) external pure returns (uint256) {
        uint256 m = UintArrayLib.min(x);
        return m;
    }

    function minMax(uint256[] memory x) external pure returns (uint256, uint256) {
        (uint256 min_, uint256 max_) = UintArrayLib.minMax(x);
        return (min_, max_);
    }

    function sum(uint256[] memory x) external pure returns (uint256) {
        uint256 s = UintArrayLib.sum(x);
        return s;
    }

    function remove(uint256[] memory x, uint256 z) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.remove(x, z);
        return y;
    }

    // function indexOf(uint256[] memory x, uint256 v) external pure returns (bool, uint256) {
    //     for (uint256 i; i < x.length;) {
    //         if (x[i] == v) {
    //             return (true, i);
    //         }

    //         unchecked {
    //             ++i;
    //         }
    //     }
    //     return (false, 0);
    // }

    // function argSort(uint256[] memory x) external pure returns (uint256[] memory y, uint256[] memory idxs) {
    //     idxs = new uint256[](x.length);
    //     // fill in index array
    //     for (uint256 i; i < x.length;) {
    //         idxs[i] = i;
    //         unchecked {
    //             ++i;
    //         }
    //     }
    //     // initialize copy of x
    //     y = new uint256[](x.length);
    //     populate(y, x);
    //     // sort
    //     quickSort(y, int256(0), int256(y.length - 1), idxs);
    // }

    // /**
    //  * @dev return a new sorted copy of array x
    //  */
    // function sort(uint256[] memory x) external pure returns (uint256[] memory y) {
    //     y = new uint256[](x.length);
    //     populate(y, x);
    //     quickSort(y, int256(0), int256(y.length - 1));
    // }

    // /**
    //  * @dev sort array x in place with quick sort algorithm
    //  */
    // function quickSort(uint256[] memory x) external pure {
    //     quickSort(x, int256(0), int256(x.length - 1));
    // }

    // function quickSort(uint256[] memory arr, int256 left, int256 right) external pure {
    //     if (left == right) return;
    //     int256 i = left;
    //     int256 j = right;
    //     unchecked {
    //         uint256 pivot = arr[uint256(left + right) / 2];
    //         while (i <= j) {
    //             while (arr[uint256(i)] < pivot) {
    //                 ++i;
    //             }
    //             while (pivot < arr[uint256(j)]) {
    //                 --j;
    //             }
    //             if (i <= j) {
    //                 (arr[uint256(i)], arr[uint256(j)]) = (arr[uint256(j)], arr[uint256(i)]);
    //                 ++i;
    //                 --j;
    //             }
    //         }
    //     }
    //     if (left < j) quickSort(arr, left, j);
    //     if (i < right) quickSort(arr, i, right);
    // }

    // function quickSort(uint256[] memory arr, int256 left, int256 right, uint256[] memory indexArray) external pure {
    //     if (left == right) return;
    //     int256 i = left;
    //     int256 j = right;
    //     unchecked {
    //         uint256 pivot = arr[uint256((left + right) / 2)];
    //         while (i <= j) {
    //             while (arr[uint256(i)] < pivot) {
    //                 ++i;
    //             }
    //             while (pivot < arr[uint256(j)]) {
    //                 --j;
    //             }
    //             if (i <= j) {
    //                 (arr[uint256(i)], arr[uint256(j)]) = (arr[uint256(j)], arr[uint256(i)]);
    //                 (indexArray[uint256(i)], indexArray[uint256(j)]) = (indexArray[uint256(j)], indexArray[uint256(i)]);
    //                 ++i;
    //                 --j;
    //             }
    //         }
    //         if (left < j) quickSort(arr, left, j, indexArray);
    //         if (i < right) quickSort(arr, i, right, indexArray);
    //     }
    // }

    // function append(uint256[] memory x, uint256 v) external pure returns (uint256[] memory y) {
    //     y = new uint256[](x.length + 1);
    //     uint256 i;
    //     for (i; i < x.length;) {
    //         y[i] = x[i];

    //         unchecked {
    //             ++i;
    //         }
    //     }
    //     y[i] = v;
    // }

    // /**
    //  * @dev return a new array that's the result of concatting a and b
    //  */
    // function concat(uint256[] memory a, uint256[] memory b) external pure returns (uint256[] memory y) {
    //     y = new uint256[](a.length + b.length);
    //     uint256 v;
    //     uint256 i;
    //     for (i; i < a.length;) {
    //         y[v] = a[i];

    //         unchecked {
    //             ++i;
    //             ++v;
    //         }
    //     }
    //     for (i = 0; i < b.length;) {
    //         y[v] = b[i];

    //         unchecked {
    //             ++i;
    //             ++v;
    //         }
    //     }
    // }

    // function populate(uint256[] memory a, uint256[] memory b) external pure {
    //     for (uint256 i; i < a.length;) {
    //         a[i] = b[i];

    //         unchecked {
    //             ++i;
    //         }
    //     }
    // }

    // function at(uint256[] memory x, int256 i) external pure returns (uint256) {
    //     int256 len = x.length.toInt256();
    //     if (i >= 0) {
    //         if (i > len) revert IndexOutOfBounds();
    //         return x[uint256(i)];
    //     } else {
    //         if (i < -len) revert IndexOutOfBounds();
    //         // cast directly here because len + i must > 0
    //         return x[uint256(len + i)];
    //     }
    // }

    // function subEachFrom(uint256[] memory x, uint256 z) external pure returns (int256[] memory y) {
    //     y = new int256[](x.length);
    //     int256 intZ = z.toInt256();
    //     for (uint256 i; i < x.length;) {
    //         y[i] = intZ - x[i].toInt256();

    //         unchecked {
    //             ++i;
    //         }
    //     }
    // }

    // /**
    //  * @dev return a new array y with y[i] = x[i] - z
    //  */
    // function subEachBy(uint256[] memory x, uint256 z) external pure returns (int256[] memory y) {
    //     y = new int256[](x.length);
    //     int256 intZ = z.toInt256();
    //     for (uint256 i; i < x.length;) {
    //         y[i] = x[i].toInt256() - intZ;

    //         unchecked {
    //             ++i;
    //         }
    //     }
    // }

    // function dot(uint256[] memory a, int256[] memory b) external pure returns (int256 s) {
    //     for (uint256 i; i < a.length;) {
    //         s += int256(a[i]) * b[i];

    //         unchecked {
    //             ++i;
    //         }
    //     }
    // }

    // function toInt256(uint256[] memory x) external pure returns (int256[] memory y) {
    //     y = new int256[](x.length);
    //     for (uint256 i; i < x.length;) {
    //         y[i] = x[i].toInt256();

    //         unchecked {
    //             ++i;
    //         }
    //     }
    // }
}

/**
 * tests written for coverage. all calls routed through UintArrayLibTester
 */
contract UintArrayLibCoverage is Test {
    using UintArrayLib for uint256[];

    UintArrayLibTester public tester;

    function setUp() public {
        tester = new UintArrayLibTester();
    }

    function _getDefaultArray() internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 5;
        arr[2] = 2;
        arr[3] = 4;
        arr[4] = 3;
        return arr;
    }

    function testMax() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(tester.max(arr), 5);
    }

    function testMin() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(tester.min(arr), 1);
    }

    function testSum() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(tester.sum(arr), 15);
    }

    function testMinMax() public {
        uint256[] memory arr = _getDefaultArray();
        (uint256 min_, uint256 max_) = tester.minMax(arr);
        assertEq(min_, 1);
        assertEq(max_, 5);
    }

    function testRemove() public {
        uint256[] memory arr = _getDefaultArray();
        uint256[] memory removed = tester.remove(arr, 0);
        assertEq(removed[0], 5);
        assertEq(removed.length, 4);
    }
}
