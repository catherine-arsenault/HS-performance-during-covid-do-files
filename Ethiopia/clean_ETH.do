* HS performance during Covid
* Ethiopia 
* Data cleaning, January-August 2020 
/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER HEALTH FACILITY)

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

u "$user/$data/Data for analysis/Ethiopia_Jan19-August20_WIDE.dta", clear

*new data for resus_qual_num and resus_qual_denom and kmc_qual_num and kmc_qual_denom are available
order  region zone org unit_id fp_util*_19 fp_util*_20  anc_util*_19 anc_util*_20 del_util*_19 ///
	  del_util*_20 cs_util*_19 cs_util*_20 sti_util*_19 sti_util*_20  pnc_util*_19 pnc_util*_20 ///
	  diarr_util*_19  diarr_util*_20  pneum_util*_19 pneum_util*_20 art_util*_19 art_util*_20  ///
	  sam_util*_19 sam_util*_20 opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20 er_util*_19 ///
	  er_util*_20 road_util*_19 road_util*_20 diab_util*_19 diab_util*_20 hyper_util*_19 ///
	  hyper_util*_20 kmc_qual_num*_19 kmc_qual_num*_20 kmc_qual_denom*19 kmc_qual_denom*20 ///
	  resus_qual_num*_19 resus_qual_num*_20 resus_qual_denom*_19 resus_qual_denom*_20 ///
	  cerv_qual*_19 cerv_qual*_20 hivsupp_qual_num*_19 ///
	  hivsupp_qual_num*_20  diab_qual_num*_19 diab_qual_num*_20 hyper_qual_num*_19 hyper_qual_num*_20  ///
	  vacc_qual*_19 vacc_qual*_20 pent_qual*_19 pent_qual*_20 bcg_qual*_19 bcg_qual*_20 measles_qual*_19 ///
	  measles_qual*_20 opv3_qual*_19 opv3_qual*_20 pneum_qual*_19 pneum_qual*_20 rota_qual*_19 ///
	  rota_qual*_20 sb_mort*_19 sb_mort*_20 newborn_mort_num*_19 newborn_mort_num*_20 mat_mort*_19 ///
	  mat_mort*_20 er_mort_num*19 er_mort_num*20 icu_mort_num*19  icu_mort_num*20 ipd_mort_num*19 ///
	  ipd_mort_num*20 totaldel*_19 totaldel*_20 resus_qual*_19 resus_qual*_20 kmc_qual*_19 kmc_qual*_20 

*drop all resus_qual and kmc_qual
drop resus_qual1_19-resus_qual8_20 
drop kmc_qual1_19-kmc_qual8_20

********************************************************************
* 3669 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(fp_util1_19-ipd_mort_num8_20), m
drop if all_visits==.
drop all_visits 
* Retains 2376 woreda/facilities with some data from Jan19-Aug20
********************************************************************
global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util diab_util hyper_util  cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom  
				
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num 

global all $volumes $mortality

/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA
****************************************************************/
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/20=1) 

putexcel set "$user/$data/Analyses/Ethiopia changes 2019 2020.xlsx", sheet(Total facilities reporting, replace)  modify
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

/****************************************************************
EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-August20_fordatacleaning1.xlsx", firstrow(variable) replace

/*******************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS THE SERVICE THAT MONTH (E.G. DELIVERIES, INPATIENT ADMISSIONS)
********************************************************************	
For mortality, we inpute 0s if the facility had the service that the deaths
relate to that month. E.g. deliveries, ER visits or Inpatient admissions */
forval i = 1/12 {
	replace newborn_mort_num`i'_19 = 0 if newborn_mort_num`i'_19==. & totaldel`i'_19!=. 
	replace sb_mort_num`i'_19 = 0 	   if sb_mort_num`i'_19==.  & totaldel`i'_19!=. 
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & totaldel`i'_19!=. 
	replace er_mort_num`i'_19 = 0      if er_mort_num`i'_19==. & er_util`i'_19!=.
	replace ipd_mort_num`i'_19 = 0     if ipd_mort_num`i'_19==. & ipd_util`i'_19!=.
}
forval i = 1/8 {
	replace newborn_mort_num`i'_20 = 0 if newborn_mort_num`i'_20==. & totaldel`i'_20!=. 
	replace sb_mort_num`i'_20 = 0 	   if sb_mort_num`i'_20==. & totaldel`i'_20!=. 
	replace mat_mort_num`i'_20 = 0     if mat_mort_num`i'_20== . & totaldel`i'_20!=. 
	replace er_mort_num`i'_20 = 0      if er_mort_num`i'_20==. & er_util`i'_20!=. 
	replace ipd_mort_num`i'_20 = 0     if ipd_mort_num`i'_20==. & ipd_util`i'_20!=. 
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel region org* *mort_num* using "$user/$data/Data cleaning/Ethio_Jan19-Aug20_fordatacleaning1.xlsx", firstrow(variable) replace

/****************************************************************
         IDENTIFY OUTLIERS AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  

We do not assess outliers for diabetes and hypertension because they were 
not collected until October 2019 
MK: KMC and newborn resus was added 11/18/20*/

foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util   cerv_qual ///
			  opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual art_util ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 {  // until august 2020 
				 *  9_20 10_20 11_20 12_20
		gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

****************************************************************
* 					OTHER EDITS
****************************************************************
*Newborn resuscitation and KMC intitatied
*Replace numberator as missing if it is greater than denominator 
forval i=1/12 {
	replace kmc_qual_num`i'_19 = . if kmc_qual_num`i'_19 > kmc_qual_denom`i'_19 & kmc_qual_num`i'_19 !=.
	replace resus_qual_num`i'_19 = . if resus_qual_num`i'_19 > resus_qual_denom`i'_19 & resus_qual_num`i'_19 !=.
}

forval i=1/8 {
	replace kmc_qual_num`i'_20 = . if kmc_qual_num`i'_20 > kmc_qual_denom`i'_20 & kmc_qual_num`i'_20 !=.
	replace resus_qual_num`i'_20 = . if resus_qual_num`i'_20 > resus_qual_denom`i'_20 & resus_qual_num`i'_20 !=.
}
*Diabetes and hypertension were only collected starting OCT 2019
*Drop variables for utilisation and quality from Jan to Sep 2019
foreach x in diab_util diab_qual_num hyper_util hyper_qual_num {
	forval i = 1/9 {
		drop `x'`i'_19
	}
}
* Calculate total inpatients
forval i = 1/12 {
	egen totalipd_mort`i'_19= rowtotal(ipd_mort_num`i'_19 icu_mort_num`i'_19), m	
	* total of Inpatient and ICU deaths since we don't have ICU utilisation
}
forval i = 1/8 {
	egen totalipd_mort`i'_20= rowtotal(ipd_mort_num`i'_20 icu_mort_num`i'_20), m
}

