#!/bin/bash

echo -e "#############################################################################################################" "\n"

echo -e Moviendo todos los archivos de resultados obtenidos a: /home/admcenasa/Analisis_corridas/Resultados_all_virus "\n"

echo -e "#############################################################################################################" "\n"

cd /home/admcenasa/Analisis_corridas/Resultados_all_virus

mkdir -p FastQC
mkdir -p FastQC/Lecturas
mkdir -p FastQC/Lecturas_pt
mkdir -p FastQC/Lecturas/multiQC
mkdir -p FastQC/Lecturas_pt/multiQC
#Mover los archivos generados por FastQC a la carpeta FastQC
mv /home/admcenasa/Analisis_corridas/fastQC/virus/*fastqc* ./FastQC/Lecturas
mv /home/admcenasa/Analisis_corridas/fastQC_ptrim/virus/*fastqc* ./FastQC/Lecturas_pt
rm -R /home/admcenasa/Analisis_corridas/fastQC/virus/multiqc/multiqc_data
mv /home/admcenasa/Analisis_corridas/fastQC/virus/multiqc/*multiqc* ./FastQC/Lecturas/multiQC 
mv /home/admcenasa/Analisis_corridas/fastQC_ptrim/virus/multiqc/postrimm_multiqc* ./FastQC/Lecturas_pt/multiQC
rm -R /home/admcenasa/Analisis_corridas/fastQC_ptrim/virus/multiqc/multiqc_data 

mkdir -p Archivos_trimming
#Mover los archivos limpios (trimming) a la carpeta Archivos_trimming
mv /home/admcenasa/Analisis_corridas/Archivos_postrim/virus/*_trim* ./Archivos_trimming

#mkdir -p Ensambles/
#mv /home/admcenasa/Analisis_corridas/SPAdes/virus/BLAST_assembly/*.fa ./Ensambles

mkdir -p BLASTn_results/
#Mover todos los resultados de blast a la carpeta Ensambles/BLASTn_results
mv /home/admcenasa/Analisis_corridas/SPAdes/virus/BLAST_assembly/*tsv ./BLASTn_results
rm /home/admcenasa/Analisis_corridas/SPAdes/virus/*.fa

mkdir -p KRAKEN2
#Mover los archivos obtenidos por KRAKEN2 a la carpeta KRAKEN2
mv /home/admcenasa/Analisis_corridas/kraken2/virus/*kraken* ./KRAKEN2

mkdir -p KmerFinder
#Mover los archivos obtenidos por KmerFinder a la carpeta KmerFinder
mv /home/admcenasa/Analisis_corridas/kmerfinder/virus/*results* ./KmerFinder

mkdir -p Estadisticos
#Mover archivos con estadisticos
mv /home/admcenasa/Analisis_corridas/fastQC/virus/estadisticos/*stats* ./Estadisticos
mv /home/admcenasa/Analisis_corridas/fastQC_ptrim/virus/estadisticos/*stats_pt* ./Estadisticos
mv /home/admcenasa/Analisis_corridas/SPAdes/virus/estadisticos/*global* ./Estadisticos 

mkdir -p Lecturas_crudas
mv /home/admcenasa/Analisis_corridas/Corrida_virus/*fastq.gz ./Lecturas_crudas
