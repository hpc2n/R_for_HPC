#!/bin/bash
#SBATCH -A *FIXME*
#Asking for 7 min.
#SBATCH -t 00:07:00
#SBATCH -c 2

ml purge
ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0 

R --no-save --no-restore -f *FIXME*.R
