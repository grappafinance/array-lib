// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {IntArrayLib} from "../../IntArrayLib.sol";

/**
 * Basic tests for int array lib
 */
contract IntArrayLibTest is Test {
    using IntArrayLib for int256[];

    function testMax() public {
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
}
