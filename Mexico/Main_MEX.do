* Master do file: Health system performance during Covid-19 - IMSS
* PI Catherine Arsenault
* Analyst MK Kim

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Mexico"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Mexico"

********************************************************************************
* Creation do files
* Recodes data from January 2019 to Feb 2020
do "$dofiles/cr_MEX_01.do"

/* Recodes indicators for March to May 2020, merges with Jan-Feb, appends Covid 
mortality data */
do "$dofiles/cr_MEX_02.do"

* Recodes data from June 2020, merges with prior data
do "$dofiles/cr_MEX_03.do"

* Recodes data from July 2020, merges with prior data
do "$dofiles/cr_MEX_04.do"

* Recodes data from August 2020 and corrects deliveries-c-sections
do "$dofiles/cr_MEX_05.do"

* Recodes COVID mortality data from June 2020 to Oct 2020
do "$dofiles/cr_MEX_06.do"

* Recodes data from September 2020 and merges with prior data
do "$dofiles/cr_MEX_07.do"

* Adding 1 cancer indicator and merging with prior data
do "$dofiles/cr_MEX_08.do"

* Recodes data from October 2020, merges with prior data 
do "$dofiles/cr_MEX_09.do"

* Recodes COVID mortality data from June 2020 to Dec 2020
do "$dofiles/cr_MEX_10.do"

* Recodes data from November 2020, merges with prior data 
do "$dofiles/cr_MEX_11.do"

********************************************************************************
* Format do files

/*Reformats data for dashboard: Calculates national totals, reshapes to long form,
and creates the final csv file for the dashboard. */ 
do "$dofiles/format_MEX.do"

********************************************************************************
* Analyses do files

* Analysis: calculates changes between March-August 2020 and March-August 2019 
do "$dofiles/an_MEX_01.do"
