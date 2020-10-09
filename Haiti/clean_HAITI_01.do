* HS performance during Covid
* Aug 24, 2020 
* Hait, January 2019 - June 2020
* Data cleaning, Catherine Arsenault
* Data recoded in R by Celestin

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

=======
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"

import excel using "$user/$data/Data for analysis/Data_Haiti_Recoded_JAN2019_JUN2020.xlsx", firstrow clear

gen month = "8_19" if regexm(date, "Août 2019")
replace month = "4_19" if regexm(date,  "Avril 2019")
replace month = "4_20" if regexm(date,  "Avril 2020")
replace  month = "12_19" if regexm(date, "Décembre 2019")
replace  month = "2_19" if regexm(date,  "Février 2019" )
replace  month = "2_20" if regexm(date,   "Février 2020" )       
replace  month = "1_19" if regexm(date,  "Janvier 2019" )
replace  month = "1_20" if regexm(date,   "Janvier 2020" )
replace  month =  "7_19" if regexm(date,   "Juillet 2019")
replace  month = "6_19"  if regexm(date,    "Juin 2019" )
replace  month = "6_20" if regexm(date,     "Juin 2020" )
replace  month = "5_19" if regexm(date,     "Mai 2019" )
replace  month = "5_20" if regexm(date,      "Mai 2020" )
replace  month = "3_19" if regexm(date,    "Mars 2019" )
replace  month = "3_20" if regexm(date,     "Mars 2020" )
replace  month = "11_19" if regexm(date,  "Novembre 2019") 
replace  month = "10_19" if regexm(date,   "Octobre 2019") 
replace  month = "9_19" if regexm(date,"Septembre 2019" )
drop date

reshape wide anc_util-ipd_mort, i(orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitname) j(month) string
* Looking at data in excel before we clean
*export excel using "$user/$data/Data cleaning/Haiti_Jan19-Jun20_fordatacleaning.xlsx", firstrow(variable) replace // 

* 8997 facilities. Dropping all facilities that don't report any indicators all 18 months
egen all_visits = rowtotal(anc_util10_19-ipd_mort9_19), m
drop if  all_visits==.
drop all_visits 
* Drops 65 facilities, retains 835

order org* anc_util*_19 anc_util*_20 cs_util*_19 cs_util*_20 del_util*_19 del_util*_20 pnc_util*_19 pnc_util*_20 diab_util*_19 diab_util*_20 ///
			diarr_util*_19 diarr_util*_20 fp_util*_19 fp_util*_20 vacc_qual*_19 vacc_qual*_20 hyper_util*_19 hyper_util*_20 live_birth*_19 ///
			live_birth*_20 malnu_util*_19 malnu_util*_20 opd_util*_19 opd_util*_20 road_util*_19 road_util*_20 tbdetect_qual*_19 ///
			tbdetect_qual*_20 mat_mort*_19 mat_mort*_20 sb_mort*_19 sb_mort*_20 ipd_mort*_19 ipd_mort*_20 

global volumes anc_util cs_util del_util pnc_util diab_util diarr_util fp_util hyper_util live_birth malnu_util opd_util road_util vacc_qual tbdetect_qual
global mortality mat_mort  sb_mort   
global all $volumes $mortality 

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
/*******************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 AS LONG AS FACILITY
REPORTS SOME MORTAILITY DATA AT SOME POINT DURING THE YEAR OR IF 
THE SERVICE WAS >0 THAT MONTH (E.G. DELIVERIES, INPATIENT ADMISSIONS)
********************************************************************	
For mortality, if a faciity reports a death (or a 0) at any point, then missings will be replaced by 0s for all other months
Missingness doesnt need to be consistent since deaths are rare */
foreach x of global mortality  {
	egen total`x' = rowtotal(`x'*), m // sums all the deaths and sets new var to . if all vars are missing
	forval i = 1/12 {
		replace `x'`i'_19=0 if `x'`i'_19==. & total`x'!=. // replaces to 0 all the missings if all vars are not missing 
	}
	forval i= 1/6 { // For now ends at June in 2020
		replace `x'`i'_20=0 if `x'`i'_20==. & total`x'!=.
	}
	drop total`x'
}
/* We also need to put 0s for facilities that had deliveries, ER visits and Inpatient admissions, but no deaths all year
Otherwise, average mortality will be inflated */
egen somedeliveries= rowtotal(del_util*), m 
forval i = 1/12 {
	replace sb_mort`i'_19 = 0 	   if sb_mort`i'_19==. &  somedeliveries>0 & somedeliveries<.
	replace mat_mort`i'_19 = 0     if mat_mort`i'_19== . & somedeliveries>0 & somedeliveries<.
	*replace ipd_mort`i'_19 = 0     if ipd_mort`i'_19==. & ipd_util`i'_19>0 & ipd_util`i'_19<. 
}
forval i= 1/6 { // For now ends at June in 2020
	replace sb_mort`i'_20 = 0 	if sb_mort`i'_20==. & somedeliveries>0 & somedeliveries<.
	replace mat_mort`i'_20 = 0  if mat_mort`i'_20== . & somedeliveries>0 & somedeliveries<.
	*replace ipd_mort`i'_20 = 0  if ipd_mort`i'_20==. & ipd_util`i'_20>0 & ipd_util`i'_20<.  
}
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Haiti_Jan19-Jun20_fordatacleaning1.xlsx", firstrow(variable) replace

/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over 12 months in volume data
Any value that is greater or smaller than 3SD from the mean 12-month trend is set to missing
This is only applied if the mean of the series is greater or equal to 1 
This technique avoids flagging as outlier a value of 1 if facility reports: 
0 0 0 0 0 1 0 0 0 0 0 0  which is common for mortality
AS THERE ARE ONLY 6 MONTHS OF DATA IN 2020, WE WON'T DROP OUTLIERS IN 2020 FOR NOW */
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*_19)
	egen rowsd`x'= rowsd(`x'*_19)
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
	
