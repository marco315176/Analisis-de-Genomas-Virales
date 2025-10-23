#!/bin/bash

echo -e "###############################################################################################################" "\n"

echo -e === Ejecutar kmerfinder sobre ensambles obtenidos con metaSPAdes para la identificación taxonómica de virus === "\n"

echo -e                                        ===== Inicio: $(date) ===== "\n"

echo -e "###############################################################################################################" "\n"

#---------------------------------------------------------
# Definir rutas de directorios de entrada y salida
dirfa="/home/admcenasa/Analisis_corridas/SPAdes/virus"
dirout="/home/admcenasa/Analisis_corridas/kmerfinder/virus"
dirfqfilt="/home/admcenasa/Analisis_corridas/Archivos_postrim/virus/bowtie_filter"
diroutfq="/home/admcenasa/Analisis_corridas/Resultados_all_virus/Archivos_trimming"
#---------------------------------------------------------

cd ${dirfa}

for assembly in *.fa*; do
    ID="$(basename ${assembly} | cut -d '-' -f '1')"
    ename="$(basename ${assembly} | cut -d '_' -f '1,2')"

# -----------------------------------------------------------------------
# Correr kmerfinder sobre los ensambles obtenidos con metaSPAdes o SPAdes
# -----------------------------------------------------------------------

kmerfinder_main.py -i ${assembly} \
              -db $KF_DB_PATH/viral/viral.TG \
              -tax $KF_DB_PATH/viral/viral.tax \
              -o ${dirout}/KF_${ID}

# ----------------------------------------------------------------------------------------------------------------------
# Mover los resultados .txt y .spa un directorio atras, añadiendoles el ID de su muestra y eliminar la carpeta /KF_${ID}
# ----------------------------------------------------------------------------------------------------------------------

mv ${dirout}/KF_${ID}/results.txt ${dirout}/${ID}_results.txt
mv ${dirout}/KF_${ID}/results.spa ${dirout}/${ID}_results.spa
rm -R ${dirout}/KF_${ID}

done

# ------------------------------------------------------------------------------------
# Mover los archivos trimmiados a una carpeta nombrada con el genero del organismo identificado
# ------------------------------------------------------------------------------------

cd ${dirout}

for file in *spa; do
    genero=$(cat ${file} | sed -n '2p' | cut -d ' ' -f '2,3,4' | cut -d ',' -f '1'| tr ' ' '_')
    ID=$(basename ${file} | cut -d '_' -f '1')

for trim in ${dirfqfilt}/*fastq.gz; do
    trim_ID=$(basename ${trim} | cut -d '_' -f '1')

if [[ ${ID} != ${trim_ID} ]]; then
       continue
 else
mkdir -p ${diroutfq}/${genero}_bt2_filter

echo -e "Moviendo ${trim} a ${genero}_bt2_filter"
     mv ${trim} ${diroutfq}/${genero}_bt2_filter

        fi
    done
done


# -----------------------------------------------------
# Conjuntar los archivos .spa en uno solo de resultados
# -----------------------------------------------------

cd ${dirout}

for file in *.spa; do
    ename="$(basename ${file} | cut -d '_' -f '1')"
    echo -e "\n ########## ${ename} ########## \n$(cat ${file})"

done >> ./kmerfinder_results_all.tsv

rm *.txt
