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

    function indexOf(uint256[] memory x, uint256 v) external pure returns (bool, uint256) {
        (bool found, uint256 index) = UintArrayLib.indexOf(x, v);
        return (found, index);
    }

    function argSort(uint256[] memory x) external pure returns (uint256[] memory, uint256[] memory) {
        (uint256[] memory y, uint256[] memory indexes) = UintArrayLib.argSort(x);
        return (y, indexes);
    }

    function sort(uint256[] memory x) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.sort(x);
        return y;
    }

    function quickSort(uint256[] memory x) external pure returns (uint256[] memory) {
        UintArrayLib.quickSort(x);

        return x;
    }

    function quickSort(uint256[] memory x, int256 left, int256 right) external pure returns (uint256[] memory) {
        UintArrayLib.quickSort(x, left, right);
        return x;
    }

    function quickSort(uint256[] memory x, int256 left, int256 right, uint256[] memory indexArray)
        external
        pure
        returns (uint256[] memory, uint256[] memory)
    {
        UintArrayLib.quickSort(x, left, right, indexArray);
        return (x, indexArray);
    }

    function append(uint256[] memory x, uint256 v) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.append(x, v);
        return y;
    }

    function concat(uint256[] memory a, uint256[] memory b) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.concat(a, b);
        return y;
    }

    function populate(uint256[] memory a, uint256[] memory b) external pure returns (uint256[] memory) {
        UintArrayLib.concat(a, b);
        return a;
    }

    function at(uint256[] memory x, int256 i) external pure returns (uint256) {
        uint256 v = UintArrayLib.at(x, i);
        return v;
    }

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

    function _getDefaultIndexArr() internal pure returns (uint256[] memory) {
        uint256[] memory idxs = new uint256[](5);
        idxs[0] = 0;
        idxs[1] = 1;
        idxs[2] = 2;
        idxs[3] = 3;
        idxs[4] = 4;
        return idxs;
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

    function testIndexOf() public {
        uint256[] memory arr = _getDefaultArray();
        (bool found0, uint256 indexOf0) = tester.indexOf(arr, 0);
        assertEq(found0, false);
        assertEq(indexOf0, 0);

        (bool found3, uint256 indexOf3) = tester.indexOf(arr, 3);
        assertEq(found3, true);
        assertEq(indexOf3, 4);
    }

    function testArgSort() public {
        uint256[] memory arr = _getDefaultArray();
        (uint256[] memory sorted, uint256[] memory indexes) = tester.argSort(arr);
        assertEq(sorted[0], 1);
        assertEq(sorted[1], 2);
        assertEq(sorted[2], 3);
        assertEq(sorted[3], 4);
        assertEq(sorted[4], 5);

        assertEq(indexes[0], 0); // index of v = 1
        assertEq(indexes[1], 2); // index of v = 2
        assertEq(indexes[2], 4);
        assertEq(indexes[3], 3);
        assertEq(indexes[4], 1);
    }

    function testSort() public {
        uint256[] memory arr = _getDefaultArray();
        arr = tester.sort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSort() public {
        uint256[] memory arr = _getDefaultArray();
        arr = tester.quickSort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSortPart1() public {
        uint256[] memory arr = _getDefaultArray();
        arr = tester.quickSort(arr, 2, 4); // only sort arr[2:5]

        assertEq(arr[0], 1); // untouched
        assertEq(arr[1], 5); // untouched
        assertEq(arr[2], 2);
        assertEq(arr[3], 3);
        assertEq(arr[4], 4);
    }

    function testQuickSortPart2() public {
        uint256[] memory arr = _getDefaultArray();
        arr = tester.quickSort(arr, 0, 2); // only sort arr[2:5]

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 5);
        assertEq(arr[3], 4); // untouched
        assertEq(arr[4], 3); // untouched
    }

    function testQuickSortWithIdxs() public {
        uint256[] memory arr = _getDefaultArray();
        uint256[] memory idxs = _getDefaultIndexArr();
        (arr, idxs) = tester.quickSort(arr, 2, 4, idxs); // only sort arr[2:5]

        assertEq(arr[0], 1); // untouched
        assertEq(arr[1], 5); // untouched
        assertEq(arr[2], 2);
        assertEq(arr[3], 3);
        assertEq(arr[4], 4);

        assertEq(idxs[0], 0); // untouched
        assertEq(idxs[1], 1); // untouched
        assertEq(idxs[2], 2);
        assertEq(idxs[3], 4); // swapped
        assertEq(idxs[4], 3); // swapped
    }
}
