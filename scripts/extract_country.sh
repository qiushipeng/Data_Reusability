#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=24:00:00

module purge
eval "$(conda shell.bash hook)"
conda activate /home1/qiushipe/.conda/envs/myenv
python /scratch1/qiushipe/data_reusability/scripts/extract_country.py