save "$user/$data/Data for analysis/Haiti_Jan19-Jun20_WIDE.dta", replace
/****************************************************************
EXPORT RECODED DATA WITH IMPUTED ZEROS FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Haiti_Jan19-Jun20_fordatacleaning2.xlsx", firstrow(variable) replace
	
/****************************************************************
                    CALCULATE COMPLETENESS
****************************************************************
Completeness for each indicator-month
This calculates the % of facilities reporting each indicator every month from 
the max facilities that have reported over the period (since we dont have a census)
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
tabstat complete*, c(s) s(min) // Review completeness here
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
Completeness is an issue for April to June 2020. Facilities have
not reported yet. (As of August 15th)
For each variable, keep only those that have reported at least 14 
out of 18 months (incl the latest 2 months) This brings 
completeness up "generally" above 90% for all variables. */
foreach x of global all {
			 	preserve
				keep org* `x'* 
				egen total`x'= rownonmiss(`x'*)
				keep if total`x'>14 & `x'5_20!=. & `x'6_20!=. // keep if at least 14 out of 18 months are reported & may/jun are reported
				*keep if total`x'== 18
				drop total`x'
				save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
			 }
u "$user/$data/Data for analysis/tmpanc_util.dta", clear

foreach x in cs_util del_util pnc_util diab_util diarr_util fp_util hyper_util live_birth malnu_util opd_util road_util ///
			 vacc_qual tbdetect_qual mat_mort  sb_mort   {
			 	merge 1:1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitname orgunitlevel1  ///
			              using "$user/$data/Data for analysis/tmp`x'.dta"
						  drop _merge
				save "$user/$data/Data for analysis/Haiti_Jan19-Jun20_WIDE_CCA.dta", replace
	}
foreach x in anc_util cs_util del_util pnc_util diab_util diarr_util fp_util hyper_util live_birth malnu_util opd_util road_util ///
			 vacc_qual tbdetect_qual mat_mort  sb_mort   {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
/******************************************************************************
 CALCULATE INDICATORS (NUM/DENOM) HERE, ONCE DATA CLEANING COMPLETE
 Quality and mortality indicators
*******************************************************************************/
forval i = 1/12 {
	egen totaldel`i'_19 = rowtotal( del_util`i'_19  cs_util`i'_19), m
	gen cs_qual`i'_19 = cs_util`i'_19 / totaldel`i'_19  // Csection %
	gen sb_mort_rate`i'_19 = sb_mort`i'_19 / (totaldel`i'_19) // stillbirth rate 
	gen mat_mort_rate`i'_19 = mat_mort`i'_19 / (totaldel`i'_19) // Maternal mortality 
}
forval i = 1/6 {
	egen totaldel`i'_20 = rowtotal( del_util`i'_20  cs_util`i'_20), m
	gen cs_qual`i'_20 = cs_util`i'_20 / totaldel`i'_20 // Csection %
	gen sb_mort_rate`i'_20 = sb_mort`i'_20 / totaldel`i'_20 // stillbirth rate 
	gen mat_mort_rate`i'_20 = mat_mort`i'_20 / totaldel`i'_20 // Maternal mortality 
}
*REPLACE TO MISSING ANY % indicator that is greater than 1 
foreach x in cs_qual sb_mort_rate mat_mort_rate  {
	forval i = 1/12 {
		replace `x'`i'_19 = . if `x'`i'_19 >1
	}
	forval i = 1/6 {
		replace `x'`i'_20 = . if `x'`i'_20 >1
	}
}
drop totaldel*
* MORTALITY PER 1000
forval i = 1/12 {
	replace sb_mort_rate`i'_19 = sb_mort_rate`i'_19*1000
	replace mat_mort_rate`i'_19 = mat_mort_rate`i'_19*1000
}
forval i = 1/6 {
	replace sb_mort_rate`i'_20 = sb_mort_rate`i'_20*1000
	replace mat_mort_rate`i'_20 = mat_mort_rate`i'_20*1000
}
save "$user/$data/Data for analysis/Haiti_Jan19-Jun20_WIDE.dta", replace

