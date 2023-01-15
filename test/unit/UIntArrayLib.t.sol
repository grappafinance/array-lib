// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {UintArrayLib} from "src/UintArrayLib.sol";

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
}
