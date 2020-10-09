* HS performance during Covid
* Ethiopia 
* Data cleaning, January-June 2020 
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

u "$user/$data/Data for analysis/Ethiopia_Jan19-June20_WIDE.dta", clear

****NEW TEXT IS RIGHT HERE*****

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

* 3710 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(fp_util1_20-icu_mort_num12_19), m
drop if all_visits==.
drop all_visits 
* Retains 2383 woreda/facilities with some data from Jan19-Jun20

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
				ipd_util er_util road_util diab_util hyper_util kmc_qual resus_qual  cerv_qual ///
				hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual 

global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num 

global all $volumes $mortality

order  region zone org fp_util*_19 fp_util*_20  anc_util*_19 anc_util*_20 del_util*_19 del_util*_20  cs_util*_19 ///
	  cs_util*_20 sti_util*_19 sti_util*_20  pnc_util*_19 pnc_util*_20 diarr_util*_19 diarr_util*_20 ///
	  pneum_util*_19 pneum_util*_20 sb_mort*_19 sb_mort*_20 mat_mort*_19 mat_mort*_20 sam_util*_19 sam_util*_20 ///
	  ipd_util*_19 ipd_util*_20 er_util*_19 er_util*_20 road_util*_19 road_util*_20 diab_util*_19 diab_util*_20 ///
	  hyper_util*_19 hyper_util*_20 kmc_qual*_19 kmc_qual*_20 resus_qual*_19 resus_qual*_20  cerv_qual*_19 cerv_qual*_20 ///
	  hivsupp_qual_num*_19 hivsupp_qual_num*_20  diab_qual_num*_19 diab_qual_num*_20 hyper_qual_num*_19 hyper_qual_num*_20  ///
	  vacc_qual*_19 vacc_qual*_20 pent_qual*_19 pent_qual*_20 bcg_qual*_19 bcg_qual*_20 measles_qual*_19 measles_qual*_20 ///
	  opv3_qual*_19 opv3_qual*_20 pneum_qual*_19 pneum_qual*_20 rota_qual*_19 rota_qual*_20 
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
For mortality, if a faciity reports a death (or a 0) at any point during the year then missings will be replaced by 0s for all other months
Missingness doesnt need to be consistent since deaths are rare */
foreach x of global mortality  {
	egen total`x' = rowtotal(`x'*), m  // sums all the deaths and sets new var to . if all vars are missing
	forval i = 1/12 {
		replace `x'`i'_19=0 if `x'`i'_19==. & total`x'!=. // replaces to 0 all the missings if there was a value during period
	}
	forval i= 1/6 { 
		replace `x'`i'_20=0 if `x'`i'_20==. & total`x'!=.
	}
	drop total`x'
}
/* We also need to put 0s for facilities that had deliveries, ER visits and Inpatient admissions, but no deaths all year
Otherwise, average mortality will be inflated */
egen somedeliveries= rowtotal(del_util*), m 
egen someinpatient= rowtotal(ipd_util*), m 
egen someer= rowtotal(er_util*), m 
forval i = 1/12 {
	replace newborn_mort_num`i'_19 = 0 if newborn_mort_num`i'_19==. & somedeliveries>0 & somedeliveries<.
	replace sb_mort_num`i'_19 = 0 	   if sb_mort_num`i'_19==. &  somedeliveries>0 & somedeliveries<. 
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & somedeliveries>0 & somedeliveries<. 
	replace er_mort_num`i'_19 = 0      if er_mort_num`i'_19==. & someer>0 & someer<. 
	replace ipd_mort_num`i'_19 = 0     if ipd_mort_num`i'_19==. & someinpatient>0 & someinpatient<. 
}
forval i = 1/6 {
	replace newborn_mort_num`i'_20 = 0 if newborn_mort_num`i'_20==. & somedeliveries>0 & somedeliveries<.
	replace sb_mort_num`i'_20 = 0 	   if sb_mort_num`i'_20==. &  somedeliveries>0 & somedeliveries<. 
	replace mat_mort_num`i'_20 = 0     if mat_mort_num`i'_20== . & somedeliveries>0 & somedeliveries<. 
	replace er_mort_num`i'_20 = 0      if er_mort_num`i'_20==. & someer>0 & someer<. 
	replace ipd_mort_num`i'_20 = 0     if ipd_mort_num`i'_20==. & someinpatient>0 & someinpatient<. 
}
drop some*
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-June20_fordatacleaning1.xlsx", firstrow(variable) replace

