* HS performance during Covid - Ethiopia
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Ethiopia"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Ethiopia"


********************************************************************************
* Creation do files

* Imports raw data and renames variables for January 2019-December 2019
*do "$dofiles/cr_ETH_01.do"

* Imports raw data and renames variables for January 2020-June 2020, and merge with 2019 data
*do "$dofiles/cr_ETH_02.do"

* Imports raw data and renames variables for January 2020-August 2020, and merge with 2019 data
* Updates the 2020 data to more recently extracted so we no longer use cr_ETH_02
* do  "$dofiles/cr_ETH_03.do"

* Edits to KMC and newborn resuscitation indicators (Jan 2019-August2020)
* Imports raw indicators, recodes and merge with latest dataset
* do  "$dofiles/cr_ETH_04.do"

* Imports raw data and renames variables for January 2019-Oct 2020 
* Data from Jan 2019 to Oct 2020 (Tirr2011 to Tikemet 2013 was sent again)
* Overwrites previous do files
*do "$dofiles/cr_ETH_05.do"

* Imports raw data and renames variables for January 2019 - Dec 2020 
* Overwrites previous do files 
do "$dofiles/cr_ETH_06.do"

*TB quarterly data
do "$dofiles/cr_ETH_TB_01.do"

********************************************************************************
* Cleaning do files

* Cleans data (see cleaning protocol in shared folder)
do "$dofiles/clean_ETH.do"

* Cleans TB data
do "$dofiles/clean_ETH_TB.do"

********************************************************************************
* Format do files

* Formats data for dashboard
do "$dofiles/format_ETH.do"

********************************************************************************
* Analyses do files

* Analyses (2020 vs 2019 comparisons) (comparing Q1 and Q2 in 2020)
 do "$dofiles/an_ETH_01.do"
