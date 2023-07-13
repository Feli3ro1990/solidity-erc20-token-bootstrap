pragma solidity ^0.5.7;

import "./ERC20Standard.sol";

contract NewToken is ERC20Standard {
	constructor() public {
		totalSupply = 27000000;
		name = "Siglos";
		decimals = 7;
		symbol = "SGL";
		version = "1.1.9";
		balances[msg.sender] = totalSupply;
	}
}
