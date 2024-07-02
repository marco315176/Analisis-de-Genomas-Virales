#!/bin/bash

echo -e "#################################################################################"
echo -e ===== Iniciando pipeline para análisis de genomas virales =====
echo -e ===== Inicio del pipeine: $(date) =====
echo -e "#################################################################################"

# ---------------------------------------------------------------------------------------------------------
# Script para obtener estadisticos de lecturas crudas, reaizar trimming y obtener estadisticos pos-trimming
# ---------------------------------------------------------------------------------------------------------

bash estadisticas_lecturas_virus.sh

# ---------------------------------------------------------------
# Script para reaizar el ensamble con SPAdes con la opción --meta
# ---------------------------------------------------------------

bash metaSPAdes_viral.sh

# -------------------------------------------------------------------------
# Script para btener las estadisticas de los ensambles obtenidos con SPAdes
# -------------------------------------------------------------------------

bash Estadisticos_ensamble_virus.sh

# -----------------------------------------------------------------------------------------------------------------------------------------------
# Scripts para realizar la identificación taxonómica de genero y especie, así como el MLST y formula antigénica de aisados de Salmonella y E.coli
# -----------------------------------------------------------------------------------------------------------------------------------------------

bash kmerfinder_viral.sh

#bash kraken2_viral.sh

# -----------------------------------
# Script para separar contigs virales 
# -----------------------------------

bash  virsorter2.sh

# ---------------------------------------------------------
# Mover todos los archivos de resultados a una sola carpeta
# ---------------------------------------------------------

bash results_virus.sh

echo -e "#########################################"
echo -e ===== Fin del pipeline: $(date) =====
echo -e "#########################################"

