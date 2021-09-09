// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";



contract TreeItems is ERC1155 {
    
    mapping(address => uint) public balances;
    address public owner;

    uint256 public constant Baby = 0;
    uint256 public constant Iron = 1;
    uint256 public constant Bronze = 2;
    uint256 public constant SILVER = 3;
    uint256 public constant GOLD = 4;
    uint256 public constant Platinum = 5;
    uint256 public constant Diamond = 6;
    uint256 public constant Draw_Ticket = 777;
    
    
        constructor() public ERC1155("https://raw.githubusercontent.com/JaeseungJung/Sol/main/toy/Tree-Item/{id}.json") {
        owner = msg.sender; 
        
        _mint(msg.sender, Baby, 10**14, "");
        _mint(msg.sender, Iron, 10**12, "");
        _mint(msg.sender, Bronze, 10**10, "");
        _mint(msg.sender, SILVER, 10**8, "");
        _mint(msg.sender, GOLD, 10**6, "");
        _mint(msg.sender, Platinum, 10**4, "");
        _mint(msg.sender, Diamond, 10**2, "");
        
        _mint(msg.sender, Draw_Ticket, 10**18, "");

}
    
    
        modifier onlyOwner () {
        require(msg.sender == owner);
        _;
}


     function donate() public payable {
        
        balances[msg.sender] += msg.value;
        
        uint amount_baby = msg.value/10**15;
        _safeTransferFrom(owner, msg.sender, 0, amount_baby, "");
     }
     
     
      function merge_cards(uint fromID) public  {
          uint toID = fromID + 1;
        
        _safeTransferFrom(msg.sender, owner, fromID, 10, "");
        _safeTransferFrom(owner, msg.sender, toID, 1, "");
     }


   function draw() public  {
         
        
        _safeTransferFrom(msg.sender, owner, 777, , "");
         RandomNumberConsumer(0x3310a91295391781b2639028a9008ac9Dfea3FAb).getRandomNumber();
       
     }
     

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
       
    }


    function donation_balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
}



      receive() external payable {}

}

