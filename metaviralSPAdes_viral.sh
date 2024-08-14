#!/bin/bash

echo -e "#############################################################" "\n" 

echo -e ======= Ensamble de genomas virales con metaSPAdes ======= "\n"

echo -e                 ===== Inicio: $(date) ===== "\n"

echo -e "##############################################################" "\n"

# -------------------------------------------------------------------
# Cámbio de directorio a donde se encuentran las lecturas postrimming
# -------------------------------------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/Archivos_postrim/Virus

for R1 in *_R1_* ; do
    R2=${R1/_R1_/_R2_}
    ID="$(basename ${R1} | cut -d '_' -f '1')"

# --------------------------------------------------------------------------------------------------------------------
# Ejecuta SPAdes con función de metagenómica sobre mis lecturas R1 y R2 y genera el archivo de salida ${ID}_metaviralSPAdes
# --------------------------------------------------------------------------------------------------------------------

spades.py --metaviral -1 ${R1} \
                      -2 ${R2} \
          -t 6 -o /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaviralSPAdes

# ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Cámbio de nombre del archivo "contigs.fasta" a "${ID}-metaviralSPAdes-assembly.fasta" y elimina el directorio "${ID}_metaviralSPAdes" con los archivos no necesarios
# ----------------------------------------------------------------------------------------------------------------------------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaviralSPAdes/contigs.fasta /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaviralSPAdes/${ID}-metaviralSPAdes-assembly.fasta
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaviralSPAdes/${ID}-metaviralSPAdes-assembly.fasta /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/.
rm -R /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}_metaviralSPAdes

# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecuta seqtk sobre "${ID}-metaviralSPAdes-assembly.fasta" para eliminar todos los contigs menores a 450 pb y nombra el archivo de salida como "${ID}-metaviralSPAdes-assembly.fa"
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

seqtk seq -L 500 /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaviralSPAdes-assembly.fasta > /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaviralSPAdes-assembly.fa

chmod -R 775 /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaviralSPAdes-assembly.fa

# --------------------------------------------------------------------------------------------------
# Remueve los primeros archivos de contigs a modo de solo conservar los archivos generados por seqtk
# --------------------------------------------------------------------------------------------------

rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/${ID}-metaviralSPAdes-assembly.fasta

done #término del ciclo iniciado con "for"


echo -e "##################################################################"
echo -e                   ===== Fin: $(date) =====
echo -e "##################################################################"
