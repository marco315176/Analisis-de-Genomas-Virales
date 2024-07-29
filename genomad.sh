#!/bin/bash

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral

for assembly in *fa; do
    ID="$(basename ${assembly} | cut -d '-' -f '1')"
    ename="$(basename ${assembly} | cut -d '.' -f '1')"

genomad end-to-end --cleanup --splits 5 --min-score 0.5 ${assembly} /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/${ID}_genomad_output $GENOMAD_DB_PATH

#--relaxed

mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/${ID}_genomad_output/${ename}_summary/${ename}_virus_genes.tsv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/.
mv /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/${ID}_genomad_output/${ename}_summary/${ename}_virus_proteins.faa /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/.

rm -R /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad/${ID}_genomad_output

done

cd /home/secuenciacion_cenasa/Analisis_corridas/SPAdes_viral/genomad

for file in *tsv; do
    ename="$(basename ${file} | cut -d '-' -f '1')"

 echo -e "\n${ename} \n$(cat ${file})"

done >> Anotacion_results_all.tsv

rm *virus_genes*
