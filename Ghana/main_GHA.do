* HS performance during Covid - South Korea
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ghana)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Ghana"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
*global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Ghana"

********************************************************************************
* Creation do files
* Imports raw data and renames variables for January 2019 - August 2020
* do "$dofiles/cr_GHA_01.do"

* Creation do files
* Imports raw data and renames variables for January 2019 - Dec 2020
* Overwrite previous data 
do "$dofiles/cr_GHA_02.do"
********************************************************************************
* Cleaning do files
* Remove outliers at regional level
do "$dofiles/clean_GHA.do"

********************************************************************************
* Format do files
* Formats data for dashboard
do "$dofiles/format_GHA.do"

********************************************************************************
* Analyses do files
* Analyses (2020 vs 2019 comparisons)
* do "$dofiles/an_CHI_01.do"
