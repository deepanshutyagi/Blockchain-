pragma solidity ^0.4.8;

contract healthi{
    
    
    address public owner;
    
    
    
    event requestGenerated (address from,address to,uint timestamp);
    event accessGranted (address from, address to, uint timestamp);
    event registrationComplete(address,uint id);
    
   
    // Patient details on the chain
    struct Patients{
        address patient;
        uint256 publicKey;
        uint256 id;
      
        
    }
    
   uint  numPatient;
   Patients[] Patient;
    
    //healthcare provider details on the chain
    
    struct healthProviders{
        address healthProv;
        uint256 publicKey;
        uint256 id;
        
    }
    
    
   uint numHealthProviders;
   healthProviders[] healthProvider;
    
    //mapping for accesstime granted by certain address to certain address
    mapping (address=> mapping(address=>uint)) accessTime;
    mapping (address=> mapping(address=>bool)) requested;
    mapping (address=> mapping(address=>bool)) accessgranted;
    mapping (address => bool)  registered;
    
    // contructor
    function healthi() {
        owner=msg.sender;
        numPatient=0;
        numHealthProviders=0;
    }
    
    //Onlyonwner modifier
    modifier onlyOwner(){
        if (msg.sender!=owner){
            revert();
        }
        _;
    }
    
    // register new patient
    function registerPatient(uint256 publickey,address patient)  external  returns(uint patientId) {
        
       if (registered[patient]==false){
            patientId+=numPatient;
            Patient[patientId]=Patients(patient,publickey,patientId);
            registered[patient]==true;
            registrationComplete(patient,patientId);
            return(patientId);
       }
       
       else{
           revert();
       }
    
        
    }
    
    
    //Only owner allowed to register new health provider is restricted to only owner
    function registerHealthProvider(uint256 publickey,address healthProv) onlyOwner   external returns (uint healthProviderid){
       if (registered[healthProv]==false){ 
        
         healthProviderid+=numHealthProviders;
         healthProvider[healthProviderid]=healthProviders(healthProv,publickey,healthProviderid);
         registered[healthProv]==true;
         registrationComplete(healthProv,healthProviderid);
         return(healthProviderid);
            
       }
        
       else{
           revert();
       }
        
    }
    
    
    
    //Access request from health institute made for patient
    function  requestAccess(uint256 patientid,address patient,uint256 time) external returns(bool){
        if (registered[patient]==true && registered[msg.sender]==true ){
            if (requested[msg.sender][patient]=false){
                for (uint i=0;i<=(Patient.length);i++){
                    if(patientid==Patient[i].id){
                        accessTime[msg.sender][patient]=time;
                        requested[msg.sender][patient]=true;
                        requestGenerated(msg.sender,patient,now) ;
                        return (true);
                    }
                    
                }
                
            }
            
            
            
        }
        else{
            revert();
        }
        
    }
        
        
        
    //Grantaccess to healthprovider
    function grantAccess(address entity) external returns(bool) {
        if (registered[entity]==true && registered[msg.sender]==true ){
            if (requested[entity][msg.sender]==true){
                if(accessgranted[msg.sender][entity]==false){
                    if (accessTime[msg.sender][entity]==0){
                        uint timeGiven=accessTime[entity][msg.sender];
                        accessTime[msg.sender][entity]=timeGiven;
                    
                        accessgranted[msg.sender][entity]=true;
                        return(true);
               
                    }
                }
                
                
                
            
            
            
            }
        
        }
        else{
            revert();
        }
        
        
    }
    
    

    
    
    
    
    
}
