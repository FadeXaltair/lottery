const { ethers } = require("hardhat");

async function main() {
  const LotteryFactory = await ethers.getContractFactory("Lottery");
console.log("deploying contract ...");

const simpleLottery = await LotteryFactory.deploy();
 await simpleLottery.deployed();

console.log(`deployed contract at ${simpleLottery.address}`);

const totalEth = await simpleLottery.getBalance();
console.log(`Your total balance is ${totalEth}`);


const random = await simpleLottery.random();
console.log(`random number is ${random}`);

const setNumber = await simpleLottery.store(7);
await setNumber.wait(1);

console.log(`your number is ${setNumber}`);
}


main().then(()=> process.exit(0)).catch((error)=>{
  console.log(error);
  process.exit(1);
});