#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16GB
#SBATCH --time=24:00:00

awk -F '[,]' '{print $1}' /scratch1/qiushipe/data_reusability/data_tables/pmcAndAccs.csv | \
uniq | \
sort -u > /scratch1/qiushipe/data_reusability/data_lists/pmc_id_sorted.txt

cd /scratch1/qiushipe/data_reusability/publications_unzipped
grep -e "PMC" /scratch1/qiushipe/data_reusability/data_lists/pmc_id_sorted.txt | \
xargs -I '{}' cp '{}.xml' /scratch1/qiushipe/data_reusability/publications_sorted