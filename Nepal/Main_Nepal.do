*Master do file: Health system performance during Covid-19 - Nepal
* PI Catherine Arsenault
* Analyst MK Kim
	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Nepal"

**********************************************************************
* Creation do files

* Imports 2019 raw data extracted from dhis2 , renames variables
do "$dofiles/Palika/cr_NEP_01.do"

* Imports Jan 2020 - June 2020 raw data extracted from dhis2, renames variables
* do "$dofiles/Palika/cr_NEP_02.do"

* Imports Jan 2020- Nov 2020 raw data extracted from dhis2, renames variables, merge with 2019 data 
do "$dofiles/Palika/cr_NEP_03.do"

* Imports Nov 2020- Dec 2020 raw data extracted from dhis2, renames variables, merge with Jan19-Nov20 data 
* overwrites Nov2020 data from cr_NEP_03.do file 
do "$dofiles/Palika/cr_NEP_04.do"

**********************************************************************
* Data cleaning
* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/Palika/clean_NEP.do"

**********************************************************************
* Formats data for dashboard
do "$dofiles/Palika/format_NEP.do"

**********************************************************************
* Update: Adding first 6 months of 2021 
do "$dofiles/Palika/cr_NEP_05.do"
do "$dofiles/Palika/clean_NEP_2021.do"
do "$dofiles/Palika/format_NEP_2021.do"
**********************************************************************
* Analyses for policy briefs

* Calculates changes between Q2 2020 and Q2 2019 for policy brief
do "$dofiles/Palika/an_NEP_01.do"

