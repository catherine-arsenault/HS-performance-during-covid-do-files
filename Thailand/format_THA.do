* HS performance during Covid
* Created Dec 8, 2020 
* Thailand, January 2019 -   data at Province level 


u  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_clean.dta", clear


********************************************************************************
* CREATE NATIONAL TOTALS FOR MONTHLY DATA
******************************************************************************** 
foreach v in opd_util ipd_util dental_util diab_util dengue_util diarr_util heart_util hyper_util stroke_util predel_util totaldel road_util road_mort_num mal_qual pneum_qual anc_util {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/Thailand_Oct18-Dec20_monthly_clean.dta", replace

********************************************************************************
* RESHAPE FOR DASHBOARD FOR MONTHLY DATA 
********************************************************************************
u "$user/$data/Data for analysis/Thailand_Oct18-Dec20_monthly_clean.dta", clear 

global varlist opd_util ipd_util dental_util diab_util dengue_util diarr_util heart_util hyper_util stroke_util predel_util totaldel road_util road_mort_num mal_qual pneum_qual anc_util			   

preserve
	keep if year==2020
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	save "$user/$data/Data for analysis/temp20.dta", replace
restore 

preserve
	keep if year==2019
	foreach v of global varlist {
	rename(`v')(`v'19)
	}
	save "$user/$data/Data for analysis/temp19.dta", replace
restore 

preserve 
	keep if year==2018
	foreach v of global varlist {
	rename(`v')(`v'18)
	}
	save "$user/$data/Data for analysis/temp18.dta", replace
restore 


u "$user/$data/Data for analysis/temp20.dta", clear 
append using "$user/$data/Data for analysis/temp19.dta"
save "$user/$data/Data for analysis/temp19_20.dta", replace
append using "$user/$data/Data for analysis/temp18.dta"

export delimited using "$user/$data/Thailand_Oct18-Dec20_monthly_dashboard.csv", replace

rm "$user/$data/Data for analysis/temp20.dta"
rm "$user/$data/Data for analysis/temp19.dta"
rm "$user/$data/Data for analysis/temp18.dta"
rm "$user/$data/Data for analysis/temp19_20.dta"


* Quarterly data are removed from the final analysis: 
/********************************************************************************
* CREATE SEPARATE DATA FOR MONTHLY DATA
********************************************************************************
* Monthly data 
keep Province year month opd_util dental_util ipd_util mal_qual pneum_qual
drop if month==. 


u  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_clean.dta", clear
********************************************************************************
* CREATE SEPARATE DATA FOR QUARTERLY DATA
********************************************************************************
keep Province year quarter anc_util bcg_qual tbdiag_qual 
drop if quarter==. 


********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************

foreach v in anc_util bcg_qual tbdiag_qual  {
	by year quarter, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/Thailand_Oct18-Oct20_quarter_clean.dta", replace

********************************************************************************
* RESHAPE FOR DASHBOARD FOR QUARTERLY DATA 
********************************************************************************
u "$user/$data/Data for analysis/Thailand_Oct18-Oct20_quarter_clean.dta", clear 

global varlist anc_util bcg_qual tbdiag_qual		   

preserve
	keep if year==2020
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	save "$user/$data/Data for analysis/temp20.dta", replace
restore 

preserve
	keep if year==2019
	foreach v of global varlist {
	rename(`v')(`v'19)
	}
	save "$user/$data/Data for analysis/temp19.dta", replace
restore 

preserve 
	keep if year==2018
	foreach v of global varlist {
	rename(`v')(`v'18)
	}
	save "$user/$data/Data for analysis/temp18.dta", replace
restore 


u "$user/$data/Data for analysis/temp20.dta", clear 
append using "$user/$data/Data for analysis/temp19.dta"
save "$user/$data/Data for analysis/temp19_20.dta", replace
append using "$user/$data/Data for analysis/temp18.dta"

export delimited using "$user/$data/Thailand_Oct18-Oct20_quarter_dashboard.csv", replace

rm "$user/$data/Data for analysis/temp20.dta"
rm "$user/$data/Data for analysis/temp19.dta"
rm "$user/$data/Data for analysis/temp18.dta"
rm "$user/$data/Data for analysis/temp19_20.dta"
*/















