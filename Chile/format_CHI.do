* HS performance during Covid
* February 3 2021
* Chile 
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
********************************************************************************
COLLAPSE PRIMARY CARE DATA TO PROVINCE LEVEL AND RESHAPE FOR DASHBOARD
********************************************************************************/
u "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE_CCA_AN.dta", clear

global all  hyper_util diab_util  road_util surg_util pnc_util fp_util er_util mental_util anc_util

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
		* Saves dataset for analyses 		
		save "$user/$data/Data for analysis/Chile_su_24months.dta", replace
		
/****************************************************************
		ADDING HOSPITAL LEVEL DATA
*****************************************************************/
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
/****************************************************************
		ADDING VACCINATION DATA AT THE COMUNA LEVEL
*****************************************************************/
u "$user/$data/Data for analysis/tmp.dta", clear 
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
		
/****************************************************************
		ADDING BREAST CANCER SCREENING DATA AT THE REGION LEVEL
*****************************************************************/		
import excel using "/$user/$data/Raw data/CL - Brest Cancer.xlsx", firstrow clear
rename (_1-Y) ///
(breast_util1_19	breast_util2_19	breast_util3_19	breast_util4_19 ///
breast_util5_19	breast_util6_19	breast_util7_19	breast_util8_19	///
breast_util9_19	breast_util10_19	breast_util11_19	breast_util12_19 ///
breast_util1_20	breast_util2_20	breast_util3_20	breast_util4_20	breast_util5_20	///
breast_util6_20 breast_util7_20   breast_util8_20   breast_util9_20 ///
  breast_util10_20 breast_util11_20 breast_util12_20)
  
reshape long breast_util, i(region ) j(month) string
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
		
		
		
		
		
		
		
