pragma solidity 0.4.11;//not sure which version to use as 0.4.13 just came out

//imports
import "./SafeMath.sol";
//https://theethereum.wiki/w/index.php/ERC20_Token_Standard
contract ERC20 {
    //function totalSupply() constant returns (uint totalSupply) {}
    //function balanceOf(address owner) constant returns (uint balance) {}
    //function transfer(address _to, uint _value) returns (bool success) {}
    function transferFrom(address _from, address _to, uint _value) returns (bool success) {}
    function approve(address _spender, uint _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns (uint remaining) {}
    
    //event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
 }

  contract ERC223ReceivingContract {
    function tokenFallback(address _from, uint _value, bytes _data);
}

 contract ERC223 {
  uint public totalSupply;
  function balanceOf(address owner) constant returns (uint);
  
  function name() constant returns (string _name);
  function symbol() constant returns (string _symbol);
  function decimals() constant returns (uint8 decimals);
  function totalSupply() constant returns (uint256 _supply);

  function transfer(address _to, uint value) returns (bool ok);
  function transfer(address _to, uint value, bytes data) returns (bool ok);
  event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}

contract DelphiToken is ERC20, ERC223, SafeMath{

//start contract - list all variables 

    address public owner;
    string  public name = "Delphi Token";
    uint    public totalSupply;
    string  public symbol = "DEL";
    uint    public tokValue;
    uint8   public decimals = 18;
    uint    public adminCount;//no. of admins
    uint public MAX_TOTAL_TOKEN_AMOUNT;

//mappings
    mapping (address=>uint256) balance;  //balance of 
    mapping (address=> mapping (address => uint256)) allow; //allowed
    mapping (address => bool) public frozen;//frozen 
    mapping (address=> bool) administrator;//for adding new administrators

//modifier
    // if person is not owner of the contract throw
    modifier isCreator() {
            if (msg.sender != owner) throw;
            _;
    }
    
    //if person is not admin throw    
    modifier onlyAdmin(){
            if (administrator[msg.sender]!=true) throw;
            _;
    }
    	

//events
    event Transfer (address buyer, address owner, uint256 amount, bytes data);
  //event Transfer (address buyer, address owner, uint256 amount);
    event Approval (address owner, address buyer, uint256 amount); 

//constructor - initialize all variables
    function DelphiToken() {
        owner = msg.sender;
        administrator[msg.sender]=true;
        adminCount=1;
        MAX_TOTAL_TOKEN_AMOUNT = safeMul((10** uint(decimals)),1000000000);
    }

    function freezeAccount(address _account) onlyAdmin{
        frozen[_account] = true;
    }
    function unfreeze(address _account) onlyAdmin{
        frozen[_account] = false;
    }
    
        
    //total supply
    function totalSupply() constant returns (uint256 totalSupply){
        return totalSupply;
    }

    //function tokenFallback(address owner, uint amount, bytes data){    }

    //Balance of 
    function balanceOf(address owner) constant returns (uint256 _balance){
            //get the balance of the amount of tokens we have 
         return balance[owner];
    }
    function transfer(address _to, uint value, bytes data) returns (bool ok){
            uint codeLength;

            assembly {
                codeLength := extcodesize(_to)// Retrieve the size of the code on target address, this needs assembly .
            }

            if (_to == 0x0) throw;                             
            if (balance[msg.sender] < value) throw;           
            if (frozen[msg.sender]==true||frozen[_to] == true) throw;         //check if frozen
            balance[msg.sender] = safeSub(balance[msg.sender],value);                     
            balance[_to] = safeAdd(balance[_to],value);                          
            Transfer(msg.sender, _to, value, data);

            if(codeLength > 0){
                ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
                receiver.tokenFallback(msg.sender, value, data);
            }
            Transfer(msg.sender, _to, value, data);
            return true;

        }

    function transfer(address _to, uint value)returns(bool ok){//yl
    bytes memory empty;
    return transfer(_to,value,empty);
/*
        uint codeLength;
        assembly {
            codeLength := extcodesize(_to)// Retrieve the size of the code on target address, this needs assembly .
        }
        if (_to == 0x0) throw;                             
        if (balance[msg.sender] < value) throw;
        if (frozen[msg.sender]==true||frozen[_to] == true) throw;         //check if frozen
        balance[msg.sender] = safeSub(balance[msg.sender],value);                    
        balance[_to] = safeAdd(balance[_to],value);                          
        Transfer(msg.sender, _to, value);

        if(codeLength > 0){
            ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
            bytes memory empty;
            receiver.tokenFallback(msg.sender, value, empty);
        }
        Transfer(msg.sender, _to, value, empty);
        return true;*/
    }

    function approve(address _spender, uint256 _value) returns (bool status){
        if (msg.sender == _spender) throw;
        allow[msg.sender][_spender]=_value;
        Approval(msg.sender,_spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint remaining){
        return allow[_owner][_spender];
    }

    function transferFrom (address _from, address _to, uint256 _amount) returns (bool status){
        if (_from==_to || balance[_from]<_amount || _amount > allow[_from][msg.sender]) throw;
        allow[_from][msg.sender] = safeSub(allow[_from][msg.sender],_amount);
        balance[_to] = safeAdd(balance[_to],_amount);
        balance[_from] = safeSub(balance[_from],_amount);
        //Transfer(_from,_to,_amount);
        return true;
    }

    function mintToken (address addr, uint amount) onlyAdmin returns (bool success){
        if (safeAdd(totalSupply,amount) > MAX_TOTAL_TOKEN_AMOUNT) throw;
        balance[addr] = safeAdd(balance[addr],amount);
        return true;
    }

    function burnToken (uint amount) returns (bool success){
        safeSub(balance[msg.sender],amount);
        return true;
    }
    
    // This functionality is optional and can be extended to admins consensus for adding newadmin 
    // The basic idea being if the creator wants some-address to have exclusive rights to access some of the functionalities in the contract; 
    
    function addAdmin(address newadmin) isCreator returns(bool success){
        if(administrator[newadmin]==true) throw;
        administrator[newadmin]=true;
        adminCount++;
        return true;
    }
}

