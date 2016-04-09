#  Exercício 2: MC723 
### Professor: Lucas Wanner
### Aluno: Renato Toshiaki Shibata -- RA:082674

#1)Introdução
Optei por simular 4 programas com apenas um nível de cache (L1 de instruções e L1 de dados). Os programas escolhidos foram `gzip_f2b`,`vortex_f2b`,`parser_f2b` e `mesa_f2b`.

Os resultados pertinentes a cada um deste programas se encontram nos subdiretórios de mesmo nome, conforme se pode ver aí na hierarquia de diretórios do git.

Do script `ex2_gzip.sh`, basicamente foi rodado o seguinte comando na pasta `traces` do professor Lucas na rede do IC:
>../../dinero4sbc/dineroIV -informat s -trname gzip_f2b -maxtrace 20 -l1-isize ${i_} -l1-dsize ${d_} -l1-ibsize ${ib_} -l1-dbsize ${db_} > ${out_}

onde os parametros do tamanho dos blocos de cache de instrução foram fixados como:
>ib_=16

>db_=16

Então esse comando foi rodado várias vezes, alterando-se os valores do parametro `i_`e `d_` para potencias de 2, variando de 2KB até 1MB. Ou seja, foram coletados 10 resultados, de onde o valor mais importante na saída é a taxa de miss(`Miss rate`), que foi utilizada para plotar o gráfico. Isso significa que quanto menor o seu valor, melhor é a configuração, pois a CPU desperdiça menos ciclos devido a miss para encontrar o dado na cache e não precisa ir até a memória principal.

#2)Identificando melhor tamanho de cache 

Desse modo, todos os outros parâmetros foram deixados constantes. As únicas variáveis eram os valores dos tamanhos das caches como explicado anteriormente.

Procedimento análogo foi realizado para todos os outros programas para se descobrir o tamanho de cache ideal. Existe um script correspondente a cada um desses programas: `ex2_mesa.sh`,`ex2_vortex.sh`,`ex2_parser.sh`. 

Percebemos que a taxa de miss(`miss rate`) da cache de instrução permanece a mesma enquanto a taxa de miss de cache dados varia. Desse modo notamos que eles são independentes entre si e decidi no mesmo script testar diversos tamanhos de caches para ambos instrução e dados ao mesmo tempo para um certo programa.

Além disso, para o programa `vortex_f2b`, em seu script correspondente, resolvi fixar o tamanho dos blocos das caches de instrução e de dados para 512, ao invés de 16. Isso fez com que o `miss rate` fosse mais elevado para os mesmos valores de tamanho de cache testados nos outros 3 programas. Isso pode ser visto claramente na comparação entre os gráficos que está no arquivo de Excel `graficos_missrate.pdf`

#3) Identificando melhor tamanho dos blocos
Pelo gráfico, podemos perceber que se tratam de funções monotônicas decrescentes. Ou seja, quanto maior o tamanho da cache, tanto de instruções como de dados, menor a taxa de miss. Com uma diferença de que para o caso da cache de instruções, a taxa de miss consegue ser zerada a partir de um certo tamanho da cache, sendo esse tamanho variando de programa para programa.

#4) Por que não foram usados outros parâmetros
De acordo com todos os parâmetros disponíveis pelo `dineroIV`, através da opção `-help`. Podemos analisar: a politica de realocação tem manter o padrão mesmo, LRU(least recent used), pois segue o principio da localidade temporal. A politica de fetch deve manter o padrão também, sempre sob demanda, que é um equilibrio entre "always" e "miss". Politica de escrita, "write-back" seria o padrão e é o mais usado hoje em dia nos mais diversos micros devido a sua eficiência comprovada. 
