* HS performance during Covid - Lao PDR
* Master do file 
* Created by: Catherine Arsenault
* January 12, 2021

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Lao PDR)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Lao PDR"
global dofiles "/Users/minkyungkim/Documents/GitHub/HS-performance-during-covid-do-files/Lao PDR"

********************************************************************************
* Creation do files
* Imports Jan 2019 - Oct 2020 raw data, renames variables 
do "$dofiles/cr_Lao_01.do"

********************************************************************************
* Cleaning do files
* Cleans the data (see cleaning protocol in shared folder)
do "$dofiles/clean_Lao.do"

********************************************************************************
* Format do files for dashboard
do "$dofiles/format_Lao.do"

********************************************************************************
* Analysis: calculates changes in Q2 (April-June 2019vs2020) Q3 (July-Sep 2019 vs 2020) 
do "$dofiles/an_Lao.do"
