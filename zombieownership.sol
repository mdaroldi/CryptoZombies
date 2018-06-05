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

    /// @notice Function that will be used with transfer() and takeOwnership(), which have the same logic but in reverse order
    /// @param _from The owner of the credits
    /// @param _to Who will receive the credits
    /// @param _tokenId The ID of the zombie
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombieCount[_to]++;
        ownerZombieCount[_from]--;
        zombieToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }
    /// @notice Function with the transfer logic
    /// @param _to Who will receive the credits
    /// @param _tokenId The ID of the zombie
    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    /// @notice Function for approval of the transfer
    /// @param _to Who will receive the credits
    /// @param _tokenId The ID of the zombie
    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        zombieApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    /// @notice Function for checking if the msg.sender has been approved to take the token
    /// @param _tokenId The ID of the zombie
    function takeOwnership(uint256 _tokenId) public {
        require(msg.sender == zombieApprovals[_tokenId]);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}