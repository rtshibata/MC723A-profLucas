#!/bin/sh
#
#executar script para coletar uma tabela com 10 combinações distintas de tamanho
#para um programa
#

#supondo que me encontro na rede do IC
traces="/home/staff/lucas/mc723/traces/255.vortex.f2b"
p1="255.vortex.f2b"
home_ex2="/home/ec2010/ra082674/MC723-LucasWanner/exercicio2/output.txt"
name="vortex_f2b"

cd ${traces}



#parametros a serem avaliados
i_="16K"
d_="16K"
ib=2
db=2


for j in $(seq 1 1 10)
do
	out_="${home_ex2/output./.${j}__${p1}.}"
	echo "---------"	
	echo "aqui est $out_"
	echo "---------"
	db_=$(( db ** j ))
	ib_=$(( ib ** j ))
	echo $db_
	echo $ib_
	echo "---------"
	#executa e joga output em output.txt na minha pasta no ic
	../../dinero4sbc/dineroIV -informat s -trname vortex_f2b -maxtrace 20 -l1-isize ${i_} -l1-dsize ${d_} -l1-ibsize ${ib_} -l1-dbsize ${db_} > ${out_}
done

# ../../dinero4sbc/dineroIV -informat s -trname gzip_f2b -maxtrace 20 -l1-isize 16K -l1-dsize 16K -l1-ibsize 32 -l1-dbsize 32