/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over 12 months in volume data
Any value that is greater or smaller than 3SD from the mean 12-month trend is set to missing
This is only applied if the mean of the series is greater or equal to 1 
This technique avoids flagging as outlier a value of 1 if facility reports: 
0 0 0 0 0 1 0 0 0 0 0 0  which is common for mortality

Hypertension and diabetes (util and quality) were incomplete until October 2019. 
We wont drop outliers for these 4 variables, as we do not have 12 months of data.
KMC quality and Newborn resuscitated were provided as proportions, we also do not include those in outlier assessement */

foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
				ipd_util er_util road_util kmc_qual resus_qual cerv_qual hivsupp_qual_num  ///
				 vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual   {
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
/****************************************************************
		REVIEW COMPLETENESS
****************************************************************/
tabstat compl*, c(s) s(min) 
	
* Create flags for low completeness
foreach v of varlist compl* {
	gen flag`v' = 1 if `v'<0.90
	lab var flag`v' "Completeness < 90%"
}
*Drop all empty flags // remaining flags will identify the months < 95%
foreach var of varlist flag* {
     capture assert mi(`var')
     if !_rc {
        drop `var'
     }
 }
drop compl* 

* Investigate flags that remain 
/****************************************************************
DIABETES AND HYPERTENSION STARTED BEING COLLECTED IN OCT 19
drop any values for utilisation and quality from Jan to Sep 2019
****************************************************************/
foreach x in diab_util diab_qual_num hyper_util hyper_qual_num {
	forval i = 1/9 {
		drop `x'`i'_19
	}
}
drop flagcompl*diab* flagcompl*hyper*  
/******************************************************************************
 CALCULATE INDICATORS (NUM/DENOM) HERE, ONCE DATA CLEANING COMPLETE
 Quality and mortality indicators
*******************************************************************************/ 
forval i = 1/12 {
	egen totaldel`i'_19 = rowtotal(del_util`i'_19  cs_util`i'_19)
	gen cs_qual`i'_19 = cs_util`i'_19 / (totaldel`i'_19) // Csection %
	gen hivsupp_qual`i'_19 = hivsupp_qual_num`i'_19 / art_util`i'_19 // VL supression %
	gen newborn_mort`i'_19 = newborn_mort_num`i'_19 / (totaldel`i'_19) // newborn mortality per 1000 
	gen sb_mort`i'_19 = sb_mort_num`i'_19 / (totaldel`i'_19) // stillbirth rate per 1000
	gen mat_mort`i'_19 = mat_mort_num`i'_19 / (totaldel`i'_19) // Maternal mortality per 1000 deliveries
	egen tempipd_mort`i'_19= rowtotal(ipd_mort_num`i'_19 icu_mort_num`i'_19), m	 // total of Inpatient and ICU deaths since we don't have ICU utilisation
	gen ipd_mort`i'_19 = tempipd_mort`i'_19 / ipd_util`i'_19 // Inpatient mortality per 1000 inpatient admission
	drop tempipd_mort`i'_19
	gen er_mort`i'_19 = er_mort_num`i'_19 / er_util`i'_19 // ER mortality per 1000 ER visits
}
forval i = 1/6 {
	egen totaldel`i'_20 = rowtotal(del_util`i'_20  cs_util`i'_20)
	gen cs_qual`i'_20 = cs_util`i'_20 / (totaldel`i'_20) // Csection %
	gen hivsupp_qual`i'_20 = hivsupp_qual_num`i'_20 / art_util`i'_20 // VL supression %
	gen newborn_mort`i'_20 = newborn_mort_num`i'_20 / (totaldel`i'_20) // newborn mortality per 1000 
	gen sb_mort`i'_20 = sb_mort_num`i'_20 / (totaldel`i'_20) // stillbirth rate per 1000
	gen mat_mort`i'_20 = mat_mort_num`i'_20 / (totaldel`i'_20) // Maternal mortality per 1000 deliveries
	egen tempipd_mort`i'_20= rowtotal(ipd_mort_num`i'_20 icu_mort_num`i'_20), m	 // total of Inpatient and ICU deaths since we don't have ICU utilisation
	gen ipd_mort`i'_20 = tempipd_mort`i'_20 / ipd_util`i'_20 // Inpatient mortality per 1000 inpatient admission
	drop tempipd_mort`i'_20
	gen er_mort`i'_20 = er_mort_num`i'_20 / er_util`i'_20 // ER mortality per 1000 ER visits
}
 * Diabetes and hypertension only available Occtober to December 2019
 forval i = 10/12 {
 	gen diab_qual`i'_19 = diab_qual_num`i'_19 / diab_util`i'_19 // control diabetes %
	gen hyper_qual`i'_19 = hyper_qual_num`i'_19 / hyper_util`i'_19 // control hypertension %
	replace diab_qual`i'_19= . if  diab_qual`i'_19 >1
	replace hyper_qual`i'_19= . if hyper_qual`i'_19 >1
 }
 forval i = 1/6{
 	gen diab_qual`i'_20 = diab_qual_num`i'_20 / diab_util`i'_20 // control diabetes %
	gen hyper_qual`i'_20 = hyper_qual_num`i'_20 / hyper_util`i'_20 // control hypertension %
	replace diab_qual`i'_20= . if  diab_qual`i'_20 >1
	replace hyper_qual`i'_20= . if hyper_qual`i'_20 >1
 }
* REPLACE TO MISSING ANY % indicator that is greater than 1 
foreach x in kmc_qual resus_qual cs_qual hivsupp_qual  newborn_mort sb_mort mat_mort ipd_mort er_mort   {
	forval i = 1/12 {
		replace `x'`i'_19 = . if `x'`i'_19 >1
	}
	forval i=1/6 {
		replace `x'`i'_20 = . if `x'`i'_20 >1
	}
}
order cs_qual* hivsupp_qual* diab_qual* hyper_qual* newborn_mort* sb_mort* mat_mort* ipd_mort* er_mort*, after (rota_qual12_19)
* MORTALITY PER 1000
forval i = 1/12 {
	replace newborn_mort`i'_19 = newborn_mort`i'_19*1000
	replace sb_mort`i'_19 = sb_mort`i'_19*1000
	replace mat_mort`i'_19 = mat_mort`i'_19*1000
	replace ipd_mort`i'_19 = ipd_mort`i'_19*1000
	replace er_mort`i'_19 = er_mort`i'_19*1000
}
forval i = 1/6 {
	replace newborn_mort`i'_20 = newborn_mort`i'_20*1000
	replace sb_mort`i'_20 = sb_mort`i'_20*1000
	replace mat_mort`i'_20 = mat_mort`i'_20*1000
	replace ipd_mort`i'_20 = ipd_mort`i'_20*1000
	replace er_mort`i'_20 = er_mort`i'_20*1000
}
drop totaldel*
save "$user/$data/Ethiopia_Jan19-June20_WIDE.dta", replace
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-Jun20_fordatacleaning2.xlsx", firstrow(variable) replace

/****************************************************************
                  RESHAPE FOR DASHBOARD
*****************************************************************/	
drop *_num*_19 *_num*_20 flag* 
reshape long  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ipd_util er_util ///
		road_util diab_util hyper_util kmc_qual resus_qual cs_qual cerv_qual hivsupp_qual diab_qual hyper_qual vacc_qual pent_qual bcg_qual ///
		measles_qual opv3_qual pneum_qual rota_qual newborn_mort sb_mort mat_mort er_mort ipd_mort, ///
		i(unit_id) j(month) string

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
	lab var cs_qual "Caesarean rates"
	lab var resus_qual "% asphyxiated neonates who were resuscitated and survived"
	lab var diab_qual "% diabetic patients with controlled blood sugar"
	lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
	lab var hivsupp_qual "% ART patients with undetect VL"
* Institutional mortality MEANS
	lab var newborn_mort"Institutional newborn deaths per 1000"
	lab var sb_mort "Institutional stillbirths per 1000 "
	lab var mat_mort "Institutional maternal deaths per 1000"
	lab var er_mort "Emergency room deaths per 1000"
	lab var ipd_mort "Inpatient (incl. ICU) deaths per 1000"
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" |	month=="6_20"  | ///
                	month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" |	month=="11_20" |	month=="12_20"
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

export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Jun20_fordashboard.csv", replace









