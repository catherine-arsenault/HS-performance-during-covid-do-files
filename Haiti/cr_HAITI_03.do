* HS performance during Covid
* Haiti 2021, region level 

clear all 
set more off 
********************************************************************************
import excel  using "$user/$data/Raw data/2021 data Jan-Jun2021vs12162021_formatted.xlsx", firstrow clear
save "$user/$data/Data for analysis/Haiti_2021.dta", replace

import excel  using "$user/$data/Raw data/2021 data Jan-Jun2021vs12162021_formatted.xlsx", firstrow sheet("Femmes enceintes") clear
merge 1:1 Departement using "$user/$data/Data for analysis/Haiti_2021.dta"
drop _merge 
save "$user/$data/Data for analysis/Haiti_2021.dta", replace

import excel  using "$user/$data/Raw data/2021 data Jan-Jun2021vs12162021_formatted.xlsx", firstrow sheet("Accouchements") clear
merge 1:1 Departement using "$user/$data/Data for analysis/Haiti_2021.dta"
drop _merge 
save "$user/$data/Data for analysis/Haiti_2021.dta", replace

import excel  using "$user/$data/Raw data/2021 data Jan-Jun2021vs12162021_formatted.xlsx", firstrow sheet("Diabetes") clear
merge 1:1 Departement using "$user/$data/Data for analysis/Haiti_2021.dta"
drop _merge 

drop anc* fp*
reshape long diab_util del_util, i(Departement) j(month)
gen year= 2021
rename Departement departement
save "$user/$data/Data for analysis/Haiti_2021.dta", replace
