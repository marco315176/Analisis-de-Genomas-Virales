#!/bin/bash

echo -e "#####################################################################" "\n"

echo -e Moviendo todos los archivos de resultados obtenidos a una sola carpeta "\n"

echo -e "#####################################################################" "\n"

cd /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus

mkdir -p FastQC
mkdir -p FastQC/Lecturas
mkdir -p FastQC/Lecturas_pt
mkdir -p FastQC/Lecturas/multiQC
mkdir -p FastQC/Lecturas_pt/multiQC
#Mover los archivos generados por FastQC a la carpeta FastQC
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus/*fastqc* ./FastQC/Lecturas
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus/*fastqc* ./FastQC/Lecturas_pt
rm -R /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus/multiqc/multiqc_data
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus/multiqc/*multiqc* ./FastQC/Lecturas/multiQC 
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus/multiqc/postrimm_multiqc* ./FastQC/Lecturas_pt/multiQC
rm -R /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus/multiqc/multiqc_data 

mkdir -p Archivos_trimming
#Mover los archivos limpios (trimming) a la carpeta Archivos_trimming
mv /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus/*_trim* ./Archivos_trimming

#mkdir -p Ensambles
#mkdir -p Ensambles/Contigs_filtrados
#Mover todos los ensambles a la carpeta Ensambles
#mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/*SPAdes* ./Ensambles
#mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/*SPAdes* ./Ensambles/Contigs_filtrados

mkdir -p KRAKEN2
#Mover los archivos obtenidos por KRAKEN2 a la carpeta KRAKEN2
mv /home/secuenciacion_cenasa/Analisis_corridas/kraken2/virus/*kraken* ./KRAKEN2

mkdir -p KmerFinder
#Mover los archivos obtenidos por KmerFinder a la carpeta KmerFinder
mv /home/secuenciacion_cenasa/Analisis_corridas/kmerfinder/virus/*results* ./KmerFinder

#mkdir -p Resultados_BLAST
#Mover los resultados obtenidos por BLASTn a la carpeta Resultados_BLAST
#mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/BLASTn_results/*tsv ./Resultados_BLAST

mkdir -p Estadisticos
#Mover archivos con estadisticos
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus/estadisticos/*stats* ./Estadisticos
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus/estadisticos/*stats_pt* ./Estadisticos
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/estadisticos/*global* ./Estadisticos 
