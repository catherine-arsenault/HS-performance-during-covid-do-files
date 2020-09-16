* HS performance during Covid
* Ethiopia 
* Data cleaning, January-December 2019 Baseline data
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

u "$user/$data/Data for analysis/Ethiopia_Jan19-Dec19_WIDE.dta", clear

* 3465 "facilities" Dropping all facilities that don't report any indicators all year
egen all_visits = rowtotal(fp_util1_19-icu_mort_num12_19), m
drop if all_visits==.
drop all_visits 
* Retains 2160 Woreda and facilities with some data during 2019

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
ipd_util er_util road_util diab_util hyper_util kmc_qual resus_qual  cerv_qual hivsupp_qual_num diab_qual_num hyper_qual_num ///
vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual 

global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num icu_mort_num ipd_mort_num

global all fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ///
ipd_util er_util road_util diab_util hyper_util kmc_qual resus_qual  cerv_qual hivsupp_qual_num diab_qual_num ///
hyper_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num ///
mat_mort_num er_mort_num icu_mort_num ipd_mort_num
                 
/****************************************************************
VOLUMES:  REPLACE MISSINGS TO 0 IF MISSINGNESS IS CONSISTENT
****************************************************************
Identify consistent missingnes in volume data 
If the facility is missing data at the begining of the year and then starts reporting until the end of year 
We will assume that a one time swtich from missing to non-missing is a new facility opening during the year
In this case, replace the missings with zeros */
foreach x of global volumes  {
	recode `x'1_19 (.=0) if `x'1_19==. & (`x'2_19!=. & `x'3_19!=. & `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. & `x'8_19!=. ///
		& `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 (.=0) if (`x'1_19==. & `x'2_19==.) & (`x'3_19!=. & `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. & ///
		`x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==.) & (`x'4_19!=. & `x'5_19!=. & `x'6_19!=. & `x'7_19!=. ///
		& `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==.) & (`x'5_19!=. & `x'6_19!=. & ///
		`x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==.) & (`x'6_19!=. ///
		& `x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & `x'5_19==. & ///
		`x'6_19==.) & (`x'7_19!=. & `x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. & ///
		`x'5_19==. & `x'6_19==. & `x'7_19==.) & (`x'8_19!=. & `x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & `x'4_19==. ///
		& `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==.) & (`x'9_19!=. & `x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 (.=0) if (`x'1_19==. & `x'2_19==. & `x'3_19==. & ///
		`x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==.) & (`x'10_19!=. & `x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==.) & (`x'11_19!=. & `x'12_19!=.)
	recode `x'1_19 `x'2_19 `x'3_19 `x'4_19 `x'5_19 `x'6_19 `x'7_19 `x'8_19 `x'9_19 `x'10_19 `x'11_19 (.=0) if (`x'1_19==. & `x'2_19==. & ///
		`x'3_19==. & `x'4_19==. & `x'5_19==. & `x'6_19==. & `x'7_19==. & `x'8_19==. & `x'9_19==. & `x'10_19==. & `x'11_19==.) & `x'12_19!=.
}
/****************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOME MORTAILITY DATA AT SOME POINT DURING THE YEAR
****************************************************************
For mortality, if a faciity reports a death (or a 0) at any point during the year then missings will be replaced by 0s for all other months
Missingness doesnt need to be consistent since deaths are rare */
foreach x of global mortality  {
	egen total`x' = rowtotal(`x'*), m // sums all the deaths and sets new var to . if all vars are missing
	forval i = 1/12 {
		replace `x'`i'_19=0 if `x'`i'_19==. & total`x'!=. // replaces to 0 all the missings if all vars are not missing 
	}
	drop total`x'
}
/* We also need to put 0s for facilities that had deliveries, ER visits and Inpatient admissions, but no deaths all year
Otherwise, average mortality will be inflated */
forval i = 1/12 {
	replace newborn_mort_num`i'_19 = 0 if newborn_mort_num`i'_19==. & del_util`i'_19>0 & del_util`i'_19<.
	replace sb_mort_num`i'_19 = 0 	   if sb_mort_num`i'_19==. & del_util`i'_19>0 & del_util`i'_19<. 
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & del_util`i'_19>0 & del_util`i'_19<. 
	replace er_mort_num`i'_19 = 0      if er_mort_num`i'_19==. & er_util`i'_19>0 & er_util`i'_19<. 
	replace ipd_mort_num`i'_19 = 0     if ipd_mort_num`i'_19==. & ipd_util`i'_19>0 & ipd_util`i'_19<. 
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-Dec1_fordatacleaning.xlsx", firstrow(variable) replace

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

foreach x in fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util ipd_util er_util ///
			 road_util cerv_qual hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
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
	egen maxfac`x' = rowmax (nb`x'*)
	forval i=1/12 {
		gen complete_`x'`i'= nb`x'`i'_19/maxfac`x' 
		lab var complete_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	drop nb`x'* maxfac`x'
}
tabstat complete*, c(s) s(min) // Review completeness here
* Create flags
foreach v of varlist complete_* {
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
drop complete* 

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
drop flagcomplete_diab_util1 flagcomplete_diab_util2 flagcomplete_diab_util3 flagcomplete_diab_util4 flagcomplete_diab_util5 ///
	 flagcomplete_diab_util6 flagcomplete_diab_util7 flagcomplete_diab_util8 flagcomplete_hyper_util1 flagcomplete_hyper_util2 ///
	 flagcomplete_hyper_util3 flagcomplete_hyper_util4 flagcomplete_hyper_util5 flagcomplete_hyper_util6 flagcomplete_hyper_util7 ///
	 flagcomplete_hyper_util8 flagcomplete_diab_qual_num1 flagcomplete_diab_qual_num2 flagcomplete_diab_qual_num3 flagcomplete_diab_qual_num4 ///
	 flagcomplete_diab_qual_num5 flagcomplete_diab_qual_num6 flagcomplete_diab_qual_num7 flagcomplete_diab_qual_num8 flagcomplete_hyper_qual_num1 ///
	 flagcomplete_hyper_qual_num2 flagcomplete_hyper_qual_num3 flagcomplete_hyper_qual_num4 flagcomplete_hyper_qual_num5 flagcomplete_hyper_qual_num6 ///
	 flagcomplete_hyper_qual_num7 flagcomplete_hyper_qual_num8

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
 * diabetes and hypertension only available october to december 2019
 forval i = 10/12 {
 	gen diab_qual`i'_19 = diab_qual_num`i'_19 / diab_util`i'_19 // control diabetes %
	gen hyper_qual`i'_19 = hyper_qual_num`i'_19 / hyper_util`i'_19 // control hypertension %
	replace diab_qual`i'_19= . if  diab_qual`i'_19 >1
	replace hyper_qual`i'_19= . if hyper_qual`i'_19 >1
 }
* REPLACE TO MISSING ANY % indicator that is greater than 1 
foreach x in kmc_qual resus_qual cs_qual hivsupp_qual  newborn_mort sb_mort mat_mort ipd_mort er_mort   {
	forval i = 1/12 {
		replace `x'`i'_19 = . if `x'`i'_19 >1
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
drop totaldel*
save "$user/$data/Ethiopia_Jan19-Dec19_WIDE.dta", replace
*export excel using "$user/$data/Data cleaning/Ethio_Jan19-Dec1_fordatacleaning2.xlsx", firstrow(variable) replace
/****************************************************************
                  RESHAPE FOR DASHBOARD
*****************************************************************/	
drop *_num*_19 flag* 
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
	
save "$user/$data/Data for analysis/Ethiopia_Jan19-Dec19_clean.dta", replace

export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Dec19_fordashboard.csv", replace









