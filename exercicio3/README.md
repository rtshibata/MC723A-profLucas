 Exercício 3: MC723  
=====
##  Professor: *Lucas Wanner* 
##  Aluno: *Renato Toshiaki Shibata*
##  RA: *082674* 

### 1)Introdução

Primeiramente, teve que ser instalado o `mips-1.0.2` e toda a infra-estrutura de simulação. Para isso, usou-se ferramentas compiladas na conta do Professor Lucas Wanner, executando as seguintes instruções no terminal shell:
>export LD_LIBRARY_PATH=/home/staff/lucas/mc723/hw_tools/systemc-2.3.1/lib-linux64/:$LD_LIBRARY_PATH

>export PATH=$PATH:/home/staff/lucas/mc723/hw_tools/ArchC-2.2.0/installed/bin:/home/staff/lucas/mc723/hw_tools/mips-newlib-elf/bin/

Então para instalar, compilar e executar o simulador do MIPS, usou-se as seguintes instruções no terminal shell, encontrando-se no diretório onde irá instalá-lo:
>wget https://github.com/ArchC/mips/archive/v1.0.

>2.tar.gz    

>tar xzf v1.0.2.tar.gz   

>cd mips-1.0.2/  

>acsim mips.ac -abi  

>make -f Makefile.archc  

Com isso, foi-se gerado o simulador `mips.x`.

Para o caso de se usar um programa simples escrito na linguagem de programção C (exemplo: `hello.c`) como entrada, onde apenas se imprime na tela a string *Hello world* foi necessário usar um compilador(no caso, do tipo *cross-compiler*) para transformar o código em C do arquivo fonte para gerar binários para a arquitetura MIPS. Dessa forma é gerada o executável `hello.mips`.
>mips-newlib-elf-gcc -specs=archc hello.c -o hello.mips  

Logo após, foi invocado o simulador `mips.x` e ver o programa em binário `hello.mips`ser executado:
>./mips.x --load=hello.mips

Para visualizar com mais informações detalhadas sobre o código do programa converetido em assembly MIPS, pode-se usar o ***objdump***:
>mips-newlib-elf-objdump -d hello.mips > hello_objdump.txt

A saída foi escrita em `hello_objdump.txt`, que está dentro da pasta `mips-1.0.2` na hierarquia de diretório dos GitHub.

**Obs.**: Toda essa configuração e testes foram feitos através de um **SSH** para o computador da rede de laboratórios do IC.

-------------------------------------

### 2)Contando instruções

Para contar quantas vezes a instrução `add` acontece durante a execução do `hello.mips` foi editado o arquivo `mips_isa.cpp`. Foi incluído um contador global chamado ***cont_add*** além de um ***cont_addu*** para a instrução `addu`, apenas por motivos de comparação de ocorrências entre estas 2 instruções similares. 

`addu`, ao contrário de `add`, trabalha com números *unsigned* ao invés de com sinal. Assim ele não sinaliza *overflow*.

Desse modo, fora do escopo de todas as funções definidas nesse arquivo, foi adicionado as seguintes linhas para inicializar os contadores: 
```c
int cont_add=0;
int cont_addu=0;
```    
Dentro da função ***ac_behavior(begin)***, os contadores são zerados, pois é o início da execução do simulador:  
```c
cont_add = 0;
cont_addu = 0;
```

Dentro da função ***ac_behavior(end)***, imprimimos na tela os valores dos contadores, após ter terminado a execução do programa entrada pelo simulador:
```c
printf("O número de instruções add é: %d\n", cont_add);
printf("O número de instruções addu é: %d\n", cont_addu);
```
Dentro da função ***ac_behavior( add )***, o contador se auto-incrementa a cada vez que `add` é encontrado:
```c
cont_add++;
```
O mesmo é feito dentro da função ***ac_behavior( addu )***:
```c
cont_addu++;
```
Ao se recompilar 
(como mostrado anteriormente) o simulador e executar o programa `hello.mips` após essas modificações nós temos como saída aquilo que se encontra no arquivo `hello_out.txt`, que se encontra no repositório.

Observamos que não foi contado a instrução `add`nenhuma vez enquanto que a instrução `addu` foi contada 175 vezes. Isso era de se esperar, pois o MIPS prefere trabalhar com valores *unsigned* para processar linhas de código que não possuem natureza aritmética. 
***???????NAO SEI   AJUDA A????????????????????***

### 3)Avaliando o desempenho

O meu RA é 082674. Desse modo, de acordo com a tabela na página do Exercício 3 do Prof. Lucas Wanner,  devo executar os seguintes programas:
*   jpeg decoder (small)
*   fft (small)
*   gsm coder (large)

Esses programas foram obtidos dentro do diretório `MipsMibech` na pasta do Professor Lucas, o qual reúne vários programas.Ou seja, inseri as pastas `FFT`, `gsm`e `jpeg` dentro do meu diretório `mips-1.0.2`.

Então acionei a flag **-s** para o **acsim** para gerar as estastísticas da simulação de cada um dos destes programas.Ou seja, tive que executar no  terminal shell:
>acsim mips.ac -abi -s  

>make -f Makefile.archc

Logo após, para cada um dos 3 programas, procurei em seus respectivos diretórios um shell script cujo nome eram `runme_small.sh`(para os programas `jpeg` e `fft`) e `runme_large.sh`(para o programa `gsm`). Nesses shell scripts haviam o parâmetro de entrada para **-load** do simulador `mips.x`. Ou seja para o programa `jpeg` foi executado no terminal shell:  

>./mips.x --load=jpeg/jpeg-6a/djpeg -dct int -ppm -outfile jpeg/output_small_decode.ppm jpeg/input_small.jpg

Para o programa `fft`:
>./mips.x --load=FFT/fft 4 4096 > FFT/output_small.txt

Para o programa `gsm`:
>./mips.x --load=gsm/bin/toast -fps -c gsm/data/large.au > gsm/output_large.encode.gsm

As saídas após execução de cada um desses comandos estão nos seguintes arquivos, respectivamente:`jpeg1.txt`,`fft2.txt`e `gsm3.txt`.

### 4) Calculando número de ciclos 
Para calcular o número de ciclos, foi necessário identificar a qual classe de instrução se enquadra cada uma das instruções do MIPS. 

Para a classe **Acesso à memória**, que gastam 10 ciclos em média, as instruções do MIPS que se enquadram são:
*   lb
*   lui
*   lw
*   sb
*   sw

Para a classe **Controle**, que gastam 3 ciclos em média, temos:
*   beq
*   bgez
*   bgezal
*   bgtz
*   blez
*   bltz
*   bltzal
*   bne
*   j
*   jal
*   jr

Para a classe **Outros**, que gastam apenas 1 ciclo em média, são o resto das instruções que não se enquadraram nas classes anteriores.

Desse modo a fórmula matemática para calcular **n**, o número totais de ciclos gasto para um certo programa executando nesse simulador de MIPS é:  
  
$$n = 10 \sum n_{A}+ 3 \sum n_{B}+ \sum n_{C}$$ 

onde $$n_{A}$$ é o número de ciclos de uma instrução da classe **Acesso à memória**;   
$$n_{B}$$ é o número de ciclos de uma instrução da classe **Controle** e $$n_{C}$$ é o número de ciclos de uma instrução da classe **Outros** usados num programa
 






