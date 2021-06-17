* HS performance during Covid
* Chile 
* Data cleaning, January 2019 -December 2020 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

1 Impute 0s for missing values: 
	- For mortality, 0s are imputed if the facility offers the
	  service it relates to.

2 Identify extreme positive outliers and set them to missing

3 Calculate completeness for each indicator-month 

4 Complete case analysis: keep only health facilities that have 
  reported consistently (nearly) every month
  
5 Reshape dataset from wide to long.
********************************************************************/
clear all
set more off	

u "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", clear
order region municipality levelofattention facilityname id
rename (region-id) (org1 org2 org3 org4 org5)
********************************************************************
* 2541 facilities 
* Dropping all facilities that don't report any indicators all period
egen all_visits = rowtotal(mental_util1_19 - er_util12_20), m
drop if all_visits==0 //6 observations dropped
drop all_visits 
********************************************************************
*1 facility has no information on region, municipality, and level of attention 
drop if org1 == "#N/A" 
********************************************************************
global volumes road_util surg_util pnc_util fp_util er_util mental_util anc_util

/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA: exported to excel
****************************************************************/

foreach var of global volumes {
egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/24=1) //24mts : Jan19-Dec20

putexcel set "$user/$data/Codebook for Chile.xlsx", sheet(Tot fac reporting 24mos, replace)  modify
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

preserve
	local volumes road_util surg_util pnc_util fp_util er_util mental_util anc_util
			   
	reshape long `volumes', i(org*) j(month, string)
	recode `volumes' (.=0) (1/999999999=1)
	collapse (sum) `volumes', by(month)
	putexcel set "$user/$data/Codebook for Chile.xlsx", sheet(MinMax fac reporting 24mos, replace)  modify

	putexcel A1 = "Min and Max number of facilities reporting any month"
	putexcel A2 = "Variable"
	putexcel B2 = "Min month report data"	
	putexcel C2 = "Max month report data"
	local i= 2
foreach var of global volumes {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'
	putexcel B`i' = `r(min)'
	putexcel C`i' = `r(max)'
}
restore

****************************************************************
*EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************
*export excel using "$user/$data/Data cleaning/Chile_Jan19-Dec20_fordatacleaning1.xlsx", firstrow(variable) replace


/****************************************************************
         IDENTIFY POSITIVE OUTLIERS AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  

*/

foreach x of global volumes {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
			gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold 
			foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				         1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 {  
		gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE_CCA_AN.dta", replace 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Chile_Jan19-Dec20_fordatacleaning2.xlsx", firstrow(variable) replace













