pragma solidity ^0.4.13;

library SafeMathLib {
  function times(uint a, uint b) returns (uint) {
    uint c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function minus(uint a, uint b) returns (uint) {
    assert(b <= a);
    return a - b;
  }

  function plus(uint a, uint b) returns (uint) {
    uint c = a + b;
    assert(c>=a && c>=b);
    return c;
  }

  function assert(bool assertion) private {
    if (!assertion) throw;
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

//Start and End date needed for 3 or 4pm to buy some tokens and test the behavior for a crowdsale.
//We should create an event for every function call, Delphi Deployed event, Transfer event, Sucess event, Any interaction was logged

contract ComplexCrowdsale{

    using SafeMathLib for uint256;
    address owner;
    //enum StageName {PrePre, PreSale, Blackout, ICO, End}
    //StageName stage;
    uint8 stage; //PrePre, PreSale, Blackout, ICO, End
    uint256 totalTokens;
    uint256 totalTokMarket;
    ERC223 token;
    uint256[] blockTiming;
    /*
    uint256 public preBlock; //initialize a start time
    uint256 public blackoutBlock; //initialize an blackout time
    uint256 public icoBlock; //initialize an ico time
    uint256 public endBlock; //initialize an end time
    */
    uint256 public baseRate; //weicost per token
    uint256 public discount;
    uint256 public preTokenAmount;
    uint256 public totalTokenAmount;
    uint256 public holderCount;
    bool public initialized;
    mapping(address => uint256) balance;

    event TokensBought(address buyer, uint256 amt);
 ////constructor
    function ComplexCrowdsale(){
            
    }

/*
    function ComplexCrowdsale(
        address _tokenAddr, 
        uint256 _preBlock, 
        uint256 _blackoutBlock, 
        uint256 _icoBlock, 
        uint256 _endBlock, 
        uint256 _baseRate, 
        uint256 _presaleDiscount
        ) {
        initialize(_tokenAddr, _preBlock, _blackoutBlock, _icoBlock, _endBlock, _baseRate, _presaleDiscount);
    }
*/
    function initialize(address _tokenAddr, uint256 _preBlock, uint256 _blackoutBlock, uint256 _icoBlock, uint256 _endBlock, uint256 _baseRate, uint256 _presaleDiscount) {
        if (initialized) revert();
        initialized = true;  
        blockTiming = new uint256[](4);
        stage = 0;
        if (_preBlock>=_blackoutBlock || _blackoutBlock>=_icoBlock || _icoBlock >= _endBlock || discount>100) revert();
        owner = msg.sender;
        token=ERC223(_tokenAddr);
        /*preBlock = block.number + _preBlock;
        blackoutBlock = block.number + _blackoutBlock;
        icoBlock = block.number + _icoBlock;
        endBlock = block.number + _endBlock;*/
        blockTiming[0] = _preBlock;
        blockTiming[1] = _blackoutBlock;
        blockTiming[2] = _icoBlock;
        blockTiming[3] = _endBlock;
        baseRate = _baseRate;
        discount = _presaleDiscount;
        preTokenAmount = 10000;
        totalTokenAmount = 50000;
        holderCount = 0;
    }

    
    function () payable {
        buy();
    }

    function buy() payable {
        uint8 stage = getPeriod();
        uint tokensBought=msg.value/getPriceAtPeriod(stage);
        if (tokensBought<1) revert();
        if (balance[msg.sender]==0) holderCount++;
        if (stage == 1){
            preTokenAmount = preTokenAmount.minus(tokensBought);
        }
        else if (stage != 3){
            revert();
        }
        totalTokenAmount = totalTokenAmount.minus(tokensBought);
        balance[msg.sender] = balance[msg.sender].plus(tokensBought);
        token.transfer(msg.sender,tokensBought);
        TokensBought(msg.sender,tokensBought);
    }

    function tokensRemaining () constant returns (uint256 _totalTokenAmount){
        return totalTokenAmount;
    }

    function preTokensRemaining () constant returns (uint256 _preTokenAmount){
        return preTokenAmount;
    }

    function remainingTokensPeriod() constant returns (uint256 _remainingTokens){
        uint8 stage = getPeriod();
        if (stage == 1) {
            return preTokenAmount;
        }
        else if (stage == 3) {
            return totalTokenAmount;
        }
        return 0;
    }

    function setStage() {
        /*
        if (thisBlock > endBlock) stage = 4;
        else if (thisBlock > icoBlock) stage = 3;
        else if (thisBlock > blackoutBlock) stage = 2;
        else if (thisBlock > preBlock) stage = 1;
        else stage = 0;
        */
    }
/*
    function getPeriodAsString() returns (string _stage){
        uint8 = getPeriod();
        string[] names = ["PrePre","PreSale","Blackout","ICO","End"];
        return names[stage];
        if (stage == 5) return "End";
        else if (stage == 4) return "ICO";
        else if (stage == 3) return "Blackout";
        else if (stage == StageName.PreSale) return "PreSale";
        else return "PrePre";
        //return stage;
    }
*/
    function getPeriod() constant returns (uint8 _stage){
        uint256 thisBlock = block.number;
        for(uint8 i = 0; i<5; i++){
            if (thisBlock<blockTiming[i]){
                return i;
            }
        }
        return 5;
    }

    function blocksInPeriod() constant returns (uint256 numBlocks) {
        uint8 stage = getPeriod();
        if (stage<5) return blockTiming[stage]-block.number;
        return 0;
    }

    function balanceOf(address _address) constant returns (uint256 bal) {
        return balance[_address];
    }
    
    function getPrice() constant returns (uint price){
        uint8 stage = getPeriod();
        if (stage == 1) {
            return baseRate.times(100-discount)/100;
        }
        if (stage == 3) {
            return baseRate;
        }
        revert();
    }
    
    function getPriceAtPeriod(uint8 stage) constant returns (uint price){
        if (stage == 1) {
            return baseRate.times(100-discount)/100;
        }
        if (stage == 3) {
            return baseRate;
        }
        revert();
    }

    //kill the contract

    function kill() returns(bool status){
        if (msg.sender != owner) {return false;}
        if(token.transfer(owner,token.balanceOf(this))){
        }
        else {
            //token.burnToken(token.balanceOf(this));
        }
        selfdestruct(owner);
        return true;
    }
}
Contact GitHub 
