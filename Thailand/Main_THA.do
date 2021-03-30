* HS performance during Covid - Thailand
* Master do file 
* PI Catherine Arsenault
* Analyst MK Kim

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Thailand)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Thailand"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Thailand"


/* Imports raw data (Oct 2018 to Nov 2020) and renames variables 
do "$dofiles/cr_THA_01.do" */

* Imports raw data (Oct 2018 to Dec 2020) and renames variables, overwirte previous data
do "$dofiles/cr_THA_02.do"

* Format the data for dashboard 
do "$dofiles/format_THA.do"
