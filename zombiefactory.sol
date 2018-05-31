pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }
    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    /// @notice Creates the zombies and adds to the zombies array
    /// @param _name is the name of the zombie
    /// @oaram _dna a uint with the zombie's dna
    /// @dev the event NewZombie is fired here
    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna));
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }
    /// @notice Generates a random DNA number from a string
    /// @param _str the string that will be converted in dna
    /// @return a 16-digits long DNA, based on the string input
    function _generateRandomDna(string _str) private view returns(uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    /// @notice Public function that takes a name, and uses it to create a zombie with random DNA
    /// @param _name the name to be converted in random DNA
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}