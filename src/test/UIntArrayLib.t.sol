// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {UintArrayLib} from "../UintArrayLib.sol";

/**
 * Basic tests
 */
contract ArrayUtilTest is Test {
    using UintArrayLib for uint256[];

    /**
     * util for test data
     */
    function _getDefaultArray() internal pure returns (uint256[] memory) {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 5;
        arr[2] = 2;
        arr[3] = 4;
        arr[4] = 3;
        return arr;
    }

    function testSum() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(arr.sum(), 15);
    }

    function testMax() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(arr.max(), 5);
    }

    function testMin() public {
        uint256[] memory arr = _getDefaultArray();
        assertEq(arr.min(), 1);
    }

    function testMinMax() public {
        uint256[] memory arr = _getDefaultArray();
        (uint256 min, uint256 max) = arr.minMax();
        assertEq(min, 1);
        assertEq(max, 5);
    }

    function testAppend() public {
        uint256[] memory arr = _getDefaultArray();
        arr = arr.append(1);
        arr = arr.append(2);

        assertEq(arr.length, 7);
        assertEq(arr[5], 1);
        assertEq(arr[6], 2);
    }

    function testConcat() public {
        uint256[] memory array1 = _getDefaultArray();
        uint256[] memory array2 = _getDefaultArray();

        array1 = array1.concat(array2);

        assertEq(array1.length, 10);
        assertEq(array1[0], array1[5]);
        assertEq(array1[1], array1[6]);
        assertEq(array1[2], array1[7]);
        assertEq(array1[3], array1[8]);
        assertEq(array1[4], array1[9]);
    }

    function testIndexSelector() public {
        uint256[] memory array1 = _getDefaultArray();

        // first 3 elements are 1, 5, 2
        assertEq(array1.at(0), 1);
        assertEq(array1.at(1), 5);
        assertEq(array1.at(2), 2);

        // last element is 3
        assertEq(array1.at(-1), 3);
        assertEq(array1.at(-2), 4);

        vm.expectRevert(UintArrayLib.IndexOutOfBounds.selector);
        array1.at(-6);
    }

    function testPopulate() public {
        uint256[] memory array1 = new uint256[](2);

        uint256[] memory array2 = new uint256[](2);
        array2[0] = 1;
        array2[1] = 2;

        array1.populate(array2);

        assertEq(array1.length, 2);
        assertEq(array1[0], 1);
        assertEq(array1[1], 2);
    }

    function testSort() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;

        uint256[] memory sorted = array.sort();
        assertEq(sorted.length, 5);
        assertEq(sorted[0], 100);
        assertEq(sorted[1], 200);
        assertEq(sorted[2], 300);
        assertEq(sorted[3], 400);
        assertEq(sorted[4], 500);
    }

    function testSortInPlace() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;

        array.quickSort(); // this sort the array in place
        assertEq(array[0], 100);
        assertEq(array[1], 200);
        assertEq(array[2], 300);
        assertEq(array[3], 400);
        assertEq(array[4], 500);
    }

    function testSortDups() public {
        uint256[] memory array = new uint256[](6);
        array[0] = 1;
        array[1] = 1;
        array[2] = 1;
        array[3] = 0;
        array[4] = 3;
        array[5] = 3;

        uint256[] memory sorted = array.sort();
        assertEq(sorted.length, 6);
        assertEq(sorted[0], 0);
        assertEq(sorted[1], 1);
        assertEq(sorted[2], 1);
        assertEq(sorted[3], 1);
        assertEq(sorted[4], 3);
        assertEq(sorted[5], 3);
    }

    function testArgSort() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;

        (uint256[] memory sorted, uint256[] memory indexes) = array.argSort();
        assertEq(sorted.length, 5);
        assertEq(sorted[0], 100);
        assertEq(sorted[1], 200);
        assertEq(sorted[2], 300);
        assertEq(sorted[3], 400);
        assertEq(sorted[4], 500);

        assertEq(indexes.length, 5);
        assertEq(indexes[0], 2);
        assertEq(indexes[1], 1);
        assertEq(indexes[2], 4);
        assertEq(indexes[3], 0);
        assertEq(indexes[4], 3);
    }

    function testArgSortDups() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 4;
        array[1] = 1;
        array[2] = 1;
        array[3] = 1;
        array[4] = 3;

        (uint256[] memory sorted, uint256[] memory indexes) = array.argSort();
        assertEq(sorted.length, 5);
        assertEq(sorted[0], 1);
        assertEq(sorted[1], 1);
        assertEq(sorted[2], 1);
        assertEq(sorted[3], 3);
        assertEq(sorted[4], 4);

        assertEq(indexes.length, 5);
        assertEq(indexes[0], 2);
        assertEq(indexes[1], 3);
        assertEq(indexes[2], 1);
        assertEq(indexes[3], 4);
        assertEq(indexes[4], 0);
    }

    function testArgSortDupsEvenItems() public {
        uint256[] memory array = new uint256[](6);
        array[0] = 4;
        array[1] = 1;
        array[2] = 1;
        array[3] = 1;
        array[4] = 3;
        array[5] = 3;

        (uint256[] memory sorted, uint256[] memory indexes) = array.argSort();
        assertEq(sorted.length, 6);
        assertEq(sorted[0], 1);
        assertEq(sorted[1], 1);
        assertEq(sorted[2], 1);
        assertEq(sorted[3], 3);
        assertEq(sorted[4], 3);
        assertEq(sorted[5], 4);

        assertEq(indexes.length, 6);

        assertEq(indexes[0], 2);
        assertEq(indexes[1], 3);
        assertEq(indexes[2], 1);
        assertEq(indexes[3], 4);
        assertEq(indexes[4], 5);
        assertEq(indexes[5], 0);
    }
}
