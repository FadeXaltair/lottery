// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Lottery {

    address payable[] public players;
    address public manager;
    uint256 favoriteNumber;

    constructor() {
        manager = msg.sender;
    }

// external person send eth and its address will be stored in the player array 
    receive() external payable {
        require(msg.value == 1 ether  || msg.sender == manager, "less amount");
        players.push(payable (msg.sender));
    }

    function store(uint256 _favoriteNumber) public returns(uint256) {
      return favoriteNumber = _favoriteNumber;
    }

    function getBalance() public view returns(uint) {
        require(msg.sender == manager, "you are not the manager");
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function getWinner() public {
        require(players.length >=10);
        uint r = random();
        uint index = r % players.length;
        address payable winner;
        winner = players[index];
        uint managerFee = (getBalance() * 10)/100;
        uint winnerPrize = (getBalance() * 90)/100;

        winner.transfer(winnerPrize);
        payable(manager).transfer(managerFee);

    }

}
