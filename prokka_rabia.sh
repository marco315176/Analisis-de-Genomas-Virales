#!/bin/bash

echo -e "#################################################"
echo -e       ===== Anotación de genoma de rabia =====
echo -e             ===== Inicio: $(date) =====
echo -e "##############################################"

# ----------------------------------------
# Anotación del genoma de rabia con prokka
# ----------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral

for assembly in *fa; do
    ID="$(basename ${assembly} | cut -d '-' -f '1')"
    ename="$(basename ${assembly} | cut -d '.' -f '1')"

prokka ${assembly} \
       --kingdom viral \
       --outdir /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado \
       --genus Lyssavirus

# -----------------------------------
# Eliminar archivos que no son útiles
# -----------------------------------

rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.err
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.fna
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.fsa
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.gff
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.log
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.sqn
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.tbl
rm /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.txt

# ----------------------------
# Renombrar archivos de salida
# ----------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.faa /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_proteins.faa
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.ffn /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_nucleotides.ffn
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.gbk /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_GeneBank.gbk
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/*.tsv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_results.tsv

# -----------------------------------------------------------------------------
# Mover los archivos de salida una carpeta antes y eliminar la carpeta original
# -----------------------------------------------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_proteins.faa /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_nucleotides.ffn /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_GeneBank.gbk /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado/${ID}_rabies_results.tsv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/.

rm -R /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/${ID}_rabies_anotado

done

# ------------------------------------------------------------------------------------------------
# Concatenar los archivos _results.tsv para obtener uno solo de resultados de genes identificados
# ------------------------------------------------------------------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/prokka/

for file in *_results.*; do
    ID=$(basename ${file} | cut -d '_' -f '1')

echo -e "\n${ID} \n$(cat ${file})"
done >> ./Results_rabia_all.tsv

rm ./*_results*
