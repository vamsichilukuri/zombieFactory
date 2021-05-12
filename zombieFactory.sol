pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    // even to listen for new zombies to subscribe outside of the contract on web apps ( web3.js )
    event NewZombie(uint zombieId, string zombieName, uint zombieDna);
    // specifying zombie dna size
    uint dnaDigits = 16;
    modulus for to get 16 digits dna
    uint dnaModulus = 10**dnaDigits;
    // zombie model
    struct Zombie{
        uint dna;
        string name;
    }
    // zombies collection 
    Zombie[] public zombies;
    
    // create new zombie ( private )
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_dna,_name)) - 1; 
        emit NewZombie(id,_name,_dna);
    }
    
    // generate dna for zombie
    function _generateRandomDna(string memory _str) private view returns (uint _rdna) {
         uint rdna = uint(keccak256(abi.encodePacked(_str)));
         return rdna % dnaModulus;
    }
    
    // create new zombie take name from out side of the contract ( public )
    function createRandomZombie(string memory _name) public {
        uint rdna = _generateRandomDna(_name);
        _createZombie(_name, rdna);
    }
}
