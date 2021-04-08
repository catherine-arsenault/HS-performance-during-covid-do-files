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

* Recodes data from June 2020
do "$dofiles/cr_MEX_03.do"

* Recodes data from July 2020,
do "$dofiles/cr_MEX_04.do"

* Recodes data from August 2020 and corrects deliveries-c-sections
do "$dofiles/cr_MEX_05.do"

* Recodes COVID mortality data from June 2020 to Oct 2020
do "$dofiles/cr_MEX_06.do"

* Recodes data from September 2020 
do "$dofiles/cr_MEX_07.do"

* Adding 1 cancer indicator 
do "$dofiles/cr_MEX_08.do"

* Recodes data from October 2020, updates vaccine data
do "$dofiles/cr_MEX_09.do"

* Recodes COVID mortality data from June 2020 to Dec 2020
do "$dofiles/cr_MEX_10.do"

* Recodes data from November 2020
do "$dofiles/cr_MEX_11.do"

* Recodes data from Dec 2020
do "$dofiles/cr_MEX_12.do"

* Recodes breast cancer 
do "$dofiles/cr_MEX_13.do"

* Update december 2020 data
do "$dofiles/cr_MEX_14.do"

* Final data for January-Dec2020 ART, this completes the 24-month data 
do "$dofiles/cr_MEX_15.do"


********************************************************************************
* Format do files

/*Reformats data for dashboard: Calculates national totals, reshapes to long form,
and creates the final csv file for the dashboard. */ 
do "$dofiles/format_MEX.do"

********************************************************************************
* Analyses do files

* Analysis: calculates changes between March-August 2020 and March-August 2019 
do "$dofiles/an_MEX_01.do"
