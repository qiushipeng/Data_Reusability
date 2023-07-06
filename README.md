# Global landscape of primary omics data generation and its secondary analysis across 193 countries and territories


## Download data

Download the most recent open access subset of PubMed Central (PMC) publications. Download metadata reference tables for every public SRA and GEO dataset.

Note: this data is large. Create a directory outside this repository to store the data, and point each script to that directory where appropriate.

```bash
cd scripts
./download_publications.sh
./download_refs.py
cd ../
```

## Select papers mentioning SRA or GEO

Parse the text of every publication for regular expressions matching SRA and GEO accession IDs.

```bash
cd scripts
./extract_GEO_SRA.sh
cd ../
```

## Extract the publication date from every selected paper

Parse the XML files to find the earliest listed publish date and countries.

```bash
cd scripts
./extract_date.sh
./extract_country.sh
cd ../
```

## Create a master table containing all the data

### Launch jupyter notebook


```bash
cd jupyter_notebooks
jupyter notebook
```

Merge data scraped from the PMC publications onto reference data from SRA and GEO.

* Run jupyter_notebooks/Create_Metadata_Table.ipynb
* Run jupyter_notebooks/Analyze_Metadata_Table.ipynb

## Create figures

Use everything generated so far to visualize findings.

* Run jupyter_notebooks/Visulization.ipynb
