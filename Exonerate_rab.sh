#!/bin/bash

cd /home/admcenasa/Analisis_corridas/SPAdes/virus

mkdir -p /home/admcenasa/Analisis_corridas/Resultados_all_virus/Anotacion

# ---------------------------------------------
# Correr exonerate para anotar genomas de rabia
# ---------------------------------------------

for assembly in /home/admcenasa/Analisis_corridas/Resultados_all_virus/Ensambles/Rabies_virus/*.fa; do
    ID=$(basename ${assembly} | cut -d '-' -f '1')
    ename=$(basename ${assembly} | cut -d '.' -f '1')

exonerate --bestn 1 -q $EX_DB_PATH/Rabies.faa -t ${assembly} > /home/admcenasa/Analisis_corridas/Resultados_all_virus/Anotacion/${ID}_exonerate.txt

done
