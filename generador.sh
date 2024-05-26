#!/bin/bash
while getopts d:f:n: flag
do
    case "${flag}" in
        d) fileDeudores=${OPTARG};;
        f) fileEscrito=${OPTARG};;
        n) tamano=${OPTARG};;
    esac
done
let tamano=$tamano-1;
sed -i 's| |_|g' $fileDeudores;

arr_nombre=( $(tail -n +2 $fileDeudores | cut -d ',' -f1) );
arr_nif=( $(tail -n +2 $fileDeudores | cut -d ',' -f2) );
arr_domicilio=( $(tail -n +2 $fileDeudores | cut -d ',' -f3) );
arr_concepto=( $(tail -n +2 $fileDeudores | cut -d ',' -f4) );
arr_periodo=( $(tail -n +2 $fileDeudores | cut -d ',' -f5) );
arr_expdte=( $(tail -n +2 $fileDeudores | cut -d ',' -f6) );
arr_numero=( $(tail -n +2 $fileDeudores | cut -d ',' -f7) );
arr_principal=( $(tail -n +2 $fileDeudores | cut -d ',' -f8) );
arr_recargo20=( $(tail -n +2 $fileDeudores | cut -d ',' -f9) );
arr_recargo10=( $(tail -n +2 $fileDeudores | cut -d ',' -f10) );
arr_recargo05=( $(tail -n +2 $fileDeudores | cut -d ',' -f11) );
arr_intereses=( $(tail -n +2 $fileDeudores | cut -d ',' -f12) );
arr_costas=( $(tail -n +2 $fileDeudores | cut -d ',' -f13) );
arr_total=( $(tail -n +2 $fileDeudores | cut -d ',' -f14) );
arr_recargoyTotal=( $(tail -n +2 $fileDeudores | cut -d ',' -f15) );
arr_fechaInteres=( $(tail -n +2 $fileDeudores | cut -d ',' -f16) );

for i in $(seq 0 $tamano)
do
    mkdir ./${arr_expdte[$i]};
    cp $fileEscrito ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!nombre|${arr_nombre[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!NIF|${arr_nif[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!domicilio|${arr_domicilio[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!concepto|${arr_concepto[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!periodo|${arr_periodo[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!expdte|${arr_expdte[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!numero|${arr_numero[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!principal|$(echo ${arr_principal[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!recargo20|$(echo ${arr_recargo20[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!recargo10|$(echo ${arr_recargo10[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!recargo05|$(echo ${arr_recargo05[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!intereses|$(echo ${arr_intereses[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!costas|$(echo ${arr_costas[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!total|$(echo ${arr_principal[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!recargoyTotal|$(echo ${arr_recargoyTotal[$i]} | sed "s|\.|,|")|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i "s|\!fechaInteres|${arr_fechaInteres[$i]}|g" ./${arr_expdte[$i]}/$fileEscrito;
    sed -i 's|_| |g' ./${arr_expdte[$i]}/$fileEscrito;

    cd ./${arr_expdte[$i]}/
    latexmk ./$fileEscrito -pdf
    latexmk -c
    cd ../
done