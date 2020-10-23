* HS performance during Covid
* Ethiopia 
* Data cleaning, January-June 2020 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

1 Impute 0s for missing values: 
	- For volume data, missingness must be consistent
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
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

u "$user/$data/Data for analysis/Ethiopia_Jan19-June20_WIDE.dta", clear

* 3710 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(fp_util1_20-icu_mort_num12_19), m
drop if all_visits==.
drop all_visits 
* Retains 2383 woreda/facilities with some data from Jan19-Jun20
********************************************************************

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
				ipd_util er_util road_util diab_util hyper_util kmc_qual resus_qual  cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util

global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num 

global all $volumes $mortality

order  region zone org unit_id fp_util*_19 fp_util*_20  anc_util*_19 anc_util*_20 del_util*_19 ///
	  del_util*_20 cs_util*_19 cs_util*_20 sti_util*_19 sti_util*_20  pnc_util*_19 pnc_util*_20 ///
	  diarr_util*_19  diarr_util*_20  pneum_util*_19 pneum_util*_20 art_util*_19 art_util*_20  ///
	  sam_util*_19 sam_util*_20 opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20 er_util*_19 ///
	  er_util*_20 road_util*_19 ///
	  road_util*_20 diab_util*_19 diab_util*_20 hyper_util*_19 hyper_util*_20 kmc_qual*_19 ///
	  kmc_qual*_20 resus_qual*_19 resus_qual*_20  cerv_qual*_19 cerv_qual*_20 hivsupp_qual_num*_19 ///
	  hivsupp_qual_num*_20  diab_qual_num*_19 diab_qual_num*_20 hyper_qual_num*_19 hyper_qual_num*_20  ///
	  vacc_qual*_19 vacc_qual*_20 pent_qual*_19 pent_qual*_20 bcg_qual*_19 bcg_qual*_20 measles_qual*_19 ///
	  measles_qual*_20 opv3_qual*_19 opv3_qual*_20 pneum_qual*_19 pneum_qual*_20 rota_qual*_19 ///
	  rota_qual*_20 sb_mort*_19 sb_mort*_20 newborn_mort_num*_19 newborn_mort_num*_20 mat_mort*_19 ///
	  mat_mort*_20 er_mort_num*19 er_mort_num*20 icu_mort_num*19  icu_mort_num*20 ipd_mort_num*19 ///
	  ipd_mort_num*20
