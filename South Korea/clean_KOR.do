* HS performance during Covid
* South Korea 
* Data cleaning, January-August 2020 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

1 Identify extreme positive outliers and set them to missing
  
2 Reshape dataset from wide to long.
********************************************************************/
clear all
set more off	

u "$user/$data/Data for analysis/Kor_Jan19-Aug20_WIDE.dta", clear

********************************************************************
* 17 regions 
* Dropping regions that don't report any indicators all period
egen all_visits = rowtotal(sti_util1_19-allcause_mort_num8_20), m
drop if all_visits==. //no observation drop
drop all_visits 
********************************************************************
global volume sti_util anc_util del_util cs_util diarr_util pneum_util
global other diab_util hyper_util art_util mental_util opd_util er_util ipd_util kmc_qual
global mortality newborn_mort_num sb_mort_num mat_mort_num allcause_mort_num ipd_mort_num totaldel
global all $volume $other $mortality 

/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA: exported to excel
****************************************************************/

foreach var of global all {
egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/20=1) //20mts : Jan19-Aug20

putexcel set "$user/$data/Codebook for South Korea.xlsx", sheet(Tot reg reporting 20mos, replace)  modify
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
	local all sti_util anc_util del_util cs_util diarr_util pneum_util ///
	diab_util hyper_util art_util mental_util opd_util er_util ipd_util kmc_qual ///
	newborn_mort_num sb_mort_num mat_mort_num allcause_mort_num ipd_mort_num totaldel
			   
	reshape long `all', i(region) j(month, string)
	recode `all' (.=0) (1/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Codebook for South Korea.xlsx", sheet(MinMax reg reporting 20mos, replace)  modify

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

****************************************************************
*EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************
*export excel using "$user/$data/Data cleaning/Chile_Jan19-October20_fordatacleaning1.xlsx", firstrow(variable) replace


/****************************************************************
         IDENTIFY POSITIVE OUTLIERS AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  

We do not assess outliers for diabetes and hypertension because they were not 
collected until October 2019 
*/

foreach x of global all {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
			gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold 
			foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				         1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20  {  // until Aug 2020 
				         *  9_20 10_20 11_20 12_20
		gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

save "$user/$data/Data for analysis/Kor_Jan19-Oct20_WIDE_CCA_AN.dta", replace 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Chile_Jan19-Aug20_fordatacleaning2.xlsx", firstrow(variable) replace


