import os
import xml.etree.ElementTree as ET

path = '/scratch1/qiushipe/data_reusability/publications_sorted'
file_names = os.listdir(path)

def extract_country(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return 'error'
    labels = root.findall('./front/article-meta/aff/label')
    countries = []
    for i in range(len(labels)):
        aff = labels[i].tail
        country = aff.split(',')[-1].strip()
        #  e.g. Unit of Health Sciences and Education, University of Hamburg, Martin-Luther-King Platz 6, 20146 Hamburg, Germany
        countries.append(aff)
    return countries

for file_name in file_names:
    file = open(path + '/' + file_name)
    try:
        country = extract_country(file)[-1]
    except:
        country = 'error'
    pmc_ID = file_name.split('.')[0]
    
    saved_file = open('/scratch1/qiushipe/data_reusability/data_lists/Country.csv', 'a+')
    saved_file.writelines(pmc_ID + ',' + country + '\n')
    saved_file.close()