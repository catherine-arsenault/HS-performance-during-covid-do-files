* HS performance during Covid
* KZN, South Africa
* Data cleaning, January-December 2019 Baseline data
* Created by Catherine Arsenault, September 2020
/********************************************************************
SUMMARY: This do file contains methods to address data quality issues
in Dhis2. It uses a dataset in wide form (1 row per health facility)

1 Impute 0s for missing values: 
	- For volume data, missingness must be consistent
	- For mortality, 0s are imputed if the facility offers the
	  service the mortality indicator relates to.

2 Identify extreme outliers and set them to missing

3 Calculate completeness for each indicator-month 

4 Complete case analysis: keep only health facilities that have 
  reported every month (or nearly every month) 
  
5 Reshape dataset from wide to long.
********************************************************************/
clear all 
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"
global data "/HMIS Data for Health System Performance Covid (South Africa)"

u "$user/$data/Data for analysis/fac_wide.dta", clear

global volumes anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util er_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num
global all $volumes $mortality 

drop fp_util* hyper_util* /* these indicators are no longer collected after April 2020 (start of financial year)
							 Must be dropped from analysis */ 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning0.xlsx", firstrow(variable) replace

/***************************************************************
VOLUMES:  REPLACE MISSINGS TO 0 IF MISSINGNESS IS CONSISTENT
****************************************************************
Identify consistent missingnes in volume data 
We will not impute if the facility is missing data at the begining of the year and then starts reporting until the end of year
We will assume that a one time swtich from missing to non-missing is a new facility opening during the year
Or a facility reporting a new indicator 
In this case, replace the missings with zeros */
foreach x of global volumes  {
recode `x'1 (.=0) if `x'1==. & (`x'2!=. & `x'3!=. & `x'4!=. & `x'5!=. & `x'6!=. & `x'7!=. & `x'8!=. & `x'9!=. & `x'10!=. & ///
	   `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.) 
recode `x'1 `x'2 (.=0) if (`x'1==. & `x'2==.) & (`x'3!=. & `x'4!=. & `x'5!=. & `x'6!=. & `x'7!=. & `x'8!=. & `x'9!=. & ///
	   `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 (.=0) if (`x'1==. & `x'2==. & `x'3==.) & (`x'4!=. & `x'5!=. & `x'6!=. & `x'7!=. & `x'8!=. & `x'9!=. & ///
	   `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==.) & (`x'5!=. & `x'6!=. & `x'7!=. & `x'8!=. & `x'9!=. & ///
	   `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==.) & (`x'6!=. & `x'7!=. & `x'8!=. & ///
	   `x'9!=. & `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & `x'6==.) & (`x'7!=. & `x'8!=. & ///
	   `x'9!=. & `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & `x'6==. & `x'7==.) & (`x'8!=. & ///
       `x'9!=. & `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & `x'6==. & `x'7==. & ///
       `x'8==.) & (`x'9!=. & `x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & `x'6==. & `x'7==. & ///
       `x'8==. & `x'9==.) & (`x'10!=. & `x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & `x'6==. & ///
       `x'7==. & `x'8==. & `x'9==. & `x'10==.) & (`x'11!=. & `x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & ///
	   `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & ///
	   `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==.) & (`x'12!=. & `x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & ///
	   `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & ///
	   `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==.) & (`x'13!=. & `x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & ///
	   `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & ///
	   `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==.) & (`x'14!=. & `x'15!=. & `x'16!=. & `x'17!=. & `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 `x'14 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & `x'5==. & ///
	   `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==. & `x'14==.) & (`x'15!=. & `x'16!=. & `x'17!=. & ///
	   `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 `x'14 `x'15 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & ///
	   `x'5==. & `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==. & `x'14==. & `x'15==.) & (`x'16!=. & `x'17!=. & ///
	   `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 `x'14 `x'15 `x'16 (.=0) if (`x'1==. & `x'2==. & `x'3==. & `x'4==. & ///
	   `x'5==. & `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==. & `x'14==. & `x'15==. & `x'16==.) & (`x'17!=. & ///
	   `x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 `x'14 `x'15 `x'16 `x'17 (.=0) if (`x'1==. & `x'2==. & `x'3==. & ///
       `x'4==. & `x'5==. & `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==. & `x'14==. & `x'15==. & `x'16==. & ///
	   `x'17==.) & (`x'18!=. & `x'19!=.)
recode `x'1 `x'2 `x'3 `x'4 `x'5 `x'6 `x'7 `x'8 `x'9 `x'10 `x'11 `x'12 `x'13 `x'14 `x'15 `x'16 `x'17 `x'18 (.=0) if (`x'1==. & `x'2==. & ///
	   `x'3==. & `x'4==. & `x'5==. & `x'6==. & `x'7==. & `x'8==. & `x'9==. & `x'10==. & `x'11==. & `x'12==. & `x'13==. & `x'14==. & ///
	   `x'15==. & `x'16==. & `x'17==. & `x'18==.) & `x'19!=.
}
/****************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOMETHING AT SOME POINT DURING THE YEAR
****************************************************************
For mortality, if a faciity reports a death (or a 0) at any point then missings will be replaced by 0s for all other months
Missingness doesnt need to be consistent since deaths are rare */

foreach x of global mortality  {
	egen total`x' = rowtotal(`x'*), m // sums all the deaths and sets new var to . if all vars are missing
	forval i = 1/19 {
		replace `x'`i'=0 if `x'`i'==. & total`x'!=. // replaces to 0 all the missings if all vars are not missing 
	}
	drop total`x'
}
/* We also need to impute 0 deaths for facilities that had deliveries, ER visits and Inpatient admissions, but no deaths all year
Otherwise, average mortality will be inflated at regional level  when we calculate rates */
forval i = 1/19 {
	replace newborn_mort_num`i' = 0 if newborn_mort_num`i'==. & del_util`i' >0 & totaldel`i' <.
	replace sb_mort_num`i' = 0 	   if sb_mort_num`i' ==. & del_util`i' >0 & totaldel`i' <. 
	replace mat_mort_num`i' = 0     if mat_mort_num`i' == . & del_util`i' >0 & totaldel`i' <. 
	replace trauma_mort_num`i' = 0      if trauma_mort_num`i' ==. & trauma_util`i' >0 & trauma_util`i' <. 
	replace ipd_mort_num`i' = 0     if ipd_mort_num`i' ==. & ipd_util`i' >0 & ipd_util`i' <. 
	replace icu_mort_num`i'=0		if icu_mort_num`i'==. & icu_util`i' >0 & icu_util`i' <. 	
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
export excel using  "$user/$data/Data cleaning/KZN_Jan19-Jul20_fordatacleaning1.xlsx", firstrow(variable) replace
/****************************************************************
              IDENTIFY OUTLIERS AND SET TO MISSING 
****************************************************************
Identifying extreme outliers over 12 months in volume data
Any value that is greater or smaller than 3SD from the mean 12-month trend is set to missing
This is only applied if the mean of the series is greater or equal to 1 
This technique avoids flagging as outlier a value of 1 if facility reports: 
0 0 0 0 0 1 0 0 0 0 0 0  which is common for mortality
*/ 
foreach x of global all  {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3*(rowsd`x'))
	gen neg_out`x' = rowmean`x'-(3*(rowsd`x'))
	/*We need to investigate if we can remove outliers post Covid? For now, only
	  assessing outliers from Jan-Dec 2019*/
	forval i = 1/12 {
		gen flag_outlier_`x'`i'= 1 if `x'`i'>pos_out`x' & `x'`i'<.
		replace flag_outlier_`x'`i'= 1 if `x'`i' < neg_out`x'
		replace flag_outlier_`x'`i'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less
		replace `x'`i'=. if flag_outlier_`x'`i'==1
	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x' flag_outlier_`x'*
}
/****************************************************************
                    CALCULATE COMPLETENESS
***************************************************************** 
Completeness for each indicator-month
This calculates the % of facilities reporting each indicator every month
Creates a flag variable if less than 90% of expected facilities are reporting */

* Calculate max number of facilities reporting any indicator each month
foreach x of global all {
	forval i=1/19 {
		egen nb`x'`i' = count(`x'`i')
	}
	egen maxfac`x' = rowmax (nb`x'*)
	
* Calculate the % reporting each month from the max	
	forval i=1/19 {
		gen complete_`x'`i'= nb`x'`i'/maxfac`x' 
		lab var complete_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	drop nb`x'* maxfac`x'
}
* Create flag if completeness is below 95%
foreach v of varlist complete_* {
	gen flag`v' = 1 if `v'<0.95
	lab var flag`v' "Completeness < 95%"
}

*Drop all empty flags // remaining flags will identify the indicator-months that are incomeplete < 95%
foreach var of varlist flag* {
     capture assert mi(`var')
     if !_rc {
        drop `var'
     }
 }
* Investigate completeness 
  tabstat complete*, c(s) s(min) // Review completeness here
  drop complete* 
  drop flag* 
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/KZN_Jan19-Jul20_WIDE.dta", replace
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
export excel  using "$user/$data/Data cleaning/KZN_Jan19-Dec19_fordatacleaning3.xlsx", firstrow(variable) replace
/***************************************************************
                 COMPLETE CASE ANALYSIS
****************************************************************
Completeness is an issue, particularly April-June 2020. An for c-sections,
child diarrhea, total outpatient visits and tb screening. Some Facilities 
have not reported yet. For each variable, keep only heath facilities that 
have reported at least 14 out of 18 months (incl the latest 3 months) 
This brings completeness up "generally" above 90% for all variables. */
foreach x of global all  {
	preserve
		keep Province-factype `x'* 
		egen total`x'= rownonmiss(`x'*)
		keep if total`x'>14 & `x'17!=. & `x'18!=. & `x'19!=. 
		* keep if at least 14 out of 18 months are reported & april-jun 2020 are reported 
		* keep if total`x'== 18
		drop total`x'
		save "$user/$data/Data for analysis/tmp`x'.dta", replace
	restore
}
* Merge together
u "$user/$data/Data for analysis/tmpanc1_util.dta", clear
foreach x in totaldel del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
			   ipd_util er_util road_util diab_util kmcn_qual cerv_qual tbscreen_qual tbdetect_qual ///
			   tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual icu_util ///
			   trauma_util newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num {
			   merge 1:1 Province-factype using "$user/$data/Data for analysis/tmp`x'.dta"
			   drop _merge
			   save "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA.dta", replace
	}
foreach x of global all {
	rm "$user/$data/Data for analysis/tmp`x'.dta"
}
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
export excel  using "$user/$data/Data cleaning/KZN_Jan19-Dec19_fordatacleaning4.xlsx", firstrow(variable) replace
	
			   
/****************************************************************
                  RESHAPE FOR DASHBOARD
*****************************************************************/	

/*reshape long   anc1_util del_util  pnc_util diarr_util pneum_util kmcn_qual pent_qual /// 
			   measles_qual pneum_qual rota_qual newborn_mort_num sb_mort_num ///
			  mat_mort_num  , i(Facility factype Province dist subdist) j(month) */
			  
reshape long  anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
			  sam_util art_util opd_util ipd_util er_util road_util trauma_util ///
			  icu_util diab_util kmcn_qual cerv_qual cs_qual tbscreen_qual ///
			  tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual pneum_qual rota_qual newborn_mort sb_mort ///
			  mat_mort ipd_mort trauma_mort icu_mort newborn_mort_num ///
			  mat_mort_num sb_mort_num ipd_mort_num trauma_mort_num icu_mort_num, ///
			  i(Facility factype Province dist subdist) j(month)
			  
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13			  

* Labels (And dashboard format)
* Volume RMNCH services TOTALS
	*lab var fp_util "Number of new and current users of contraceptives"
	lab var anc1_util "Total number of first antenatal care visits"
	lab var totaldel "Number of facility deliveries: c-section and vaginal"
	lab var del_util "Number of vaginal facility deliveries"
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
	lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	 TOTALS
	lab var diab_util "Number of diabetic patients enrolled"
	*lab var hyper_util "Number of hypertensive patients enrolled"
	lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	lab var er_util "Number of emergency room visits"
	lab var trauma_util "Number of trauma admissions"
	lab var ipd_util "Number of inpatient admissions "
	lab var icu_util " Number of icu admissions"
	lab var road_util "Number of road traffic injuries"
* Quality  TOTALS
	lab var kmcn_qual "Number of Neonate - Received 24hr KMC"
	lab var cerv_qual "# women 30+ screened for cervical cancer"
	lab var tbdetect_qual "Number tb cases confirmed"
	lab var tbtreat_qual "Number tb cases started on treatment"
	lab var tbscreen_qual "Number screened for tb"
* Institutional mortality MEANS
	lab var newborn_mort "Institutional newborn deaths per 1000"
	lab var sb_mort "Institutional stillbirths per 1000 "
	lab var mat_mort "Institutional maternal deaths per 1000"
	lab var trauma_mort "Trauma deaths per 1000"
	lab var ipd_mort "Inpatient deaths per 1000"
	lab var icu_mort "ICU deaths per 1000"
	
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/KZN_Jan19-Jul20_clean.dta", replace

/****************************************************************
  COLLAPSE TO REGION TOTALS AND RESHAPE FOR DASHBOARD
*****************************************************************/
u "$user/$data/Data for analysis/KZN_Jan19-Jul20_WIDE_CCA.dta", clear
	drop Province
	encode Facility, gen(facname)
	collapse (sum) anc1_util1-trauma_mort_num19 , by(dist)
	order dist
	set obs 12 // adding an empty row to dataset
	foreach x of var _all    {
		egen `x'tot= total(`x'), m
		replace `x'= `x'tot in 12 // adding each var's total in that empty row
		drop `x'tot
}
	decode dist, gen(district)
	replace district="Kwazulu-Natal (Province total)" if district==""
	drop dist
	order district 

reshape long  anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
			  sam_util art_util opd_util ipd_util er_util road_util trauma_util ///
			  icu_util diab_util kmcn_qual cerv_qual cs_qual tbscreen_qual ///
			  tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual pneum_qual rota_qual newborn_mort sb_mort ///
			  mat_mort ipd_mort trauma_mort icu_mort newborn_mort_num ///
			  mat_mort_num sb_mort_num ipd_mort_num trauma_mort_num icu_mort_num, ///
			  i(district) j(month)
			  
rename month rmonth
gen month= rmonth
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	


* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist anc1_util totaldel del_util cs_util pnc_util diarr_util pneum_util ///
	sam_util art_util opd_util ipd_util er_util road_util diab_util kmcn_qual cerv_qual ///
	tbscreen_qual tbdetect_qual tbtreat_qual vacc_qual pent_qual bcg_qual measles_qual ///
	pneum_qual rota_qual icu_util trauma_util newborn_mort_num sb_mort_num mat_mort_num ///
	ipd_mort_num icu_mort_num trauma_mort_num cs_qual newborn_mort sb_mort mat_mort ipd_mort ///
	trauma_mort icu_mort 
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

merge m:m district month using "$user/$data/Data for analysis/temp.dta"
drop _merge

rm "$user/$data/Data for analysis/temp.dta"

export delimited using "$user/HMIS Data for Health System Performance Covid (South Africa)/KZN_Jan19-Jul20_fordashboard.csv", replace



	

/*************************************************************
* Completeness for each facility and indicator over 12 months
* Calculates the number of non-missing reports out of 12
foreach x of global volumes  {
	egen tot_reports_`x'= rownonmiss(`x'*)
	lab var tot_reports_`x' "Number of months reporting"
}

*************************************************************
* MODIFIED Z SCORE with shifted values

forval i = 1/12 { // adding to shift median from 0 to 1
	replace newborn_mort_num`i' = newborn_mort_num`i' + 1
}
egen median= rowmedian(newborn_mort_num*) // median over 12 months
forval i = 1/12 {
	gen absdiff`i'= abs(newborn_mort_num`i'-median) // absolute difference from the median for each month
	gen diff`i'= newborn_mort_num`i'-median // regular difference
}
egen mad = rowmedian(absdiff*)
forval i = 1/12 {
	gen mod_z_score`i' = 0.6745*diff`i'/mad 
}

drop median absdiff* diff* median mad
