#!/bin/bash


echo -e "###############################################################################################"

echo -e ============= Estadísticos de lecturas de archivos fastQ.gz de corridas virales ================

echo                                ===== Inicio: $(date) =====

echo -e "###############################################################################################"

cd /home/secuenciacion_cenasa/Analisis_corridas/Corrida_virus

# ------------------------------------------------------------------------
# Ejecuta fastQC sobre las lecturas en el directorio que terminen con .gz
# ------------------------------------------------------------------------

fastqc *.gz -o /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus


echo "##########################################################################"

echo ====== Reporte de resultados multiqc de archivos de lecturas crudas ====== 

echo "##########################################################################"

cd /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus 

# -------------------------------------------------------------------------------------------------
# Ejecuta multiqc sobre los reportes .HTML generados por fastQC para generar un reporte en conjunto
# -------------------------------------------------------------------------------------------------

multiqc . -o /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastQC/Virus/multiqc 

mv /multiqc/multiqc_report.html /multiqc/pretrimm_multiqc_report.html


echo "###########################################################################"

echo ============ Limpieza de lecturas con Trim_Galore ===================

echo ===== Inicio: $(date) =====

echo "###########################################################################"

cd /home/secuenciacion_cenasa/Analisis_corridas/Corrida_virus

# ---------------------------------------------------------------------------------------------------
# Ejecuta Trim_Galore para realizar el proceso de trimming sobre lecturas y ejecuta fastqc postrimming
# ---------------------------------------------------------------------------------------------------

trim_galore --quality 30 --length 40 --paired  *.gz --fastqc_args "--outdir /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus" --output_dir /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus 



cd /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus

mkdir -p reports_txt

mv  *.txt ./reports_txt

chmod -R 775 *.gz

for R1 in *_R1_*; do 
    R2=${R1/_R1_*val_1.fq.gz/_R2_*val_2.fq.gz}
    nameR1="$(basename ${R1} | cut -d '_' -f '1')"
    nameR2="$(basename ${R2} | cut -d '_' -f '1')"

# --------------------------------------------------------------
# Cámbio de nombre de los archivos trimmiados de salida R1 y R2 
# --------------------------------------------------------------

mv ${R1}  ${nameR1}_R1_trim.fastq.gz 
mv ${R2}  ${nameR2}_R2_trim.fastq.gz 

done #Termino del loop iniciado con "for"


echo -e "######################################################################"

echo ====== Reporte de resultados de archivos de lecturas pot-trimming ======

echo -e "######################################################################"

cd /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus

# ------------------------------------------------------------------------------------------------------------------------------
# Ejecutar multiQC sobre los reportes .HTML generados por fastQC para generar un reporte en conjunto de los reportes postrimming
# ------------------------------------------------------------------------------------------------------------------------------

multiqc . -o /home/secuenciacion_cenasa/Analisis_corridas/Resultados_fastqc_ptrim/Virus/multiqc 

mv /multiqc/multiqc_report.html /multiqc/postrimm_multiqc_report.html 

echo -e "##################################"
echo         ===== Fin: $(date) =====
echo -e "##################################"

