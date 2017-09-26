import csv
from datetime import datetime
class CsvManipulator(object):
    
    
    def __init__(self):
        pass
    
    
    def read_csv(self,filename='assesment\sample_data_for_test.csv'):
        """
        This function reads a csv 

        Arguments:
            filename: The csv file to be read

        Returns:
            reader : A dictionary whose keys are fieldnames parameter.
        """
        reader=csv.DictReader(open(filename, 'r',newline=''))

        return reader
    
    def hi_lo_total_biomass(self):
        """
        This function returns the farmers with the highest and lowest total biomass Fwt (kg)
        Returns:

            maximum: farmers with highest total biomass fwt (kg)
            minimum : farmet with lowest total biomass fwt (kg)
            rtype:dict
        """
        reader=self.read_csv()
        bio_mass=[{"farmer":row['Farmers Name'],'biomass':float(row['Total biomass Fwt (kg)'])} for row in reader]
        maximum,minimum=max((bio for bio in bio_mass),key=lambda y:y['biomass']),min((bio for bio in bio_mass),key=lambda y:y['biomass'])
        return maximum,minimum
    
    
    def sort_by_harvesting_date(self):
        """
        This function sorts a list according to harvesting date 

        Returns:
            sortedList : a list of dictionaries with sorted values according to harvesting date
            rtype: list
        """
        reader=self.read_csv()

        sortedlist =sorted(reader, key=lambda d: datetime.strptime(d['Harvesting date'], "%d/%m/%Y"), reverse=True)

        return sortedlist

    def average_plants_harvest(self):
        """
        This function computes the average of plants harvest


        Returns:
            average : the average of the plants harvest
            rtype: list
        """
        reader=self.read_csv()
        no_of_plants_havest=[float(row['No of plants harvest']) for row in reader]
        average=sum(no_of_plants_havest)/len(no_of_plants_havest)
        return average

