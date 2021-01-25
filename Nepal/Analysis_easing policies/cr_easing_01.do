* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

global user "/Users/neenakapoor/Dropbox (Harvard University)/HMIS Data for Health System Performance Covid (Nepal)"

*Import policy data 

import excel using "$user/Analyses/District-level Diff-in-diff Analysis/policy_data.xlsx", firstrow

* Merge policy data with health service utilization data 
merge 1:m org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_clean_easing.dta"
drop _merge

drop if year == 2019

*Create pre/post indicator for DID 	- this is for placebo test, not real analysis 		
gen time = 0

replace time = 1 if year == 2020 & month == 4 | year == 2020 & month == 5 | year == 2020 & month == 6

* Treatment is eased_8_20
* Create interaction term - DID 

gen did_eased_8_20 = time*eased_8_20

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_easing_an_011320.dta", replace
