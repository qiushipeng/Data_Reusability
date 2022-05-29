#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=6:00:00

indir="/scratch/qiushipe/data_reusability/publications_unzipped/"
outfile="/scratch1/qiushipe/data_reusability/test/preFilterMatrix.csv"

grep -o -r -E -H \
-e "[SDE]R[APXRSZ][0-9]{6,7}" \
-e "PRJNA[0-9]{6,7}" \
-e "PRJD[0-9]{6,7}" \
-e "PRJEB[0-9]{6,7}" \
-e "GDS[0-9]{1,6}" \
-e "GSE[0-9]{1,6}" \
-e "GPL[0-9]{1,6}" \
-e "GSM[0-9]{1,6}" \
$indir > /scratch1/qiushipe/data_reusability/test/rawPubData.txt

rawPubData.txt >> $outfile

#输出样式 /scratch/qiushipe/data_reusability/publications_unzipped/PMC5689701.xml:GSE59102