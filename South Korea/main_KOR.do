* HS performance during Covid - South Korea
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (South Korea)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/South Korea"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/South Korea"

********************************************************************************
* Creation do files
* Imports raw data and renames variables for January 2019 - August 2020
do "$dofiles/cr_KOR.do"

********************************************************************************
* Cleaning do files - Not needed since it's province level data
* Cleans data (see cleaning protocol in shared folder) 
*do "$dofiles/clean_KOR.do"

********************************************************************************
* Format do files
* Formats data for dashboard
do "$dofiles/format_KOR.do"

********************************************************************************
* Analyses do files
* Analyses (2020 vs 2019 comparisons)
* do "$dofiles/an_CHI_01.do"
