#!/bin/bash

echo -e "###################################################################################################" "\n"

echo -e ===== Ejecutar kraken2 sobre lecturas posttrimming para identificación taxonómica de virus ===== "\n"

echo -e                              ===== Inicio: $(date) ===== "\n"

echo -e "###################################################################################################" "\n"


cd /home/admcenasa/Analisis_corridas/Archivos_postrim/virus

for R1 in *_R1_*; do
    R2=${R1/_R1_/_R2_}
    ID="$(basename ${R1} | cut -d '_' -f '1')"

# -------------------------------------------
# Ejecutar kraken2 sobre las lecturas postrim
# -------------------------------------------

echo -e "########## ${ID} ##########"

kraken2 --paired ${R1} ${R2} --gzip-compressed --db $K2_DB_PATH --use-names --threads 25 --report /home/admcenasa/Analisis_corridas/kraken2/virus/${ID}_kraken2_temp.txt

# --------------------------------------------------------------------------------------
# Filtra los resultados si en la columna 4 del reporte .txt tiene caracteres S (especie)
# --------------------------------------------------------------------------------------

awk '$4 ~ "[S]"' /home/admcenasa/Analisis_corridas/kraken2/virus/${ID}_kraken2_temp.txt > /home/admcenasa/Analisis_corridas/kraken2/virus/${ID}_kraken_species.txt
#awk '$4 ~ "[S]" && $1 >= 0.1'

# -----------------------------------------
# Añadir títulos de columna al reporte .txt
# -----------------------------------------

sed -i '1i coverage%\tcoverage#\tasigned\trank_especie\tNCBItaxonomicID\ttaxonomic_name' /home/admcenasa/Analisis_corridas/kraken2/virus/${ID}_kraken_species.txt

done

# ----------------------------------------
# Realizar gráficos interactivos con Krona
# ---------------------------------------- 

cd /home/admcenasa/Analisis_corridas/kraken2/virus

for kraken in *kraken2_temp*; do
    ID=$(basename ${kraken} | cut -d '_' -f '1')

ktImportTaxonomy -m 3 -t 5 ${kraken}  -o ./${ID}_kraken2_krona.html

done

rm /home/admcenasa/Analisis_corridas/kraken2/virus/*kraken2_temp.txt

echo -e "###############################################################" "\n"
echo -e                  ===== Fin: $(date)  =====   "\n"
echo -e "################################################################" "\n"
