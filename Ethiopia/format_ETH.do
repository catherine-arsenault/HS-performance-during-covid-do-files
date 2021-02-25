* HS performance during Covid - Ethiopia
* Format do file
* Created by Catherine Arsenault

clear all 
set more off

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom  
				
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num 	totalipd_mort_num 

global all $volumes $mortality

* ALL INDICATORS
use "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_DB.dta", clear

/**************************************************************************
 COUNTS THE NUMBER OF FACILITIES LEFT IN THE DASHBOARD DATASET AND EXPORTS 
 TO EXCEL
***************************************************************************/
foreach var of global all {
egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/24=1)
* Number of facilities reporting for at least 1 month for each indicator
putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(DB-Tot reporting, replace)  modify
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

* Min and Max number of facilities reporting every month, for each indicator
preserve
	local all  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			   totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num ///
				er_mort_num totalipd_mort_num  

	reshape long `all', i(region zone organisationunitname orgunitlevel1 orgunitlevel4) j(rmonth) string
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(rmonth)
	putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(DB- MinMax reporting, replace)  modify
	
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


* Overall mean
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
	recode `var'_report (0=0) (1/999999=1) 
	egen `var'_total_report = total(`var'_report)
	egen `var'_sum = rowtotal(`var'*)
	egen `var'_total_sum = total(`var'_sum) 
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}

putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(DB-Tot reporting)  modify
putexcel E2 = "Variable"
putexcel F2 = "Mean per facility"	
local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel E`i' = "`var'"
	qui sum `var'_total_mean
	putexcel F`i' = `r(mean)'
}
drop *_report *_sum *_mean
/**************************************************************************
 MERGE WITH TB QUARTERLY INDICATORS
***************************************************************************/
merge 1:1  region zone org*  using "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_WIDE_CCA_TB.dta"
drop _merge

/****************************************************************
 COLLAPSE  BY FACILITY TYPES, REGION TYPES AND AT NATIONAL LEVEL
*****************************************************************/
* Totals by facility types
	gen factype = "Facility type: Hospitals" if regexm(organ, "[Hh]ospital") | regexm(organ, "HOSPITAL") 
	replace factype ="Facility type: Non-Hospitals" if factype==""
	
preserve
	collapse (sum) fp_util1_19-tbdenom_qual4_20, by(factype)
	rename factype region
	save "$user/$data/Data for analysis/tmpfactype.dta", replace
restore

* Totals by region type
	collapse (sum) fp_util1_19-tbdenom_qual4_20 , by(region)	
	
	gen regtype = "Region type: Urban" if region=="Addis Ababa" ///
	                          | region=="Dire Dawa" | region=="Harari"
	replace regtype = "Region type: Agrarian" if region == "Amhara" | region=="Oromiya" ///
                              | region== "SNNP" | region=="Tigray"
	replace regtype = "Region type: Pastoral" if region == "Afar" | region=="Ben Gum" ///
                              | region=="Gambella" | region=="Somali" 
preserve
	collapse (sum) fp_util1_19-tbdenom_qual4_20 , by(regtype)	
	rename regtype region
	save "$user/$data/Data for analysis/tmpregtype.dta", replace
restore
* Totals at national level 
	encode region, gen(reg)
	drop region regtype
	order reg 
	set obs 12 // number of regions  + National 
	foreach x of var _all    {
		egen `x'tot= total(`x'), m
		replace `x'= `x'tot in 12
		drop `x'tot
}
	decode reg, gen(region)
	replace region="National" if region==""
	drop reg
	order region

append using "$user/$data/Data for analysis/tmpfactype.dta"
append using "$user/$data/Data for analysis/tmpregtype.dta"


/****************************************************************
 RESHAPE FOR DASHBAORD
*****************************************************************/
reshape long  diab_util hyper_util diab_qual_num hyper_qual_num fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util  cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num  totaldel ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
			  tbnum_qual tbdenom_qual tbdetect_qual totalipd_mort diab_detec hyper_detec ///
			 , i(region ) j(month) string

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
sort region year month
order region year month 

* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
	sam_util opd_util ipd_util er_util road_util  cerv_qual art_util ///
	hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
	newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel totalipd_mort ///
	diab_util hyper_util diab_qual_num hyper_qual_num kmc_qual_num kmc_qual_denom ///
   tbnum_qual tbdenom_qual tbdetect_qual resus_qual_num resus_qual_denom diab_detec hyper_detec
  
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
merge m:m region month using "$user/$data/Data for analysis/temp.dta"
drop _merge //34 not merging becuase they are November and December months which are missing in 2020 data

rm "$user/$data/Data for analysis/temp.dta"
rm "$user/$data/Data for analysis/tmpfactype.dta"
rm "$user/$data/Data for analysis/tmpregtype.dta"
********************************************************************************
* THIS IS THE CSV FILE FOR GOOGLE DATA STUDIO
export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Oct20_fordashboard.csv", replace

/* Code to identify clinics (private) 
replace factype =2 if regexm(organ, "[Cc]linic") | regexm(organ, "CLINIC") | ///
                           regexm(organ, "CLINIK")  |  regexm(organ, "[Cc]linik") | ///
						   regexm(organ, "[Nn]GO") | regexm(organ, "[Cc]linc") | ///
						   regexm(organ, "[Cc]LINC") | regexm(organ, "[Cc]ilinik") | ///
						   regexm(organ, "[Kk]linik") | regexm(organ, "[Kk]ilinik") | ///
						   regexm(organ, "[Cc]ilinic") | regexm(organ, " [Nn]go") | ///
						   regexm(organ, "[Cc]LIINC") | regexm(organ, "[Cc]lnic") 





