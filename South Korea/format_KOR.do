* HS performance during Covid
* February 4 2021
* South Korea
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
****************************************************************
 
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD

*****************************************************************/
u "$user/$data/Data for analysis/Kor_Jan19-Sep20_WIDE.dta", replace	

global volume sti_util anc_util cs_util diarr_util pneum_util del_util totaldel
global other diab_util hyper_util art_util mental_util opd_util er_util ipd_util kmc_qual
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num 
global all $volume $other $mortality 

*********************************************************
* Create national totals
*********************************************************
	collapse (sum) sti_util1_19 - del_util9_20 , by(region)
	encode region, gen(reg)
	drop region
	order reg
	set obs 18
		foreach x of var _all    {
		egen `x'tot= total(`x'), m
		replace `x'= `x'tot in 18
		drop `x'tot
	}
	decode reg, gen(region)
	replace region ="National" if region=="" 
	drop reg 
	order region 
	
reshape long sti_util anc_util totaldel cs_util diarr_util pneum_util diab_util ///
		hyper_util art_util mental_util opd_util er_util ipd_util kmc_qual ///
		newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num del_util, i(region) j(month) string 
	
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
		sort  region year month
		order region year month 
		
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
merge m:m region month using "$user/$data/temp.dta"
drop _merge


rm "$user/$data/temp.dta"
export delimited using "$user/$data/Kor_Jan19-Sep20_fordashboard.csv", replace

		

		
		
		
		
		
		
		
		
		
		
		
		
