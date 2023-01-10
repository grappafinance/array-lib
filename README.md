<div align="center">
  <h1 > Array Util </h1>
  <h3 style="font-size:2.2vw;color:grey">
  Library for Array
  </h3>
  
  <br/>
  <a href="https://github.com/foundry-rs/foundry"><img src="https://img.shields.io/static/v1?label=foundry-rs&message=foundry&color=blue&logo=github"/></a>
  <a href=https://github.com/grappafinance/core/actions/workflows/CI.yml""><img src="https://github.com/grappafinance/core/actions/workflows/CI.yml/badge.svg?branch=master"> </a>

  <a href="https://codecov.io/gh/grappafinance/array-lib" >
<img src="https://codecov.io/gh/grappafinance/array-lib/branch/master/graph/badge.svg?token=6CCM1VFLV9"/>
</a>
  <h5 align="center"> Lib for solidity arrays.</h5>
  
</div>

## Installation

```shell

forge install grappafinance/array-lib@v0.1.0 --no-commit

```

Add to `remapping.txt`
```
array-lib=lib/array-lib/src
```

## Usage

```solidity

import {UintArrayLib} from "array-lib/UintArrayLib.sol";

using UintArrayLib for uint256[];

function zeroSum(uint256[] memory arr) internal pure returns (bool) {
  return arr.sum() == 0;
}
```
