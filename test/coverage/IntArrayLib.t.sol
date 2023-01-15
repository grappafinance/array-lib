// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {IntArrayLib} from "src/IntArrayLib.sol";

contract IntArrayLibTester {
    function max(int256[] memory x) external pure returns (int256) {
        int256 m = IntArrayLib.max(x);
        return m;
    }

    function min(int256[] memory x) external pure returns (int256) {
        int256 m = IntArrayLib.min(x);
        return m;
    }

    function minWithIndex(int256[] memory x) external pure returns (int256, uint256) {
        (int256 min_, uint256 idx) = IntArrayLib.minWithIndex(x);
        return (min_, idx);
    }

    function sum(int256[] memory x) external pure returns (int256) {
        int256 s = IntArrayLib.sum(x);
        return s;
    }

    function maximum(int256[] memory x, int256 z) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.maximum(x, z);
        return y;
    }

    function remove(int256[] memory x, uint256 z) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.remove(x, z);
        return y;
    }

    function indexOf(int256[] memory x, int256 v) external pure returns (bool, uint256) {
        (bool found, uint256 index) = IntArrayLib.indexOf(x, v);
        return (found, index);
    }

    function append(int256[] memory x, int256 v) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.append(x, v);
        return y;
    }

    function fill(int256[] memory x, int256 v) external pure returns (int256[] memory) {
        IntArrayLib.fill(x, v);
        return x;
    }

    function slice(int256[] memory x, int256 l, int256 r) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.slice(x, l, r);
        return y;
    }

    function sortByIndexes(int256[] memory x, uint256[] memory indexes) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.sortByIndexes(x, indexes);
        return y;
    }

    function concat(int256[] memory a, int256[] memory b) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.concat(a, b);
        return y;
    }

    function populate(int256[] memory a, int256[] memory b) external pure returns (int256[] memory) {
        IntArrayLib.populate(a, b);
        return a;
    }

    function at(int256[] memory x, int256 i) external pure returns (int256) {
        int256 v = IntArrayLib.at(x, i);
        return v;
    }

    function add(int256[] memory a, int256[] memory b) external pure returns (int256[] memory) {
        int256[] memory c = IntArrayLib.add(a, b);
        return c;
    }

    function subEachBy(int256[] memory x, int256 z) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.subEachBy(x, z);
        return y;
    }

    function addEachBy(int256[] memory x, int256 z) external pure returns (int256[] memory) {
        int256[] memory y = IntArrayLib.addEachBy(x, z);
        return y;
    }

    function dot(int256[] memory a, int256[] memory b) external pure returns (int256) {
        int256 m = IntArrayLib.dot(a, b);
        return m;
    }
}

/**
 * tests written for coverage. all calls routed through IntArrayLibTester
 */
