// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {UintArrayLib} from "src/UintArrayLib.sol";

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

    function append(uint256[] memory x, uint256 v) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.append(x, v);
        return y;
    }

    function concat(uint256[] memory a, uint256[] memory b) external pure returns (uint256[] memory) {
        uint256[] memory y = UintArrayLib.concat(a, b);
        return y;
    }

    function populate(uint256[] memory a, uint256[] memory b) external pure returns (uint256[] memory) {
        UintArrayLib.populate(a, b);
        return a;
    }

    function at(uint256[] memory x, int256 i) external pure returns (uint256) {
        uint256 v = UintArrayLib.at(x, i);
        return v;
    }

    function subEachFrom(uint256[] memory x, uint256 z) external pure returns (int256[] memory) {
        int256[] memory y = UintArrayLib.subEachFrom(x, z);
        return y;
    }

    function subEachBy(uint256[] memory x, uint256 z) external pure returns (int256[] memory) {
        int256[] memory y = UintArrayLib.subEachBy(x, z);
        return y;
    }

    function dot(uint256[] memory a, int256[] memory b) external pure returns (int256) {
        int256 m = UintArrayLib.dot(a, b);
        return m;
    }

    function dot(uint256[] memory a, uint256[] memory b) external pure returns (uint256) {
        uint256 m = UintArrayLib.dot(a, b);
        return m;
    }
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

    function testMinMax2() public {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 9;
        arr[1] = 5;
        arr[2] = 2;
        arr[3] = 10;
        arr[4] = 8;
        assertEq(tester.min(arr), 2);

        (uint256 min_, uint256 max_) = tester.minMax(arr);
        assertEq(min_, 2);
        assertEq(max_, 10);
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

    function testAppend() public {
        uint256[] memory arr = _getDefaultArray();
        arr = tester.append(arr, 1);
        arr = tester.append(arr, 2);

        assertEq(arr.length, 7);
        assertEq(arr[5], 1);
        assertEq(arr[6], 2);
    }

    function testConcat() public {
        uint256[] memory array1 = _getDefaultArray();
        uint256[] memory array2 = _getDefaultArray();

        uint256[] memory newArr = tester.concat(array1, array2);
        assertEq(newArr.length, 10);
        assertEq(newArr[0], newArr[5]);
        assertEq(newArr[1], newArr[6]);
        assertEq(newArr[2], newArr[7]);
        assertEq(newArr[3], newArr[8]);
        assertEq(newArr[4], newArr[9]);
    }

    function testPopulate() public {
        uint256[] memory empty = new uint256[](5);
        uint256[] memory arr = _getDefaultArray();

        uint256[] memory newArr = tester.populate(empty, arr);
        assertEq(newArr[0], arr[0]);
        assertEq(newArr[1], arr[1]);
        assertEq(newArr[2], arr[2]);
        assertEq(newArr[3], arr[3]);
        assertEq(newArr[4], arr[4]);
    }

    function testIndexSelector() public {
        uint256[] memory array1 = _getDefaultArray();

        // default [1, 5, 2, 4, 3]
        assertEq(tester.at(array1, 0), 1);
        assertEq(tester.at(array1, 4), 3);

        // last element is 3
        assertEq(tester.at(array1, -1), 3);
        assertEq(tester.at(array1, -2), 4);

        // index underflow
        vm.expectRevert(stdError.arithmeticError);
        tester.at(array1, -6);
        vm.expectRevert(stdError.indexOOBError);
        tester.at(array1, 5);
    }

    function testSubEachFrom() public {
        // default [1, 5, 2, 4, 3]
        uint256[] memory arr = _getDefaultArray();
        int256[] memory result = tester.subEachFrom(arr, 3);

        assertEq(result[0], 2);
        assertEq(result[1], -2);
        assertEq(result[2], 1);
        assertEq(result[3], -1);
        assertEq(result[4], 0);
    }

    function testSubEachBy() public {
        // default [1, 5, 2, 4, 3]
        uint256[] memory arr = _getDefaultArray();
        int256[] memory result = tester.subEachBy(arr, 3);

        assertEq(result[0], -2);
        assertEq(result[1], 2);
        assertEq(result[2], -1);
        assertEq(result[3], 1);
        assertEq(result[4], 0);
    }

    function testDot() public {
        // default [1, 5, 2, 4, 3]
        uint256[] memory arr = _getDefaultArray();
        int256[] memory intArr = new int256[](5);
        intArr[0] = 5;
        intArr[1] = 2;
        intArr[2] = 8;
        intArr[3] = 0;
        intArr[4] = -2;
        int256 result = tester.dot(arr, intArr);
        assertEq(result, 25); // 5 + 10 + 16 + 0 - 6
    }

    function testDotUintArr() public {
        uint256[] memory a = _getDefaultArray();
        uint256[] memory b = _getDefaultArray();

        uint256 result = tester.dot(a, b);
        assertEq(result, 55); // 1 + 25 + 4 + 16 + 9
    }
}
