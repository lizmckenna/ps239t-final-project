
## Short Description

Give a short, 1-2 paragraph description of your project. Focus on the code, not the theoretical / substantive / academic side of things. 

This project:\

1. Collects Portuguese-language newspaper articles about protests in Brazil between March-August 2014 via a batch download from LexisNexis Academic\

2. Transforms the 1,429 articles into a clean and useable database\

3. Generates metadata to serve as a unique(ish) identifiers about each protest event (city, date) in order to match each description with a separate database of protest articles\

4. Conducts and reports findings of an inter-coder reliability test (3 raters) performed on a stratified sample of 418 protest events

## Dependencies

List what software your code depends on, as well as version numbers, like so:.

1. LexisNexis Academic
2. R version 3.2.2
3. Python 2.7, Anaconda distribution.

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

1. 01_collect-nyt.py: Collects data from New York Times API and exports data to the file nyt.csv
2. 02_merge-data.R: Loads, cleans, and merges the raw Polity and NYT datasets into the Analysis Dataset.
2. 03_analysis.R: Conducts descriptive analysis of the data, producing the tables and visualizations found in the Results directory.

### Results

1. coverage-over-time.jpeg: Graphs the number of articles about each region over time.
2. regression-table.txt: Summarizes the results of OLS regression, modelling *nyt* on a number of covariates.

## More Information

Include any other details you think your user might need to reproduce your results. You may also include other information such as your contact information, credits, etc.
