#!/bin/bash

echo -e "######################################################################################################################" "\n"
echo -e "\t" ========= Determinación de abundancia relativa de especies con Bracken en secuencias virales ========== "\n"
echo -e "\t" ===== Inicio: $(date) ===== "\n"
echo -e "######################################################################################################################" "\n"

#---------------------------------------------------------
# Definir rutas de directorios de entrada y salida
dirfq="/home/user/Analisis_corridas/Archivos_postrim/virus"
dirout="/home/user/Analisis_corridas/kraken2/virus"
dirbrackout="/home/user/Analisis_corridas/Bracken/virus"
#---------------------------------------------------------

cd ${dirfq}

for R1 in *_R1_*; do
    R2=${R1/_R1_/_R2_}
    ID=$(basename ${R1} | cut -d '_' -f '1' )

# ------------------------------------------------------------------------
# Correr KRAKEN2 para generar reporte de abundancia sobre lecturas postrim
# ------------------------------------------------------------------------

echo -e "########## ${ID} ##########"

kraken2 --paired ${R1} ${R2} \
        --gzip-compressed \
        --db $K2_DB_PATH \
        --use-names \
        --threads 25 \
        --report ${dirout}/${ID}_K2report.txt > ${dirout}/${ID}_kraken2_out.txt

	done

rm ${dirout}/*kraken2_out*

# ----------------------------------------------------
# Correr Bracken con los reportes de KRAKEN2 generados
# ----------------------------------------------------

cd ${dirout}

for K2 in *K2report*; do
    ID=$(basename ${K2} | cut -d '_' -f '1')

bracken -d $K2_DB_PATH \
        -i ${K2} \
        -o ${dirbrackout}/${ID}_bracken_report.tsv \
        -t 15

	done

rm ${dirout}/*K2report.txt
rm ${dirout}/*K2report_bracken_species.txt

echo -e "###########################################################################################" "\n"
echo -e "\t" ========== Análisis de abundancia relativa de especies terminado ========== "\n"
echo -e "\n" ===== Fin: $(date) ===== "\n"
echo -e "###########################################################################################"
