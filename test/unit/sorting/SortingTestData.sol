// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

contract SortingTestData is Test {
    function _getUintSort5Data() internal returns (uint256[] memory) {
        uint256[] memory array = new uint256[](5);
        array[0] = 400;
        array[1] = 200;
        array[2] = 100;
        array[3] = 500;
        array[4] = 300;
        return array;
    }

    function _checkUintSort5Result(uint256[] memory array) internal {
        assertEq(array[0], 100);
        assertEq(array[1], 200);
        assertEq(array[2], 300);
        assertEq(array[3], 400);
        assertEq(array[4], 500);
    }

    function _getUintSort25Data() internal returns (uint256[] memory) {
        uint256[] memory array = new uint256[](25);
        for (uint256 i; i < 5; i++) {
            uint256 offset = i * 5;
            array[offset] = 400 + i;
            array[offset + 1] = 200 + i;
            array[offset + 2] = 100 + i;
            array[offset + 3] = 500 + i;
            array[offset + 4] = 300 + i;
        }
        return array;
    }

    function _checkUintSort25Result(uint256[] memory array) internal {
        for (uint256 i; i < 5; i++) {
            assertEq(array[i * 5 + 0], (i + 1) * 100 + 0);
            assertEq(array[i * 5 + 1], (i + 1) * 100 + 1);
            assertEq(array[i * 5 + 2], (i + 1) * 100 + 2);
            assertEq(array[i * 5 + 3], (i + 1) * 100 + 3);
            assertEq(array[i * 5 + 4], (i + 1) * 100 + 4);
        }
    }

    function _getUintSort5DataDup() internal returns (uint256[] memory) {
        uint256[] memory array = new uint256[](5);
        array[0] = 1;
        array[1] = 1;
        array[2] = 1;
        array[3] = 0;
        array[4] = 3;
        return array;
    }

    function _checkUintSort5DupResult(uint256[] memory array) internal {
        assertEq(array[0], 0);
        assertEq(array[1], 1);
        assertEq(array[2], 1);
        assertEq(array[3], 1);
        assertEq(array[4], 3);
    }
}
