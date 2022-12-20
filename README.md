# AssemblyGame
Um jogo desenvolvido em linguagem Assembly para a matéria de Organização e Arquitetura de Computadores. 

## Como rodar
1. Clone esse repositório no seu computador
   ```bash
   git clone https://github.com/MichelH4cker/AssemblyGame.git
   ```
2. Entre na pasta ```src/``` e monte o arquivo ```.mif``` utilizando o ```montador```
    ```bash
    ./montador asteroid-attack.asm asteroid-attack.mif``` 
3. Para executar, basta utilizar o simulador
   ```bash
   ./sim asteroid-attack.mif charmap.mif
   ```

## Requisitos 
* arquivo ```montador``` ;
* arquivo ```simulador```;

> Ambos os arquivos podem ser encontrados no [repositório do professor Simões.](https://github.com/simoesusp/Processador-ICMC.git) 


## Como jogar
Utiliza as teclas WASD para movimentar a nave e desviar dos asteroides. Clique espaço para atira e ganhar pontos acertandos ao acertar os projéteis. Divirta-se!
