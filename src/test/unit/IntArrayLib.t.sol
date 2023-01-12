// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {IntArrayLib} from "../../IntArrayLib.sol";

/**
 * Basic tests for int array lib
 */
contract IntArrayLibTest is Test {
    using IntArrayLib for int256[];

    function testSlice() public {
        int256[] memory array = new int256[](5);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        array[3] = 4;
        array[4] = 5;

        int256[] memory slice = array.slice(2, 4);
        assertEq(slice.length, 2);
        assertEq(slice[0], 3);
        assertEq(slice[1], 4);

        slice = array.slice(1, -1);
        assertEq(slice.length, 3);
        assertEq(slice[0], 2);
        assertEq(slice[1], 3);
        assertEq(slice[2], 4);

        slice = array.slice(-3, -1);
        assertEq(slice.length, 2);
        assertEq(slice[0], 3);
        assertEq(slice[1], 4);

        slice = array.slice(2, 0);
        assertEq(slice.length, 3);
        assertEq(slice[0], 3);
        assertEq(slice[1], 4);
        assertEq(slice[2], 5);

        slice = array.slice(-1, -2);
        assertEq(slice.length, 0);
    }

    // function testArgSortDupsInt() public {
    //     /// this implicitly tests sort and sort dups too
    //     int256[] memory array = new int256[](5);
    //     array[0] = 4;
    //     array[1] = -1;
    //     array[2] = -1;
    //     array[3] = -1;
    //     array[4] = 3;

    //     (int256[] memory sorted, uint256[] memory indexes) = array.argSort();
    //     assertEq(sorted.length, 5);
    //     assertEq(sorted[0], -1);
    //     assertEq(sorted[1], -1);
    //     assertEq(sorted[2], -1);
    //     assertEq(sorted[3], 3);
    //     assertEq(sorted[4], 4);

    //     assertEq(indexes.length, 5);

    //     assertEq(indexes[0], 2);
    //     assertEq(indexes[1], 3);
    //     assertEq(indexes[2], 1);
    //     assertEq(indexes[3], 4);
    //     assertEq(indexes[4], 0);
    // }

    function testSortByIndexes() public {
        int256[] memory array2 = new int256[](5);
        array2[0] = 400;
        array2[1] = 200;
        array2[2] = 100;
        array2[3] = 500;
        array2[4] = 300;

        uint256[] memory indexes = new uint256[](5);
        indexes[0] = 2;
        indexes[1] = 1;
        indexes[2] = 4;
        indexes[3] = 0;
        indexes[4] = 3;

        int256[] memory sortedByIndex = array2.sortByIndexes(indexes);
        assertEq(sortedByIndex.length, 5);
        assertEq(sortedByIndex[0], 100);
        assertEq(sortedByIndex[1], 200);
        assertEq(sortedByIndex[2], 300);
        assertEq(sortedByIndex[3], 400);
        assertEq(sortedByIndex[4], 500);
    }
}