save "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_WIDE_CCA_AN.dta", replace 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-Aug20_fordatacleaning2.xlsx", firstrow(variable) replace

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly for the latest month (there are important
delays in reporting). For each variable, keep only heath facilities that 
have reported at least 14 out of 18 months (incl the latest 2 months) 
This brings completeness up "generally" above 90% for all variables. */

	foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util   cerv_qual ///
			  opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual art_util ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom {
			  preserve
					keep region zone org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>16 & `x'7_20!=. & `x'8_20!=. 
					/* keep if at least 16 out of 20 months are reported 
					& Jul/Aug 2020 are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	preserve 
		keep region zone org diab* hyper* 
		egen total = rowtotal(diab_util10_19-hyper_qual_num6_20), m
		drop if total==.
		drop total 
		save "$user/$data/Data for analysis/tmpdiab_hyper.dta", replace
	restore 
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
	foreach x in diab_hyper sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util   cerv_qual ///
			  opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual art_util ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom {
			 	merge 1:1 region  zone org using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_WIDE_CCA_DB.dta", replace
		}

* Calculate total inpatients
forval i = 1/12 {
	egen totalipd_mort`i'_19= rowtotal(ipd_mort_num`i'_19 icu_mort_num`i'_19), m	
	drop icu_mort_num`i'_19
	* total of Inpatient and ICU deaths since we don't have ICU utilisation
}
forval i = 1/8 {
	egen totalipd_mort`i'_20= rowtotal(ipd_mort_num`i'_20 icu_mort_num`i'_20), m
	drop icu_mort_num`i'_20
}

save "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_WIDE_CCA_DB.dta", replace

/***************************************************************
                 COMPLETE CASE ANALYSIS 
				     FOR ANALYSES 
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */
u "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_WIDE_CCA_AN.dta", clear

foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util   cerv_qual ///
			  opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual art_util ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom totalipd_mort {
			 	preserve
					keep region zone org* `x'*
					keep if `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. & `x'8_19!=. & ///
							`x'4_20!=. & `x'5_20!=. & `x'6_20!=. & `x'7_20!=. & `x'8_20!=.
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
				preserve 
				keep region zone org diab* hyper* 
				egen total = rowtotal(diab_util10_19-hyper_qual_num6_20), m
				drop if total==.
				drop total 
				save "$user/$data/Data for analysis/tmpdiab_hyper.dta", replace
				restore 
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
	
	foreach x in diab_hyper sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util   cerv_qual ///
			  opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual art_util ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom totalipd_mort {
			 	merge 1:1 region zone org using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
			  }
* Reshape for analyses
reshape long fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util diab_util hyper_util  cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util newborn_mort_num sb_mort_num ///
				mat_mort_num er_mort_num icu_mort_num ipd_mort_num kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom totalipd_mort, i(region zone org) j(month) string	
	
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
sort region zone org* year mo 
rename mo month

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
* Institutional mortality 
	lab var newborn_mort_num "Institutional newborn deaths"
	lab var sb_mort_num "Institutional stillbirths per 1000 "
	lab var mat_mort_num "Institutional maternal deaths per 1000"
	lab var er_mort_num "Emergency room deaths per 1000"
	lab var ipd_mort_num "Inpatient (incl. ICU) deaths per 1000"

* THIS IS THE DATASET USED FOR ANALYSES:
save "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_clean_AN.dta", replace

