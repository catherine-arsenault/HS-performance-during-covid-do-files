* HS performance during Covid
* September 13, 2020 
* Nepal, January 2019 - June 2020
* Catherine Arsenault
* Data cleaning 
clear all
set more off	
*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"

u "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", clear

order org* fp_util*_19  fp_util*_20  anc_util*_19 anc_util*_20 del_util*_19 del_util*_20 cs_util*_19 cs_util*_20  pnc_util*_19 pnc_util*_20 diarr_util*_19 diarr_util*_20 pneum_util*_19 pneum_util*_20 sam_util*_19 			  sam_util*_20 opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20 er_util*_19 er_util*_20 live_births*_19 live_births*_20 tbdetect_qual*_19 tbdetect_qual*_20 hivdiag_qual*_19 hivdiag_qual*_20 pent_qual*_19 pent_qual*_20 bcg_qual*_19 bcg_qual*_20 measles_qual*_19 measles_qual*_20 opv3_qual*_19 opv3_qual*_20 pneum_qual*_19 pneum_qual*_20 rota_qual*19 rota_qual*20 sb_mort*_19 sb_mort*_20 mat_mort*_19 mat_mort*_20 ipd_mort*_19 ipd_mort*_20 
	 
*export excel using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning0.xlsx", firstrow(variable) replace	 

/********************************************************************
SUMMARY: THIS DO FILE CONTAINS METHODS TO ADDRESS DATA QUALITY ISSUES
 IN DHIS2. IT USES DATASET IN WIDE FORM (1 ROW PER palika)

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

* 753 palika. Dropping all palika that don't report any indicators all year
egen all_visits = rowtotal(fp_util1_19-live_births6_20), m
drop if all_visits==.
drop all_visits 
* 0 palika was dropped 

global volumes fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util er_util live_births
global quality tbdetect_qual hivdiag_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual
global mortality sb_mort mat_mort ipd_mort 
global all $volumes $mortality $quality 

/*******************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS PALIKA
REPORTS SOME MORTAILITY DATA AT SOME POINT DURING THE PERIOD OR IF 
THE SERVICE WAS >0 THAT MONTH (E.G. DELIVERIES, INPATIENT ADMISSIONS)
********************************************************************	
For mortality, if a palika reports a death (or a 0) at any point,
then missings will be replaced by 0s for all other months
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
/* We also need to put 0s for facilities that had deliveries, ER visits and Inpatient admissions during the period, 
but no deaths. Otherwise, average mortality will be inflated 
MK: I also added inpatient mortality rate*/
egen somedeliveries= rowtotal(del_util*), m 
forval i = 1/12 {
	replace sb_mort`i'_19 = 0 	   if sb_mort`i'_19==. & somedeliveries>0 & somedeliveries<.
	replace mat_mort`i'_19 = 0     if mat_mort`i'_19== . & somedeliveries>0 & somedeliveries<.
	replace ipd_mort`i'_19 = 0     if ipd_mort`i'_19==. & somedeliveries>0 & somedeliveries<.
}
forval i= 1/6 { 
	replace sb_mort`i'_20 = 0 	if sb_mort`i'_20==. & somedeliveries>0 & somedeliveries<. 
	replace mat_mort`i'_20 = 0  if mat_mort`i'_20== . & somedeliveries>0 & somedeliveries<. 
	replace ipd_mort`i'_20 = 0     if ipd_mort`i'_20==. & somedeliveries>0 & somedeliveries<.
}
drop somedeliveries
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning1.xlsx", firstrow(variable) replace

