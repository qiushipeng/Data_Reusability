import os
import xml.etree.ElementTree as ET
from geograpy import extraction, places

path = '/scratch1/qiushipe/data_reusability/publications_sorted'
file_names = os.listdir(path)


### extract countries from a given string
def extract_country(text):
    e = extraction.Extractor(text = text)
    e.find_geoEntities()
    plc = places.PlaceContext(e.places)
    plc.set_countries()
    return plc.countries[-1]


### find all countries mentioned in a xml file
def parse_file(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return ['error']
    

    labels = root.findall('./front/article-meta/aff/label')
    countries = []
    for i in range(len(labels)):
        aff = labels[i].tail
            #  e.g. Unit of Health Sciences and Education, University of Hamburg, Martin-Luther-King Platz 6, 20146 Hamburg, Germany
        country = extract_country(aff)
        countries.append(country)
    
    ## different arrangement in xml files
    if countries == []:
        institution_wrap = root.findall('./front/article-meta/contrib-group/aff/institution-wrap')
        for i in range(len(institution_wrap)):
            aff = institution_wrap[i].tail
            country = extract_country(aff)
            countries.append(country)

    return countries


for file_name in file_names:
    file = open(path + '/' + file_name)
    try:
        country = parse_file(file)[-1]
    except:
        country = 'N/A'
    pmc_ID = file_name.split('.')[0]
    saved_file = open('/scratch1/qiushipe/data_reusability/data_lists/country.csv', 'a+')
    saved_file.writelines(pmc_ID + ',' + country + '\n')
    saved_file.close()