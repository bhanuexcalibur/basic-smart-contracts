// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Lottery {
    uint startTime;
    uint endtime;
    address payable public owner;
    address[] ticketholder;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function startLottery(uint lotteryPeriod) external onlyOwner {
        startTime = block.timestamp;
        endtime = block.timestamp + lotteryPeriod;
    }

    function alreadyEntered() public view returns (bool) {
        for (uint8 i; i < ticketholder.length; i++) {
            if (ticketholder[i] == msg.sender) return true;
        }
        return false;
    }

    function buyTicket() public payable {
        require(block.timestamp < endtime, "Time completed");
        require(alreadyEntered(), "already exist");
        require(msg.value == 1 ether, "Wrong value");
        ticketholder.push(msg.sender);
    }

    function endLottery() external payable onlyOwner returns (bool) {
        require(block.timestamp > endtime, "Time completed");
        uint indexOfWinner = uint(
            keccak256(
                abi.encodePacked(block.timestamp, block.difficulty, msg.sender)
            )
        ) % ticketholder.length;
        address Winner = ticketholder[indexOfWinner];
        (bool success, ) = Winner.call{value: address(this).balance}("");
        return success;
    }

    receive() external payable {}

    fallback() external payable {}

    function ContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() external onlyOwner {
        // uint _amount = address(this).balance;
        selfdestruct(payable(msg.sender));
    }
}
