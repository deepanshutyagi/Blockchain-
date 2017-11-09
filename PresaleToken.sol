

// @title Math operations with safety checks
//60606040526040805190810160405280600f81526020017f53796e617073652d50726573616c650000000000000000000000000000000000815250600390805190602001906200005192919062000276565b506012600460006101000a81548160ff021916908360ff1602179055506040805190810160405280600781526020017f53594e2d5052450000000000000000000000000000000000000000000000000081525060059080519060200190620000bb92919062000276565b506040805190810160405280600381526020017f302e330000000000000000000000000000000000000000000000000000000000815250600690805190602001906200010992919062000276565b506000600760146101000a81548160ff02191690831515021790555034156200013157600080fd5b604051602080620014eb833981016040528080519060200190919050505b60008173ffffffffffffffffffffffffffffffffffffffff1614156200017457600080fd5b80600760006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055507fbf265e8326285a2747e33e54d5945f7111f2b5edb826eb8c08d4677779b3ff9733600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019250505060405180910390a15b5062000325565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10620002b957805160ff1916838001178555620002ea565b82800160010185558215620002ea579182015b82811115620002e9578251825591602001919060010190620002cc565b5b509050620002f99190620002fd565b5090565b6200032291905b808211156200031e57600081600090555060010162000304565b5090565b90565b6111b680620003356000396000f30060606040523615610105576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806306fdde031461038c578063095ea7b31461041b57806311aee8af1461047557806318160ddd1461049e57806323b872dd146104c7578063313ce56714610540578063343937431461056f57806354fd4d50146105845780636aa633b6146106135780636e9960c31461064057806370a082311461069557806395d89b41146106e2578063969745e814610771578063a9059cbb1461079a578063d333b3b3146107f4578063dd62ed3e14610821578063ed88c68e1461088d578063f18d20be14610897578063f851a440146108ac575b5b60007fc6d328f1648cac53a495580d7554efe728603aeb41f8a0eca25fde00a25d76fb3334604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018281526020019250505060405180910390a160003411151561018257600080fd5b600760149054906101000a900460ff16151561019d57600080fd5b6101a9346109c4610901565b90507f7a3962e06a9b767d14d8bc468ab62f64a393534ab816d05489e68aaa377a3c533382600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054604051808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001838152602001828152602001935050505060405180910390a16102a6600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205482610935565b600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055507f8f69057bbc20d26114c8fa866e9b1ba609bf74aba9d415789e5bca87b47fd997303383604051808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001828152602001935050505060405180910390a15b50005b341561039757600080fd5b61039f610960565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156103e05780820151818401525b6020810190506103c4565b50505050905090810190601f16801561040d5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561042657600080fd5b61045b600480803573ffffffffffffffffffffffffffffffffffffffff169060200190919080359060200190919050506109fe565b604051808215151515815260200191505060405180910390f35b341561048057600080fd5b610488610a0b565b6040518082815260200191505060405180910390f35b34156104a957600080fd5b6104b1610a79565b6040518082815260200191505060405180910390f35b34156104d257600080fd5b610526600480803573ffffffffffffffffffffffffffffffffffffffff1690602001909190803573ffffffffffffffffffffffffffffffffffffffff16906020019091908035906020019091905050610a7f565b604051808215151515815260200191505060405180910390f35b341561054b57600080fd5b610553610a8d565b604051808260ff1660ff16815260200191505060405180910390f35b341561057a57600080fd5b610582610aa0565b005b341561058f57600080fd5b610597610b2a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156105d85780820151818401525b6020810190506105bc565b50505050905090810190601f1680156106055780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561061e57600080fd5b610626610bc8565b604051808215151515815260200191505060405180910390f35b341561064b57600080fd5b610653610bdb565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156106a057600080fd5b6106cc600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091905050610c8b565b6040518082815260200191505060405180910390f35b34156106ed57600080fd5b6106f5610cd5565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156107365780820151818401525b60208101905061071a565b50505050905090810190601f1680156107635780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561077c57600080fd5b610784610d73565b6040518082815260200191505060405180910390f35b34156107a557600080fd5b6107da600480803573ffffffffffffffffffffffffffffffffffffffff16906020019091908035906020019091905050610d79565b604051808215151515815260200191505060405180910390f35b34156107ff57600080fd5b610807610d86565b604051808215151515815260200191505060405180910390f35b341561082c57600080fd5b610877600480803573ffffffffffffffffffffffffffffffffffffffff1690602001909190803573ffffffffffffffffffffffffffffffffffffffff16906020019091905050610de8565b6040518082815260200191505060405180910390f35b610895610df5565b005b34156108a257600080fd5b6108aa61107b565b005b34156108b757600080fd5b6108bf611154565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b600080828402905061092a6000851480610925575083858381151561092257fe5b04145b61117a565b8091505b5092915050565b60008082840190506109558482101580156109505750838210155b61117a565b8091505b5092915050565b60038054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156109f65780601f106109cb576101008083540402835291602001916109f6565b820191906000526020600020905b8154815290600101906020018083116109d957829003601f168201915b505050505081565b6000806000fd5b92915050565b60007fe6c03ed8114eabea9250ad173c2f381c1de281fe3d098122e5f3c8e711b524853073ffffffffffffffffffffffffffffffffffffffff16316040518082815260200191505060405180910390a13073ffffffffffffffffffffffffffffffffffffffff163190505b90565b60005481565b6000806000fd5b9392505050565b600460009054906101000a900460ff1681565b600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16141515610afc57600080fd5b600760149054906101000a900460ff1615600760146101000a81548160ff0219169083151502179055505b5b565b60068054600181600116156101000203166002900480601f016020809104026020016040519081016040528092919081815260200182805460018160011615610100020316600290048015610bc05780601f10610b9557610100808354040283529160200191610bc0565b820191906000526020600020905b815481529060010190602001808311610ba357829003601f168201915b505050505081565b600760149054906101000a900460ff1681565b60007f33b005d053f740768cddf56d4aae11b8b1fb294e749565266b2f2b20e80e9cdf600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390a1600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690505b90565b6000600160008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205490505b919050565b60058054600181600116156101000203166002900480601f016020809104026020016040519081016040528092919081815260200182805460018160011615610100020316600290048015610d6b5780601f10610d4057610100808354040283529160200191610d6b565b820191906000526020600020905b815481529060010190602001808311610d4e57829003601f168201915b505050505081565b6109c481565b6000806000fd5b92915050565b60007fb51169e2bc220ff8f8568457941371f075453bb2e222cbef3131638de25ded4d600760149054906101000a900460ff16604051808215151515815260200191505060405180910390a1600760149054906101000a900460ff1690505b90565b6000806000fd5b92915050565b60007fc6d328f1648cac53a495580d7554efe728603aeb41f8a0eca25fde00a25d76fb3334604051808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018281526020019250505060405180910390a1600034111515610e7157600080fd5b600760149054906101000a900460ff161515610e8c57600080fd5b610e98346109c4610901565b90507f7a3962e06a9b767d14d8bc468ab62f64a393534ab816d05489e68aaa377a3c533382600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054604051808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001838152602001828152602001935050505060405180910390a1610f95600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205482610935565b600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055507f8f69057bbc20d26114c8fa866e9b1ba609bf74aba9d415789e5bca87b47fd997303383604051808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001828152602001935050505060405180910390a15b50565b600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156110d757600080fd5b600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc3073ffffffffffffffffffffffffffffffffffffffff16319081150290604051600060405180830381858888f19350505050151561115057600080fd5b5b5b565b600760009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b80151561118657600080fd5b5b505600a165627a7a723058207627ca549304d77f56c292fc606c4fd664e2e51416db8f3c357d2a00673d598c0029
// Abstract contract for the full ERC 20 Token standard

