* HS performance during Covid - Thailand
* Master do file 
* PI Catherine Arsenault
* Analyst MK Kim

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Thailand)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Thailand"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Thailand"


* Imports raw data and renames variables 
do "$dofiles/cr_THA_01.do"


* Format the data for dashboard 
do "$dofiles/format_THA.do"