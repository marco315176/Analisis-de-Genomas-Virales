#!/bin/bash

echo -e "#############################################################################" "\n"
echo -e ===== Moviendo archivos de resultados obtenidos a una sola carpeta ===== "\n"
echo -e "\t" ===== Inicio: $(date) ===== "\n"
echo -e "#############################################################################" "\n"

#-------------------------------------------------------------------
# Definir rutas de directorios de entrada y salida
dirout="/home/admcenasa/Analisis_corridas/Resultados_all_virus"
dirfq="/home/admcenasa/Analisis_corridas/fastQC/virus"
dirfqpt="/home/admcenasa/Analisis_corridas/fastQC_ptrim/virus"
dirmqc="/home/admcenasa/Analisis_corridas/fastQC/virus/multiqc"
dirmqcpt="/home/admcenasa/Analisis_corridas/fastQC_ptrim/virus/multiqc"
dirk2="/home/admcenasa/Analisis_corridas/kraken2/virus"
#dirbk=""
dirkf="/home/admcenasa/Analisis_corridas/kmerfinder/virus"
direns="/home/admcenasa/Analisis_corridas/SPAdes/virus"
dirlc="/home/admcenasa/Analisis_corridas/Corrida_virus"
dirpt="/home/admcenasa/Analisis_corridas/Archivos_postrim/virus"
#--------------------------------------------------------------------

mkdir -p ${dirout}
cd ${dirout}

#-----------------------------------
mkdir -p FastQC
mkdir -p FastQC/Lecturas
mkdir -p FastQC/Lecturas_pt
mkdir -p FastQC/Lecturas/multiQC
mkdir -p FastQC/Lecturas_pt/multiQC
#-----------------------------------
mv ${dirfq}/*fastqc* ./FastQC/Lecturas
mv ${dirfqpt}/*fastqc* ./FastQC/Lecturas_pt
rm -R ${dirmqc}/multiqc_data
mv ${dirmqc}/*multiqc* ./FastQC/Lecturas/multiQC
mv ${dirmqcpt}/postrimm_multiqc* ./FastQC/Lecturas_pt/multiQC
rm -R ${dirmqcpt}/multiqc_data

#-----------------------------------
mkdir -p Archivos_trimming
#-----------------------------------
mv ${dirpt}/*_trim* ./Archivos_trimming

#------------------------------------
mkdir -p BLASTn_results
#------------------------------------
mv ${direns}/BLAST_assembly/*tsv ./BLASTn_results
rm ${direns}/*.fa

#-------------------------------------
mkdir -p KRAKEN2
#-------------------------------------
mv ${dirk2}/*kraken* ./KRAKEN2

#-------------------------------------
mkdir -p KmerFinder
#-------------------------------------
mv ${dirkf}/*results* ./KmerFinder

mkdir -p Estadisticos
#Mover archivos con estadisticos
mv ${dirfq}/estadisticos/*stats* ./Estadisticos
mv ${dirfqpt}/estadisticos/*stats_pt* ./Estadisticos
mv ${direns}/estadisticos/*global* ./Estadisticos

mkdir -p Lecturas_crudas
mv ${dirlc}/*fastq.gz ./Lecturas_crudas
