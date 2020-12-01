* HS performance during Covid - Haiti
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Haiti"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Haiti"

* Imports raw data and renames variables for January 2018-July 2020
do "$dofiles/cr_HAITI_01.do"

* Cleans data (see cleaning protocol in shared folder)
do "$dofiles/clean_HAITI.do"

* Formats data for dashboard
do "$dofiles/format_HAITI.do"

* Analyses (2020 vs 2019 comparisons)
do "$dofiles/an_HAITI_01.do"