contract IntArrayLibCoverage is Test {
    using IntArrayLib for uint256[];

    IntArrayLibTester public tester;

    function setUp() public {
        tester = new IntArrayLibTester();
    }

    function _getDefaultArray() internal pure returns (int256[] memory) {
        int256[] memory arr = new int256[](5);
        arr[0] = 1;
        arr[1] = 5;
        arr[2] = -2;
        arr[3] = 4;
        arr[4] = -3;
        return arr;
    }

    function _getDefaultLarge() internal pure returns (int256[] memory) {
        int256[] memory arr = new int256[](5);
        arr[0] = 1e18;
        arr[1] = 5e18;
        arr[2] = -2e18;
        arr[3] = 4e18;
        arr[4] = -3e18;
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
        int256[] memory arr = _getDefaultArray();
        assertEq(tester.max(arr), 5);
    }

    function testMaximum() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        int256[] memory y = tester.maximum(arr, 0);
        assertEq(y[0], 1);
        assertEq(y[1], 5);
        assertEq(y[2], 0);
        assertEq(y[3], 4);
        assertEq(y[4], 0);
    }

    function testMin() public {
        int256[] memory arr = _getDefaultArray();
        assertEq(tester.min(arr), -3);
    }

    function testMin2() public {
        int256[] memory arr = new int256[](5);
        arr[0] = 100;
        arr[1] = 200;
        arr[2] = type(int256).min;
        arr[3] = 300;
        arr[4] = type(int256).min;
        assertEq(tester.min(arr), type(int256).min);
    }

    function testMinWithIndex() public {
        int256[] memory arr = _getDefaultArray();
        (int256 min_, uint256 idx) = tester.minWithIndex(arr);
        assertEq(min_, -3);
        assertEq(idx, 4);
    }

    function testSum() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        assertEq(tester.sum(arr), 5);
    }

    function testRemove() public {
        int256[] memory arr = _getDefaultArray();
        int256[] memory removed = tester.remove(arr, 1);
        assertEq(removed[0], 1);
        assertEq(removed[1], -2);
        assertEq(removed.length, 4);

        // remove index 5: unchange
        int256[] memory removed2 = tester.remove(arr, 5);
        assertEq(removed2[4], -3);
        assertEq(removed2.length, 5);
    }

    function testIndexOf() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        (bool found0, uint256 indexOf0) = tester.indexOf(arr, 0);
        assertEq(found0, false);
        assertEq(indexOf0, 0);

        (bool found3, uint256 indexOf3) = tester.indexOf(arr, -3);
        assertEq(found3, true);
        assertEq(indexOf3, 4);
    }

    function testAppend() public {
        int256[] memory arr = _getDefaultArray();
        arr = tester.append(arr, 1);
        arr = tester.append(arr, 2);

        assertEq(arr.length, 7);
        assertEq(arr[5], 1);
        assertEq(arr[6], 2);
    }

    function testConcat() public {
        int256[] memory array1 = _getDefaultArray();
        int256[] memory array2 = _getDefaultArray();

        int256[] memory newArr = tester.concat(array1, array2);
        assertEq(newArr.length, 10);
        assertEq(newArr[0], newArr[5]);
        assertEq(newArr[1], newArr[6]);
        assertEq(newArr[2], newArr[7]);
        assertEq(newArr[3], newArr[8]);
        assertEq(newArr[4], newArr[9]);
    }

    function testFill() public {
        int256[] memory empty = new int256[](5);

        int256[] memory newArr = tester.fill(empty, 77);
        assertEq(newArr[0], 77);
        assertEq(newArr[4], 77);
    }

    function testPopulate() public {
        int256[] memory empty = new int256[](5);
        int256[] memory arr = _getDefaultArray();

        int256[] memory newArr = tester.populate(empty, arr);
        assertEq(newArr[0], arr[0]);
        assertEq(newArr[1], arr[1]);
        assertEq(newArr[2], arr[2]);
        assertEq(newArr[3], arr[3]);
        assertEq(newArr[4], arr[4]);
    }

    function testIndexSelector() public {
        int256[] memory array1 = _getDefaultArray();

        // default [1, 5, -2, 4, -3]
        assertEq(tester.at(array1, 0), 1);
        assertEq(tester.at(array1, 4), -3);

        // last element is 3
        assertEq(tester.at(array1, -1), -3);
        assertEq(tester.at(array1, -2), 4);

        // index underflow
        vm.expectRevert(stdError.arithmeticError);
        tester.at(array1, -6);

        // index out of bond
        vm.expectRevert(stdError.indexOOBError);
        tester.at(array1, 5);
    }

    function testSlice() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory array = _getDefaultArray();

        int256[] memory slice = tester.slice(array, 2, 4);
        assertEq(slice.length, 2);
        assertEq(slice[0], -2);
        assertEq(slice[1], 4);

        // ending = 0 is the same as ending = length
        slice = tester.slice(array, 2, 0);
        assertEq(slice.length, 3);
        assertEq(slice[0], -2);
        assertEq(slice[1], 4);
        assertEq(slice[2], -3);

        // ending = length
        slice = tester.slice(array, 2, 5);
        assertEq(slice.length, 3);
        assertEq(slice[0], -2);
        assertEq(slice[1], 4);
        assertEq(slice[2], -3);
    }

    function testSliceNegativeIndex() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory array = _getDefaultArray();
        int256[] memory slice = tester.slice(array, 1, -1);
        assertEq(slice.length, 3);
        assertEq(slice[0], 5);
        assertEq(slice[1], -2);
        assertEq(slice[2], 4);

        slice = tester.slice(array, -3, -1);
        assertEq(slice.length, 2);
        assertEq(slice[0], -2);
        assertEq(slice[1], 4);

        slice = tester.slice(array, -1, -2);
        assertEq(slice.length, 0);
    }

    function testAdd() public {
        int256[] memory arr1 = _getDefaultArray();
        int256[] memory arr2 = _getDefaultArray();

        int256[] memory sum = tester.add(arr1, arr2);
        assertEq(sum[0], arr1[0] * 2);
        assertEq(sum[1], arr1[1] * 2);
        assertEq(sum[2], arr1[2] * 2);
        assertEq(sum[3], arr2[3] * 2);
        assertEq(sum[4], arr2[4] * 2);
    }

    function testSubEachBy() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        int256[] memory result = tester.subEachBy(arr, 3);

        assertEq(result[0], -2);
        assertEq(result[1], 2);
        assertEq(result[2], -5);
        assertEq(result[3], 1);
        assertEq(result[4], -6);
    }

    function testAddEachBy() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        int256[] memory result = tester.addEachBy(arr, -3);

        assertEq(result[0], -2);
        assertEq(result[1], 2);
        assertEq(result[2], -5);
        assertEq(result[3], 1);
        assertEq(result[4], -6);
    }

    function testDot() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();
        int256[] memory intArr = new int256[](5);
        intArr[0] = 5;
        intArr[1] = 2;
        intArr[2] = 8;
        intArr[3] = 0;
        intArr[4] = -2;
        int256 result = tester.dot(arr, intArr);
        assertEq(result, 5); // 5 + 10 - 16 + 0 + 6
    }

    function testDotUintArr() public {
        int256[] memory a = _getDefaultArray();
        int256[] memory b = _getDefaultArray();

        int256 result = tester.dot(a, b);
        assertEq(result, 55); // 1 + 25 + 4 + 16 + 9
    }

    function testSortByIndex() public {
        // default [1, 5, -2, 4, -3]
        int256[] memory arr = _getDefaultArray();

        uint256[] memory idxs = new uint256[](5);
        idxs[0] = 1; // first element is arr[1] = 5
        idxs[1] = 3; // second element is arr[3] = 4
        idxs[2] = 0;
        idxs[3] = 2;
        idxs[4] = 4;

        int256[] memory sorted = tester.sortByIndexes(arr, idxs);
        assertEq(sorted[0], 5);
        assertEq(sorted[1], 4);
        assertEq(sorted[2], 1);
        assertEq(sorted[3], -2);
        assertEq(sorted[4], -3);
    }
}
