// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CPQD {

    address public owner; // Endereço do dono do contrato
    bytes32 private commitmentHash; // Hash do commitment (valor sorteado + salt)
    uint public revealedSalt; // Salt revelado
    bool public isRevealed; // Indica se o commitment foi revelado
    uint public revealedValue; // Valor sorteado revelado

    mapping (uint => address []) public bets;

    // Eventos para logging
    event CommitmentRevealed(uint value, uint salt);
    event CommitmentMade(bytes32 hash);
    event BetPlaced(address bettor, uint value);

    // Mapeamento de apostas: valor apostado => array de endereços
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this function.");
        _;
    }

    // Modificador para verificar se commitment ainda não foi revelado
    modifier notRevealed() {
        require(!isRevealed, "Commitment has already been revealed.");
        _;
    }

    // Constructor - define o dono como quem fez o deploy
    constructor() {
        owner = msg.sender;
        isRevealed = false;
    }

    // Função para fazer o commitment (apenas o dono)
    function commitment(bytes32 h) public onlyOwner notRevealed {
        require(h != bytes32(0), "Hash cannot be empty.");
        commitmentHash = h;
        emit CommitmentMade(h);
    }

    // Função para apostadores fazerem suas apostas 
    function bet(uint b) public notRevealed {
        require(commitmentHash != bytes32(0), "Commitment must be made before bets.");
        bets[b].push(msg.sender);
        emit BetPlaced(msg.sender, b);
    }

    // Função para revelar o commitment (apenas o dono)
    // value = Valor sorteado original | salt = Salt usado no commitment
    function revealCommitment(uint value, uint salt) public onlyOwner {
        require(commitmentHash != bytes32(0), "No commitment was made.");
        require(!isRevealed, "Commitment has already been revealed.");
        
        bytes32 calculatedHash = keccak256(abi.encodePacked(value, salt));
        require(calculatedHash == commitmentHash, "Hash doesn't match the commitment.");

        revealedValue = value;
        revealedSalt = salt;
        isRevealed = true;

        emit CommitmentRevealed(value, salt);
    }
    
    // Função para obter resultados das apostas
    function getBets(uint value) public view returns (address[] memory) {
        return bets[value];
    }

    // Função para obter vencedores (apenas após revelação)
    function getResults() public view returns (address[] memory) {
        require(isRevealed, "Commitment has not been revealed yet.");
        return bets[revealedValue];
    }

    // Função para verificar se um endereço é vencedor
    function isWinner(address bettor) public view returns (bool) {
        require(isRevealed, "Commitment has not been revealed yet.");
        
        address[] memory winners = bets[revealedValue];
        for (uint i = 0; i < winners.length; i++) {
            if (winners[i] == bettor) {
                return true;
            }
        }
        return false;
    }

    // Função para verificar o status do contrato
    function getStatus() public view returns (bool commitmentMade, bool revealed, uint value) {
        return (commitmentHash != bytes32(0), isRevealed, revealedValue);
    }
}