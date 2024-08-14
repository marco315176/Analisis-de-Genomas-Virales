#!/bin/bash

echo -e "###################################################################################################" "\n"

echo -e ===== Ejecutar kraken2 sobre lecturas posttrimming para identificación taxonómica de virus ===== "\n"

echo -e                              ===== Inicio: $(date) ===== "\n"

echo -e "###################################################################################################" "\n"


cd /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus

for R1 in *_R1_*; do
    R2=${R1/_R1_/_R2_}
    ID="$(basename ${R1} | cut -d '_' -f '1')"

# -------------------------------------------
# Ejecutar kraken2 sobre las lecturas postrim
# -------------------------------------------

kraken2 --paired ${R1} ${R2} --gzip-compressed --db $KRAKEN2_DB_PATH --use-names --report /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/${ID}_kraken2_temp.txt --memory-mapping

# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Filtra los resultados si en la columna 4 del reporte .txt tiene caracteres G o S (genero o especie) y la columna 3 (fragmentos asignados al taxón) tiene un valor mayor a 1
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

awk '$4 ~ "[GS]" && $3 >= 1' /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/${ID}_kraken2_temp.txt > /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/${ID}_kraken_species.txt

# -----------------------------------------
# Añadir títulos de columna al reporte .txt
# -----------------------------------------

sed -i '1i coverage%\tcoverage#\tasigned\trank_especie\tNCBItaxonomicID\ttaxonomic_name' /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/${ID}_kraken_species.txt

done

# ----------------------------------------
# Realizar gráficos interactivos con Krona
# ---------------------------------------- 

cd /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/

for file in *kraken2*; do
    ID=$(basename ${file} | cut -d '_' -f '1')

ktImportText ${file} -o /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/${ID}_kraken2_krona.html

done

rm /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/*kraken2_temp.txt

echo -e "###############################################################" "\n"
echo -e                  ===== Fin: $(date)  =====   "\n"
echo -e "################################################################" "\n"
