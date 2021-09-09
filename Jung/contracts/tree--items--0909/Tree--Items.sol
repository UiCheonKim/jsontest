// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./vrf.sol";



 contract TreeItems is ERC1155, RandomNumberConsumer{
    
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
/*        constructor() 
        VRFConsumerBase(
            0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
            0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
        ) 
    {
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 0.8 * 10 ** 18; // 0.1 LINK (Varies by network)
    }
    
        modifier onlyOwner () {
        require(msg.sender == owner);
        _;
}
*/

     function donate() public payable {
        
        balances[msg.sender] += msg.value;
        
        // uint amount_baby = msg.value/10**18;
        uint amount_baby = 1;
        _safeTransferFrom(owner, msg.sender, 0, amount_baby, "");
     }


//     function withdraw() public onlyOwner {
//         payable(owner).transfer(address(this).balance);
//     }


//     function donation_balanceOf(address _who) public view returns (uint balance) {
//     return balances[_who];
// }

//       receive() external payable {}
      
//           /** 
//      * Requests randomness 
//      */
//     function getRandomNumber() public returns (bytes32 requestId) {
//         require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
//         return requestRandomness(keyHash, fee);
//     }

//     /**
//      * Callback function used by VRF Coordinator
//      */
//     function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
//         randomResult = (randomness % 50) + 1;
//     }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract

}