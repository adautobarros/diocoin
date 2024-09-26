// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeDIO is ERC721{

    struct Pokemon{
        string name;
        uint attack;
        uint defense;
        uint level;
        string img;
        string[] powers;
    }

    Pokemon[] public pokemons;
    address public gameOwner;

    constructor () ERC721 ("PokekonDIO", "POKEDIO"){

        gameOwner = msg.sender;

    } 

    modifier onlyOwnerOf(uint _monsterId) {

        require(ownerOf(_monsterId) == msg.sender,"Voce nao e o dono do pokemon, utilize o seu pokemon para batalhar");
        _;

    }

    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon){
        Pokemon storage attacker = pokemons[_attackingPokemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

         if (attacker.attack >= defender.defense) {
            attacker.level += 2;
            defender.level += 1;
        }else{
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewPokemon(string memory _name, uint  _attack, uint _defense, address _to, string memory _img, string[] memory _powers) public {
        require(msg.sender == gameOwner, "Voce nao pode criar um novo Pokemon");
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, _attack, _defense, 1,_img, _powers));
        _safeMint(_to, id);
    }


}
