* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Created by Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global analysis "/Users/acatherine/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 3 Mortality effects"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 3 Mortality effects"

******************************************************************************** 
* File paths 
global CHLdata "/HMIS Data for Health System Performance Covid (Chile)"
global ETHdata "/HMIS Data for Health System Performance Covid (Ethiopia)"
global GHAdata "/HMIS Data for Health System Performance Covid (Ghana)"
global HTIdata "/HMIS Data for Health System Performance Covid (Haiti)"
global KORdata "/HMIS Data for Health System Performance Covid (South Korea)"
global KZNdata "/HMIS Data for Health System Performance Covid (South Africa)"
global LAOdata "/HMIS Data for Health System Performance Covid (Lao PDR)"
global MEXdata "/HMIS Data for Health System Performance Covid (Mexico)"
global NEPdata "/HMIS Data for Health System Performance Covid (Nepal)"
global THAdata "/HMIS Data for Health System Performance Covid (Thailand)"

******************************************************************************** 
* Creates datasets for analyses
do "$dofiles/cr_deaths_01.do"

********************************************************************************
* ITS Graphs 
do "$dofiles/an_deaths_01.do"

********************************************************************************
* Regressions
do "$dofiles/an_deaths_02.do"

/******************************************************************************** 
* Mortality indicators available in each country 
global CHLall neo_mort_num ipd_mort_num 
global ETHall neo_mort_num sb_mort_num mat_mort_num  ipd_mort_num
global GHAall neo_mort_num sb_mort_num mat_mort_num ipd_mort_num
global HTIall sb_mort_num mat_mort_num 
global KZNall neo_mort_num sb_mort_num mat_mort_num ipd_mort_num trauma_mort_num
global LAOall neo_mort_num sb_mort_num mat_mort_num
global MEXall neo_mort_num  mat_mort_num er_mort_num ipd_mort_num 
global NEPall sb_mort_num neo_mort_num mat_mort_num ipd_mort_num 
global KORall newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num 
global THAall road_mort_num
