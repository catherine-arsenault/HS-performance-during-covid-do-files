*Master do file: Health system performance during Covid-19 - Nepal
* PI Catherine Arsenault
* Analyst MK Kim


global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"

* Facility-level analyses
* Imports raw data extracted from dhis2, renames variables
do "$user/dofiles/Facility/cr_NEP_01.do"

* Cleans the data (see cleaning protocol in shared folder)
do "$user/dofiles/Facility/clean_NEP_01.do"

* Analysis: calculates changes between Q2 2020 and Q2 2019
do 

* Cleans the data (see cleaning protocol in shared folder)
do "$user/dofiles/Facility/clean_NEP_01.do"
