
* HS performance during Covid
* November 12 2020
* Kwazuly Natal 
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
****************************************************************
ASSESSES DATASET AFTER CLEANING (NUMBER OF UNITS REPORTING, AND
SUM AND AVERAGE SERVICES PER UNIT)
****************************************************************/
u "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", clear

* Number of palika reporting any data, for each indicator
foreach var of global all {
egen `var'_report = rownonmiss(`var'*)
}

recode *_report (0=0) (1/24=1) //24 months of data

putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(After cleaning)  modify
putexcel A2 = "Variable"
putexcel B2 = "Reported any data"	
local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'_report
	putexcel B`i' = `r(sum)'
}
drop *report
* Min and Max number of palikas reporting any data, for any given month	
preserve
	local all anc1_util totaldel del_util sb_mort_denom livebirths_denom cs_util ///
	           pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num ///
			   icu_mort_num trauma_mort_num

	reshape long `all', i(Facility factype Province dist subdist) j(rmonth)
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(rmonth)
	putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(After cleaning)  modify
	putexcel C2 = "Variable"
	putexcel D2 = "Min units reporting any month"	
	putexcel E2 = "Max units reporting any month"	
	local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel C`i' = "`var'"
	qui sum `var'
	putexcel D`i' = `r(min)'
	putexcel E`i' = `r(max)'
}
restore

* Sum and average volumes
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
	recode `var'_report (0=0) (1/999999=1) 
	* Total facilities ever reporting each indicator
	egen `var'_total_report = total(`var'_report)
	* Sum/volume of services or deaths per facility over 24 months
	egen `var'_sum = rowtotal(`var'1 -`var'24)
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum) 
	* Average volume per facility 
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}

putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(After cleaning)  modify
putexcel F2 = "Variable"
putexcel G2 = "Sum of services or deaths"	
putexcel H2 = "Average per unit/facility"
local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel F`i' = "`var'"
	qui sum `var'_total_sum
	putexcel G`i' = `r(mean)'
	qui sum `var'_total_mean
	putexcel H`i' = `r(mean)'
}
drop *_report *_sum *_mean

/*******************************************************************************
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD
*******************************************************************************/
u "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", clear
	drop Province
	encode Facility, gen(facname)
	collapse (sum) anc1_util1-trauma_mort_num21 , by(dist)
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
			  mat_mort_num livebirths_denom sb_mort_num sb_mort_denom  ///
			  ipd_mort_num trauma_mort_num icu_mort_num, ///
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
	sb_mort_denom ipd_mort_num icu_mort_num trauma_mort_num livebirths_denom
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

export delimited using "$user/HMIS Data for Health System Performance Covid (South Africa)/KZN_Jan19-Dec20_fordashboard.csv", replace

/*******************************************************************************
		CREATES DATASET FOR ANALYSES
*******************************************************************************/
u "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", clear
reshape long anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
			  sam_util art_util opd_util ipd_util road_util trauma_util ///
			  icu_util diab_util kmcn_qual cerv_qual tbscreen_qual ///
			  tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual pneum_qual rota_qual  newborn_mort_num ///
			  mat_mort_num livebirths_denom sb_mort_num sb_mort_denom  ///
			  ipd_mort_num trauma_mort_num icu_mort_num, ///
			  i(Province dist subdist Facility factype ) j (month )

rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	
order Province dist subdist Facility factype year month rmonth 
* Save clean dataset for analyses
save "$user/$data/Data for analysis/KZN_su_24months_for_analyses.dta"




