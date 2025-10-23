#!/bin/bash

echo -e "###########################################################################################"
echo -e ===== Detección de genomas virales con Virsorter2 en ensambles obtenidos con metaSPAdes =====
echo -e                                   ===== Inicio: $(date) =====
echo -e "###########################################################################################"

conda activate virsorter_env

cd /home/user/Analisis_corridas/SPAdes_viral

for ensamble in *.fa; do
ID="$(basename ${ensamble} | cut -d '-' -f '1')"


virsorter run -w /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out \
              -d $VIRSORTER2_DB_PATH \
              -i ${ensamble} \
              --min-score 0.05 \
              --provirus-off  \
              --keep-original-seq \
              --include-groups  RNA,NCLDV,ssDNA,lavidaviridae all

mv /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/final-viral-combined.fa /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/${ID}-metaSPAdes-viral.fa
mv /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out/${ID}-metaSPAdes-viral.fa /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/.
rm -R /home/user/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${ID}_virsorter_out

done

conda deactivate

