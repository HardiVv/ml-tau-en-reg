#!/bin/bash
#SBATCH -p gpu
#SBATCH --gres gpu:rtx:1
#SBATCH --mem-per-gpu=20G
#SBATCH -o slurm-%x-%j-%N.out

#get commandline arguments
TRAINING_TYPE=$1
MODEL_TYPE=$2
TRAIN_SAMPS=$3
TEST_SAMPS=$4

#keras is not used, but for some reason, it's imported somewhere and crashes if this is not specified
export KERAS_BACKEND=torch

#on manivald
export RUNCMD="singularity exec -B /scratch/persistent --env PYTHONPATH=`pwd` --nv /home/software/singularity/pytorch.simg:2024-04-30 "

$RUNCMD python3 enreg/scripts/trainModel.py training_type=$TRAINING_TYPE model_type=$MODEL_TYPE training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS]
