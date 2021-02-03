* HS performance during Covid - Chile
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Chile)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Chile"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Chile"

********************************************************************************
* Creation do files
* Imports raw data and renames variables for January 2019-December 2019
do "$dofiles/cr_CHI.do"

********************************************************************************
* Cleaning do files
* Cleans data (see cleaning protocol in shared folder)
do "$dofiles/clean_CHI.do"

********************************************************************************
* Format do files
* Formats data for dashboard
do "$dofiles/format_CHI.do"

********************************************************************************
* Analyses do files
* Analyses (2020 vs 2019 comparisons)
* do "$dofiles/an_CHI_01.do"