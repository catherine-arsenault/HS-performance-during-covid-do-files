* HS performance during Covid - Ethiopia
* Master do file 
* PI Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Ethiopia"

* Imports raw data and renames variables for January 2019-December 2019
do "$dofiles/cr_ETH_01.do"

* Imports raw data and renames variables for January 2020-June 2020, and merge with 2019 data
*do "$dofiles/cr_ETH_02.do"


* Imports raw data and renames variables for January 2020-August 2020, and merge with 2019 data
* Updates the 2020 data so we no longer use cr_ETH_02

