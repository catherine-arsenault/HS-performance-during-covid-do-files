* Master do file: Health system performance during Covid-19 - IMSS
* PI Catherine Arsenault
* Analyst MK Kim


global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Mexico"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Mexico"

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

/* Recodes data from August 2020, merges with prior data, corrects an error with 
delivery/caesarean indicators. */
do "$dofiles/cr_MEX_05.do"

/* Add mortality data from June20 to Oct20, merges with prior data. */
do "$dofiles/cr_MEX_06.do"

/*Reformats data for dashboard: Calculates national totals, reshapes to long form,
and creates the final csv file for the dashboard. */ 
do "$dofiles/format_MEX.do"
