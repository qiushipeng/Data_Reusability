#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=6:00:00

mkdir -p /scratch/qiushipe/data_reusability/publications
mkdir -p /scratch/qiushipe/data_reusability/publications_unzipped
cd /scratch/qiushipe/data_reusability/publications

# download commercial use subset
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC000xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC001xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC002xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC003xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC004xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC005xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC006xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC007xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_comm/xml/oa_comm_xml.PMC008xxxxxx.baseline.2022-03-04.tar.gz

# download non-commercial use subset
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC001xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC002xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC003xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC004xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC005xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC006xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC007xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_noncomm/xml/oa_noncomm_xml.PMC008xxxxxx.baseline.2022-03-04.tar.gz

# download other subset (no machine-readable license, no license, or a custom license)
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC000xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC001xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC002xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC003xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC004xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC005xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC006xxxxxx.baseline.2022-03-04.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC007xxxxxx.baseline.2022-03-04.tar.gz 
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/oa_bulk/oa_other/xml/oa_other_xml.PMC008xxxxxx.baseline.2022-03-04.tar.gz

# unzip everything
for file in *.tar.gz; do
    tar zxvf $file --strip-components=1 -C /scratch/qiushipe/data_reusability/publications_unzipped
done