[2025] Como parte do treinamento de Criptografia Aplicada e Blockchain fornecido pela PUC-PR e CPQD, foi desenvolvido este contrato inteligente em um desafio prático do módulo de Princípios de Blockchain.

# Betting Smart Contract

Sistema de apostas descentralizado com commitment scheme implementado em Solidity.

## 📋 Descrição

O contrato implementa um sistema seguro de apostas onde:
- O dono do contrato pode fazer um commitment de um valor sorteado
- Apostadores fazem suas apostas sem conhecer o resultado
- O dono revela o valor sorteado, provando que foi determinado antes das apostas

## 🔧 Funcionalidades

- **Commitment**: Armazenamento seguro de hash do valor sorteado
- **Apostas**: Sistema de apostas múltiplas
- **Revelação**: Verificação automática do commitment
- **Controle de Acesso**: Apenas o dono pode fazer commitment e revelação

## 🚀 Deploy

### Rede Sepolia
- **Contract Address:** `0x26516401E1d5dEE2362c5AD697146E0156AB97dD`
- **Deployer:** `0x742992D09567CDC8784A06632e56Ebf3F2981a3F`

### Transações de Exemplo
- **Commitment:** [[Link Etherscan](https://sepolia.etherscan.io/tx/0x3203ea911b28b6d219b58cb5c96d1044ea3aaead6753286a122a30ac10ca4023)]
- **Bet:** [[Link Etherscan](https://sepolia.etherscan.io/tx/0x5f42ae12de4e9c7a90cf0c89d44f7d093bcb5fbc847df3d7a7b2dc5d10f427d9)]
- **Reveal:** [[Link Etherscan](https://sepolia.etherscan.io/tx/0x7fb88684bf8f47d732b1aeae1944ea015b06bc2a41f7cafbe9ed4a9311c2e837)]

## 💡 Como Usar

### 1. Fazer Commitment (Owner)
```solidity
// Calcular hash: keccak256(abi.encodePacked(valor, salt))
commitment("0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8")
```

### 2. Fazer Apostas (Qualquer usuário)
```solidity
bet(7)  // Aposta no valor 7
```

### 3. Revelar Resultado (Owner)
```solidity
revealCommitment(7, 12345)  // Revela valor=7 e salt=12345
```

## 🔍 Verificação

Para verificar o commitment:
1. Calcule: `keccak256(abi.encodePacked(valor_revelado, salt_revelado))`
2. Compare com o hash armazenado no commitment inicial

## 📊 Funções Principais

| Função | Descrição | Acesso |
|--------|-----------|--------|
| `commitment()` | Fazer commitment do valor | Owner |
| `bet()` | Fazer aposta | Público |
| `revealCommitment()` | Revelar valor e salt | Owner |
| `getResults()` | Ver resultados | Público |
| `getBets()` | Ver apostas por valor | Público |

## 🛠️ Tecnologias

- **Solidity** ^0.8.2
- **Remix IDE**
- **MetaMask**
- **Rede Ethereum Sepolia**

## 📝 Licença

GPL-3.0

## 👥 Desenvolvedor

Tiago Maciel - [[Linkedin](https://www.linkedin.com/in/tiagomaciels/)] - [[GitHub](https://github.com/tiagomaciels)]
