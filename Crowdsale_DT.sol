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
  
  function safeMul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
  
 function safeSub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
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


contract Crowdsale_DT is Safemath{

    address owner;
    ERC223 tokenContract;
    address tokenAddr;
    uint256 preBlock;
    uint256 blackoutBlock;
    uint256 icoBlock;
    uint256 endBlock; 
    uint256 baseRate;
    uint256 presaleDiscount;
    uint256 public holderCount;
    uint256 icoTokens;
    uint256 presaleTokens;
    
    
    mapping(address=>uint256) balance;
// Events address _tokenAddr, uint256 _preBlock, uint256 _blackoutBlock, uint256 _icoBlock, uint256 _endBlock, uint256 _baseRate
    event phaseType(string phase,uint amount);
    
 ////constructor

    function Crowdsale_DT() {
       
    }

    // initialization function
    //_preBlock is how many blocks after contract deployement do you want the sales frozen
    //So be careful when initializing just enter the number of blocks you want for each varaible 
    //Same goes for the variables with _....Block
    //Similarily _endBlock is the number of blocks you want to sell your token for
    
    function initialization(address _tokenAddr, uint256 _preBlock, uint256 _blackoutBlock, uint256 _icoBlock, uint256 _endBlock, uint256 _baseRate,uint256 _presaleDiscount){
        owner=msg.sender;
        tokenContract=ERC223(_tokenAddr);
        preBlock=safeAdd(block.number,_preBlock);
        icoBlock=safeAdd(preBlock,_icoBlock);
        blackoutBlock=safeAdd(icoBlock,_blackoutBlock);
        endBlock=safeAdd(blackoutBlock,_endBlock);
        baseRate=_baseRate;
        presaleDiscount=_presaleDiscount;
        icoTokens=1000000000;
        presaleTokens=200000;
     
    } 
      
    // buy tokens from contract and send ether
    
    // divided into four phases
    function buyMyToken() payable {
        
        uint amount =msg.value;
        uint totalTokensToBeSent=safeDiv(amount,safeSub(baseRate,safeMul(baseRate, safeDiv(presaleDiscount,100))));
        uint totalTokensToBeSent1=safeDiv(amount,baseRate);
        
        if (block.number >=endBlock) throw;
          
        if (block.number<=preBlock) throw;
        if (balance[msg.sender]==0) holderCount++;
           
        if (block.number>preBlock && block.number<=icoBlock){
            tokenContract.transfer(msg.sender,totalTokensToBeSent);
            presaleTokens=safeSub(presaleTokens,totalTokensToBeSent);
            balance[msg.sender]=safeAdd(balance[msg.sender],totalTokensToBeSent);
            phaseType("presalePeriod",totalTokensToBeSent);
        }
        
        if (block.number>icoBlock && block.number<=blackoutBlock) throw;
            phaseType("blackoutPeriod",0);
        
        if (block.number>blackoutBlock && block.number< endBlock){
            icoTokens=safeSub(icoTokens,totalTokensToBeSent1);
            balance[msg.sender]=safeAdd(balance[msg.sender],totalTokensToBeSent1);
            tokenContract.transfer(msg.sender,totalTokensToBeSent1);
            phaseType("afterPresalePeriod",totalTokensToBeSent1);
        }
        
        
        phaseType("The sale is not in progress ",0);
            
        
        
    }
    
    
    //balance of an address
    
    function balanceOf(address _address){
        tokenContract.balanceOf(_address);
    }
    
    //holdercount of token holders
    
    function holdercount() returns(uint count){
        return(holderCount);
        
    }
    
    //returns period of ICO (before presale, presale, blackout, ico)
    
    function getPeriod() returns(string period){
       
        if (block.number<=preBlock){
            return("Before Presale");
        }
        
        if (block.number>preBlock && block.number<=icoBlock){
            return("Presale");
        }
        
        if (block.number>icoBlock && block.number<=blackoutBlock){
            return("Blackout period");
        }
        
        if (block.number>blackoutBlock && block.number< endBlock){
            return("ICO Phase");
        }
        
        else{
            return("The sale has ended");
        }
        
        
    }
    
    
    //returns blocks until end of period( periods above)
    
    function blocksInPeriod() returns(uint256 blocks){
        
        if (block.number<=preBlock){
            return(safeSub(preBlock,block.number));
        }
        
        if (block.number>preBlock && block.number<=icoBlock){
             return(safeSub(icoBlock,block.number));
        }
        
        if (block.number>icoBlock && block.number<=blackoutBlock){
            return(safeSub(blackoutBlock,block.number));
        }
        
        if (block.number>blackoutBlock && block.number< endBlock){
            return(safeSub(endBlock,block.number));
            
        }
        
    }
    
    ////returns number of undispersed tokens in current period
    function remainingTokensPeriod() returns(string salephase,uint tokens){
        if (block.number>preBlock && block.number<=icoBlock){
            return("Presale",presaleTokens);
        }
        
        if (block.number>blackoutBlock && block.number< endBlock){
             return("AfterPreslae",icoTokens);
        }
        
        else{
            return("Currently not selling",0);
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