// https://github.com/ethereum/EIPs/issues/20

pragma solidity ^0.4.11;

// @title Math operations with safety checks

contract SafeMath {

  function safeMul(uint a, uint b) internal returns (uint) {

    uint c = a * b;

    assert(a == 0 || c / a == b);

    return c;

  }

  function safeDiv(uint a, uint b) internal returns (uint) {

    assert(b > 0);

    uint c = a / b;

    assert(a == b * c + a % b);

    return c;

  }

  function safeSub(uint a, uint b) internal returns (uint) {

    assert(b <= a);

    return a - b;

  }

  function safeAdd(uint a, uint b) internal returns (uint) {

    uint c = a + b;

    assert(c>=a && c>=b);

    return c;

  }

  function max64(uint64 a, uint64 b) internal constant returns (uint64) {

    return a >= b ? a : b;

  }

  function min64(uint64 a, uint64 b) internal constant returns (uint64) {

    return a < b ? a : b;

  }

  function max256(uint256 a, uint256 b) internal constant returns (uint256) {

    return a >= b ? a : b;

  }

  function min256(uint256 a, uint256 b) internal constant returns (uint256) {

    return a < b ? a : b;

  }

  function assert(bool assertion) internal {

    if (!assertion) {

      revert();

    }

  }

}

