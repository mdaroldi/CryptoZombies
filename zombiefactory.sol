pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        uint dna;
        string name;
    }
    Zombie[] public zombies;

    /// @notice Creates the zombies and adds to the zombies array
    function _createZombie(string _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }
    /// @notice Generates a random DNA number from a string
    /// @param _str the string that will be converted in dna
    /// @return a 16-digits long DNA, based on the string input
    function _generateRandomDna(string _str) private view returns(uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
}