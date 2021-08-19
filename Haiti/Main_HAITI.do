* HS performance during Covid - Haiti
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Haiti"


* Imports raw data and renames variables for January 2018-July 2020
* Overwrite with the latest data
*do "$dofiles/cr_HAITI_01.do"

* Imports raw data and renames variables for January 2019-March 2021
do "$dofiles/cr_HAITI_02.do"

* Cleans data (see cleaning protocol in shared folder) and creates a dataset for analyses
do "$dofiles/clean_HAITI.do"

* Formats data for dashboard
do "$dofiles/format_HAITI.do"

* Analyses (2020 vs 2019 comparisons)
do "$dofiles/an_HAITI_01.do"
