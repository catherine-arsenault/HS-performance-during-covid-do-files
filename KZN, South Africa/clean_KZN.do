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

global volumes anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num
global all $volumes $mortality 

drop fp_util* hyper_util* er_util* /* these indicators are no longer collected after April 2020 (start of financial year)
							 Must be dropped from analysis */ 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning0.xlsx", firstrow(variable) replace


/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA
****************************************************************/

foreach var of global volumes {
egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/19=1)

putexcel set "$user/$data/Analyses/KZN changes 2019 2020.xlsx", sheet(Total facilities reporting, replace)  modify
putexcel A2 = "Variable"
putexcel B2 = "Reported any data"	
local i= 2
foreach var of global volumes {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'_report
	putexcel B`i' = `r(sum)'
}
drop *report


/****************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOMETHING AT SOME POINT DURING THE YEAR
****************************************************************
For mortality, we inpute 0s if the facility had the service that the deaths
relate to that month. E.g. deliveries, ER visits or Inpatient admissions */
forval i = 1/19 {
	replace newborn_mort_num`i' = 0 if newborn_mort_num`i'==. &  totaldel`i'!=.
	replace sb_mort_num`i' = 0 	    if sb_mort_num`i' ==.  & totaldel`i'!=.
	replace mat_mort_num`i' = 0     if mat_mort_num`i' == .  &  totaldel`i'!=.
	replace trauma_mort_num`i' = 0  if trauma_mort_num`i' ==. & trauma_util`i'!=.
	replace ipd_mort_num`i' = 0     if ipd_mort_num`i' ==. & ipd_util`i' !=. 
	replace icu_mort_num`i'=0		if icu_mort_num`i'==. & icu_util`i' !=. 	
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning1.xlsx", firstrow(variable) replace
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
	forval v = 1/19 {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}

save "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA_AN.dta", replace 
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel  using "$user/$data/Data cleaning/KZN_Jan19-Dec19_fordatacleaning3.xlsx", firstrow(variable) replace

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly May and June 2020. Some palikas have
not reported yet. For each variable, keep only heath facilities that 
have reported at least 14 out of 18 months (incl the latest 2 months) 
This brings completeness up "generally" above 90% for all variables. */
	foreach x of global all {
			 	preserve
					keep Province dist subdist Facility factype `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>15 & `x'18!=. & `x'19!=. 
					/* keep if at least 15 out of 19 months are reported 
					& jun/jul 2020 are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpanc1_util.dta", clear

	foreach x in totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
				merge 1:1 Province dist subdist Facility factype using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA_DB.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	
save "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA_DB.dta", replace
/***************************************************************
                 COMPLETE CASE ANALYSIS 
				     FOR ANALYSES 
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */

u "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA_AN.dta", clear

foreach x of global all {
			 	preserve
					keep Province dist subdist Facility factype `x'*
					keep if `x'4!=. & `x'5!=. & `x'6!=. & `x'7!=. & ///
							`x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.
					* Currently April to July 2020 vs 2019 is what we compare
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpanc1_util.dta", clear

	foreach x in  totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
			 	merge 1:1 Province dist subdist Facility factype using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/KZN_Jan19-JuL20_WIDE_CCA_AN.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
* Reshape for analyses
reshape long anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num ///
			   , i(Province dist subdist Facility factype) j(month) 
	
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	

save "$user/$data/Data for analysis/KZN_Jan19-JuL20_WIDE_CCA_AN.dta", replace




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