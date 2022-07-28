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
            # e.g. <aff id="jeb13731-aff-0002">
            aff_num = int(xrefs[0].attrib['rid'].split('-aff-')[-1])
        except:
            pass

    if aff_num == None:
        try:
            # e.g. <xref ref-type="aff" rid="evy198-aff4">4</xref>
            aff_num = int(xrefs[0].attrib['rid'].casefold().split('aff')[-1])
            return aff_num
        except:
            pass

    if aff_num == None:
        try:
            # e.g. <xref ref-type="aff" rid="af0001">
            aff_num = int(xrefs[0].attrib['rid'].casefold().split('af')[-1])
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
        
    if aff_num == None:
        try:
            # e.g. <xref ref-type="aff" rid="I1">
            aff_num = int(xrefs[0].attrib['rid'].split('I')[-1])
            return aff_num
        except:
            pass

    return aff_num

def find_country_1(element):
    
    country = ''
    
    ##1 different arrangement of xml files
    try:
        label = element.find('./label')
        aff = label.tail
            #  e.g. Unit of Health Sciences and Education, University of Hamburg, Martin-Luther-King Platz 6, 20146 Hamburg, Germany
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass
    
    ##3 different arrangement of xml files
    try:
        tag_country = element.find('./country')
        country = tag_country.text
        if country != '': return country
    except: 
        pass
    
    ##4 different arrangement of xml files
    try:
        addr_line = element.find('./addr-line')
        aff = addr_line.text
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass

    ##8 different arrangement of xml files
    try:
        sup = element.find('./sup')
        aff = sup.tail
        country = aff.split(',')[-1].strip()            
        if country != '': return country
    except:
        pass

    ##9 different arrangement of xml files
    try:
        aff = element.text
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass


def find_country_2(element):
    
    country = ''
    
    ##2 different arrangement of xml files
    try:
        institution_wrap = element.find('./institution-wrap')
        aff = institution_wrap.tail
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass
    
    
    ##5 different arrangement of xml files
    try:
        label = element.find('./label')
        aff = label.tail
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass

    ##6 different arrangement of xml files
    try:
        addr_line = element.find('./addr-line')
        aff = addr_line.text
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass

    ##7 different arrangement of xml files
    try:
        tag_country = element.find('./country')
        country = tag_country.text
        if country != '': return country
    except:
        pass

    ##10 different arrangement of xml files
    try:
        aff = element.text
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass

    ##11 different arrangement of xml files
    try:
        institution = element.find('./institution')
        aff = institution.text
        country = aff.split(',')[-1].strip()
        if country != '': return country
    except:
        pass



### find all countries mentioned in a xml file
def parse_file(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return 'RootError'
    
    ## find the serial number of last author's affliation
    try:
        aff_num = get_aff_num(root)
        if aff_num == None:
            print(file.name, 'AffNumError')
    except:
        print(file.name, 'AuthorError')

    countries = []
    
    try:
        if all(i == '' for i in countries):
            countries = []
            countries = root.findall('./front/article-meta/contrib-group/contrib/aff/country')
            return countries[-1].text        
    except:
        pass
    
    if all(i == '' for i in countries):
        try:
            for i in root.findall('./front/article-meta/aff'):
                try:
                    country = find_country_1(i)
                except:
                    country = 'N/A'
                countries.append(country)
        except:
            pass

    if all(i == '' for i in countries):
        try:
            for i in root.findall('./front/article-meta/contrib-group/aff'):
                try:
                    country = find_country_2(i)
                except:
                    country = 'N/A'
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