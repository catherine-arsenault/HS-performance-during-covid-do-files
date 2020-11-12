*Master do file: Health system performance during Covid-19 - Nepal
* PI Catherine Arsenault
* Analyst MK Kim
	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"


* FACILITY LEVEL ANALYSES

* Imports raw data extracted from dhis2, renames variables
do "$dofiles/Facility/cr_NEP_01.do"

* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/Facility/clean_NEP_01.do"

* Analysis: calculates changes between Q2 2020 and Q2 2019
do "$dofiles/Facility/an_NEP_01.do"

* Formats data for dashboard
do "$dofiles/Facility/format_NEP_01.do"

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Complete case analysis does not seem to match at the 
Palika level 
* PALIKA LEVEL ANALYSES */

* Imports raw data extracted from dhis2, renames variables
do "$dofiles/Palika/cr_NEP_02.do"

* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/Facility/clean_NEP_02.do"

* Analysis: calculates changes between Q2 2020 and Q2 2019
do "$dofiles/Facility/an_NEP_02.do"

* Formats data for dashboard
do "$dofiles/Facility/format_NEP_02.do"
