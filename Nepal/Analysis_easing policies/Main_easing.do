* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 4th 2021
* Main do file
* Created by Catherine Arsenault and Neena Kappoor

*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/nek096/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
*global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"
global dofiles "/Users/nek0906/Documents/HS-performance-during-covid-do-files/Nepal"
global analysis "SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Country-specific papers/Nepal/Policy removal"

**********************************************************************
*Cleans data for months used in this analysis 
do "$dofiles/Analysis_easing policies/clean_easing.do"


**********************************************************************
* Links containment policy data to dhis2 dataset and formats data
do "$dofiles/Analysis_easing policies/cr_easing_01.do"

**********************************************************************
* Analysis do file
* Descriptives and graphs
do "$dofiles/Analysis_easing policies/an_easing_01.do"

* Regression analyses
do "$dofiles/Analysis_easing policies/an_easing_02.do"
