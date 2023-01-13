// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {QuickSort} from "src/sorting/QuickSort.sol";

/**
 * Basic tests
 */
contract QuickSortTestUnit is Test {
    using QuickSort for uint256[];
    using QuickSort for int256[];

    function testGetSorted5() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;

        uint256[] memory sorted = array.getSorted();
        assertEq(sorted.length, 5);
        assertEq(sorted[0], 100);
        assertEq(sorted[1], 200);
        assertEq(sorted[2], 300);
        assertEq(sorted[3], 400);
        assertEq(sorted[4], 500);
    }

    function testSort5() public {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;

        array.quickSort();
        assertEq(array[0], 100);
        assertEq(array[1], 200);
        assertEq(array[2], 300);
        assertEq(array[3], 400);
        assertEq(array[4], 500);
    }

    function testSort25() public {
        uint256[] memory array = new uint256[](25);
        for (uint256 i; i < 5; i++) {
            uint256 offset = i * 5;
            array[offset] = 400;
            array[offset + 1] = 200 + i;
            array[offset + 2] = 100 + i;
            array[offset + 3] = 500 + i;
            array[offset + 4] = 300 + i;
        }

        array.quickSort();
        assertEq(array[0], 100);
        assertEq(array[1], 101);
        assertEq(array[2], 102);
        assertEq(array[3], 103);
        assertEq(array[4], 104);
    }

    function testSortDup5() public {
        uint256[] memory array = new uint256[](6);
        array[0] = 1;
        array[1] = 1;
        array[2] = 1;
        array[3] = 0;
        array[4] = 3;
        array[5] = 3;

        array.quickSort();
        assertEq(array[0], 0);
        assertEq(array[1], 1);
        assertEq(array[2], 1);
        assertEq(array[3], 1);
        assertEq(array[4], 3);
        assertEq(array[5], 3);
    }

    function testArgSort5() public {
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
