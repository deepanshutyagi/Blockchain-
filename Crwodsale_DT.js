DEPLOYED_SPECS = {
    "GenAddress": "0x45801305B7d516AfF0fF8420314e48De58F2C6cf",
    "SimpleBank": {
        "address": "0x92e152822e3b9bb0343b0d40f2f5d9bf0929524e",
        "abi": [
            {
                "constant": true,
                "inputs": [],
                "name": "holderCount",
                "outputs": [
                    {
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "getPeriod",
                "outputs": [
                    {
                        "name": "period",
                        "type": "string"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "buyMyToken",
                "outputs": [],
                "payable": true,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "kill",
                "outputs": [
                    {
                        "name": "status",
                        "type": "bool"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "holdercount",
                "outputs": [
                    {
                        "name": "count",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "_address",
                        "type": "address"
                    }
                ],
                "name": "balanceOf",
                "outputs": [],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "remainingTokensPeriod",
                "outputs": [
                    {
                        "name": "salephase",
                        "type": "string"
                    },
                    {
                        "name": "tokens",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [],
                "name": "blocksInPeriod",
                "outputs": [
                    {
                        "name": "blocks",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "_tokenAddr",
                        "type": "address"
                    },
                    {
                        "name": "_preBlock",
                        "type": "uint256"
                    },
                    {
                        "name": "_blackoutBlock",
                        "type": "uint256"
                    },
                    {
                        "name": "_icoBlock",
                        "type": "uint256"
                    },
                    {
                        "name": "_endBlock",
                        "type": "uint256"
                    },
                    {
                        "name": "_baseRate",
                        "type": "uint256"
                    },
                    {
                        "name": "_presaleDiscount",
                        "type": "uint256"
                    }
                ],
                "name": "initialization",
                "outputs": [],
                "payable": false,
                "type": "function"
            },
            {
                "inputs": [],
                "payable": false,
                "type": "constructor"
            },
            {
                "anonymous": false,
                "inputs": [
                    {
                        "indexed": false,
                        "name": "phase",
                        "type": "string"
                    },
                    {
                        "indexed": false,
                        "name": "amount",
                        "type": "uint256"
                    }
                ],
                "name": "phaseType",
                "type": "event"
            }
        ]
    }
};