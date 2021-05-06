* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* Janurary 4, 2021
* Catherine Arsenault
* Data cleaning 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER palika)

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

u "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", clear

order org* fp_*_util*_19  fp_*util*_20  anc_util*_19 anc_util*_20 del_util*_19 del_util*_20 /// 
cs_util*_19 cs_util*_20 pnc_util*_19 pnc_util*_20 

drop *_mort_* fp_perm* fp_la* totaldel*19 totaldel*20 diarr_util*_19 diarr_util*_20 ///
pneum_util*_19 pneum_util*_20 opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20  ///
er_util*_19 er_util*_20 tbdetect_qual*_19 tbdetect_qual*_20 pent_qual*_19 pent_qual*_20 ///
bcg_qual*_19 bcg_qual*_20 measles_qual*_19 measles_qual*_20 opv3_qual*_19 opv3_qual*_20 ///
pneum_qual*_19 pneum_qual*_20 hyper_util*_19 hyper_util*_20 diab_util*_19 diab_util*_20 ///
hivtest_qual*_19 hivtest_qual*_20

******************************************************************
* 753 palika. Dropping all palika that don't report any indicators all year
egen all_visits = rowtotal(fp_sa_util1_19-pnc_util10_20), m
drop if all_visits==.
drop all_visits 
******************************************************************

global volumes fp_sa_util anc_util del_util cs_util pnc_util 

/****************************************************************
         IDENTIFY POSITIVE OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  */
foreach x of global volumes {
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

drop *19 *1_20 *2_20 *11_20 *12_20 


save "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_WIDE_NK_easing.dta", replace 


**************************************************************
                 *COMPLETE CASE ANALYSIS 1 
				 *All 8/8 months reported 
****************************************************************

u "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_WIDE_NK_easing.dta", clear 
			 
foreach x of global volumes { 
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=8 
					/* keep if at least 8 out of 8 are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
				
	u "$user/$data/Data for analysis/tmpfp_sa_util.dta", clear

	foreach x in anc_util del_util cs_util pnc_util {   
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_WIDE_NK_1.dta", replace  
		}
		
	foreach x of global volumes { //changed global all to volumes
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	 

**************************************************************
                 *COMPLETE CASE ANALYSIS 2 
				 *7/8 months reported 
****************************************************************
*To change your months reported, please change the line 120 

u "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_WIDE_NK_easing.dta", clear 
			 
foreach x of global volumes { 
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=7 
					/* keep if at least 7 out of 8 are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
				
	u "$user/$data/Data for analysis/tmpfp_sa_util.dta", clear

	foreach x in anc_util del_util cs_util pnc_util { 
		merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
		drop _merge
		save "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_WIDE_NK_2.dta", replace 
		}
		
	foreach x of global volumes { 
			rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	 
**********************************************************************

