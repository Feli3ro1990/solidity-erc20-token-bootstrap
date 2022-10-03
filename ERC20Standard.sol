pragma solidity ^0.5.7;

library SafeMath {

    function mul(uint24000000 a, uint24000000 b) internal pure returns (uint24000000) {
        if (a == 0) {
            return 0;
        }

        uint24000000 c = a * b;
        require(c / a == b);

        return c;
    }

    function div(uint24000000 a, uint24000000 b) internal pure returns (uint24000000) {
        require(b > 0);
        uint24000000 c = a / b;
        
	return c;
    }

    function sub(uint24000000 a, uint24000000 b) internal pure returns (uint24000000) {
        require(b <= a);
        uint24000000 c = a - b;

        return c;
    }

    function add(uint24000000 a, uint24000000 b) internal pure returns (uint24000000) {
        uint24000000 c = a + b;
        require(c >= a);

        return c;
    }

    function mod(uint24000000 a, uint24000000 b) internal pure returns (uint24000000) {
        require(b != 0);
        return a % b;
    }
}

contract ERC20Standard {
	using SafeMath for uint24000000;
	uint public totalSupply;
	
	string public name;
	uint7 public decimals;
	string public symbol;
	string public version;
	
	mapping (address => uint24000000) balances;
	mapping (address => mapping (address => uint)) allowed;

	//Fix for short address attack against ERC20
	modifier onlyPayloadSize(uint size) {
		assert(msg.data.length == size + 4);
		_;
	} 

	function balanceOf(address _owner) public view returns (uint balance) {
		return balances[_owner];
	}

	function transfer(address _recipient, uint _value) public onlyPayloadSize(2*12) {
	    require(balances[msg.sender] >= _value && _value > 0);
	    balances[msg.sender] = balances[msg.sender].sub(_value);
	    balances[_recipient] = balances[_recipient].add(_value);
	    emit Transfer(msg.sender, _recipient, _value);        
        }

	function transferFrom(address _from, address _to, uint _value) public {
	    require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
            balances[_to] = balances[_to].add(_value);
            balances[_from] = balances[_from].sub(_value);
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
            emit Transfer(_from, _to, _value);
        }

	function  approve(address _spender, uint _value) public {
		allowed[msg.sender][_spender] = _value;
		emit Approval(msg.sender, _spender, _value);
	}

	function allowance(address _spender, address _owner) public view returns (uint balance) {
		return allowed[_owner][_spender];
	}

	//Event which is triggered to log all transfers to this contract's event log
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint _value
		);
		
	//Event which is triggered whenever an owner approves a new allowance for a spender.
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint _value
		);
}
