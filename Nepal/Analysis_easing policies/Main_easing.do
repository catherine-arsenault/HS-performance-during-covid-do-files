* Effect of easing Covid-19 containment policies on health service delivery in Nepal: a difference-in-differences evaluation
* January 4th 2021
* Main do file

global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"


* Imports raw data extracted from dhis2, renames variables
do "$dofiles/Palika/cr_NEP_01.do"

* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/Palika/clean_NEP.do"
