#!/bin/bash

echo -e "#################################################################################" "\n"
echo -e         ===== Iniciando pipeline para análisis de genomas virales ===== "\n"
echo -e                      ===== Inicio del pipeine: $(date) ===== "\n"
echo -e "#################################################################################" "\n"

# ---------------------------------------------------------------------------------------------------------
# Script para obtener estadisticos de lecturas crudas, reaizar trimming y obtener estadisticos pos-trimming
# ---------------------------------------------------------------------------------------------------------

bash estadisticas_lecturas_virus.sh

# --------------------------------------------------------
# Script para filtrar las secuencias virales de la muestra
# --------------------------------------------------------

bash bowtie2_viral.sh

# ---------------------------------------------------------------
# Script para reaizar el ensamble con SPAdes con la opción --meta
# ---------------------------------------------------------------

bash metaSPAdes_viral.sh

# -------------------------------------------------------------------------
# Script para btener las estadisticas de los ensambles obtenidos con SPAdes
# -------------------------------------------------------------------------

bash Estadisticos_ensamble_virus.sh

# ----------------------------------------------------------------------
# Scripts para realizar la identificación taxonómica de genero y especie
# ----------------------------------------------------------------------

bash kraken2_viral.sh

bash kmerfinder_viral.sh

# -------------------------------------------------------
# Script para identificar los contigs de virus con BLASTn
# -------------------------------------------------------

#bash BLAST_virus.sh

# ---------------------------------------------------------
# Mover todos los archivos de resultados a una sola carpeta
# ---------------------------------------------------------

bash results_virus.sh

echo -e "######################################################################################"
echo -e ===== Pipeline de análisis de genomas virales completado: $(date) =====
echo -e "######################################################################################"

