#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=24:00:00

module purge
eval "$(conda shell.bash hook)"
conda activate /project/ypatel_840/qiushipe/reusability
python /scratch1/qiushipe/data_reusability/scripts/extract_date.py