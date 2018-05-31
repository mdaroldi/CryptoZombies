pragma solidity ^0.4.19;

import "./zombiefactory.sol";

/// @notice Contract/interface of zombies' favorite food!
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
        );
}

contract ZombieFeeding is ZombieFactory {

    KittyInterface kittyContract;

    /// @notice Set the Kitty contract address
    /// @param _address Kitty address
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }
    /// @notice Function combines the DNA's of the zombie and other forms of life to create a new zombie
    /// @param _zombieId DNA of the zombie
    /// @param _targetDna DNA of the victim
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - newDna % 100 + 99;
        }
            _createZombie("NoName", newDna);
    }

    /// @notice Function that gets the kitty genes from the contract and calls feedAndMultiply()
    /// @param _zombieId 
    /// @param _kittyId
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}