// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {BubbleSort} from "src/sorting/BubbleSort.sol";

contract BubbleSortTester {
    function sort(int256[] memory x) external pure returns (int256[] memory) {
        BubbleSort.sort(x);
        return x;
    }

    function sort(uint256[] memory x) external pure returns (uint256[] memory) {
        BubbleSort.sort(x);
        return x;
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

    function testSortUintLength0() public {
        uint256[] memory arr = new uint256[](1);
        arr[0] = 50;
        arr = tester.sort(arr);
        assertEq(arr[0], 50);
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
}
