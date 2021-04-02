* HS performance during Covid
* KZN, South Africa
* Data cleaning,
* Created by Catherine Arsenault, September 2020
/********************************************************************
SUMMARY: This do file contains methods to address data quality issues
in Dhis2. It uses a dataset in wide form (1 row per health facility)

1 Impute 0s for missing values: 
	- For mortality, 0s are imputed if the facility offers the
	  service the mortality indicator relates to.

2 Identify extreme outliers and set them to missing

3 Complete case analysis: keep only health facilities that have 
  reported consistently 
  
4 Creates 2 dataset: one for the dashboard and one for analyses
********************************************************************/
clear all 
set more off	

u "$user/$data/Data for analysis/fac_wide.dta", clear

global volumes anc1_util totaldel del_util sb_mort_denom livebirths_denom cs_util ///
			   pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util
			   
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num

global all $volumes $mortality 

drop fp_util* hyper_util* er_util* /* these indicators are no longer collected after April 2020 (start of financial year)
							 Must be dropped from analysis */ 
							 
order livebirths_denom*, after(trauma_mort_num24)
order sb_mort_denom*, after(livebirths_denom24)
order trauma_util*, after(sb_mort_denom24)							 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning0.xlsx", firstrow(variable) replace


/****************************************************************
ASSESSES DATASET BEFORE CLEANING (NUMBER OF UNITS REPORTING, AND
SUM AND AVERAGE SERVICES PER UNIT)
****************************************************************/
* Number of palika reporting any data, for each indicator
foreach var of global all {
egen `var'_report = rownonmiss(`var'*)
}

recode *_report (0=0) (1/24=1) //24 months of data

putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(Before cleaning)  modify
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
	putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(Before cleaning)  modify
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

putexcel set "$user/$data/Codebook for South Africa.xlsx", sheet(Before cleaning)  modify
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

/****************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOMETHING AT SOME POINT DURING THE YEAR
****************************************************************
For mortality, we inpute 0s if the facility had the service that the deaths
relate to that month. E.g. deliveries, ER visits or Inpatient admissions */
forval i = 1/24 {
	replace newborn_mort_num`i' = 0 if newborn_mort_num`i'==. &  livebirths_denom`i'!=.
	replace sb_mort_num`i' = 0 	    if sb_mort_num`i' ==.  & sb_mort_denom`i'!=.
	replace mat_mort_num`i' = 0     if mat_mort_num`i' == .  & livebirths_denom`i'!=.
	replace trauma_mort_num`i' = 0  if trauma_mort_num`i' ==. & trauma_util`i'!=.
	replace ipd_mort_num`i' = 0     if ipd_mort_num`i' ==. & ipd_util`i' !=. 
	replace icu_mort_num`i'=0		if icu_mort_num`i'==. & icu_util`i' !=. 	
}
save "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_AN.dta", replace 
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning1.xlsx", firstrow(variable) replace





/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly May and June 2020. Some palikas have
not reported yet. For each variable, keep only heath facilities that 
have reported at least 15 out of 18 months (incl the latest 2 months) 
This brings completeness up "generally" above 90% for all variables. */
	foreach x of global all {
			 	preserve
					keep Province dist subdist Facility factype `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=15
					/* keep if at least 15 out of 24 months are reported 
					& Nov/Dec are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpanc1_util.dta", clear

	foreach x in totaldel del_util sb_mort_denom livebirths_denom cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
				merge 1:1 Province dist subdist Facility factype using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
/****************************************************************
              IDENTIFY OUTLIERS AND SET TO MISSING 
****************************************************************
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  */
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	forval v = 1/24 {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}			 
	
save "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", replace
/***************************************************************
                 COMPLETE CASE ANALYSIS 
		   COMPARING QUARTERS 2 (2020 VS 2019)
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */

u "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_AN.dta", clear

*Q2 (April-June) Policy brief 
foreach x of global all {
			 	preserve
					keep Province dist subdist Facility factype `x'*
					keep if `x'4!=. & `x'5!=. & `x'6!=. & ///
							`x'16!=. & `x'17!=. & `x'18!=. 
							//April-June 2019 vs 2020 
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpanc1_util.dta", clear

	foreach x in  totaldel del_util sb_mort_denom livebirths_denom cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
			 	merge 1:1 Province dist subdist Facility factype using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/KZN_CCA_Q2.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
*Remove outliers
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	forval v = 1/24 {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}	
			 
			 
* Reshape for analyses
reshape long anc1_util totaldel del_util sb_mort_denom livebirths_denom cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num ///
			   , i(Province dist subdist Facility factype) j(month) 
	
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	


* Drop the other months
keep if month>=4 & month<=6

save "$user/$data/Data for analysis/KZN_CCA_Q2.dta", replace


/***************************************************************
                 COMPLETE CASE ANALYSIS 
		   COMPARING QUARTERS 3 (2020 VS 2019)
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */

u "$user/$data/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_AN.dta", clear

foreach x of global all {
			 	preserve
					keep Province dist subdist Facility factype `x'*
					keep if `x'7!=. & `x'8!=. & `x'9!=. & ///
							`x'19!=. & `x'20!=. & `x'21!=. 
							//July-Sep 2019 vs 2020 
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpanc1_util.dta", clear

	foreach x in  totaldel del_util sb_mort_denom livebirths_denom cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
			 	merge 1:1 Province dist subdist Facility factype using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge

				save "$user/$data/Data for analysis/KZN_CCA_Q3.dta", replace

		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
*Remove outliers
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	forval v = 1/24 {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}	
			 
* Reshape for analyses
reshape long anc1_util totaldel del_util sb_mort_denom livebirths_denom cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num ///
			   , i(Province dist subdist Facility factype) j(month) 
	
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	


* Drop the other months
keep if month>=7 & month<=9

save "$user/$data/Data for analysis/KZN_CCA_Q3.dta", replace


/*************************************************************
* Completeness for each facility and indicator over 12 months
* Calculates the number of non-missing reports out of 12
foreach x of global volumes  {
	egen tot_reports_`x'= rownonmiss(`x'*)
	lab var tot_reports_`x' "Number of months reporting"
}

*************************************************************
* MODIFIED Z SCORE with shifted values

forval i = 1/12 { // adding to shift median from 0 to 1
	replace newborn_mort_num`i' = newborn_mort_num`i' + 1
}
egen median= rowmedian(newborn_mort_num*) // median over 12 months
forval i = 1/12 {
	gen absdiff`i'= abs(newborn_mort_num`i'-median) // absolute difference from the median for each month
	gen diff`i'= newborn_mort_num`i'-median // regular difference
}
egen mad = rowmedian(absdiff*)
forval i = 1/12 {
	gen mod_z_score`i' = 0.6745*diff`i'/mad 
}

drop median absdiff* diff* median mad
