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

# -------------------------
# Remover archivos sin uso
# -------------------------

rm ./BLASTn_results/${ID}_results.tsv
rm ./BLASTn_results/${ID}_results_2.tsv
rm ./BLASTn_results/*.txt*
rm ./BLASTn_results/*tmp*

done

# ------------------------------------------------
# Filtrar los contigs que hicieron match con BLAST
# ------------------------------------------------

for blast in /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/BLASTn_results/*tsv; do
    ID_blast="$(basename ${blast} | cut -d '_' -f '1')"

for assembly in /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/*fa; do
    ID_assembly="$(basename ${assembly} | cut -d '-' -f '1')"
    name_assembly="$(basename ${assembly} | cut -d '-' -f '1,2')"

# ------------------------------------------------------------------------------------
# Control si el ID del ensamble y de los resultados obtenidos por BLAST son los mismos
# ------------------------------------------------------------------------------------

echo -e "Nombres Control:\t Ensamble: ${ID_assembly} \tBLAST: ${ID_blast}"

if [[ ${ID_assembly} != ${ID_blast} ]]; then 
   continue
   else
echo -e "Else Control:\t Ensamble: ${ID_assembly} \tRead: ${ID_blast}"

grep -oP 'NODE_\d+_length_\d+_cov_\d+\.\d+' ${blast} > ./BLASTn_results/${name_assembly}_contigs_list.txt

# --------------------------------------------
# Filtrar los contigs con la herramienta seqtk
# --------------------------------------------

seqtk subseq ${assembly} ./BLASTn_results/${name_assembly}_contigs_list.txt > /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/${name_assembly}_viral_tmp.fasta
cat ./Contigs_filtrados/${name_assembly}_viral_tmp.fasta | uniq > ./Contigs_filtrados/${name_assembly}_viral.fasta

      fi
  done
done

# ------------------------
# Remover archivos sin uso
# ------------------------

rm ./BLASTn_results/*.txt*
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/Contigs_filtrados/*tmp*

echo -e "###############################"
echo -e     ===== Fin: $(date) =====
echo -e "###############################"
