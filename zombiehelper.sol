pragma solidity ^0.4.19;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;

    /// @notice Modifier uses the zombie level to restrict access to special abilities
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    /// @notice Function that enables users to level their zombie up by paying a fee
    /// @param _zombieId The zombie that will be leveled up
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

    /// @notice Function allows user to change the zombie's name above level 2
    /// @param _zombieId The zombie that will have the name changed
    /// @param _newName String with the new name
    function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    /// @notice Function allows user to change the zombie's DNA above level 20
    /// @param _zombieId The zombie that will have the DNA customized
    /// @param _newDna Uint with the new DNA
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    /// @notice Function returns a user's entire zombie army
    /// @param _owner Address of the zombie owner
    function getZombiesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}