/****************************************************************
EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-June20_fordatacleaning0.xlsx", firstrow(variable) replace
/****************************************************************
VOLUMES:  REPLACE MISSINGS TO 0 IF MISSINGNESS IS CONSISTENT
****************************************************************
Identifies consistent missingnes in volume data. If the facility is missing data at the begining 
and then starts reporting until the end , we will assume that a one time swtich from missing to non-missing 
indicates a new facility opening (or that newly starts reporting a certain indicator)
In this case, replace the missings with zeros */
foreach x of global volumes  {
	recode `x'1_19 (.=0) if `x'1_19==. & (`x'2_19!=. & `x'3_19!=. & `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. & `x'8_19!=. ///
		& `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 (.=0) if (`x'1_19==. & `x'2_19==.) & (`x'3_19!=. & `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. & ///
		`x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==.) & (`x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. ///
		& `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==.) & (`x'5_19!=. & `x'6_19!=. & ///
		`x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. ///
		& `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==.) & (`x'6_19!=. ///
		& `x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & ///
		`x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & ///
		`x'6_19==.) & (`x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & ///
		`x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & ///
		`x'5_19==. & `x'6_19==. & `x'7_19==.) & (`x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & ///
		`x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. ///
		& `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==.) & (`x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & `x'2_20!=. & ///
		`x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & ///
		`x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==.) & (`x'10_19!=. & `x'11_19!=. & `x'12_19!=. & `x'1_20!=. & ///
		`x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==.) & (`x'11_19!=. & `x'12_19!=. & ///
		`x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==.) & (`x'12_19!=. & ///
		`x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==. & `x'12_19==.) &  ///
		(`x'1_20!=. & `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 `x'1_20 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==. & `x'12_19==. & `x'1_20==.) &  ///
		( `x'2_20!=. & `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 `x'1_20 `x'2_20 (.=0) if (`x'1_19==. & ///
			`x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==. & ///
			`x'12_19==. & `x'1_20==. & `x'2_20==.) &  ( `x'3_20!=. & `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 `x'1_20 `x'2_20 `x'3_20 (.=0) if (`x'1_19==. & ///
	       `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==. & ///
		   `x'12_19==. & `x'1_20==. & `x'2_20==. & `x'3_20==.) &  ( `x'4_20!=. & `x'5_20!=. & `x'6_20!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 `x'1_20 `x'2_20 `x'3_20 `x'4_20 (.=0) if ///
		  (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & ///
		  `x'11_19==. & `x'12_19==. & `x'1_20==. & `x'2_20==. & `x'3_20==. & `x'4_20==.) &  ( `x'5_20!=. & `x'6_20!=.)
    recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 `x'12_19 `x'1_20 `x'2_20 `x'3_20 `x'4_20 `x'5_20 (.=0) if ///
		  (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & ///
		  `x'11_19==. & `x'12_19==. & `x'1_20==. & `x'2_20==. & `x'3_20==. & `x'4_20==. & `x'5_20==.) &  ( `x'6_20!=.)
}
/****************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOME MORTAILITY DATA AT SOME POINT DURING THE YEAR
****************************************************************
For mortality, we inpute 0s if the facility had the service that the deaths
relate to that month. E.g. deliveries, ER visits or Inpatient admissions */
forval i = 1/12 {
	replace newborn_mort_num`i'_19 = 0 if newborn_mort_num`i'_19==. & (del_util`i'_19!=. | cs_util`i'_19!=.)
	replace sb_mort_num`i'_19 = 0 	   if sb_mort_num`i'_19==. & (del_util`i'_19!=. | cs_util`i'_19!=.)
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & (del_util`i'_19!=. | cs_util`i'_19!=.)
	replace er_mort_num`i'_19 = 0      if er_mort_num`i'_19==. & er_util`i'_19!=.
	replace ipd_mort_num`i'_19 = 0     if ipd_mort_num`i'_19==. & ipd_util`i'_19!=.
}
forval i = 1/6 {
	replace newborn_mort_num`i'_20 = 0 if newborn_mort_num`i'_20==. & (del_util`i'_20!=. | cs_util`i'_20!=.)
	replace sb_mort_num`i'_20 = 0 	   if sb_mort_num`i'_20==. &  (del_util`i'_20!=. | cs_util`i'_20!=.)
	replace mat_mort_num`i'_20 = 0     if mat_mort_num`i'_20== . & (del_util`i'_20!=. | cs_util`i'_20!=.)
	replace er_mort_num`i'_20 = 0      if er_mort_num`i'_20==. & er_util`i'_20!=. 
	replace ipd_mort_num`i'_20 = 0     if ipd_mort_num`i'_20==. & ipd_util`i'_20!=. 
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-June20_fordatacleaning1.xlsx", firstrow(variable) replace

/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over 12 months. Any value that is greater 
or smaller than 3SD from the mean 12-month trend is set to missing
This is only applied if the mean of the series is greater or equal to 1 
This technique avoids flagging as outlier a value of 1 if facility reports: 
0 0 0 0 0 1 0 0 0 0 0 0  which is common for mortality

Hypertension and diabetes (util and quality) were incomplete until October 2019. 
We won't drop outliers for these 4 variables, as we do not have 12 months of data.
KMC quality and Newborn resuscitated were extracted as proportions, we also do not include those in outlier assessement */

foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
				ipd_util er_util road_util   cerv_qual ///
				opd_util hivsupp_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util  ///
				newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3*(rowsd`x'))
	gen neg_out`x' = rowmean`x'-(3*(rowsd`x'))
	forval i = 1/12 {
		gen flag_outlier_`x'`i'= 1 if `x'`i'_19>pos_out`x' & `x'`i'_19<.
		replace flag_outlier_`x'`i'= 1 if `x'`i'_19 < neg_out`x'
		replace flag_outlier_`x'`i'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less
		replace `x'`i'_19=. if flag_outlier_`x'`i'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x' flag_outlier_`x'*
}
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-June20_fordatacleaning2.xlsx", firstrow(variable) replace
/****************************************************************
                    CALCULATE COMPLETENESS
****************************************************************
Completeness for each indicator-month
This calculates the % of facilities reporting each indicator every month from 
the max facilities that have reported over the period (since we dont have a census)
Creates a flag variable if less than 95% of expected facilities are reporting */
foreach x of global all {
	forval i=1/12 {
		egen nb`x'`i'_19 = count(`x'`i'_19) 
	}
	forval i=1/6 { // ends at june for now
		egen nb`x'`i'_20 = count(`x'`i'_20) 
	}
	egen maxfac`x' = rowmax (nb`x'*)
	forval i=1/12 {
		gen compl19_`x'`i'= nb`x'`i'_19/maxfac`x' 
		lab var compl19_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	forval i=1/6 {
		gen compl20_`x'`i'= nb`x'`i'_20/maxfac`x' 
		lab var compl20_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	drop nb`x'* maxfac`x'
}

	tabstat compl*, c(s) s(min) // Review completeness here
	
* Create flags for low completeness
foreach v of varlist compl* {
	gen flag`v' = 1 if `v'<0.95
	lab var flag`v' "Completeness < 95%"
}
*Drop all empty flags // remaining flags will identify the months < 95%
foreach var of varlist flag* {
     capture assert mi(`var')
     if !_rc {
        drop `var'
     }
 }
drop compl* 
*Investigate flags that remain 
/****************************************************************
Diabetes and hypertension were only collected starting OCT 2019
Drop any values for utilisation and quality from Jan to Sep 2019
****************************************************************/
foreach x in diab_util diab_qual_num hyper_util hyper_qual_num {
	forval i = 1/9 {
		drop `x'`i'_19
	}
}
drop flagcompl*diab* flagcompl*hyper*  

/***************************************************************
                 COMPLETE CASE ANALYSIS
****************************************************************
Completeness is an issue, particularly March-June 2020. Some Woredas 
have not reported yet. For each variable, keep only heath facilities that 
have reported at least 14 out of 18 months (incl the latest 3 months) 
This brings completeness up "generally" above 90% for all variables. 
This won't include diabetes and hypertension because they started
in October 2019. */
drop flag* 
foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			 opd_util ipd_util er_util road_util  kmc_qual resus_qual  cerv_qual ///
			 art_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			 measles_qual opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num mat_mort_num ///
			 er_mort_num icu_mort_num ipd_mort_num  {
	preserve
		keep region  zone org `x'* 
		egen total`x'= rownonmiss(`x'*)
		keep if total`x'>14 & `x'4_20!=. & `x'5_20!=. & `x'6_20!=. 
		* keep if at least 14 out of 18 months are reported & april-jun 2020 are reported 
		* keep if total`x'== 18
		drop total`x'
		save "$user/$data/Data for analysis/tmp`x'.dta", replace
	restore
}

keep region zone org diab* hyper* 
egen total = rowtotal(diab_util10_19-hyper_qual_num6_20), m
drop if total==.
drop total 
save "$user/$data/Data for analysis/tmpdiab_hyper.dta", replace

* Merge together
foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
				opd_util ipd_util er_util road_util  kmc_qual resus_qual  cerv_qual ///
				art_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num mat_mort_num ///
				er_mort_num icu_mort_num ipd_mort_num  {
			 	merge 1:1 region  zone org using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_WIDE_CCA.dta", replace
	}
	
foreach x in diab_hyper fp_util sti_util anc_util del_util cs_util pnc_util diarr_util ///
				pneum_util sam_util ipd_util er_util road_util  kmc_qual resus_qual cerv_qual ///
				art_util opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num mat_mort_num ///
				er_mort_num icu_mort_num ipd_mort_num  {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
/****************************************************************
EXPORT RECODED DATA FOR VISUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-June20_fordatacleaning3.xlsx", firstrow(variable) replace

/******************************************************************************
 Calculate total deliveries and total inpatients for mortality indicators
*******************************************************************************/ 
forval i = 1/12 {
	egen totaldel`i'_19 = rowtotal(del_util`i'_19  cs_util`i'_19)
	egen totalipd_mort`i'_19= rowtotal(ipd_mort_num`i'_19 icu_mort_num`i'_19), m	
	drop icu_mort_num`i'_19
	* total of Inpatient and ICU deaths since we don't have ICU utilisation
}
forval i = 1/6 {
	egen totaldel`i'_20 = rowtotal(del_util`i'_20  cs_util`i'_20)
	egen totalipd_mort`i'_20= rowtotal(ipd_mort_num`i'_20 icu_mort_num`i'_20), m
	drop icu_mort_num`i'_20
	* total of Inpatient and ICU deaths since we don't have ICU utilisation
}

save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_WIDE_CCA.dta", replace

/****************************************************************
                  RESHAPE TO LONG
*****************************************************************/	
reshape long  diab_util hyper_util diab_qual_num hyper_qual_num fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util kmc_qual resus_qual cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num totaldel ///
			  totalipd_mort, i(region zone org) j(month) string

* Labels (And dashboard format)
* Volume RMNCH services TOTALS
	lab var fp_util "Number of new and current users of contraceptives"
	lab var sti_util "Number of consultations for STI care"
	lab var anc_util "Total number of antenatal care visits"
	lab var del_util "Number of facility deliveries"
	lab var cs_util "Number of caesarean sections"
	lab var diarr_util "Number children treated with ORS for diarrhea"
	lab var pneum_util "Number of consultations for sick child care - pneumonia"
	lab var sam_util "Number of children screened for malnutrition"
	lab var pnc_util "Number of postnatal visits within 7 days of birth" 
* Vaccines TOTALS
	lab var vacc_qual "Number fully vaccinated by age 1"
	lab var bcg_qual "Nb children vaccinated with bcg vaccine"
	lab var pent_qual "Nb children vaccinated with 3rd dose pentavalent"
	lab var measles_qual "Nb children vaccinated with measles vaccine"
	lab var opv3_qual "Nb children vaccinated with 3rd dose oral polio vaccine"
	lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	 TOTALS
	lab var diab_util "Number of diabetic patients enrolled"
	lab var hyper_util "Number of hypertensive patients enrolled"
	lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
	lab var road_util "Number of road traffic injuries"
	lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
* Quality MEANS
	lab var kmc_qual "% of LBW babies initiated on KMC"
	*lab var cs_qual "Caesarean rates"
	lab var resus_qual "% asphyxiated neonates who were resuscitated and survived"
	*lab var diab_qual "% diabetic patients with controlled blood sugar"
	*lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
	*lab var hivsupp_qual "% ART patients with undetect VL"
* Institutional mortality MEANS
	*lab var newborn_mort "Institutional newborn deaths per 1000"
	*lab var sb_mort "Institutional stillbirths per 1000 "
	*lab var mat_mort "Institutional maternal deaths per 1000"
	*lab var er_mort "Emergency room deaths per 1000"
	*lab var ipd_mort "Inpatient (incl. ICU) deaths per 1000"
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
rename mo month
sort region zone organisationunitname year mo
order region zone organisationunitname year mo

save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_clean.dta", replace

/****************************************************************
  COLLAPSE TO REGION TOTALS AND RESHAPE FOR DASHBOARD
*****************************************************************/
u "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_WIDE_CCA.dta", clear
drop kmc* resus*
collapse (sum) diab_util10_19-totalipd_mort6_20 , by(region)
encode region, gen(reg)
drop region
order reg
set obs 12
foreach x of var _all    {
	egen `x'tot= total(`x'), m
	replace `x'= `x'tot in 12
	drop `x'tot
}
decode reg, gen(region)
replace region="National" if region==""
drop reg
order region

reshape long  diab_util hyper_util diab_qual_num hyper_qual_num fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util  cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num totaldel ///
			  totalipd_mort, i(region ) j(month) string
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
rename mo month
sort region year month
order region year month 

* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
	sam_util opd_util ipd_util er_util road_util  cerv_qual art_util ///
	hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
	newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num totaldel totalipd_mort ///
	diab_util hyper_util diab_qual_num hyper_qual_num
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/Data for analysis/temp.dta", replace
restore
keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
	}
drop year
merge m:m region month using "$user/$data/Data for analysis/temp.dta"
drop _merge

rm "$user/$data/Data for analysis/temp.dta"


export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Jun20_fordashboard.csv", replace









