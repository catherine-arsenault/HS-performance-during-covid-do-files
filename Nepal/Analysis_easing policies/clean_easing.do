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

u "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", clear

order org* fp_util*_19  fp_util*_20  anc_util*_19 anc_util*_20 del_util*_19 del_util*_20 cs_util*_19 cs_util*_20 ///
totaldel*19 totaldel*20  pnc_util*_19 pnc_util*_20 diarr_util*_19 diarr_util*_20 pneum_util*_19 pneum_util*_20 ///
sam_util*_19  sam_util*_20 opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20 er_util*_19 er_util*_20  ///
tbdetect_qual*_19 tbdetect_qual*_20 hivdiag_qual*_19 hivdiag_qual*_20 pent_qual*_19 pent_qual*_20 ///
bcg_qual*_19 bcg_qual*_20 measles_qual*_19 measles_qual*_20 opv3_qual*_19 opv3_qual*_20 ///
pneum_qual*_19 pneum_qual*_20  


drop sb_mort_num1_20-peri_mort_num6_20

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning1.xlsx", firstrow(variable) replace	 

******************************************************************
* 753 palika. Dropping all palika that don't report any indicators all year
egen all_visits = rowtotal(fp_util1_19-ipd_mort_num12_19), m
drop if all_visits==.
drop all_visits 
******************************************************************

global volumes fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
               sam_util opd_util ipd_util er_util  tbdetect_qual  hivdiag_qual ///
			   totaldel pent_qual bcg_qual measles_qual opv3_qual pneum_qual 

/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
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
				 1_20 2_20 3_20 4_20 5_20 6_20  {
				 * 7_20 8_20 9_20 10_20 11_20 12_20
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE_CCA_easing.dta", replace 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel  using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning2.xlsx", firstrow(variable) replace	

/***************************************************************
                    COMPLETE CASE ANALYSIS                 
****************************************************************
Completeness is an issue, particularly for the latest months. Some palikas have
not reported yet. For each variable, keep only heath facilities that 
have reported at least 14 out of 18 months. This brings completeness up "generally" 
above 90% for all variables. */
	foreach x of global volumes {
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>14  
					/* keep if at least 14 out of 18 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear

	foreach x in  anc_util del_util cs_util pnc_util diarr_util pneum_util ///
               sam_util opd_util ipd_util er_util  tbdetect_qual  hivdiag_qual ///
			   totaldel pent_qual bcg_qual measles_qual opv3_qual pneum_qual {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE_CCA_easing.dta", replace
		}
	foreach x of global volumes {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	
save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE_CCA_easing.dta", replace

* Reshape for analyses
reshape long fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			 opd_util ipd_util er_util tbdetect_qual hivdiag_qual pent_qual bcg_qual ///
			 totaldel measles_qual opv3_qual pneum_qual  ///
			  , i(org*) j(month) string	
	
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
sort orgunitlevel1 orgunitlevel2 orgunitlevel3 organisationunitname year mo 
rename mo month

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_clean_easing.dta", replace