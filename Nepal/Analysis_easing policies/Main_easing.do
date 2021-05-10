* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 4th 2021
* Main do file
* Created by Catherine Arsenault and Neena Kappoor

global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/neenakapoor/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"
*global dofiles "/Users/neenakapoor/Desktop/HS-performance-during-covid-do-files/Nepal"
global analysis "/QuEST Network/Core Research/HS performance Covid (internal)/Country-specific papers/Nepal/Policy removal"


**********************************************************************
* Links containment policy data to dhis2 dataset and formats data
do "$dofiles/Analysis_easing policies/cr_easing_01.do"

**********************************************************************
* Analysis do file
* Descriptives
do "$dofiles/Analysis_easing policies/an_easing_01.do"

* Regression analyses
do "$dofiles/Analysis_easing policies/an_easing_02.do"
