#!/bin/bash

echo -e "###############################################################################" "\n"
echo -e              ===== Filtrando de lecturas virales con bowtie2 ===== "\n"
echo -e                         ===== Inicio: $(date)  ===== "\n"
echo -e "###############################################################################" "\n"

#Para indexar una secuencia fasta a la base de datos de bowtie2: bowtie2-build genome.fasta bt2_db_virus

#---------------------------------------------------------
# Definir rutas de directorios de entrada y salida
dirfq="/home/user/Analisis_corridas/Archivos_postrim/virus"
dirout="/home/user/Analisis_corridas/Archivos_postrim/virus/bowtie_filter"
#---------------------------------------------------------

cd ${dirfq}

for r1 in *_R1_*; do
    r2=${r1/_R1_/_R2_}
    ID=$(basename ${r1} | cut -d '_' -f '1')
echo -e "\n" "########## ${ID} ##########" "\n"

bowtie2 --local  -p 15 --ignore-quals --very-sensitive-local --reorder \
        --al-conc-gz ${dirout}/${ID}_trim_bt.fastq.gz \
        -x $BT2_virus_DB_PATH/bt2_db_virus -1 ${r1} -2 ${r2}  \
        -S ${dirout}/${ID}_align.sam
#Para lecturas no alineadas: --un-conc-gz ${dirout}/${ID}_notalig.fastq.gz
#--al-conc-gz ${dirout}/${ID}_trim_bt.fastq.gz

# ----------------------------------------
# Renombrar los archivos de salida R1 y R2
# ----------------------------------------

mv ${dirout}/${ID}_trim_bt.fastq.1.gz ${dirout}/${ID}_R1_trim_bt.fastq.gz
mv ${dirout}/${ID}_trim_bt.fastq.2.gz ${dirout}/${ID}_R2_trim_bt.fastq.gz
chmod -R 775 ${dirout}/*trim_bt.fastq*
rm ${dirout}/*align.sam*

done

echo -e "#############################################################" "\n"
echo -e          "\t"         ===== Fin: $(date)  ===== "\n"
echo -e "#############################################################" "\n"
