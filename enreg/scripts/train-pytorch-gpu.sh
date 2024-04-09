#!/bin/bash
#SBATCH -p gpu
#SBATCH --gres gpu:rtx:1
#SBATCH --mem-per-gpu=10G
#SBATCH -o slurm-%x-%j-%N.out


apptainer exec -B /scratch/persistent/laurits --env PYTHONPATH=`pwd` --nv /home/software/singularity/pytorch.simg\:2024-02-13 python3 enreg/scripts/trainLorentzNet.py
# apptainer exec -B /scratch/persistent/laurits --env PYTHONPATH=`pwd` --nv /home/software/singularity/pytorch.simg\:2024-02-13 python3 enreg/scripts/trainParticleTransformer.py