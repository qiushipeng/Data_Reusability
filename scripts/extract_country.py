import os
import xml.etree.ElementTree as ET

path = '/scratch1/qiushipe/data_reusability/publications_sorted'
file_names = os.listdir(path)


### find all countries mentioned in a xml file
def parse_file(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return 'error'
    
    ## find the number of last author's affliation
    try:
        contribs = root.findall('./front/article-meta/contrib-group/contrib[@contrib-type="author"]')
        xrefs = contribs[-1].findall('./xref')
        aff_num = int(xrefs[0].attrib['rid'][3:])
    except:
        return 'error'
    
    countries = []

    ##1 different arrangement of xml files
    try:
        labels = root.findall('./front/article-meta/aff/label')
        for i in range(len(labels)):
            aff = labels[i].tail
                #  e.g. Unit of Health Sciences and Education, University of Hamburg, Martin-Luther-King Platz 6, 20146 Hamburg, Germany
            country = aff.split(',')[-1].strip()
            countries.append(country)
    except:
        pass
    
    ##2 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            institution_wrap = root.findall('./front/article-meta/contrib-group/aff/institution-wrap')
            for i in range(len(institution_wrap)):
                aff = institution_wrap[i].tail
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass
    
    ##3 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            tag_country = root.findall('./front/article-meta/aff/country')
            for i in range(len(tag_country)):
                country = tag_country[i].text
                countries.append(country)
    except: 
        pass
    
    ##4 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            addr_line = root.findall('./front/article-meta/aff/addr-line')
            for i in range(len(addr_line)):
                aff = addr_line[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass
    
    return countries[aff_num - 1]


for file_name in file_names:
    file = open(path + '/' + file_name)
    try:
        country = parse_file(file)
    except:
        country = 'N/A'
    pmc_ID = file_name.split('.')[0]
    saved_file = open('/scratch1/qiushipe/data_reusability/data_lists/country.csv', 'a+')
    saved_file.writelines(pmc_ID + ',' + country + '\n')
    saved_file.close()