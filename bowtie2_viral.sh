#!/bin/bash

echo -e "###############################################################################" "\n"
echo -e                ===== Filtrado de lecturas virales con bowtie2 ===== "\n"
echo -e                           ===== Inicio: $(date)  ===== "\n"
echo -e "###############################################################################" "\n"

#Para indexar una secuencia fasta a la base de datos de bowtie2: bowtie2-build genome.fasta genome_index

# --------------------------------------------------------------
# Moverse al directorio donde se encuentran las lecturas limpias
# ---------------------------------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus

# ---------------------------------------------------------------------------------------
# Alinear y filtrar las lecturas concordantes con virus al archivo ${ID}_trim_bt.fastq.gz
# ---------------------------------------------------------------------------------------

for r1 in *_R1_*; do
    r2=${r1/_R1_/_R2_}
    ID=$(basename ${r1} | cut -d '_' -f '1')

bowtie2 --local --ignore-quals --very-sensitive-local --reorder --al-conc-gz /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_trim_bt.fastq.gz -x /home/secuenciacion_cenasa/Programas_Bioinformaticos/bowtie2-2.5.3-linux-x86_64/db_bowtie2/bt2_db_virus -1 ${r1} -2 ${r2}  -S /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_align.sam
#Para lecturas no alineadas: --un-conc-gz /home/secuenciacion_cenasa/Programas_Bioinformaticos/bowtie2-2.5.3-linux-x86_64/${ID}_notalig.fastq.gz

# ----------------------------------------
# Renombrar los archivos de salida R1 y R2
# ----------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_trim_bt.fastq.1.gz /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_R1_trim_bt.fastq.gz
mv /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_trim_bt.fastq.2.gz /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/${ID}_R2_trim_bt.fastq.gz
chmod -R 775 /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/*trim_bt.fastq*
rm /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/bowtie_filter/*align.sam*

done
