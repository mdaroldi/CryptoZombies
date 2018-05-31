pragma solidity ^0.4.19;

import "./zombiefactory.sol";


contract ZombieFeeding is ZombieFactory {

    /// @notice Function combines the DNA's of the zombie and other forms of life to create a new zombie
    /// @param _zombieId DNA of the zombie
    /// @param _targetDna DNA of the victim
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}