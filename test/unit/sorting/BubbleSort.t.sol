// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SortingTestData} from "./SortingTestData.sol";

import {BubbleSort} from "src/sorting/BubbleSort.sol";

/**
 * @dev basic test cases for all sorting algorithms
 */
contract BubbleSortInheritTests is SortingTestData {
    using BubbleSort for uint256[];

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
