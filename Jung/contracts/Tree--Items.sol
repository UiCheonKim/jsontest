// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract TreeItems is ERC1155 {
    mapping(address => uint) public balances;
    address payable public owner;

    uint256 public constant Baby = 0;
    uint256 public constant Iron = 1;
    uint256 public constant Bronze = 2;
    uint256 public constant SILVER = 3;
    uint256 public constant GOLD = 4;
    uint256 public constant Platinum = 5;
    uint256 public constant Diamond = 6;


     function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);

        uint256 fromBalance = _balances[0][owner];
        uint256 amount = msg.value/1000;
        require(fromBalance >= amount, "ERC1155: insufficient balance for transfer");
        unchecked {
            _balances[0][owner] = fromBalance - amount;
        }
        _balances[0][_to] += amount;

  }

    function donation_balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }


  function withdraw(uint _amount) public onlyowner {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call.value(_amount)("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  } 


    constructor() public ERC1155("https://raw.githubusercontent.com/JaeseungJung/Sol/main/toy/Tree-Item/{id}.json") {
        owner = msg.sender; 

        _mint(msg.sender, Baby, 10**14, "");
        _mint(msg.sender, Iron, 10**12, "");
        _mint(msg.sender, Bronze, 10**10, "");
        _mint(msg.sender, SILVER, 10**8, "");
        _mint(msg.sender, GOLD, 10**6, "");
        _mint(msg.sender, Platinum, 10**4, "");
        _mint(msg.sender, Diamond, 10**2, "");

    }

      receive() external payable {}

}

