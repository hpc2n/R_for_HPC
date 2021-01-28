#!/bin/bash
#SBATCH -A *FIXME* 
#Asking for 10 min.
#SBATCH -t 00:20:00
#SBATCH -N 1
#SBATCH -c *FIXME*

#ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
#ml R/3.6.0 

ml GCC/7.3.0-2.30 OpenMPI/3.1.1; ml R/3.5.1
ml R-bundle-Bioconductor/3.8-R-3.5.1

R --no-save --no-restore -f parallel.R