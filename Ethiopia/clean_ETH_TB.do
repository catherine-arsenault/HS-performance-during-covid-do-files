* HS performance during Covid
* Ethiopia TB data
* Data cleaning, January 2019-June 2020 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

1 Impute 0s for missing values: 
	- For mortality, 0s are imputed if the facility offers the
	  service it relates to.

2 Identify extreme outliers and set them to missing

3 Calculate completeness for each indicator-month 

4 Complete case analysis: keep only health facilities that have 
  reported every month (or nearly every month) 
  
5 Reshape dataset from wide to long.
********************************************************************/
clear all
set more off	

use "$user/$data/Data for analysis/EthiopiaTB_Jan19-June20_WIDE.dta", clear

********************************************************************
* 3687 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(tbdetect_qual1-tbnum_qual6), m
drop if all_visits==.
drop all_visits 
* Retains 1625 woreda/facilities with some data from Jan19-June20
********************************************************************

local all tbdetect_qual tbdenom_qual tbnum_qual

/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA
****************************************************************/
foreach var of local all {
	egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/6=1) 

putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(Before cleaning, replace)  modify
putexcel A2 = "Variable"
putexcel B2 = "Reported any data"	
local i= 44
foreach var of local all {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'_report
	putexcel B`i' = `r(sum)'
}
drop *report

/*******************************************************************
CURE: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS THE TB REGISTERED COHORT THAT MONTH
********************************************************************	
For cure, we inpute 0s if the facility reported a cohort that quarter */
forval i = 1/6 {
	recode tbnum_qual`i' (.=0) if tbdenom_qual`i'!=. 
}

/****************************************************************
         IDENTIFY OUTLIERS AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  */

foreach x in tbdetect_qual tbdenom_qual tbnum_qual {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
			gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // positive threshold
				forvalues v = 1/6 {  // until June 2020
					gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
					replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
					replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
			}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************/

	foreach x in tbdetect_qual tbdenom_qual tbnum_qual {
			  preserve
					keep region zone org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>4 & `x'6!=.
					/* keep if at least 5 out of 6 quarters are reported & Q2 2020 is reported */
					drop total`x'
					rename `x'1 `x'1_19
					rename `x'2 `x'4_19
					rename `x'3 `x'7_19
					rename `x'4 `x'10_19
					rename `x'5 `x'1_20
					rename `x'6 `x'4_20
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	
		use "$user/$data/Data for analysis/tmptbdetect_qual.dta", clear
		merge 1:1 region zone org* using "$user/$data/Data for analysis/tmptbnum_qual.dta", force 
		drop _merge
		merge 1:1 region zone org* using "$user/$data/Data for analysis/tmptbdenom_qual.dta", force 
		drop _merge		
		save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_WIDE_CCA_TB.dta", replace
		
	
	
