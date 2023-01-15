// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {SortingTestData} from "./SortingTestData.sol";
import {QuickSort} from "src/sorting/QuickSort.sol";

/**
 * @dev basic test cases for all sorting algorithms
 */
contract QuickSortInheritTests is SortingTestData {
    using QuickSort for uint256[];

    function testSort5() public {
        uint256[] memory array = _getUintSort5Data();
        array.sort();
        _checkUintSort5Result(array);
    }

    function testSort25() public {
        uint256[] memory array = _getUintSort25Data();
        array.sort();
        _checkUintSort25Result(array);
    }

    function testSortDup5() public {
        uint256[] memory array = _getUintSort5DataDup();
        array.sort();
        _checkUintSort5DupResult(array);
    }
}

/**
 * @dev extended tests on other function from the libarary
 */
contract QuickSortUnitTestExtended is Test {
    using QuickSort for uint256[];

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
