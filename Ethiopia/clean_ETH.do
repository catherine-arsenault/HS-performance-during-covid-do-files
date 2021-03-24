* HS performance during Covid
* Ethiopia 
* Data cleaning, January-October 2020 
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

u "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE.dta", clear

********************************************************************
* 3616 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(fp_util1_19-totaldel10_20), m
drop if all_visits==.
drop all_visits 
* Retains 2336 woreda/facilities with some data from Jan19-Oct20
********************************************************************
global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom  
				
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num 

global all $volumes $mortality

/****************************************************************
TOTAL NUMBER OF FACILITIES REPORTING ANY DATA: exported to excel 
****************************************************************/
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
}
recode *_report (0=0) (1/22=1) //Jan19-Oct20:22 months 

putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(Tot reporting, replace)  modify
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
	local all  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num ///
				mat_mort_num er_mort_num icu_mort_num ipd_mort_num  
	reshape long `all', i(org*) j(month, string)		  
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(MinMax fac reporting 22mos, replace)  modify
	
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

* Overall mean
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
	recode `var'_report (0=0) (1/999999=1) 
	egen `var'_total_report = total(`var'_report)
	egen `var'_sum = rowtotal(`var'*)
	egen `var'_total_sum = total(`var'_sum) 
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}

putexcel set "$user/$data/Codebook for Ethiopia.xlsx", sheet(Tot reporting)  modify
putexcel E2 = "Variable"
putexcel F2 = "Mean per facility"	
local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel E`i' = "`var'"
	qui sum `var'_total_mean
	putexcel F`i' = `r(mean)'
}
drop *_report *_sum *_mean
/****************************************************************
EXPORT DATA BEFORE RECODING FOR VISUAL INSPECTION
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-October20_fordatacleaning1.xlsx", firstrow(variable) replace

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
	replace icu_mort_num`i'_19 = 0     if icu_mort_num`i'_19==. & ipd_util`i'_19!=. // we don't have ICU admissions so we use inpatient
}
forval i = 1/10 {
	replace newborn_mort_num`i'_20 = 0 if newborn_mort_num`i'_20==. & totaldel`i'_20!=. 
	replace sb_mort_num`i'_20 = 0 	   if sb_mort_num`i'_20==. & totaldel`i'_20!=. 
	replace mat_mort_num`i'_20 = 0     if mat_mort_num`i'_20== . & totaldel`i'_20!=. 
	replace er_mort_num`i'_20 = 0      if er_mort_num`i'_20==. & er_util`i'_20!=. 
	replace ipd_mort_num`i'_20 = 0     if ipd_mort_num`i'_20==. & ipd_util`i'_20!=.
	replace icu_mort_num`i'_20 = 0     if icu_mort_num`i'_20==. & ipd_util`i'_20!=. // we don't have ICU admissions so we use inpatient
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel org* *mort_num* using "$user/$data/Data cleaning/Ethio_Jan19-Aug20_fordatacleaning2.xlsx", firstrow(variable) replace

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

foreach x in  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				icu_mort_num ipd_mort_num {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
			gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold 
			foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				         1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 {  // until Oct 2020 
				         *  11_20 12_20
		gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

****************************************************************
* 			OTHER DATA QUALITY EDITS
****************************************************************
*Newborn resuscitation and KMC intitatied
*Replace numberator as missing if it is greater than denominator 
forval i=1/12 {
	replace kmc_qual_num`i'_19 = . if kmc_qual_num`i'_19 > kmc_qual_denom`i'_19 & kmc_qual_num`i'_19 !=.
	replace resus_qual_num`i'_19 = . if resus_qual_num`i'_19 > resus_qual_denom`i'_19 & resus_qual_num`i'_19 !=.
}

forval i=1/10 { // until Oct 2020
	replace kmc_qual_num`i'_20 = . if kmc_qual_num`i'_20 > kmc_qual_denom`i'_20 & kmc_qual_num`i'_20 !=.
	replace resus_qual_num`i'_20 = . if resus_qual_num`i'_20 > resus_qual_denom`i'_20 & resus_qual_num`i'_20 !=.
}

*Diabetes and hypertension were only collected starting October 2019
*Drop variables for utilisation and quality from Jan to Sep 2019
foreach x in diab_util diab_qual_num hyper_util hyper_qual_num ///
			 diab_detec hyper_detec {
	forval i = 1/9 {
		drop `x'`i'_19
	}
}
* Calculate total inpatients deaths
forval i = 1/12 {
	egen totalipd_mort`i'_19= rowtotal(ipd_mort_num`i'_19 icu_mort_num`i'_19), m	
	drop ipd_mort_num`i'_19 icu_mort_num`i'_19
	rename totalipd_mort`i'_19 totalipd_mort_num`i'_19
	* total of Inpatient and ICU deaths since we don't have ICU utilisation
}
forval i = 1/10 {
	egen totalipd_mort`i'_20= rowtotal(ipd_mort_num`i'_20 icu_mort_num`i'_20), m
	drop ipd_mort_num`i'_20 icu_mort_num`i'_20
	rename totalipd_mort`i'_20 totalipd_mort_num`i'_20
}


save "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_AN.dta", replace 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-Aug20_fordatacleaning3.xlsx", firstrow(variable) replace

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly for the latest months (there are important
delays in reporting). For each variable, keep only heath facilities that 
have reported at least 17 out of 22 months (incl the latest 2 months) 
This brings completeness up "generally" above 90% for all variables.

Lines 180-194 below ignore  diabetes and hypertension because they were not 
collected until October 2019  */
	
	foreach x in  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				totalipd_mort_num {
			  preserve
					keep  org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=17 & `x'9_20!=. & `x'10_20!=. 
					/* keep if at least 17 out of 22 months are reported 
					& Sep/Oct 2020 are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	preserve 
		keep  org* diab* hyper* 
		egen total = rowtotal(diab_util10_19-hyper_qual_num10_20), m // until Oct 2020
		drop if total==.
		drop total 
		save "$user/$data/Data for analysis/tmpdiab_hyper.dta", replace
	restore 
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
		* all variables except the first (fp_util) and diabetes hypertension
		* diabetes and hypertension are saved under diab_hyper
		foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
					totaldel ipd_util er_util road_util  cerv_qual diab_hyper ///
					opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
					measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
					resus_qual_num resus_qual_denom  newborn_mort_num sb_mort_num mat_mort_num er_mort_num totalipd_mort_num  {
			 	merge 1:1  org* using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_DB.dta", replace
		}
* Region names	
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname
	
save "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_DB.dta", replace

/***************************************************************
                 COMPLETE CASE ANALYSIS DATASET
			   COMPARING QUARTERS 2 (2020 vs 2019)
****************************************************************
we keep only those facilities that reported months of interest. In this case,
we are comparing Quarters 2 2020 vs. 2019 */
u "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_AN.dta", clear

foreach x in  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				totalipd_mort_num {
			  preserve
					keep  org* `x'* 
					keep if `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & ///
							`x'4_20!=. & `x'5_20!=. & `x'6_20!=.
					/* keep if Q2 2020 and 2019 are not missing */

					*drop total`x'

					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
	foreach x in  sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				totalipd_mort_num  {
			 	merge 1:1  org* using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
			  }
			  
* Reshape for analyses
reshape long  fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util  cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num  totaldel ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
			  totalipd_mort_num , i( org*) j(month) string	
	
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
sort org* year mo 
order org* year mo 
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
	*lab var diab_util "Number of diabetic patients enrolled"
	*lab var hyper_util "Number of hypertensive patients enrolled"
	lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
	lab var road_util "Number of road traffic injuries"
	lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
	*lab var diab_qual_num "Number of diabetic patients enrolled to care"
	*lab var hyper_qual_num "Number of hypertensive patients enrolled to care"
	lab var totaldel "Total number of births attended by skilled health personnel"
	lab var hivsupp_qual_num "Nb of adult and pediatric patients with viral load <1,000 copies/ml"
	lab var kmc_qual_num "Nb of newborns weighting <2000g and/or premature newborns for which KMC initiated" 
	lab var kmc_qual_denom "Total number of newborns weighting <2000gm and/or premature"
	lab var resus_qual_num "Total number of neonates resusciated and survived"
	lab var resus_qual_denom "Total number of neonates resuscitated"
* Institutional mortality 
	lab var newborn_mort_num "Institutional newborn deaths"
	lab var sb_mort_num "Institutional stillbirths per 1000 "
	lab var mat_mort_num "Institutional maternal deaths per 1000"
	lab var er_mort_num "Emergency room deaths per 1000"
	*lab var ipd_mort_num "Inpatient deaths per 1000"
	*lab var icu_mort_num "ICU deaths per 1000"
	lab var totalipd_mort_num "Total inpatient (incl. ICU) deaths per 1000" 

* Region names	
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname
	
	
* drop the other months
keep if month>=4 & month<=6
 
save "$user/$data/Data for analysis/Ethiopia_CCA_Q2.dta", replace


/***************************************************************
                 COMPLETE CASE ANALYSIS DATASET
			       COMPARING QUARTERS 1 AND 2 OF 2020
****************************************************************
we keep only those facilities that reported all months of interest. In this case,
we are comparing the first and second quarters of 2020 */

u "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_AN.dta", clear

	foreach x in  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				totalipd_mort_num diab_util diab_detec diab_qual_num hyper_util hyper_detec hyper_qual_num {
			  preserve
					keep  org* `x'* 
					keep if `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & ///
							`x'4_20 !=. & `x'5_20 !=. & `x'6_20 !=.
					/* keep if Q1 and Q2 2020 are fully reported  */
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
			  restore
				}
	
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
		* all variables except the first (fp_util) 
		foreach x in  sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
					totaldel ipd_util er_util road_util  cerv_qual ///
					opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
					measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
					resus_qual_num resus_qual_denom  newborn_mort_num sb_mort_num ///
					diab_util diab_detec diab_qual_num hyper_util hyper_detec hyper_qual_num ///
					mat_mort_num er_mort_num totalipd_mort_num  {
			 	merge 1:1  org* using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Q1_Q2_2020_comparisons.dta", replace
		}
		
reshape long fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
		totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom  newborn_mort_num sb_mort_num ///
				mat_mort_num er_mort_num totalipd_mort_num, i( org*) j(month) string	
* Region names	
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname
	

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
	*lab var diab_util "Number of diabetic patients enrolled"
	*lab var hyper_util "Number of hypertensive patients enrolled"
	lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
	lab var road_util "Number of road traffic injuries"
	lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
	*lab var diab_qual_num "Number of diabetic patients enrolled to care"
	*lab var hyper_qual_num "Number of hypertensive patients enrolled to care"
	lab var totaldel "Total number of births attended by skilled health personnel"
	lab var hivsupp_qual_num "Nb of adult and pediatric patients with viral load <1,000 copies/ml"
	lab var kmc_qual_num "Nb of newborns weighting <2000g and/or premature newborns for which KMC initiated" 
	lab var kmc_qual_denom "Total number of newborns weighting <2000gm and/or premature"
	lab var resus_qual_num "Total number of neonates resusciated and survived"
	lab var resus_qual_denom "Total number of neonates resuscitated"
* Institutional mortality 
	lab var newborn_mort_num "Institutional newborn deaths"
	lab var sb_mort_num "Institutional stillbirths per 1000 "
	lab var mat_mort_num "Institutional maternal deaths per 1000"
	lab var er_mort_num "Emergency room deaths per 1000"
	*lab var ipd_mort_num "Inpatient deaths per 1000"
	*lab var icu_mort_num "ICU deaths per 1000"
	lab var totalipd_mort "Total inpatient (incl. ICU) deaths per 1000" 

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
sort org* year mo 
order org* year mo 
rename mo month

*drop the other months
keep if (month >=1 & month<=3 & year ==2020) | (month >=4 & month<=6 & year ==2020)

* THIS IS THE DATASET USED TO COMPARE Q2 2020 TO Q2 2019: 
save "$user/$data/Data for analysis/Ethiopia_Q1_Q2_2020_comparisons.dta", replace

/***************************************************************
                 COMPLETE CASE ANALYSIS DATASET
			       COMPARING QUARTERS 1 AND 3 OF 2020
****************************************************************
we keep only those facilities that reported all months of interest. In this case,
we are comparing the first and second quarters of 2020 */

u "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_AN.dta", clear

	foreach x in  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			  totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom newborn_mort_num sb_mort_num mat_mort_num er_mort_num ///
				totalipd_mort_num diab_util diab_detec diab_qual_num hyper_util hyper_detec hyper_qual_num {
			  preserve
					keep  org* `x'* 
					keep if `x'1_20!=. & `x'2_20!=. & `x'3_20!=. & ///
							`x'7_20 !=. & `x'8_20 !=. & `x'9_20 !=.
					/* keep if Q1 and Q2 2020 are fully reported  */
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
			  restore
				}
	
	
	u "$user/$data/Data for analysis/tmpfp_util.dta", clear
		* all variables except the first (fp_util) 
		foreach x in  sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
					totaldel ipd_util er_util road_util  cerv_qual ///
					opd_util hivsupp_qual_num  vacc_qual pent_qual bcg_qual ///
					measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
					resus_qual_num resus_qual_denom  newborn_mort_num sb_mort_num ///
					diab_util diab_detec diab_qual_num hyper_util hyper_detec hyper_qual_num ///
					mat_mort_num er_mort_num totalipd_mort_num  {
			 	merge 1:1  org* using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Q1_Q3_2020_comparisons.dta", replace
		}
		
reshape long fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
		totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util kmc_qual_num kmc_qual_denom ///
				resus_qual_num resus_qual_denom  newborn_mort_num sb_mort_num ///
				mat_mort_num er_mort_num totalipd_mort_num, i( org*) j(month) string	
* Region names	
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname
	

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
	*lab var diab_util "Number of diabetic patients enrolled"
	*lab var hyper_util "Number of hypertensive patients enrolled"
	lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
	lab var road_util "Number of road traffic injuries"
	lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
	*lab var diab_qual_num "Number of diabetic patients enrolled to care"
	*lab var hyper_qual_num "Number of hypertensive patients enrolled to care"
	lab var totaldel "Total number of births attended by skilled health personnel"
	lab var hivsupp_qual_num "Nb of adult and pediatric patients with viral load <1,000 copies/ml"
	lab var kmc_qual_num "Nb of newborns weighting <2000g and/or premature newborns for which KMC initiated" 
	lab var kmc_qual_denom "Total number of newborns weighting <2000gm and/or premature"
	lab var resus_qual_num "Total number of neonates resusciated and survived"
	lab var resus_qual_denom "Total number of neonates resuscitated"
* Institutional mortality 
	lab var newborn_mort_num "Institutional newborn deaths"
	lab var sb_mort_num "Institutional stillbirths per 1000 "
	lab var mat_mort_num "Institutional maternal deaths per 1000"
	lab var er_mort_num "Emergency room deaths per 1000"
	*lab var ipd_mort_num "Inpatient deaths per 1000"
	*lab var icu_mort_num "ICU deaths per 1000"
	lab var totalipd_mort "Total inpatient (incl. ICU) deaths per 1000" 

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
sort org* year mo 
order org* year mo 
rename mo month

*drop the other months
keep if (month >=1 & month<=3 & year ==2020) | (month >=7 & month<=9 & year ==2020)

* THIS IS THE DATASET USED TO COMPARE Q1 2020 TO Q3 2010: 
save "$user/$data/Data for analysis/Ethiopia_Q1_Q3_2020_comparisons.dta", replace
