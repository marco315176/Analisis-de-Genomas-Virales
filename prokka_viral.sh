#!/bin/bash

echo -e "#################################################" "\n"
echo -e       ===== Anotación de genomas virales con prokka ===== "\n"
echo -e                ===== Inicio: $(date) ===== "\n"
echo -e "##############################################" "\n"

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral

for genero in Lyssavirus Influenzavirus Herpesvirus; do
#Rabies, Influenza, Herpesvirus
echo -e "Genero: ${genero}"

for file in /home/secuenciacion_cenasa/Analisis_corridas/kmerfinder/virus/*.spa; do
    gene=$(cat ${file} | sed -n '2p' | cut -d ' ' -f '2' | tr ' ' '_')
    organism=$(cat ${file} | sed -n '2p' | cut -d ' ' -f '2,3' | tr ' ' '_')
    ID_org=$(basename ${file} | cut -d '_' -f '1')

for assembly in /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/*.fa; do
    ID=$(basename ${assembly} | cut -d '-' -f '1')
    ename=$(basename ${assembly} | cut -d '.' -f '1')

case ${genero} in Lyssavirus)
     if [[ ${gene} == Rabies ]]; then
echo -e "If control: ${genero} ${gene}"
    if [[ ${ID_org} == ${ID} ]]; then
echo -e "If control: ${ID_org} ${ID}"

prokka ${assembly} \
       --kingdom viral \
       --outdir /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado \
       --genus ${genero}

# -----------------------------------
# Eliminar archivos que no son útiles
# -----------------------------------

rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.err
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.fna
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.fsa
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.gff
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.log
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.sqn
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.tbl
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.txt

# ----------------------------
# Renombrar archivos de salida
# ----------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.faa /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_proteins.faa
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.ffn /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_nucleotides.ffn
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.gbk /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_GeneBank.gbk
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.tsv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_results.tsv

# -----------------------------------------------------------------------------
# Mover los archivos de salida una carpeta antes y eliminar la carpeta original
# -----------------------------------------------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_proteins.faa /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_nucleotides.ffn /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_GeneBank.gbk /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_results.tsv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.

rm -R /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado

            else
       continue
          fi
       fi
     ;;
             Herpesvirus)
if [[ ${gene} == Equid ]]; then
echo -e "If control: ${genero} ${gene}"
    if [[ ${ID_org} == ${ID} ]]; then
echo -e "If control: ${ID_org} ${ID}"

prokka ${assembly} \
       --kingdom viral \
       --outdir /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado \
       --genus ${genero}

# -----------------------------------
# Eliminar archivos que no son útiles
# -----------------------------------

rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.err
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.fna
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.fsa
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.gff
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.log
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.sqn
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.tbl
rm /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.txt

# ----------------------------
# Renombrar archivos de salida
# ----------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.faa /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_proteins.faa
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.ffn /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_nucleotides.ffn
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.gbk /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_GeneBank.gbk
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/*.tsv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_results.tsv

# -----------------------------------------------------------------------------
# Mover los archivos de salida una carpeta antes y eliminar la carpeta original
# -----------------------------------------------------------------------------

mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_proteins.faa /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_nucleotides.ffn /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_GeneBank.gbk /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.
mv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado/${ID}_${gene}_results.tsv /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/.

rm -R /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka/${ID}_${gene}_anotado

            else
       continue
          fi
       fi
     ;;
   esac

  done
 done
done

# ------------------------------------------------------------------------------------------------
# Concatenar los archivos _results.tsv para obtener uno solo de resultados de genes identificados
# ------------------------------------------------------------------------------------------------

cd /home/secuenciacion_cenasa/Analisis_corridas/Resultados_all_virus/Ensambles/prokka

for kmer in /home/secuenciacion_cenasa/Analisis_corridas/kmerfinder/virus/*.spa; do
    gene=$(cat ${kmer} | sed -n '2p' | cut -d ' ' -f '2' | tr ' ' '_')
    organism=$(cat ${kmer} | sed -n '2p' | cut -d ' ' -f '2,3' | tr ' ' '_')
    ID_org=$(basename ${kmer} | cut -d '_' -f '1')

for file in *_results.tsv; do
    ID=$(basename ${file} | cut -d '_' -f '1')
    spf=$(basename ${file} | cut -d '_' -f '2')

if [[ ${gene} == ${spf} ]]; then
echo -e "\n${ID} \n$(cat ${file})"

          else
    continue
   fi

 done > ./Resultados_${gene}_all.tsv
done

mv ./Resultados_Equid_all.tsv ./Resultados_EHV_all.tsv

#rm ./*_results*