contract Token {

    /* This is a slight change to the ERC20 base standard.

    function totalSupply() constant returns (uint256 supply);

    is replaced with:

    uint256 public totalSupply;

    This automatically creates a getter function for the totalSupply.

    This is moved to the base contract since public getter functions are not

    currently recognised as an implementation of the matching abstract

    function by the compiler.

    */

    /// total amount of tokens

    uint256 public totalSupply;

    /// @param _owner The address from which the balance will be retrieved

    /// @return The balance

    function balanceOf(address _owner) constant returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`

    /// @param _to The address of the recipient

    /// @param _value The amount of token to be transferred

    /// @return Whether the transfer was successful or not

    function transfer(address _to, uint256 _value) returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`

    /// @param _from The address of the sender

    /// @param _to The address of the recipient

    /// @param _value The amount of token to be transferred

    /// @return Whether the transfer was successful or not

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

    /// @notice `msg.sender` approves `_spender` to spend `_value` tokens

    /// @param _spender The address of the account able to transfer the tokens

    /// @param _value The amount of tokens to be approved for transfer

    /// @return Whether the approval was successful or not

    function approve(address _spender, uint256 _value) returns (bool success);

    /// @param _owner The address of the account owning tokens

    /// @param _spender The address of the account able to transfer the tokens

    /// @return Amount of remaining tokens allowed to spent

    function allowance(address _owner, address _spender) constant returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

/*

You should inherit from StandardToken or, for a token like you would want to

deploy in something like Mist, see PresaleToken.sol.

(This implements ONLY the standard functions and NOTHING else.

If you deploy this, you won't have anything useful.)

Implements ERC 20 Token standard: https://github.com/ethereum/EIPs/issues/20

.*/

contract StandardToken is Token {

    function transfer(address _to, uint256 _value) returns (bool success) {

        revert();

    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {

        revert();

    }

    function balanceOf(address _owner) constant returns (uint256 balance) {

        return balances[_owner];

    }

    function approve(address _spender, uint256 _value) returns (bool success) {

        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        return true;

    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {

      return allowed[_owner][_spender];

    }

    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;

}

contract PresaleToken is StandardToken, SafeMath{

    string public name="Presale";                   

    uint8 public decimals=18; 

    string public symbol="PRE";                 

    string public version = '0.1';       

    

    // $0.12/1 token if $300/1 ether

    uint256 public constant presale_price = 4*(10**14);

    address public admin;

    bool public isEnabled = false;

    event PresalInactive(bytes32 message);

    event PresaleActive(bytes32 message);

    event WithdrawSuccess(address withdrawTo, uint256 amount);

    event WithdrawFail(address withdrawTo, uint256 amount);

    event InitPurchase(address sender, uint256 quantity, uint256 initial);

    event PostPurchase(address presale, address sender, uint256 quantity);

    event PresaleIsEnabled(bool isEnabled);

    event Admin(address _address);

    event AdminSet(address sender, address admin);

    event PresaleValue(uint256 _value);

    event PayableHit(address _address, uint256 _value);

    // if person is not admin of the contract throw

    modifier isAdmin() {

            if (msg.sender != admin) throw;

            _;

    }

    /// @notice `msg.sender` invest `msg.value`

    function() payable {

        

        PayableHit(msg.sender, msg.value);

        

        //check value sent

        require(msg.value > 0);

        

        // check active

        require(isEnabled);

        // calculate quantity

        uint256 quantity = safeDiv(msg.value, presale_price);

        InitPurchase(msg.sender, quantity, balances[msg.sender]);

        

        // update balance of sender

        balances[msg.sender] = safeAdd(balances[msg.sender], quantity);

        PostPurchase(this, msg.sender, quantity);

    }

    /// @notice `msg.sender` invest `msg.value`

    function donate() payable {

        

        PayableHit(msg.sender, msg.value);

        

        //check value sent

        require(msg.value > 0);

        

        // check active

        require(isEnabled);

        // calculate quantity

        uint256 quantity = safeDiv(msg.value, presale_price);

        InitPurchase(msg.sender, quantity, balances[msg.sender]);

        

        // update balance of sender

        balances[msg.sender] = safeAdd(balances[msg.sender], quantity);

        PostPurchase(this, msg.sender, quantity);

    }

    //set owner of presale token to deployer address

    function PresaleToken(address _admin) {

        admin = _admin;

        AdminSet(msg.sender, admin);

    }

    //toggle presale on/off

    function togglePresale() external isAdmin {

        isEnabled=!isEnabled;

    }

    //withdraw to owner address

    function adminWithdraw(uint256 value) external isAdmin {

        if(value > this.balance){

            WithdrawFail(admin, value);

            revert();

        }

        admin.transfer(value);

        WithdrawSuccess(admin,value);

        

    }

    

    //return ether in contract

    function getPresaleValue() external returns (uint256 _value){

        PresaleValue(this.balance);

        return this.balance;

    }

    

    //get presale status

    function getIsEnabled() external returns (bool _isEnabled){

        PresaleIsEnabled(isEnabled);

        return isEnabled;

    }

    

    //TODO owner->admin

    //get owner address

    function getAdmin() external returns (address _admin) {

        Admin(admin);

        return admin;

    }

    

}

