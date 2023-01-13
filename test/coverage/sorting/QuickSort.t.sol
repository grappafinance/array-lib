// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {QuickSort} from "src/sorting/QuickSort.sol";

contract QuickSortTester {
    // Int Array Sorting

    function argSort(int256[] memory x) external pure returns (int256[] memory, uint256[] memory) {
        (int256[] memory y, uint256[] memory indexes) = QuickSort.argSort(x);
        return (y, indexes);
    }

    function getSorted(int256[] memory x) external pure returns (int256[] memory) {
        int256[] memory y = QuickSort.getSorted(x);
        return y;
    }

    function quickSort(int256[] memory x) external pure returns (int256[] memory) {
        QuickSort.quickSort(x);

        return x;
    }

    function quickSort(int256[] memory x, int256 left, int256 right) external pure returns (int256[] memory) {
        QuickSort.quickSort(x, left, right);
        return x;
    }

    function quickSort(int256[] memory x, int256 left, int256 right, uint256[] memory indexArray)
        external
        pure
        returns (int256[] memory, uint256[] memory)
    {
        QuickSort.quickSort(x, left, right, indexArray);
        return (x, indexArray);
    }

    // Uint Array sorting

    function argSort(uint256[] memory x) external pure returns (uint256[] memory, uint256[] memory) {
        (uint256[] memory y, uint256[] memory indexes) = QuickSort.argSort(x);
        return (y, indexes);
    }

    function getSorted(uint256[] memory x) external pure returns (uint256[] memory) {
        uint256[] memory y = QuickSort.getSorted(x);
        return y;
    }

    function quickSort(uint256[] memory x) external pure returns (uint256[] memory) {
        QuickSort.quickSort(x);

        return x;
    }

    function quickSort(uint256[] memory x, int256 left, int256 right) external pure returns (uint256[] memory) {
        QuickSort.quickSort(x, left, right);
        return x;
    }

    function quickSort(uint256[] memory x, int256 left, int256 right, uint256[] memory indexArray)
        external
        pure
        returns (uint256[] memory, uint256[] memory)
    {
        QuickSort.quickSort(x, left, right, indexArray);
        return (x, indexArray);
    }
}

/**
 * tests written for coverage. all calls routed through QuickSortTester
 */
contract QuickSortLibCoverage is Test {
    using QuickSort for uint256[];

    QuickSortTester public tester;

    function setUp() public {
        tester = new QuickSortTester();
    }

    // Int Array Sorting

    function _getDefaultIntArray() internal pure returns (int256[] memory) {
        int256[] memory arr = new int256[](5);
        arr[0] = 1;
        arr[1] = 5;
        arr[2] = -2;
        arr[3] = 4;
        arr[4] = -3;
        return arr;
    }

    /**
     * util for test data
     */
    function _getDefaultUintArray() internal pure returns (uint256[] memory) {
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

    function testArgSortInt() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultIntArray();
        (int256[] memory sorted, uint256[] memory indexes) = tester.argSort(arr);
        assertEq(sorted[0], -3);
        assertEq(sorted[1], -2);
        assertEq(sorted[2], 1);
        assertEq(sorted[3], 4);
        assertEq(sorted[4], 5);

        assertEq(indexes[0], 4); // index of v = -3
        assertEq(indexes[1], 2); // index of v = -2
        assertEq(indexes[2], 0);
        assertEq(indexes[3], 3);
        assertEq(indexes[4], 1);
    }

    function testSortInt() public {
        int256[] memory arr = _getDefaultIntArray();
        arr = tester.getSorted(arr);

        assertEq(arr[0], -3);
        assertEq(arr[1], -2);
        assertEq(arr[2], 1);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSortInt() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultIntArray();
        arr = tester.quickSort(arr);

        assertEq(arr[0], -3);
        assertEq(arr[1], -2);
        assertEq(arr[2], 1);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSortPart1Int() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultIntArray();
        arr = tester.quickSort(arr, 2, 4); // only sort arr[2:5]

        assertEq(arr[0], 1); // untouched
        assertEq(arr[1], 5); // untouched
        assertEq(arr[2], -3);
        assertEq(arr[3], -2);
        assertEq(arr[4], 4);
    }

    function testQuickSortPart2Int() public {
        int256[] memory arr = _getDefaultIntArray();
        arr = tester.quickSort(arr, 0, 2); // only sort arr[2:5]

        assertEq(arr[0], -2);
        assertEq(arr[1], 1);
        assertEq(arr[2], 5);
        assertEq(arr[3], 4); // untouched
        assertEq(arr[4], -3); // untouched
    }

    function testQuickSortWithIdxsInt() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultIntArray();
        uint256[] memory idxs = _getDefaultIndexArr();
        (arr, idxs) = tester.quickSort(arr, 2, 4, idxs); // only sort arr[2:5]

        assertEq(arr[0], 1); // untouched
        assertEq(arr[1], 5); // untouched
        assertEq(arr[2], -3);
        assertEq(arr[3], -2);
        assertEq(arr[4], 4);

        assertEq(idxs[0], 0); // untouched
        assertEq(idxs[1], 1); // untouched
        assertEq(idxs[2], 4);
        assertEq(idxs[3], 2);
        assertEq(idxs[4], 3);
    }

    // Uint Array Sorting

    function testArgSortUint() public {
        uint256[] memory arr = _getDefaultUintArray();
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

    function testSortUint() public {
        uint256[] memory arr = _getDefaultUintArray();
        arr = tester.getSorted(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSortUint() public {
        uint256[] memory arr = _getDefaultUintArray();
        arr = tester.quickSort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testQuickSortPart1Uint() public {
        uint256[] memory arr = _getDefaultUintArray();
        arr = tester.quickSort(arr, 2, 4); // only sort arr[2:5]

        assertEq(arr[0], 1); // untouched
        assertEq(arr[1], 5); // untouched
        assertEq(arr[2], 2);
        assertEq(arr[3], 3);
        assertEq(arr[4], 4);
    }

    function testQuickSortPart2Uint() public {
        uint256[] memory arr = _getDefaultUintArray();
        arr = tester.quickSort(arr, 0, 2); // only sort arr[2:5]

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 5);
        assertEq(arr[3], 4); // untouched
        assertEq(arr[4], 3); // untouched
    }

    function testQuickSortWithIdxsUint() public {
        uint256[] memory arr = _getDefaultUintArray();
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
