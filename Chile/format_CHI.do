* HS performance during Covid
* February 3 2021
* Chile 
* PI Catherine Arsenault, Analyst MK Kim
* Formating data for dashboard and analyses

/****************************************************************
ASSESSES DATASET AFTER CLEANING: SUM OF HEALTH CARE VISITS
****************************************************************/
u "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE_CCA_AN.dta", clear

putexcel set "$user/$data/Codebook for Chile.xlsx", sheet(Final data, replace)  modify
foreach var of global volumes {
	* Sum/volume of services or deaths per facility over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
}
putexcel A2 = "Variable"
putexcel B2 = "Total health care visits in the final data"
local i= 2
	foreach var of global volumes {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
drop  *_sum 
u "$user/$data/Data for analysis/tmpH.dta", clear 
global Hvol ipd_util del_util cs_util 
foreach var of global Hvol {
	* Sum/volume of services or deaths per facility over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
}
local i= 12
	foreach var of global Hvol {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
drop  *_sum 	
u "$user/$data/Data for analysis/tmpC.dta", clear 
global Cvol measles_qual pneum_qual bcg_qual pent_qual 
foreach var of global Cvol {
	* Sum/volume of services or deaths per facility over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
}
local i= 16
	foreach var of global Cvol {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
u "$user/$data/Data for analysis/tmpR.dta"	, clear 
 global Rvol pneum_util breast_util 
foreach var of global Rvol {
	* Sum/volume of services or deaths per facility over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
}
local i= 21
	foreach var of global Rvol {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
/****************************************************************
FORMATS FACILITY-LEVEL DATA FOR DASHBOARD
****************************************************************/
u "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE_CCA_AN.dta", clear

global all  hyper_util diab_util road_util surg_util pnc_util fp_util er_util mental_util anc_util

* Create national total
	rename (org1-org5) (region municipality levelofattention facilityname id)
	collapse (sum) mental_util1_19 - er_util12_20 , by(region)
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
	drop if reg==.
	drop reg 
	order region 
	
reshape long  hyper_util diab_util  road_util surg_util pnc_util fp_util er_util ///
             mental_util anc_util, i(region) j(month) string 
	
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
export delimited using "$user/$data/Chile_Jan19-Dec20_fordashboard.csv", replace

*******************************************************************************
* Formats facility-level data for analyses

u "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE_CCA_AN.dta", clear
rename (org1-org5) (region municipality levelofattention facilityname id)

reshape long  road_util surg_util pnc_util fp_util ///
			er_util mental_util anc_util hyper_util diab_util, i(region municipality levelofattention ///
			facilityname id) j(month) string 
	
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	///
	month=="4_20" |	month=="5_20" | month=="6_20"  | month=="7_20" | ///
	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
			
		save "$user/$data/Data for analysis/Chile_su_24months.dta", replace
		
*******************************************************************************
* Adding hospital-level data (no missingness)

u "$user/$data/Data for analysis/tmpH.dta", clear 
reshape long ipd_util del_util cs_util , i(region facilityname) j(month) string
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	///
	month=="4_20" |	month=="5_20" | month=="6_20"  | month=="7_20" | ///
	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
		append  using "$user/$data/Data for analysis/Chile_su_24months.dta"
		order region municipality levelofattention facilityname id  year month 
		
		* Saves dataset for analyses 		
		save "$user/$data/Data for analysis/Chile_su_24months.dta", replace
		
*******************************************************************************
* Adding community-level vaccination data 

u "$user/$data/Data for analysis/tmpC.dta", clear 
rename (Comuna REGION) (municipality region)
reshape long measles_qual pneum_qual bcg_qual pent_qual, i(region municipality) j(month) string
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	///
	month=="4_20" |	month=="5_20" | month=="6_20"  | month=="7_20" | ///
	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
		append  using "$user/$data/Data for analysis/Chile_su_24months.dta"
		order region municipality levelofattention facilityname id  year month 
		* Saves dataset for analyses 		
		save "$user/$data/Data for analysis/Chile_su_24months.dta", replace
		
*******************************************************************************
* Adding indicators available at regional level 

u "$user/$data/Data for analysis/tmpR.dta", clear 		
  
reshape long breast_util pneum_util neo_mort_num ipd_mort_num, i(region ) j(month) string
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	///
	month=="4_20" |	month=="5_20" | month=="6_20"  | month=="7_20" | ///
	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
		
		append  using "$user/$data/Data for analysis/Chile_su_24months.dta"
		order region municipality levelofattention facilityname id  year month 
		
		* Saves dataset for analyses 		
		save "$user/$data/Data for analysis/Chile_su_24months.dta", replace		
		
rm 	"$user/$data/Data for analysis/tmpR.dta"
rm "$user/$data/Data for analysis/tmpC.dta"	
rm "$user/$data/Data for analysis/tmpH.dta"
rm "$user/$data/Data for analysis/tmp.dta"
		
		
