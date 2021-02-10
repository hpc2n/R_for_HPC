#!/bin/bash
#SBATCH -A *FIXME* 
#Asking for 10 min.
#SBATCH -t 00:20:00
#SBATCH -c *FIXME*

ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0 

R --no-save --no-restore -f parallel.R