/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over 12 months. Any value that is greater or smaller than 
3SD from the mean 12-month trend is set to missing.
This is only applied if the mean of the series is greater or equal to 1 
This technique avoids flagging as outlier a value of 1 if facility reports: 
0 0 0 0 0 1 0 0 0 0 0 0  which is common for mortality indicators.
As there are only 6 months of data for 2020 right now, this is only applied to 2019 */
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*_19)
	egen rowsd`x'= rowsd(`x'*_19)
	gen pos_out`x' = rowmean`x'+(3*(rowsd`x')) // + threshold
	gen neg_out`x' = rowmean`x'-(3*(rowsd`x')) // - threshold
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
*export excel  using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning2.xlsx", firstrow(variable) replace	
/****************************************************************
                    CALCULATE COMPLETENESS
****************************************************************
Calculate completeness for each indicator-month. This calculates the % 
of facilities reporting each indicator every month from the max facilities 
that have reported over the period (since we dont have a census of facilities)
Creates a flag variable if less than 90% of expected facilities are reporting */
foreach x of global all {
	forval i=1/12 {
		egen nb`x'`i'_19 = count(`x'`i'_19) 
	}
	forval i=1/6 { // ends at june for now
		egen nb`x'`i'_20 = count(`x'`i'_20) 
	}
	egen maxfac`x' = rowmax (nb`x'*)
	forval i=1/12 {
		gen complete19_`x'`i'= nb`x'`i'_19/maxfac`x' 
		lab var complete19_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	forval i=1/6 {
		gen complete20_`x'`i'= nb`x'`i'_20/maxfac`x' 
		lab var complete20_`x'`i' "Proportion of facilities reporting indicator x in month i"
	}
	drop nb`x'* maxfac`x'
}
	tabstat complete*, c(s) s(min) 
	// Review completeness here- let CA know what the completeness is like from the excel spreadsheet 

	
* Create flags
foreach v of varlist complete* {
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
drop complete* 
* Investigate flags that remain 

/***************************************************************
                 COMPLETE CASE ANALYSIS
****************************************************************
Completeness is an issue, particularly May and June 2020. Palikas have
not reported yet. For each variable, keep only heath facilities that have reported at least 14 
out of 18 months (incl the latest 2 months) This brings 
completeness up "generally" above 90% for all variables. */
drop flag* 
foreach x of global all {
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>14 & `x'5_20!=. & `x'6_20!=. /* keep if at least 14 out of 18 months are reported 
																 & may/jun 2020 are reported */
					*keep if total`x'== 18
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
			 }
u "$user/$data/Data for analysis/tmpanc_util.dta", clear
foreach x in fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util er_util live_births tbdetect_qual hivdiag_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual sb_mort mat_mort ipd_mort  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE_CCA.dta", replace
	}
foreach x in fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util er_util live_births tbdetect_qual hivdiag_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual sb_mort mat_mort ipd_mort  {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Nepal_palika_Jan19-Jun20_fordatacleaning3.xlsx", firstrow(variable) replace

/******************************************************************************
 CALCULATE INDICATORS (NUM/DENOM) HERE, ONCE DATA CLEANING COMPLETE
 QUALITY, AND MORTALITY RATES
*******************************************************************************/
forval i = 1/12 {
	egen totaldel`i'_19 = rowtotal( del_util`i'_19  cs_util`i'_19), m
	gen cs_qual`i'_19 = cs_util`i'_19 / totaldel`i'_19  // Csection %
	gen sb_mort_rate`i'_19 = sb_mort`i'_19 / (totaldel`i'_19) // stillbirth rate per month per facility
	gen mat_mort_rate`i'_19 = mat_mort`i'_19 / (totaldel`i'_19) // Maternal mortality 
	*replace newborn_mort`i'_19 = newborn_mort`i'_19 / (totaldel`i'_19) // newborn mortality  
}
forval i = 1/6 { // ends in june for now
	egen totaldel`i'_20 = rowtotal( del_util`i'_20  cs_util`i'_20), m
	gen cs_qual`i'_20 = cs_util`i'_20 / totaldel`i'_20 // Csection %
	gen sb_mort_rate`i'_20 = sb_mort`i'_20 / totaldel`i'_20 // stillbirth rate 
	gen mat_mort_rate`i'_20 = mat_mort`i'_20 / totaldel`i'_20 // Maternal mortality 
	*replace newborn_mort`i'_20 = newborn_mort`i'_20 / totaldel`i'_20 // newborn mortality 
}
*Replace to missing any %, rate indicator that is greater than 1 
foreach x in cs_qual sb_mort_rate mat_mort_rate  {
	forval i = 1/12 {
		replace `x'`i'_19 = . if `x'`i'_19 >1
	}
	forval i = 1/6 {
		replace `x'`i'_20 = . if `x'`i'_20 >1
	}
}
drop totaldel*
* Mortality per 1000
forval i = 1/12 {
	replace sb_mort_rate`i'_19 = sb_mort_rate`i'_19*1000
	replace mat_mort_rate`i'_19 = mat_mort_rate`i'_19*1000
	replace ipd_mort`i'_19 = ipd_mort`i'_19*1000
}
forval i = 1/6 {
	replace sb_mort_rate`i'_20 = sb_mort_rate`i'_20*1000
	replace mat_mort_rate`i'_20 = mat_mort_rate`i'_20*1000
	replace ipd_mort`i'_20 = ipd_mort`i'_20*1000
}
save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE_CCA.dta", replace

/****************************************************************
                  RESHAPE FOR DASHBOARD
*****************************************************************/
reshape long  fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util er_util live_births tbdetect_qual hivdiag_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual sb_mort mat_mort ipd_mort sb_mort_rate mat_mort_rate cs_qual ipd_mort_rate  ///
				, i(orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname organisationunitid organisationunitcode) j(month) string

* Labels (And dashboard format)
* Volume RMNCH services TOTALS
	lab var fp_util "Number of new and current users of contraceptives"
	*lab var sti_util "Number of consultations for STI care"
	lab var anc_util "Total number of antenatal care visits"
	lab var del_util "Number of facility deliveries"
	lab var cs_util "Number of caesarean sections"
	lab var pnc_util "Number of postnatal visits (at least 3 per protocol)" 
	lab var diarr_util "Number children treated with ORS for diarrhea"
	*lab var diarr_qual "Number of consultations for sick child care - diarrhea"
	lab var pneum_util "Number of consultations for sick child care - pneumonia"
	lab var sam_util "Number of children screened for malnutrition"
	lab var opd_util "Number of outpatient visits"
	lab var ipd_util "Number of inpatient admissions"
	lab var er_util "Number of emergency room visits"
	lab var live_births "Number of live births"
* Vaccines TOTALS
	*lab var vacc_qual "Number fully vaccinated by age 1"
	lab var bcg_qual "Nb children vaccinated with bcg vaccine"
	lab var pent_qual "Nb children vaccinated with 3rd dose pentavalent"
	lab var measles_qual "Nb children vaccinated with measles vaccine"
	lab var opv3_qual "Nb children vaccinated with 3rd dose oral polio vaccine"
	lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	 TOTALS
	*lab var diab_util "Number of diabetic patients enrolled"
	*lab var hyper_util "Number of hypertensive patients enrolled"
	*lab var art_util "Number of adult and children on ART "
	*lab var opd_util  "Nb outpatient visits"
	*lab var er_util "Number of emergency room visits"
	*lab var ipd_util "Number of inpatient admissions total"
	*lab var road_util "Number of road traffic injuries"
	*lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
* Quality MEANS
	lab var tbdetect_qual "Number of TB cases detected"
	lab var hivdiag_qual "Number of new HIV cases diagnosed"
	*lab var kmc_qual "% of LBW babies initiated on KMC"
	lab var cs_qual "Caesarean rates"
	*lab var resus_qual "% asphyxiated neonates who were resuscitated and survived"
	*lab var diab_qual "% diabetic patients with controlled blood sugar"
	*lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
	*lab var hivsupp_qual "% ART patients with undetect VL"
* Institutional mortality MEANS
	*lab var newborn_mort"Institutional newborn deaths per 1000"
	lab var sb_mort_rate "Institutional stillbirths per 1000"
	lab var mat_mort_rate "Institutional maternal deaths per 1000"
	*lab var er_mort "Emergency room deaths per 1000"
	lab var ipd_mort_rate "Inpatient deaths per 1000"

	
	
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
sort orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname organisationunitid organisationunitcode year mo 
rename mo month
save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_clean.dta", replace

* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util er_util live_births tbdetect_qual hivdiag_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual sb_mort mat_mort ipd_mort sb_mort_rate mat_mort_rate cs_qual ipd_mort_rate  
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/temp.dta", replace
restore
keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
	}
drop year
merge m:m orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname organisationunitid organisationunitcode mo using "$user/$data/temp.dta"
drop _merge


rm "$user/$data/temp.dta"

* Final dataset for dashboard
export delimited using "$user/$data/Nepal_palika_Jan19-Jun20_fordashboard.csv", replace






























