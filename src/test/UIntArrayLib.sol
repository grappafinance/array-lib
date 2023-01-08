// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, stdError} from "forge-std/Test.sol";

import {UintArrayLib} from "../UintArrayLib.sol";

/**
 * Basic tests
 */
contract ArrayUtilTest is Test {
    using UintArrayLib for uint256[];

    function testConcat() public {
        uint256[] memory array1 = new uint256[](0);
        array1 = array1.append(1);
        array1 = array1.append(2);

        assertEq(array1.length, 2);
        assertEq(array1[0], 1);
        assertEq(array1[1], 2);

        uint256[] memory array2 = new uint256[](0);
        array2 = array2.append(3);
        array2 = array2.append(4);
        array1 = array1.concat(array2);

        assertEq(array1.length, 4);
        assertEq(array1[0], 1);
        assertEq(array1[1], 2);
        assertEq(array1[2], 3);
        assertEq(array1[3], 4);

        array1 = new uint256[](0);
        array1 = array1.append(1);
        array2 = new uint256[](0);
        array1 = array1.concat(array2);

        assertEq(array1.length, 1);
        assertEq(array1[0], 1);
    }

    function testNegativeIndexSelector() public {
        uint256[] memory array1 = new uint256[](0);
        array1 = array1.append(1);
        array1 = array1.append(2);
        array1 = array1.append(3);

        uint256 element;

        element = array1.at(-1);
        assertEq(element, 3);

        vm.expectRevert(UintArrayLib.IndexOutOfBounds.selector);
        array1.at(-10);
    }

    function testPopulate() public {
        uint256[] memory array1 = new uint256[](2);

        uint256[] memory array2 = new uint256[](2);
        array2[0] = 1;
        array2[1] = 2;

        array1.populate(array2, 0);
        assertEq(array1.length, 2);
        assertEq(array1[0], 1);
        assertEq(array1[1], 2);

        vm.expectRevert(stdError.indexOOBError);
        array1.populate(array2, 1);
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
