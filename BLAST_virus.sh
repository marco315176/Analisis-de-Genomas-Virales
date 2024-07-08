#!/bin/bash

echo -e "#########################################################################################################"

echo -e ===== Correr BLASTn para identificar contigs de genes de Influenza en ensambles obtenidos con SPAdes =====

echo -e                         ===== Inicio: $(date) =====

echo -e "###########################################################################################################"

#Crear la base de datos de BLASTn: makeblastdb -in archivo.fa -dbtype nucl -out ./Influenza_db
#La base de datos de influenza se puede descargar en: https://www.ncbi.nlm.nih.gov/labs/virus/vssi/#/virus?SeqType_s=Nucleotide&VirusLineage_ss=Influenza%20A%20virus,%20taxid:11320&HostLineage_ss=NOT%20Homo%20sapiens%20(human),%20taxid:HostId_i:*%20NOT%20HostId_i:9606

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral


for ensamble in *.fa; do
    ID="$(basename ${ensamble} | cut -d '-' -f '1')"

# ---------------------------------------------------------------------------------------------------
# Ejecutar BLASTn sobre los ensambles para identificar los contigs de influenza y sus antigenos H y N
# ---------------------------------------------------------------------------------------------------

blastn -query ${ensamble} -db $BLASTN_DB_PATH/virus_db -outfmt "6 qseqid salltitles sstrand" -max_target_seqs 1 -perc_identity 90 -evalue 1e-10 -out /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/BLASTn_results/${ID}_results.tsv

#Para conocer el % de identidad: -outfmt "6 pident"
#ID de secuencia de consulta: -outfmt "6 qseqid"

# --------------------------------
# Modificar los archivos de salida
# --------------------------------

cat ./BLASTn_results/${ID}_results.tsv | tr " " "_" > ./BLASTn_results/${ID}_results_2.tsv
cat ./BLASTn_results/${ID}_results_2.tsv | awk '{print $1}' > ./BLASTn_results/${ID}_nodos.txt
cat ./BLASTn_results/${ID}_results_2.tsv | awk '{print $2}' | cut -d '(' -f '3,4' > ./BLASTn_results/${ID}_gen.txt
cat ./BLASTn_results/${ID}_results_2.tsv | awk '{print $3}' > ./BLASTn_results/${ID}_sentido.txt
cat ./BLASTn_results/${ID}_gen.txt | cut -d ',' -f '1' > ./BLASTn_results/${ID}_gen1.txt
cat ./BLASTn_results/${ID}_gen1.txt | tr "_" " " > ./BLASTn_results/${ID}_gen2.txt
cat ./BLASTn_results/${ID}_gen2.txt | tr "( )" " | " > ./BLASTn_results/${ID}_gen3.txt
paste ./BLASTn_results/${ID}_nodos.txt ./BLASTn_results/${ID}_sentido.txt ./BLASTn_results/${ID}_gen3.txt > ./BLASTn_results/${ID}_BLASTn_results_tmp.tsv
cat ./BLASTn_results/${ID}_BLASTn_results_tmp.tsv | uniq > ./BLASTn_results/${ID}_BLASTn_results.tsv

# ----------------------------
# Remover archivos resultantes
# ----------------------------

rm ./BLASTn_results/${ID}_results.tsv
rm ./BLASTn_results/${ID}_results_2.tsv
rm ./BLASTn_results/*.txt*
rm ./BLASTn_results/*tmp*

done



echo -e "###############################"
echo -e     ===== Fin: $(date) =====
echo -e "###############################"
