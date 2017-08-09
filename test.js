#!/usr/bin/env node

const fs = require('fs');
const solc = require('solc');
const Web3 = require('web3');
const Tx = require('ethereumjs-tx');
const Wallet = require('ethereumjs-wallet');

const RPC_HOST = "https://rinkeby.infura.io/";

const web3 = new Web3(new Web3.providers.HttpProvider(RPC_HOST));

const GEN_PASSPHASE = "synapse";

var GEN_ADDRESS = "0x12297931936063C501F46AeD9175763a9E0cdd02";
var key = "f932912da489f72d6a953f2a9989dcb6ec6b2c47959433c013fcb1c63b04096c";
var GEN_PRIVATE_KEY = new Buffer(key, 'hex');

function compileContracts() {
    // Compile the source code
    var input = {sources: {
        'DelphiToken.sol': fs.readFileSync('DelphiToken.sol').toString(),
    }};

    //console.log(input.toString());
    const output = solc.compile(input, 1);
    console.log(output)

    var result = {};

    for (var k in  output.contracts) {
        const contractKey = k.split(':').pop();
        const bytecode = output.contracts[k].bytecode;
        const abi = JSON.parse(output.contracts[k].interface);
        result[contractKey] = {
            bytecode: bytecode,
            abi: abi
        }
    }

    return result;
}

//console.log(web3.eth.accounts[0]);
function setContract(abi,address) {
    let MyContract = web3.eth.contract(abi);
    // instantiate by address
    return MyContract.at(address);
}

compiledContracts = compileContracts();

let token = setContract(compiledContracts['DelphiToken'].abi,"0xb0092e1580326749f1f2ed66cf923f082548cb80");
//token.mintToken("0x0a0f88dc4d2f9c534e5f08999cfde517611e44af", 10000,{from:GEN_ADDRESS});
//let owner = "0x0a0f88dc4d2f9c534e5f08999cfde517611e44af";
//let data = token.balanceOf.call(owner);
//console.log("the owner of token is "+data);
token.addAdmin("0xec607c1d5241bebaea2c69fa68b596d8ffde186a",{from:GEN_ADDRESS});
console.log("add new admin");
//token.mintToken(owner, 1000000,{from:owner});
//let data = token.balanceOf.call(owner);
//console.log("the balance of my account is "+data);
//token.transfer(web3.eth.accounts[3], 1000,{from:web3.eth.accounts[2]})
//let data1 = token.balanceOf.call(web3.eth.accounts[2]);
//console.log("the balance of my account is "+data1);