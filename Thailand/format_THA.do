* HS performance during Covid
* Created Dec 8, 2020 
* Thailand, January 2019 -   data at Province level 


u  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_clean.dta", clear

********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************
foreach v in anc_util bcg_qual tbdiag_qual opd_util dental_util ipd_util mal_qual pneum_qual {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}

foreach v in anc_util bcg_qual tbdiag_qual opd_util dental_util ipd_util mal_qual pneum_qual {
	by year quarter, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}


********************************************************************************
* RESHAPE FOR DASHBOARD - monthly data 
********************************************************************************
*Stuck - not sure how to rename 2018-2020 

keep Province year month opd_util dental_util ipd_util mal_qual pneum_qual
global varlist opd_util dental_util ipd_util mal_qual pneum_qual			   

preserve
	keep if year==2020
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	save "$user/$data/temp20.dta", replace
restore 

preserve
	keep if year==2019
	foreach v of global varlist {
	rename(`v')(`v'19)
	}
	save "$user/$data/temp19.dta", replace
restore 

preserve 
	keep if year==2018
	foreach v of global varlist {
	rename(`v')(`v'18)
	}
	save "$user/$data/temp18.dta", replace
restore 

u "$user/$data/temp20.dta", clear 
merge m:m Province month using "$user/$data/temp19.dta"
drop _merge 
save "$user/$data/temp19_20.dta", replace

u "$user/$data/temp19_20.dta", clear 
merge m:m Province month using "$user/$data/temp18.dta"
drop _merge 

export delimited using "$user/$data/Thailand_Oct18-Oct20_month_dashboard.csv", replace

rm "$user/$data/temp20.dta"
rm "$user/$data/temp19.dta"
rm "$user/$data/temp18.dta"
rm "$user/$data/temp19_20.dta"












