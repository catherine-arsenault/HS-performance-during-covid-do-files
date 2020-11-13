
* HS performance during Covid
* November 12 2020
* Kwazuly Natal 
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
****************************************************************
 
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD

*****************************************************************/
u "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA_DB.dta", clear
	drop Province
	encode Facility, gen(facname)
	collapse (sum) anc1_util1-trauma_mort_num19 , by(dist)
	order dist
	set obs 12 // adding an empty row to dataset
	foreach x of var _all    {
		egen `x'tot= total(`x'), m
		replace `x'= `x'tot in 12 // adding each var's total in that empty row
		drop `x'tot
}
	decode dist, gen(district)
	replace district="Kwazulu-Natal (Province total)" if district==""
	drop dist
	order district 

reshape long  anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
			  sam_util art_util opd_util ipd_util road_util trauma_util ///
			  icu_util diab_util kmcn_qual cerv_qual tbscreen_qual ///
			  tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual pneum_qual rota_qual  newborn_mort_num ///
			  mat_mort_num sb_mort_num ipd_mort_num trauma_mort_num icu_mort_num, ///
			  i(district) j(month)
			  
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	


* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
	sam_util art_util opd_util ipd_util road_util diab_util kmcn_qual cerv_qual ///
	tbscreen_qual tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual ///
	pneum_qual rota_qual icu_util trauma_util newborn_mort_num sb_mort_num mat_mort_num ///
	ipd_mort_num icu_mort_num trauma_mort_num  
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/Data for analysis/temp.dta", replace
restore
	keep if year==2019
	foreach v of global varlist {
		rename(`v')(`v'19)
	}
drop year

merge m:m district month using "$user/$data/Data for analysis/temp.dta"
drop _merge

rm "$user/$data/Data for analysis/temp.dta"

export delimited using "$user/HMIS Data for Health System Performance Covid (South Africa)/KZN_Jan19-Jul20_fordashboard.csv", replace



	
