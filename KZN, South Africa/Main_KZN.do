* Master do file: Health system performance during Covid-19 - Kwazulu Natal
* Catherine Arsenault and Anna Gage

*global user "/Users/acatherine/Dropbox (Harvard University)"
global data "HMIS Data for Health System Performance Covid (South Africa)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/KZN, South Africa"

* Imports raw data, renames and constructs variables
do "$dofiles/cr_KZN_01.do"

* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/clean_KZN.do"

* Analysis: calculates changes between Q2 2020 and Q2 2019
do "$dofiles/an_KZN_01.do"

* Formats data for dashboard
do "$dofiles/format_KZN.do"
