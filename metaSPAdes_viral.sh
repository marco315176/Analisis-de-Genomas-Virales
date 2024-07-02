#!/bin/bash

echo -e "#############################################################"

echo -e ======= Ensamble de genomas virales con metaSPAdes =======

echo -e                 ===== Inicio: $(date) =====

echo -e "##############################################################"

# -------------------------------------------------------------------
# Cámbio de directorio a donde se encuentran las lecturas postrimming
# -------------------------------------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus

for R1 in *_R1_* ; do
    R2=${R1/_R1_/_R2_}
    ID="$(basename ${R1} | cut -d '_' -f '1')"

# --------------------------------------------------------------------------------------------------------------------
# Ejecuta SPAdes con función de metagenómica sobre mis lecturas R1 y R2 y genera el archivo de salida ${ID}_metaSPAdes
# --------------------------------------------------------------------------------------------------------------------

spades.py --meta -1 ${R1} \
                 -2 ${R2} \
          -t 6 -o /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaSPAdes

# ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Cámbio de nombre del archivo "contigs.fasta" a "${ID}-metaSPAdes-assembly.fasta" y elimina el directorio "${ID}_metaSPAdes" con los archivos no necesarios
# ----------------------------------------------------------------------------------------------------------------------------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaSPAdes/contigs.fasta /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaSPAdes/${ID}-metaSPAdes-assembly.fasta
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaSPAdes/${ID}-metaSPAdes-assembly.fasta /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/.
rm -R /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaSPAdes

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecuta seqtk sobre "${ID}-metaSPAdes-assembly.fasta" para eliminar todos los contigs menores a 450 pb y nombra el archivo de salida como "${ID}-metaSPAdes-assembly.fa"
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

seqtk seq -L 600 /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaSPAdes-assembly.fasta > /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaSPAdes-assembly.fa

chmod -R 775 /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaSPAdes-assembly.fa

# --------------------------------------------------------------------------------------------------
# Remueve los primeros archivos de contigs a modo de solo conservar los archivos generados por seqtk
# --------------------------------------------------------------------------------------------------

rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaSPAdes-assembly.fasta

done #término del ciclo iniciado con "for"


echo -e "###########################################################################################"
echo -e ===== Detección de genomas virales con Virsorter2 en ensambles obtenidos con metaSPAdes =====
echo -e                                   ===== Inicio: $(date) =====
echo -e "###########################################################################################"

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral

for ensamble in *.fa; do
ID="$(basename ${ensamble} | cut -d '-' -f '1')"

# -----------------------------------------------------------------------
# Ejecutar virsorter2 para identificar los contigs pertenecientes a virus 
# -----------------------------------------------------------------------

virsorter run -w /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_out_tmp \
              -d $VIRSORTER2_DB_PATH \
              -i ${ensamble} \
              --min-score 0.1 \
              --include-groups  dsDNAphage,NCLDV,RNA,ssDNA,lavidaviridae all

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/final-viral-combined.fa /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/${ID}-metaSPAdes-viral.fa
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/${ID}-metaSPAdes-viral.fa /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/.
rm -R /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out

done

echo -e "##################################################################"
echo -e                   ===== Fin: $(date) =====
echo -e "##################################################################"
