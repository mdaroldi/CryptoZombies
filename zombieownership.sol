pragma solidity ^0.4.19;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

    /// @notice Function return the number of zombies _owner has
    /// @param _owner The address of the owner
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerZombieCount[_owner];
    }

    /// @notice return the address of whoever owns the zombie with ID _tokenId
    /// @param _tokenId The ID of the zombie
    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return zombieToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) public {

    }

    function approve(address _to, uint256 _tokenId) public {

    }

    function takeOwnership(uint256 _tokenId) public {

    }
}