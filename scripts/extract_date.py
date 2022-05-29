import os
import xml.etree.ElementTree as ET
import calendar
import datetime

path = '/scratch1/qiushipe/data_reusability/publications_sorted'
file_names = os.listdir(path)

def extract_earliest_date(file):
    try:
        root = ET.parse(file).getroot()
    except:
        return 'error'   
    
    dates = []
    for date in root.iter('pub-date'):
        try: # is there a year?
            y = int(date.findall('./year')[0].text)
        except:
            continue
        try: # is there a month?
            m = int(date.findall('./month')[0].text)
        except:
            m = 12 # last month of the year
        try: # is there a day?
            d = int(date.findall('./day')[0].text)
        except:
            d = int(calendar.monthrange(y, m)[1]) # last day of the month
        this_date = datetime.date(y, m, d)
        dates.append(this_date)

    if len(dates) == 0:
        return 'NaN'
    else:
        dates.sort()
        # choose the earliest date
        earliest_date = dates[0].isoformat()
        return earliest_date

for file_name in file_names:
    file = open(path + '/' + file_name)
    earliest_date = extract_earliest_date(file)
    pmc_ID = file_name.split('.')[0]
    
    saved_file = open('/scratch1/qiushipe/data_reusability/data_lists/preFilterDates.csv', 'a+')
    saved_file.writelines(pmc_ID + ',' + earliest_date + '\n')
    saved_file.close()
    