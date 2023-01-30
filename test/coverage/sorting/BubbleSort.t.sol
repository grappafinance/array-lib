// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {BubbleSort} from "src/sorting/BubbleSort.sol";

contract BubbleSortTester {
    function sort(int256[] memory x) external pure returns (int256[] memory) {
        BubbleSort.sort(x);
        return x;
    }

    function argSort(int256[] memory x) external pure returns (int256[] memory, uint256[] memory idxs) {
        idxs = BubbleSort.argSort(x);
        return (x, idxs);
    }

    function sort(uint256[] memory x) external pure returns (uint256[] memory) {
        BubbleSort.sort(x);
        return x;
    }

    function argSort(uint256[] memory x) external pure returns (uint256[] memory, uint256[] memory idxs) {
        idxs = BubbleSort.argSort(x);
        return (x, idxs);
    }
}

/**
 * tests written for coverage. all calls routed through tester
 */
contract BubbleSortLibCoverage is Test {
    BubbleSortTester public tester;

    function setUp() public {
        tester = new BubbleSortTester();
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

    function _getDefaultIntDupArray() internal pure returns (int256[] memory) {
        int256[] memory arr = new int256[](5);
        arr[0] = 1;
        arr[1] = 1;
        arr[2] = 1;
        arr[3] = 1;
        arr[4] = 1;
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

    function _getDefaultUintDupArray() internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 1;
        arr[2] = 1;
        arr[3] = 1;
        arr[4] = 1;
        return arr;
    }

    function testSortIntLength0() public {
        int256[] memory arr = new int256[](1);
        arr[0] = 50;
        arr = tester.sort(arr);
        assertEq(arr[0], 50);
    }

    function testSortInt() public {
        int256[] memory arr = _getDefaultIntArray();
        arr = tester.sort(arr);

        assertEq(arr[0], -3);
        assertEq(arr[1], -2);
        assertEq(arr[2], 1);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testArgSortIntLength0() public {
        uint256[] memory idxs;
        int256[] memory arr = new int256[](1);
        arr[0] = 50;
        (arr, idxs) = tester.argSort(arr);
        assertEq(arr[0], 50);
        assertEq(idxs[0], 0);
    }

    function testArgSortInt() public {
        uint256[] memory idxs;
        int256[] memory arr = _getDefaultIntArray();
        (arr, idxs) = tester.argSort(arr);

        assertEq(arr[0], -3);
        assertEq(arr[1], -2);
        assertEq(arr[2], 1);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);

        assertEq(idxs[0], 4);
        assertEq(idxs[1], 2);
        assertEq(idxs[2], 0);
        assertEq(idxs[3], 3);
        assertEq(idxs[4], 1);
    }

    function testArgSortIntsDup() public {
        uint256[] memory idxs;
        int256[] memory arr = _getDefaultIntDupArray();
        (arr, idxs) = tester.argSort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 1);
        assertEq(arr[2], 1);
        assertEq(arr[3], 1);
        assertEq(arr[4], 1);

        assertEq(idxs[0], 0);
        assertEq(idxs[1], 1);
        assertEq(idxs[2], 2);
        assertEq(idxs[3], 3);
        assertEq(idxs[4], 4);
    }

    function testSortUintLength0() public {
        uint256[] memory arr = new uint256[](1);
        arr[0] = 50;
        arr = tester.sort(arr);
        assertEq(arr[0], 50);
    }

    function testArgSortUintLength0() public {
        uint256[] memory idxs;
        uint256[] memory arr = new uint256[](1);
        arr[0] = 50;
        (arr, idxs) = tester.argSort(arr);
        assertEq(arr[0], 50);
        assertEq(idxs[0], 0);
    }

    function testSortUint() public {
        uint256[] memory arr = _getDefaultUintArray();
        arr = tester.sort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);
    }

    function testArgSortUint() public {
        uint256[] memory idxs;
        uint256[] memory arr = _getDefaultUintArray();
        (arr, idxs) = tester.argSort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 2);
        assertEq(arr[2], 3);
        assertEq(arr[3], 4);
        assertEq(arr[4], 5);

        assertEq(idxs[0], 0);
        assertEq(idxs[1], 2);
        assertEq(idxs[2], 4);
        assertEq(idxs[3], 3);
        assertEq(idxs[4], 1);
    }

    function testArgSortUintDup() public {
        uint256[] memory idxs;
        uint256[] memory arr = _getDefaultUintDupArray();
        (arr, idxs) = tester.argSort(arr);

        assertEq(arr[0], 1);
        assertEq(arr[1], 1);
        assertEq(arr[2], 1);
        assertEq(arr[3], 1);
        assertEq(arr[4], 1);

        assertEq(idxs[0], 0);
        assertEq(idxs[1], 1);
        assertEq(idxs[2], 2);
        assertEq(idxs[3], 3);
        assertEq(idxs[4], 4);
    }
}
