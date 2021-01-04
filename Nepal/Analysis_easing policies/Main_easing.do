* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 4th 2021
* Main do file
* Created by Catherine Arsenault and Neena Kappoor

global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"

* Imports raw data extracted from dhis2, renames variables
do "$dofiles/Palika/cr_NEP_01.do"

* Cleans the data 
do "$dofiles/Analysis_easing policies/clean_easing.do"

* Descriptives

* Regression analyses
