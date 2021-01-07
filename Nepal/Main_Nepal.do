*Master do file: Health system performance during Covid-19 - Nepal
* PI Catherine Arsenault
* Analyst MK Kim
	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"
*global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"


* Imports 2019 raw data extracted from dhis2 , renames variables
do "$dofiles/Palika/cr_NEP_01.do"

* Imports Jan 2020 - June 2020 raw data extracted from dhis2, renames variables
* do "$dofiles/Palika/cr_NEP_02.do"

* Imports Jan 2020 - June 2020 raw data extracted from dhis2, renames variables
do "$dofiles/Palika/cr_NEP_01.do"


* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/Palika/clean_NEP.do"

* Analysis: calculates changes between Q2 2020 and Q2 2019
do "$dofiles/Palika/an_NEP_01.do"

* Formats data for dashboard
do "$dofiles/Palika/format_NEP.do"
