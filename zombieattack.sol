pragma solidity ^0.4.19;

import "./zombiehelper.sol";

contract ZombieBattle is ZombieHelper {
    uint randNonce = 0;
    uint attackVictoryProbability = 70;
    /// @notice Random number function to determine the outcome of our battles
    /// @param _modulus Defines the number of digits the random number will have
    /// @return the random number 
    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }

    /// @notice Function with attack logic
    /// @param _zombieId The zombie that is attacking
    /// @param _targetId The zombie that's been attacked
    function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
    }
}