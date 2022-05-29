#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16GB
#SBATCH --time=12:00:00


# download GEO reference data
# max page size is 5000, number of pages is total number of "sample" datasets / 5000
# page sizes updated 2022-03-16

# series
echo "Accession,Title,Series_Type,Taxonomy,Sample_Count,Datasets,Supplementary_Types,Supplementary_Links,PubMed_ID,SRA_Accession,Contact,Release_Date" > ./geo_series.csv
for i in `seq 35`
do
    wget -O ./series_${i}.csv "https://www.ncbi.nlm.nih.gov/geo/browse/?view=series&sort=date&mode=csv&page=${i}&display=5000"
    sed 1d ./series_${i}.csv >> ./geo_series.csv
    rm ./series_${i}.csv
done



# samples
echo "Accession,Title,Sample_Type,Taxonomy,Channels,Platform,Series,Supplementary_Types,Supplementary_Links,SRA_Accession,Contact,Release_Date" > ./geo_samples.csv
for i in `seq 991`
do
    wget -O ./samples_${i}.csv "https://www.ncbi.nlm.nih.gov/geo/browse/?view=samples&sort=date&mode=csv&page=${i}&display=5000"
    sed 1d ./samples_${i}.csv >> ./geo_samples.csv
    rm ./samples_${i}.csv
done

# platforms
echo "Accession,Title,Technology,Taxonomy,Data_Rows,Samples_Count,Series_Count,Contact,Release_Date" > ./geo_platforms.csv
for i in `seq 5`
do
    wget -O ./platforms_${i}.csv "https://www.ncbi.nlm.nih.gov/geo/browse/?view=platforms&sort=date&mode=csv&page=${i}&display=5000"
    sed 1d ./platforms_${i}.csv >> ./geo_platforms.csv
    rm ./platforms_${i}.csv
done


# download SRA reference data
echo "Run,ReleaseDate,LoadDate,spots,bases,spots_with_mates,avgLength,size_MB,AssemblyName,download_path,Experiment,LibraryName,LibraryStrategy,LibrarySelection,LibrarySource,LibraryLayout,InsertSize,InsertDev,Platform,Model,SRAStudy,BioProject,Study_Pubmed_id,ProjectID,Sample,BioSample,SampleType,TaxID,ScientificName,SampleName,g1k_pop_code,source,g1k_analysis_group,Subject_ID,Sex,Disease,Tumor,Affection_Status,Analyte_Type,Histological_Type,Body_Site,CenterName,Submission,dbgap_study_accession,Consent,RunHash,ReadHash" > ./sra_complete_runs.csv

# sources = ("GENOMIC" "TRANSCRIPTOMIC" "METAGENOMIC" "METATRANSCRIPTOMIC" "SYNTHETIC" "VIRAL RNA" "GENOMIC SINGLE CELL" "TRANSCRIPTOMIC SINGLE CELL" "OTHER")# GENOMIC
# GENOMIC
nohup wget -O ./sra_runs_GENOMIC_2022.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=5" &
nohup wget -O ./sra_runs_GENOMIC_2021.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=3" &
nohup wget -O ./sra_runs_GENOMIC_2020.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623f598d6ab7df183b5a3e44&query_key=5" &
nohup wget -O ./sra_runs_GENOMIC_2019.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=7" &
nohup wget -O ./sra_runs_GENOMIC_2018.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623f5e9d521b3a11c37353e1&query_key=2" &
nohup wget -O ./sra_runs_GENOMIC_2017.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=10" &
nohup wget -O ./sra_runs_GENOMIC_2016.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=11" &
nohup wget -O ./sra_runs_GENOMIC_2015.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62462956eb13131e3248cd4a&query_key=13" &
nohup wget -O ./sra_runs_GENOMIC_2014.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624796b1ec493f14f2463cbb&query_key=1" &
nohup wget -O ./sra_runs_GENOMIC_2013.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624796b1ec493f14f2463cbb&query_key=3" &
nohup wget -O ./sra_runs_GENOMIC_2007-2012.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624796b1ec493f14f2463cbb&query_key=5" &

# TRANSCRIPTOMIC


nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2008-2012.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=7" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2013.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=5" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=4" &

# Jan to May
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_1half_paired_1.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624d1b72dd767122395a6535&query_key=3" &
# April 有问题
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_1half_paired_2_.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62772fe951d1c8421c64e98c&query_key=2" &
# May
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_1half_paired_3.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624df79bd9a49b58b31c7062&query_key=5" &
# Jun
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_1half_paired_4.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624df79bd9a49b58b31c7062&query_key=7" & 

nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_1half_single.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624ca01fc20c323cce2c1ae8&query_key=3" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2014_2half.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=10" &

nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2015.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624a80fbd9678a2b905b8fd1&query_key=4" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2016.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624a80fbd9678a2b905b8fd1&query_key=2" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2017.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_62488af9dd767122395a43e3&query_key=14" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2018_1half.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=2" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2018_2half.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_624b585115c67f0289367e84&query_key=3" &

nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2019.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_6248efeb99f02a7209383b33&query_key=1" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2020.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_6248efeb99f02a7209383b33&query_key=2" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2021.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_6249e72d561c8361d36dd2d0&query_key=1" &
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_2022.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_6249e72d561c8361d36dd2d0&query_key=2" &

# METAGENOMIC
nohup wget -O ./sra_runs_METAGENOMIC.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623cb1d0dd76880795550351&query_key=2" &
# METATRANSCRIPTOMIC
nohup wget -O ./sra_runs_METATRANSCRIPTOMIC.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623dfce49cac61372d6d1b11&query_key=2" &
# SYNTHETIC
nohup wget -O ./sra_runs_SYNTHETIC.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623e000867f2777601273ce9&query_key=1" &
# VIRAL RNA
nohup wget -O ./sra_runs_VIRAL_RNA.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623e000867f2777601273ce9&query_key=2" &
# GENOMIC SINGLE CELL
nohup wget -O ./sra_runs_GENOMIC_SINGLE_CELL.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623e000867f2777601273ce9&query_key=3" &
# TRANSCRIPTOMIC SINGLE CELL
nohup wget -O ./sra_runs_TRANSCRIPTOMIC_SINGLE_CELL.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623e0111517c1063d3271379&query_key=6" &
# OTHER
nohup wget -O ./sra_runs_OTHER.csv "https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?save=efetch&rettype=runinfo&db=sra&WebEnv=MCID_623e0111517c1063d3271379&query_key=7" &


#Removes first line and concatenates all csvs
sed 1d ./sra_runs_* >> ./sra_complete_runs.csv