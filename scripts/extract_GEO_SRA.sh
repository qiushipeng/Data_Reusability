#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16GB
#SBATCH --time=24:00:00

indir="/scratch/qiushipe/data_reusability/publications_unzipped/"
outfile="/scratch1/qiushipe/data_reusability/data_tables/pmcAndAccs.csv"

# extract papers that contain SRA or GEO accession numbers from input folder
grep -o -r -E -H \
-e "[SDE]R[APXRSZ][0-9]{6,7}" \
-e "PRJNA[0-9]{6,7}" \
-e "PRJD[0-9]{6,7}" \
-e "PRJEB[0-9]{6,7}" \
-e "GDS[0-9]{1,6}" \
-e "GSE[0-9]{1,6}" \
-e "GPL[0-9]{1,6}" \
-e "GSM[0-9]{1,6}" \
$indir > /scratch1/qiushipe/data_reusability/data_lists/rawPubData.txt
## output format: /scratch/qiushipe/data_reusability/publications_unzipped/PMC5689701.xml:GSE59102

# reformat the raw scraped data into a csv
echo "pmc_ID,accession" > /scratch1/qiushipe/data_reusability/data_tables/pmcAndAccs.csv
awk -F "[/.:]" '{print $6","$8}' /scratch1/qiushipe/data_reusability/data_lists/rawPubData.txt >> $outfile