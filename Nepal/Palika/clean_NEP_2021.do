* HS performance during Covid
* Dec 3, 2021
* Catherine Arsenault
* Data cleaning Nepal 2021

clear all
set more off	

u  "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", clear
order org* tbdetect_qual* hivtest_qual* diab_util* hyper_util* bcg_qual1* ///
pent_qual* pneum_qual*

merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta"
drop _merge sb_mort_num* mat_mort_num* ipd_mort_num* neo_mort_num* fp_perm_util* ///
fp_la_util* totaldel* opv3_qual* 

global all fp_sa_util anc_util del_util cs_util pnc_util diarr_util ///
			   pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual ///
			   measles_qual pneum_qual 

/****************************************************************
ASSESSES DATASET BEFORE CLEANING (NUMBER OF UNITS REPORTING, AND
SUM AND AVERAGE SERVICES PER UNIT)
****************************************************************/
* Number of palika reporting any data, for each indicator
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*) // counts the number of non missing cells
}
	recode *_report (0=0) (1/30=1) // 0 never any value, 1 some values

putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(2021 Before cleaning)  modify
putexcel A2 = "Variable"
putexcel B2 = "Number reporting any data"	
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
	local all fp_sa_util anc_util del_util cs_util pnc_util diarr_util ///
			   pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual ///
			   measles_qual pneum_qual 
			   
	reshape long `all', i(org*) j(month, string)
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(2021 Before cleaning) modify  
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
	* Sum/volume of services or deaths per palika over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20  `var'1_20 `var'2_20 ///
	  `var'1_21 `var'2_21 `var'3_21 `var'4_21 `var'5_21 `var'6_21), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
	* Average volume per Palika
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}

putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(2021 Before cleaning)  modify
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

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness can be an issues. For each variable, keep only heath facilities that 
have reported at least 19 out of 30 months. This brings completeness up "generally" 
above 90% for all variables. */
	foreach x of global all {
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=19
					/* keep if at least 19 out of 30 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpfp_sa_util.dta", clear

	foreach x in anc_util del_util cs_util pnc_util diarr_util ///
			   pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual ///
			   measles_qual pneum_qual  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE_CCA.dta", replace
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
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 ///
				 1_21 2_21 3_21 4_21 5_21 6_21  {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}

save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE_CCA.dta", replace 
