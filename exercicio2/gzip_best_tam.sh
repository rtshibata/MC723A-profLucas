#!/bin/sh
#

#supondo que ja se sabe os tamanhos de cache ideais
best_i="32K"
best_d="32K"

#supondo que me encontro na rede do IC
traces="/home/staff/lucas/mc723/traces/164.gzip.f2b"
p1="best_tam_164.gzip.f2b"
home_ex2="/home/ec2010/ra082674/MC723-LucasWanner/MC723A-profLucas/exercicio2/output.txt"

cd ${traces}

#parametros a serem avaliados
i_=${best_i}
d_=${best_d} 
ib_=16
db_=16

for j in $(seq 1 1 10) #32,64,128,256,512, 1K,2K,4K,8K,16K
	do
		ib_=$(( ib_ * 2 ))
		db_=$(( db_ * 2 )) 		
		out_="${home_ex2/output./${db_}__${p1}.}"
		echo "---------"	
		echo "aqui est $out_"
		echo "data cache tam: $d_ bits"
		echo "inst cache tam: $i_ bits"
		echo "data: $db_ B"
		echo "instrucao: $ib_ B"
		echo "---------"
		#executa e joga output em output.txt na minha pasta no ic
		../../dinero4sbc/dineroIV -informat s -trname gzip_f2b -maxtrace 20 -l1-isize ${i_} -l1-dsize ${d_} -l1-ibsize ${ib_} -l1-dbsize ${db_} > ${out_}
	done

name="best_tam_gzip"
mv *.*[$name].* /gzip/${name}/

