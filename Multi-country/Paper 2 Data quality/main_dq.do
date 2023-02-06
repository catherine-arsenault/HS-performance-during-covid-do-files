* HS performance during Covid - Data quality, multi-country 
* Master do file 
* PI Catherine Arsenault
* Created by Neena Kapoor 

*global user "/Users/nek096/Dropbox (Harvard University)"
*global dofiles "/Users/nek096/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 2 Data quality"


global user "/Users/catherine.arsenault/Dropbox"
*global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 2 Data quality"
global analysis "SPH Kruk QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 2 Quality dhis2"


*global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"
*global analysis "/Users/annagage/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 2 Quality dhis2"


********************************************************************************
* Creation do files
* Counts outliers and completeness for sentinel indicators 
do "$dofiles/cr_dq_01.do"

* Internal and external consistency  
do "$dofiles/cr_dq_02.do"

********************************************************************************

