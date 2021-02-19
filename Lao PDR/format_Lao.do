
* HS performance during Covid
* January 21, 2021
* Lao, January 2019 - Oct 2020, analyses at facility LEVEL 
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/*********************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
*********************************************************************
	COUNTS THE NUMBER OF FACILITIES REMAINING IN THE FINAL DATASET

**********************************************************************/
use "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE_CCA_DB.dta", clear

foreach var of global all {
egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/22=1) //22mts : Jan19-Oct20

putexcel set "$user/$data/Codebook for Lao PDR.xlsx", sheet(DB-Tot reporting, replace)  modify
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

preserve
	local all fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util bcg_qual totaldel pent_qual measles_qual opv3_qual pneum_qual ///
			   diab_util hyper_util opd_util ipd_util road_util neo_mort_num ///
			   sb_mort_num mat_mort_num
			   
	reshape long `all', i(org*) j(month, string)
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Codebook for Lao PDR.xlsx", sheet(DB-MinMax reporting, replace)  modify

	putexcel A1 = "Min and Max number of facilities reporting any month"
	putexcel A2 = "Variable"
	putexcel B2 = "Min month report data"	
	putexcel C2 = "Max month report data"
	local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'
	putexcel B`i' = `r(min)'
	putexcel C`i' = `r(max)'
}
restore
/*****************************************************************
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD

*****************************************************************/
	rename orgunitlevel2 province
	order province  org* 
	collapse (sum) fp_perm_util1_19-mat_mort_num10_20 , by(province)
	encode province, gen(prv)
	drop province
	order prv
	set obs 19
foreach x of var _all    {
	egen `x'tot= total(`x'), m
	replace `x'= `x'tot in 19
	drop `x'tot
}
decode prv, gen(province)
replace province="National" if province==""
drop prv
order province

* Reshaping for data visualisations / dashboard
reshape long  fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util bcg_qual totaldel pent_qual measles_qual opv3_qual pneum_qual ///
			   diab_util hyper_util opd_util ipd_util road_util ///
			   neo_mort_num sb_mort_num mat_mort_num, i(province) j(month) string
			  
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort province year month
order province year month 

* Reshaping for data visualisations
preserve
	keep if year == 2020
	foreach v of global all {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/temp.dta", replace
restore
keep if year==2019
foreach v of global all {
	rename(`v')(`v'19)
	}
drop year
merge m:m province month using "$user/$data/temp.dta"
drop _merge


rm "$user/$data/temp.dta"
export delimited using "$user/$data/Lao_Jan19-Oct20_fordashboard.csv", replace



























