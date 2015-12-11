
## Short Description

This project:

1. Collects Portuguese-language newspaper articles about protests in Brazil between March-August 2014 via a batch download from LexisNexis Academic

2. Transforms the 1,429 articles into a clean and useable database

3. Generates metadata to serve as a unique(ish) identifiers about each protest event (city, date) in order to match each description with a separate database of protest articles

4. Conducts inter-coder reliability test (3 raters) performed on a stratified sample of 418 protest events

## Dependencies

1. LexisNexis Academic
2. R version 3.2.2
3. Python 2.7, Anaconda distribution.
4. Qualtrics

## Files

List all other files contained in the repo, along with a brief description of each one, like so:

### Data

1. polity.csv: The PolityVI dataset, available here: http://www.systemicpeace.org/inscrdata.html
2. nyt.csv: Contains data from the New York Times API collected via collect-nyt.ipynb . Includes information on all articles containing the term "Programmer Cat", 1980-2010.
3. analysis-dataset.csv: The final Analysis Dataset derived from the raw data above. It includes country-year values for all UN countries 1980-2010, with observations for the following variables: 
    - *ccode*: Correlates of War numeric code for country observation
    - *year*: Year of observation
    - *polity*: PolityVI score
    - *nyt*: Number of New York Times articles about "Programmer Cat"

### Code

1. 01_collect-nyt.py: Collects data from LexisNexis keyword search for "protest" in 4-month period under study.  and exports data to the file nyt.csv
2. 02_merge-data.R: Loads, cleans, and merges the raw Polity and NYT datasets into the Analysis Dataset.

1. 01_split_ln.py (by Neal Caren): splits batch downloaded .txt files from LexisNexis keyword search for "protest" in the 4-month period under study. exports data to seperate, merge-able .csv files. 
 
***NOTE: Neal Caren's script is written for English-language newspaper articles. Because this project dealt with articles written in Portuguese, I had to first find & replace all instances in which "All Rights Reserved" had been translated to the 'gese ("Todos os Diretos Reservado").

2. 02_query_cities.ipynb: pre-processes and then searches articles for key words "manifest" and "protest" within 30 words of one of the 10 cities in question. adds key: value pair to protest list of dictionaires with T(1) or F(0) information if there was a hit.

3. 03_clean, merge, match.R: loads, cleans, and merges the LexisNexis data with the other database of protests (called Folha), matching on city/date metadata.

4. 04_sample_for_irr.R: conducts a stratified random sample of the protests to use for inter-rater reliability tests.

5. 05_map_of_protests.R: plots protests by city proportional to size.

### Data

lexis_nexis_data: raw .txt files from batch download of Portuguese-language articles that contain the word protest between March and August of 2014

all_protests.csv: merged version of all LN articles

folha.csv: 418 protests covered by the newspaper Folha de São Paulo during the same time interval

irr_sample.csv: stratified sample (proportional to city) to use in IRR tests

### Results

1. protest_map_color.jpeg: geospatial depiction of protest distribution across 10 cities

2. irr.txt: summarizes the results of inter-coder reliability test. (coming soon: waiting for Portuguese-speaking raters to finish!)

## More Information

contact - Liz McKenna (emckenna@berkeley.edu)
many, many thanks to Rochelle (@rochelleterman) and Frannie (@franniez) for all your help on the python code!
