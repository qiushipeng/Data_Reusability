import os
import xml.etree.ElementTree as ET

path = '/scratch1/qiushipe/data_reusability/publications_sorted'
file_names = os.listdir(path)

### find the serial number of last author's affliation
def get_aff_num(root):
    contribs = root.findall('./front/article-meta/contrib-group/contrib[@contrib-type="author"]')
    xrefs = contribs[-1].findall('./xref[@ref-type="aff"]')
    aff_num = None
    try:
        # e.g. <xref ref-type="aff" rid="af2-ijms-22-00514">2</xref>
        try:
            aff_num = int(xrefs[0].text)
            return aff_num
        except:
            # e.g. <xref rid="af0010" ref-type="aff">b</xref>
            if ord(xrefs[0].text) > 96 and ord(xrefs[0].text) < 123:
                aff_num = ord(xrefs[0].text) - 96
                return aff_num
    except:
        pass
    
    if aff_num == None:
        try:
            # e.g. <xref ref-type="aff" rid="evy198-aff4">4</xref>
            aff_num = int(xrefs[0].attrib['rid'].split('aff')[-1])
            return aff_num
        except:
            pass

    if aff_num == None:
        try:
            # e.g. <xref ref-type="aff" rid="A1">1</xref>
            aff_num = int(xrefs[0].attrib['rid'].split('A')[-1])
            return aff_num
        except:
            pass

    return aff_num


### find all countries mentioned in a xml file
def parse_file(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return 'RootError'
    
    ## find the serial number of last author's affliation
    try:
        aff_num = get_aff_num(root)
    except:
        print(file.name, 'AuthorError')

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
            countries = []
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
            countries = []
            tag_country = root.findall('./front/article-meta/aff/country')
            for i in range(len(tag_country)):
                country = tag_country[i].text
                countries.append(country)
    except: 
        pass
    
    ##4 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            addr_lines = root.findall('./front/article-meta/aff/addr-line')
            for i in range(len(addr_lines)):
                aff = addr_lines[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass
    
    ##5 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            labels = root.findall('./front/article-meta/contrib-group/aff/label')
            for i in range(len(labels)):
                aff = labels[i].tail
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass

    ##6 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            addr_lines = root.findall('./front/article-meta/contrib-group/aff/addr-line')
            for i in range(len(addr_lines)):
                aff = addr_lines[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass

    ##7 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            tag_country = root.findall('./front/article-meta/contrib-group/aff/country')
            for i in range(len(tag_country)):
                country = tag_country[i].text
                countries.append(country)
    except:
        pass

    ##8 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            sups = root.findall('./front/article-meta/aff/sup')
            for i in range(len(sups)):
                aff = sups[i].tail
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass

    ##9 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            affs = root.findall('./front/article-meta/aff')
            for i in range(len(affs)):
                aff = affs[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass

    ##10 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            affs = root.findall('./front/article-meta/contrib-group/aff')
            for i in range(len(affs)):
                aff = affs[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass

    ##11 different arrangement of xml files
    try:
        if all(i == '' for i in countries):
            countries = []
            institutions = root.findall('front/article-meta/contrib-group/aff/institution')
            for i in range(len(institutions)):
                aff = institutions[i].text
                country = aff.split(',')[-1].strip()
                countries.append(country)
    except:
        pass
    
    if len(countries) == 1 and countries[0] != '':
        return countries[0]
    else:
        return countries[aff_num - 1]


for file_name in file_names:
    file = open(path + '/' + file_name)
    try:
        country = parse_file(file)
    except:
        country = 'N/A'
        print(file.name, 'N/A')
    if country == None: country = 'None'
    pmc_ID = file_name.split('.')[0]
    saved_file = open('/scratch1/qiushipe/data_reusability/data_lists/country.csv', 'a+')
    saved_file.writelines(pmc_ID + ',' + country + '\n')
    saved_file.close()