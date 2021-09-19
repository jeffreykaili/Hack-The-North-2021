const Web3 = require('web3');
const contract = require('truffle-contract'); //idk if im gonna use this

const web3 = new Web3('http://127.0.0.1:7545') //create instance of Web3 & connect it to our local ganache blockchain



function routes(app) {
    app.get('/fetchcoin', (req,res)=>{ //find out how much coin a user has
        let address = req.query.address;
        web3.eth.getBalance(address).then(balance => {
            balanceInEth = balance / (10 ** 18); //converting from wei to eth
            res.send({balance: balanceInEth});
        }).catch(err => {
            console.log(err);
        });
    });

    app.get('/addcoin', (req,res)=>{ //add coin to a user's wallet
        let address = req.query.address;
        let amount = req.query.amount;
        //let privateKey = req.query.private_key;  DO WE NEED THIS??? IDK

        web3.eth.sendTransaction({
            from: "0xFC814D2034d1272D40bDe771Af4F9D6D43C34980", //master address
            to: address,
            value: web3.utils.toWei(amount, "ether"), 
        }, function(err, transactionHash) {
            if (err) { 
                console.log(err); 
            } else {
                console.log("transaction successful with hash: " + transactionHash);

                web3.eth.getBalance(address).then(balance => { //return user's new balance after removing 'amount'
                    balanceInEth = balance / (10 ** 18);
                    res.send({balance: balanceInEth});
                }).catch(err => {
                    console.log(err);
                });
            }
        });
    });

    app.get('/removecoin', (req,res)=>{ //remove coin from a user's wallet
        let address = req.query.address;
        let amount = req.query.amount;
        //let privateKey = req.query.private_key;  DO WE NEED THIS??? IDK

        web3.eth.sendTransaction({
            from: address,
            to: "0xFC814D2034d1272D40bDe771Af4F9D6D43C34980", //master address
            value: web3.utils.toWei(amount, "ether"), 
        }, function(err, transactionHash) {
            if (err) { 
                console.log(err); 
            } else {
                console.log("transaction successful with hash: " + transactionHash);

                web3.eth.getBalance(address).then(balance => { //return user's new balance after removing 'amount'
                    balanceInEth = balance / (10 ** 18);
                    res.send({balance: balanceInEth});
                }).catch(err => {
                    console.log(err);
                });
            }
        });
    });
}
module.exports = routes