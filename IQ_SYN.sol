///


pragma solidity ^0.4.14;
//to revise for testing
import "Market.sol";
import "SynToken.sol";

contract IQToken {
    
    
    event AnchorRequestReceived(address _address);
    event AnchorRequestStatus(string Status);
    event InsufficientIQ(uint256 needed, uint256 balance);
    event InsufficientSyn(uint256 needed, uint256 balance);
    event SynReceived(address _address, uint256 amount);
    event InvalidDeposit();
    event InvalidWithdrawal(uint256 requested, uint256 available);

    SynToken public synToken;
    SynapseMarket public market;
    uint  private iqRequired;
    address public owner;
    uint256 public synValue;
    
    
    mapping(address => uint256)      synDeposits;
    mapping(address => uint256)       iqBalances;
    mapping(string  =>  uint256)       iqRequired;
    mapping(address =>  uint256) lastFunctionCall;
    mapping(string  =>  bool)    approveAnchoring;
    
    struct Ranges{
        uint min;
        uint max;
        uint divisor;
      
        
    }
    
    Ranges[] ranges;
    
    
  
    
    // Initialize market and token contracts
    function IQToken(address token_address,
                     address market_address) {
        synToken =SynToken(token_address);
        market =SynapseMarket(market_address);
        owner =msg.sender;
       
        
    }

    
    modifier onlyOwner(){
        if (msg.sender!=owner) throw;
    }
    
    
    //check IQ required for anchoring data
    // Parameter transactionid is gasprice for oracalization
    //This function multiplie syntokenbalance of msg.sender with value of syn at exchange than subtracts gasprice of oracalization and divides it by divisor accoridng to the range set by owner
    //
    
    // Recieve request from provider,approve/deny based on oracalizatrion gas cost and Datahash
    // Can be replaced by a struct called user that holds all the details like Datahash,transactionid but there might be scalability Problems
    //For now I am just using mapppings
    //Transaction
    function requestAnchor(string DataHash,uint256 Transactionid)
                          external
                          constant
                          returns (bool) {
        AnchorRequestReceived(msg.sender);
        setIQrequired(DataHash,Transactionid);
        
        
        //Check that Data Hash is valid
        
             // Check iq balance
            if (iqBalances[msg.sender]<iqRequired[DataHash]){
                return false;
                AnchorRequestStatus("Failed"); 
                InsufficientIQ(safeSub(iqRequired[DataHash],iqBalances[msg.sender]),iqBalances[msg.sender]);
                throw;
            }
            
            else{
                //Decrementing the IQ here
                //Transactionid returns the oracalization gas cost with 
                //expecting it returns  value say in wei
                //Right now IQ balance becomes z
                iqBalances[msg.sender]=safeSub(iqBalances[msg.sender],iqRequired[dataHash]);
                
                
                return true;
                AnchorRequestStatus("Success");
                
            }
            
        
       
        
        
    }

    //calc if enough iq available
    //TODO iq incrementation += generation, iq decrementation -= iq cost
    function GenerateIQ()
                      internal
                      constant
                      returns(bool,uint iqgenerated){
        uint256 bondedSyn =synDeposits[msg.sender];
        if ((now - lastFunctionCall[msg.sender]) <= 10 minutes) throw;
        
        if (synDeposits[msg.sender]>=ranges[0].min){
          iqBalances[msg.sender]+=bondedSyn/2;
          lastFunctionCall[msg.sender]=now; 
          
            
            
            
            
        }
        
        
            
        

        return true;
    }

    //recieve deposit from provider address
    function deposit(uint256 value)
                     external
                     returns (bool) {
        // Approve market to transfer
        synToken.approve(this, amount);

        // Attempt transfer
        if ( !synToken.transferFrom(msg.sender, this, value) ) {
            InvalidDeposit();
            return false;
        }

        // Add to deposit
        synDeposits[msg.sender] += value;

        return true;
    }

    // Withdraw syn
    function withdraw(uint256 value)
                      external
                      returns(bool) {
        // Check available deposit
        if ( value > synDeposits[msg.sender] ) {
            InvalidWithdrawal(value,synDeposits[msg.sender]);
            return false;
        }

        // Approve market to transfer
        syn.approve(this, amount);

        // Withdraw
        synToken.transferFrom(this, msg.sender, value);

        return true;
    }
    
    //Check IQ Balance
    function iqBalance() returns(uint Balance){
        return(iqBalances[msg.sender]);
    }
    
    //Set syntoken value for  single token so its faster than calling some exchange API
    //Input the value in wei
    
    function setSynvalue(uint value) onlyOwner returns(uint){
        synValue=value;
        return(synValue);
        
    }
    
    //Owner defines range and divisor which will decide the amount of Iq required for Anchoring data
    //Here rng is range name which will be an integer,we can log these ranges based on this range index
    //Divisor is the number that the providers Syntoken balance will be divided by when he requests for anchoring event
    
    function defineRange(uint rng,uint min, uint max,uint divisor) onlyOwner returns(bool){
           
           ranges[rng]=Ranges(min,max,divisor);
           return(true);
        
    }
    
    
    // Get  getrange that your Syntoken Balance falls in
    function getRange(uint value) private returns(uint){
        for(uint i=0;i<=(ranges.length);i++){
            if(value>=ranges[i].min && value<=ranges[i].max){
                return(i);
            }
            else{
                throw;
            }
        
        }
        
        
    }
    
    
    //check IQ required for anchoring data
    // Parameter transactionid is gasprice for oracalization
    //This function multiplie syntokenbalance of msg.sender with value of syn at exchange than subtracts gasprice of oracalization and divides it by divisor accoridng to the range set by owner
    //
    function setIQrequired(string Datahash,uint transactionId) returns(uint) {
            
            for(uint i=0;i<=(ranges.length);i++){
                if(synToken.BalanceOf[msg.sender]>=ranges[i].min && synToken.BalanceOf[msg.sender]<=ranges[i].max){
                    iqRequired[Datahash]=safeDivide(safeSub(safeMul(synToken.BalanceOf[msg.sender],synValue),transactionId),ranges[i].divisor);
                    return(iqRequired[Datahash]);
                    
                
                }
                else{
                    throw;
                }
            }
            
        
        
        
        
    }
    
    
    
    
    
}