/****************************************************************
                  RESHAPE FOR DASHBOARD
*****************************************************************/	
reshape long  anc_util cs_util del_util diab_util diarr_util pnc_util vacc_qual fp_util hyper_util live_birth malnu_util ///
			  opd_util road_util tbdetect_qual mat_mort  sb_mort mat_mort_rate  sb_mort_rate cs_qual, ///
			  i(orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitname) j(month) string

* Labels (And dashboard format)
* Volume RMNCH services TOTALS
	lab var fp_util "Number of new and current users of contraceptives"
	*lab var sti_util "Number of consultations for STI care"
	lab var anc_util "Total number of antenatal care visits"
	lab var del_util "Number of facility deliveries"
	lab var cs_util "Number of caesarean sections"
	lab var diarr_util "Number children treated with ORS for diarrhea"
	*lab var pneum_util "Number of consultations for sick child care - pneumonia"
	*lab var sam_util "Number of children screened for malnutrition"
	*lab var pnc_util "Number of postnatal visits within 7 days of birth" 
* Vaccines TOTALS
	*lab var vacc_qual "Number fully vaccinated by age 1"
	*lab var bcg_qual "Nb children vaccinated with bcg vaccine"
	*lab var pent_qual "Nb children vaccinated with 3rd dose pentavalent"
	*lab var measles_qual "Nb children vaccinated with measles vaccine"
	*lab var opv3_qual "Nb children vaccinated with 3rd dose oral polio vaccine"
	*lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	*lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	 TOTALS
	lab var diab_util "Number of diabetic patients enrolled"
	lab var hyper_util "Number of hypertensive patients enrolled"
	*lab var art_util "Number of adult and children on ART "
	lab var opd_util  "Nb outpatient visits"
	*lab var er_util "Number of emergency room visits"
	*lab var ipd_util "Number of inpatient admissions total"
	lab var road_util "Number of road traffic injuries"
	*lab var cerv_qual "# women 30-49 screened with VIA for cervical cancer"
* Quality MEANS
	*lab var kmc_qual "% of LBW babies initiated on KMC"
	lab var cs_qual "Caesarean rates"
	*lab var resus_qual "% asphyxiated neonates who were resuscitated and survived"
	*lab var diab_qual "% diabetic patients with controlled blood sugar"
	*lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
	*lab var hivsupp_qual "% ART patients with undetect VL"
* Institutional mortality MEANS
	*lab var newborn_mort"Institutional newborn deaths per 1000"
	lab var sb_mort_rate "Institutional stillbirths per 1000 "
	lab var mat_mort_rate "Institutional maternal deaths per 1000"
	*lab var er_mort "Emergency room deaths per 1000"
	*lab var ipd_mort "Inpatient (incl. ICU) deaths per 1000"
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
sort orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitname year mo 
rename mo month
save "$user/$data/Data for analysis/Haiti_Jan19-Jun20_clean.dta", replace

* Reshaping for data visualisations
preserve
	keep if year == 2020
	global varlist anc_util cs_util del_util diab_util diarr_util fp_util hyper_util live_birth malnu_util opd_util road_util ///
			      tbdetect_qual mat_mort  sb_mort cs_qual  
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
merge m:m orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitname orgunitlevel1 mo using "$user/$data/temp.dta"
drop _merge


rm "$user/$data/temp.dta"
export delimited using "$user/$data/Haiti_Jan19-Jun20_fordashboard.csv", replace











