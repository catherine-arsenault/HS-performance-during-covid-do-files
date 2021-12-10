* HS performance during Covid
* April 21, 2021 
* Haiti, January 2019 - March 2021
* Data cleaning, Catherine Arsenault

/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

1 Impute 0s instead of missing values: 
	- For mortality, 0s are imputed if the facility offers the
	  service it relates to that month.

2 Identify extreme outliers and set them to missing

3 Calculate completeness for each indicator-month 

4 Complete case analysis: keep only health facilities that have 
  reported every month (or nearly every month) 
  
5 Reshape dataset from wide to long.
********************************************************************/
clear all
set more off	

u "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear

global volumes dental_util fp_util anc_util opd_util diab_util hyper_util ///
			   del_util pnc_util cerv_qual vacc_qual
global mortality sb_mort_num mat_mort_num
global all $volumes $mortality 

* FOR NOW WE WILL NOT INCLUDE DATA FROM 2021
drop *_21

* 1212 facilities. Dropping all facilities that don't report any indicators all 18 months
egen all_visits = rowtotal(mat_mort_num1_20 - vacc_qual12_20), m
drop if  all_visits==.
drop all_visits 
* Drops 373 facilities, retains 839

/****************************************************************
ASSESSES DATASET BEFORE CLEANING (NUMBER OF UNITS REPORTING, AND
SUM AND AVERAGE SERVICES PER UNIT)
****************************************************************/
* Number of facility reporting any data, for each indicator 
	foreach var of global all {
	egen `var'_report = rownonmiss(`var'*) //counts the number of non missing cells
	}
	recode *_report (0=0) (1/24=1) // 0 never any value, 1 some value 

	putexcel set "$user/$data/Analyses/Codebook for Haiti Internal.xlsx", sheet(Before cleaning)  modify
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
* Min and Max number of facilities reporting any data, for any given month	
preserve
	local all dental_util fp_util anc_util opd_util diab_util hyper_util ///
			   del_util pnc_util cerv_qual vacc_qual sb_mort_num mat_mort_num
	reshape long `all', i(Number) j(month, string)
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Analyses/Codebook for Haiti Internal.xlsx", sheet(Before cleaning)  modify
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
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
	* Average volume per facilities
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}
putexcel set "$user/$data/Analyses/Codebook for Haiti Internal.xlsx", sheet(Before cleaning)  modify
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
putexcel set "$user/$data/Codebook for Haiti.xlsx", sheet(Raw data)  modify
putexcel A2 = "Variable"
putexcel B2 = "Total health care visits in the raw data"
local i= 2
	foreach var of global volumes {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
drop *_report *_sum *_mean

/*******************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS THE SERVICE THAT MONTH (E.G. DELIVERIES, INPATIENT ADMISSIONS)
********************************************************************	
For mortality, we inpute 0s if the facility had the service that the deaths
relate to that month. E.g. deliveries, ER visits or Inpatient admissions */
forval i = 1/12 {
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & del_util`i'_19!=.	
	replace sb_mort_num`i'_19 = 0     if sb_mort_num`i'_19== . & del_util`i'_19!=.
}
forval i= 1/12 { 
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & del_util`i'_19!=.	
	replace sb_mort_num`i'_20 = 0     if sb_mort_num`i'_20== . & del_util`i'_20!=.
}

save "$user/$data/Data for analysis/Haiti_Jan19-Dec20_WIDE_CCA_AN.dta", replace 

/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Haiti_Jan19-Dec20_fordatacleaning1.xlsx", firstrow(variable) replace

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly for the latest months included. Some 
palikas have not reported yet. For each variable, keep only heath facilities that 
have reported at least 15 out of 24 months. This brings completeness up "generally" 
above 90% for all variables. */
	foreach x of global all {
			 	preserve
					keep org* ID Number `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=15
					/* keep if at least 15 out of 24 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	
	u "$user/$data/Data for analysis/tmpdental_util.dta", clear

	foreach x in  fp_util anc_util opd_util diab_util hyper_util ///
			   del_util pnc_util cerv_qual vacc_qual sb_mort_num mat_mort_num {
			 	merge 1:1 Number using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Haiti_Jan19-Dec20_WIDE_CCA_DB.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	
/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  */
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}
save "$user/$data/Data for analysis/Haiti_Jan19-Dec20_WIDE_CCA_DB.dta", replace

/***************************************************************
                 COMPLETE CASE ANALYSIS 
				 COMPARING QUARTERS 2 (2020 vs. 2019)
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) 

u "$user/$data/Data for analysis/Haiti_Jan19-Dec20_WIDE_CCA_AN.dta", clear

foreach x of global all {
			 	preserve
					keep org* ID Number `x'*
					keep if `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & ///
							`x'4_20!=. & `x'5_20!=. & `x'6_20!=.
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpdental_util.dta", clear

	foreach x in  fp_util anc_util opd_util diab_util hyper_util ///
			   del_util pnc_util cerv_qual vacc_qual sb_mort_num mat_mort_num {
			 	merge 1:1 Number using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Haiti_CCA_Q2.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }

		 
* Reshape for analyses
reshape long dental_util fp_util anc_util opd_util diab_util hyper_util ///
			   del_util pnc_util cerv_qual vacc_qual sb_mort_num ///
			   mat_mort_num, i(Number) j(month) string	
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
		month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
		month=="9_20" |	month=="10_20" | ///
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
sort orgunitlevel1 orgunitlevel2 orgunitlevel3  year mo ID Number 
rename mo month
order org* year month ID Number 

* Drop the other months
keep if month>=4 & month<=6

save "$user/$data/Data for analysis/Haiti_CCA_Q2.dta", replace





















