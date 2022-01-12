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
order region municipality  levelofattention facilityname id
rename (region-id) (org1 org2 org3 org4 org5 )
********************************************************************
* 2808 facilities 
* Dropping all facilities that don't report any indicators all period
egen all_visits = rowtotal(hyper_util1_19 - er_util12_20), m
drop if all_visits==0 // 6 observations dropped
drop all_visits 
********************************************************************
global volumes diab_util hyper_util road_util surg_util pnc_util fp_util er_util mental_util anc_util

/****************************************************************
ASSESSES DATASET BEFORE CLEANING: SUM OF HEALTH CARE VISITS
****************************************************************/
preserve
putexcel set "$user/$data/Codebook for Chile.xlsx", sheet(Raw data, replace)  modify
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
putexcel B2 = "Total health care visits in the raw data"
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
	
restore
****************************************************************
*EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************
*export excel using "$user/$data/Data cleaning/Chile_Jan19-Dec20_fordatacleaning2.xlsx", firstrow(variable) replace
* No missing data in Chile. No need to run complete case analysis code.

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
rm "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta" 
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Chile_Jan19-Dec20_fordatacleaning2.xlsx", firstrow(variable) replace













