#!/bin/bash

#edit this as needed
export OUTDIR=training-outputs/240528_PT_num_layers_4/
#export OUTDIR=tests

#for regression and decay mode, use only signal (tau) jets
export TRAIN_SAMPS=zh_train.parquet
export TEST_SAMPS=z_test.parquet,zh_test.parquet
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=jet_regression model_type=LorentzNet
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=jet_regression model_type=ParticleTransformer
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=jet_regression model_type=SimpleDNN
 
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=dm_multiclass model_type=LorentzNet
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=dm_multiclass model_type=ParticleTransformer models.ParticleTransformer.hyperparameters.num_layers=4
sbatch enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=dm_multiclass model_type=SimpleDNN

##for binary classification, use signal (tau) and background (non-tau) jets
# export TRAIN_SAMPS=zh_train.parquet,qq_train.parquet
# export TEST_SAMPS=z_test.parquet,zh_test.parquet,qq_test.parquet
# sbatch --mem-per-gpu 150G enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=binary_classification model_type=LorentzNet
# sbatch --mem-per-gpu 150G enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=binary_classification model_type=ParticleTransformer
# sbatch --mem-per-gpu 150G enreg/scripts/train-pytorch-gpu.sh output_dir=$OUTDIR training_samples=[$TRAIN_SAMPS] test_samples=[$TEST_SAMPS] training_type=binary_classification model_type=SimpleDNN
