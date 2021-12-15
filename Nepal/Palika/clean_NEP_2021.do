* HS performance during Covid
* Dec 3, 2021
* Catherine Arsenault
* Data cleaning Nepal 2021

clear all
set more off	

u  "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", clear
order org* tbdetect_qual* hivtest_qual* diab_util* hyper_util* bcg_qual1* ///
pent_qual* pneum_qual*
* Merge to 2019-2020 data 
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta"
drop _merge sb_mort_num* mat_mort_num* ipd_mort_num* neo_mort_num* fp_perm_util* ///
fp_la_util* totaldel* opv3_qual* 

global all fp_sa_util anc_util del_util cs_util pnc_util diarr_util ///
			   pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual ///
			   measles_qual pneum_qual 

/***************************************************************
                    COMPLETE CASE ANALYSIS 
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
