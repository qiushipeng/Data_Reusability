#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=6:00:00


cd /scratch/qiushipe/data_reusability/publications

# unzip everything
for file in *.tar.gz; do
    tar zxvf $file --strip-components=1 -C /scratch/qiushipe/data_reusability/publications_unzipped
done
