pragma solidity ^0.4.8;

contract Safemath{
  
  function safeAdd(uint a, uint b) internal returns (uint) {
    uint c = a + b;
    assert(c >= a);
    return c;
  }
  function safeDiv(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

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


contract Simple_Crowdsale_DT is Safemath{

    address owner;
    uint256 totalTokens;
    uint256 totalTokMarket;
    uint256 singleTokenValueInWei;
    ERC223 tokenContract;
    uint256 public  saleStartDate;  //initialize a start time
    uint256 public  saleEndDate; //initialize an end time
    uint256 public  presalePeriod;
    uint256 public  baseratePreSale;
    uint256 public  baserateAfterPreSale;
    uint    public  blackoutPeriod;
// Events 
    event phaseType(string phase,uint amount);
    
 ////constructor

    function Simple_Crowdsale_DT(address _tokenContractAddr,uint saleEndDate,uint presalePeriod,uint blackoutPeriod,uint baseratePreSale,uint baserateAfterPreSale) {
        owner = msg.sender;
        saleStartDate= block.number;
        saleEndDate= safeAdd(block.number,saleEndDate);
        presalePeriod=safeAdd(block.number,presalePeriod);
        blackoutPeriod=safeAdd(safeAdd(block.number,blackoutPeriod),presalePeriod);
        tokenContract=ERC223(_tokenContractAddr);
        baseratePreSale=baseratePreSale;
        baserateAfterPreSale=baserateAfterPreSale;
    
    }

    // buy tokens from contract and send ether
    
    // didvide into three phases presale,blackout,afterpresale
    function buyMyToken() payable {
        uint amount =msg.value;
        uint totalTokensToBeSent=safeDiv(amount,baseratePreSale);
        uint totalTokensToBeSent1=safeDiv(amount,baserateAfterPreSale);
        
        if (block.number < saleStartDate) throw;
        if (block.number > saleEndDate) throw;
        
        if (block.number<=presalePeriod){
            tokenContract.transfer(msg.sender,totalTokensToBeSent);
            phaseType("presalePeriod",totalTokensToBeSent);
        }
        
        if (block.number>presalePeriod && block.number<=blackoutPeriod) throw;
            phaseType("blackoutPeriod",0);
        
        if (block.number>presalePeriod && block.number>blackoutPeriod){
            tokenContract.transfer(msg.sender,totalTokensToBeSent1);
            phaseType("afterPresalePeriod",totalTokensToBeSent1);
        }
        
    }

    
    


    //kill the contract

    function kill() returns(bool status){
        if (msg.sender != owner) {return false;}
            tokenContract.transfer(owner,tokenContract.balanceOf(this));
        selfdestruct(owner);
        return true;
    }
}
