#  Exercício 2: MC723 
### Professor: Lucas Wanner
### Aluno: Renato Toshiaki Shibata -- RA:082674

Optei por simular 4 programas com apenas um nível de cache (L1 de instruções e L1 de dados). Os programas escolhidos foram gzip_f2b e vortex_f2b.
Devido ao tempo gasto para o entendimento do enunciado, apenas pude executar para esses 2 programas.

Ao rodar o script `ex2.sh`, que executa para 10 diferentes tamanhos de bloco de cache L1, sendo esses tamanhos valores de potência na base 2, ou seja, de 2Bytes até 1024 Bytes ou 1KiloBytes. 

Neste diretório se encontra os resultados da execução para cada uma das potências.

Basicamente os parametros escolhidos foram:
>../../dinero4sbc/dineroIV -informat s -trname ${name}-maxtrace 20 -l1-isize ${i_} -l1-dsize ${d_} -l1-ibsize ${ib_} -l1-dbsize ${db_} > ${out_}

onde os parametros foram definidos inicialmente como:
>traces="/home/staff/lucas/mc723/traces/255.vortex.f2b"

>p1="255.vortex.f2b"

>home_ex2="/home/ec2010/ra082674/MC723-LucasWanner/exercicio2/output.txt"

>name="vortex_f2b"

>i_="16K"

>d_="16K"

>ib=2

>db=2

Então esse comando foi rodado várias vezes, alterando-se os valores do parametro `ib_`e `db_` para potencias de 2, por exemplo, 4,8,16,32,etc. 

Esse mesmo procedimento foi realizado para vortex.


Infelizmente não houve tempo para análise dos dados para verificar a melhor configuração, combinação de tamanhos de cache.
