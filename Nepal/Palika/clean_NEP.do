* HS performance during Covid
* September 13, 2020 
* Nepal, January 2019 - Nov 2020
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

order org* fp_perm_util*_19 fp_perm_util*_20 fp_sa_util*_19 fp_sa_util*_20 ///
fp_la_util*_19 fp_la_util*_20 anc_util*_19 anc_util*_20 del_util*_19 ///
del_util*_20 cs_util*_19 cs_util*_20 ///
totaldel*19 totaldel*20  pnc_util*_19 pnc_util*_20 diarr_util*_19 ///
diarr_util*_20 pneum_util*_19 pneum_util*_20  ///
opd_util*_19 opd_util*_20 ipd_util*_19 ipd_util*_20 er_util*_19 er_util*_20  ///
tbdetect_qual*_19 tbdetect_qual*_20  hyper_util*19 hyper_util*20 ///
diab_util*19 diab_util*20 hivtest_qual*19 hivtest_qual*20 ///
pent_qual*_19 pent_qual*_20 bcg_qual*_19 bcg_qual*_20 measles_qual*_19 ///
measles_qual*_20 opv3_qual*_19 opv3_qual*_20 pneum_qual*_19 pneum_qual*_20  ///
sb_mort*_19 sb_mort*_20 mat_mort*_19 mat_mort*_20 ipd_mort*_19 ipd_mort*_20 ///
neo_mort_num*_19 neo_mort_num*_20 

/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel  using "$user/$data/Data cleaning/Nepal_palika_Jan19-Dec20_fordatacleaning1.xlsx", firstrow(variable) replace	 

******************************************************************
* 753 palika. Dropping all palika that don't report any indicators all year
egen all_visits = rowtotal(fp_perm_util1_19 - neo_mort_num10_20), m
drop if all_visits==.
drop all_visits 
* 0 palika was dropped 
******************************************************************

global volumes fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util diarr_util pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual  hivtest_qual hyper_util diab_util totaldel pent_qual bcg_qual ///
			   measles_qual opv3_qual pneum_qual 
global mortality sb_mort_num mat_mort_num ipd_mort_num neo_mort_num 
global all $volumes $mortality 

/****************************************************************
ASSESSES DATASET BEFORE CLEANING (NUMBER OF UNITS REPORTING, AND
SUM AND AVERAGE SERVICES PER UNIT)
****************************************************************/
* Number of palika reporting any data, for each indicator
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*) // counts the number of non missing cells
}
	recode *_report (0=0) (1/24=1) // 0 never any value, 1 some values

putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(Before cleaning)  modify
putexcel A2 = "Variable"
putexcel B2 = "Number reporting any data"	
local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel A`i' = "`var'"
	qui sum `var'_report
	putexcel B`i' = `r(sum)'
}
drop *report
* Min and Max number of palikas reporting any data, for any given month	
preserve
	local all fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util diarr_util pneum_util   opd_util ipd_util er_util ////
			   tbdetect_qual  hivtest_qual  hyper_util diab_util totaldel pent_qual bcg_qual ///
			   measles_qual opv3_qual pneum_qual sb_mort_num mat_mort_num ///
			   ipd_mort_num neo_mort_num 
			   
	reshape long `all', i(org*) j(month, string)
	recode `all' (.=0) (0/999999999=1)
	collapse (sum) `all', by(month)
	putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(Before cleaning) modify  
	putexcel C2 = "Variable"
	putexcel D2 = "Min units reporting any month"	
	putexcel E2 = "Max units reporting any month"	
	local i= 2
foreach var of global all {	
	local i = `i'+1
	putexcel C`i' = "`var'"
	qui sum `var'
	putexcel D`i' = `r(min)'
	putexcel E`i' = `r(max)'
}
restore

* Sum and average volumes 
foreach var of global all {
	egen `var'_report = rownonmiss(`var'*)
	recode `var'_report (0=0) (1/999999=1) 
	* Total facilities ever reporting each indicator
	egen `var'_total_report = total(`var'_report) 
	* Sum/volume of services or deaths per palika over 24 months
	egen `var'_sum = rowtotal(`var'1_19 `var'2_19 `var'3_19 `var'4_19 `var'5_19 ///
	 `var'6_19 `var'7_19 `var'8_19 `var'9_19 `var'10_19 `var'11_19 `var'12_19 ///
	 `var'1_20 `var'2_20 `var'3_20 `var'4_20 `var'5_20 `var'6_20 `var'7_20 ///
	 `var'8_20 `var'9_20 `var'10_20 `var'11_20 `var'12_20 ), m
	* Sum/volume of services across whole country
	egen `var'_total_sum = total(`var'_sum)
	* Average volume per Palika
	gen `var'_total_mean = `var'_total_sum /`var'_total_report
}

putexcel set "$user/$data/Analyses/Nepal Codebook Internal.xlsx", sheet(Before cleaning)  modify
putexcel F2 = "Variable"
putexcel G2 = "Sum of services or deaths"	
putexcel H2 = "Average per unit/facility"
local i= 2
	foreach var of global all {	
		local i = `i'+1
		putexcel F`i' = "`var'"
		qui sum `var'_total_sum
		putexcel G`i' = `r(mean)'
		qui sum `var'_total_mean
		putexcel H`i' = `r(mean)'
	}
putexcel set "$user/$data/Nepal Codebook.xlsx", sheet(Raw data)  modify
putexcel A2 = "Variable"
putexcel B2 = "Total health care visits in the raw data"
local i= 2
	foreach var of global volumes {	
		local i = `i'+1
		putexcel A`i' = "`var'"
		qui sum `var'_total_sum
		putexcel B`i' = `r(mean)'
	}
drop *_report *_sum *_mean

/*******************************************************************
MORTALITY: REPLACE ALL MISSINGNESS TO 0 IF FACILITY
REPORTS THE SERVICE THAT MONTH (E.G. DELIVERIES, INPATIENT ADMISSIONS)
********************************************************************	
For mortality, we inpute 0s if the facility had the service the deaths
relate to that month. E.g. maternal deaths and deliveries, ER deaths and ER visits,
Inpatient deaths and Inpatient admissions */
forval i = 1/12 {
	replace sb_mort_num`i'_19 = 0  if sb_mort_num`i'_19==. &  totaldel`i'_19!=.
	replace mat_mort_num`i'_19 = 0     if mat_mort_num`i'_19== . & totaldel`i'_19!=.
	replace ipd_mort_num`i'_19 = 0     if ipd_mort_num`i'_19== . & ipd_util`i'_19!=.
	replace neo_mort_num`i'_19 = 0  if neo_mort_num`i'_19==. &  totaldel`i'_19!=.
}
forval i= 1/12 { 
	replace sb_mort_num`i'_20 = 0  if sb_mort_num`i'_20==. &  totaldel`i'_20!=.
	replace mat_mort_num`i'_20 = 0     if mat_mort_num`i'_20== . & totaldel`i'_20!=.
	replace ipd_mort_num`i'_20 = 0     if ipd_mort_num`i'_20== . & ipd_util`i'_20!=.
	replace neo_mort_num`i'_20 = 0  if neo_mort_num`i'_20==. &  totaldel`i'_20!=.
}

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_AN.dta", replace
/****************************************************************
EXPORT RECODED DATA FOR MANUAL CHECK IN EXCEL
****************************************************************/
*export excel using "$user/$data/Data cleaning/Nepal_palika_Jan19-Nov20_fordatacleaning2.xlsx", firstrow(variable) replace

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly for the latest months included. Some 
palikas have not reported yet. For each variable, keep only heath facilities that 
have reported at least 15 out of 24 months. This brings completeness up "generally" 
above 90% for all variables. */
	foreach x of global all {
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=15
					/* keep if at least 15 out of 24 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpfp_perm_util.dta", clear

	foreach x in  fp_sa_util fp_la_util anc_util del_util cs_util pnc_util diarr_util pneum_util totaldel ///
                 opd_util ipd_util er_util  tbdetect_qual hivtest_qual hyper_util diab_util  ///
			   pent_qual bcg_qual measles_qual opv3_qual pneum_qual  ///
			   sb_mort_num mat_mort_num ipd_mort_num neo_mort_num  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_DB.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
	
/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
***************************************************************** 
Identifying extreme outliers over the period. Any value that is greater than 
3.5SD from the mean  trend is set to missing.This is only applied if the mean 
of the series is greater or equal to 1. This technique avoids flagging as 
outlier a value of 1 if facility reports: 0 0 0 0 0 1 0 0 0 0 0 0  which is 
common for mortality indicators.  */
foreach x of global all {
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

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_DB.dta", replace 

/***************************************************************
                 COMPLETE CASE ANALYSIS 
			COMPARING QUARTERS 2 (2020 VS. 2019)
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */

u "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_AN.dta", clear
foreach x of global all {
			 	preserve
					keep org* `x'*
					keep if `x'4_19!=. & `x'5_19!=. & `x'6_19!=. & ///
							`x'4_20!=. & `x'5_20!=. & `x'6_20!=.
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpfp_perm_util.dta", clear

	foreach x in  fp_sa_util fp_la_util anc_util del_util cs_util pnc_util diarr_util ///
				pneum_util totaldel   opd_util ipd_util er_util  tbdetect_qual  ///
				hivtest_qual   pent_qual bcg_qual measles_qual opv3_qual hyper_util diab_util pneum_qual  ///
			   sb_mort_num mat_mort_num ipd_mort_num neo_mort_num  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_CCA_Q2.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
/****************************************************************
         IDENTIFY POSITIVE OUTLIERS BASED ON 2 YR TREND
	               AND SET THEM TO MISSING 
*****************************************************************/

foreach x of global all {
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
			 
* Reshape for analyses
reshape long fp_perm_util fp_sa_util fp_la_util anc_util del_util hyper_util diab_util cs_util pnc_util ///
			diarr_util pneum_util   opd_util ipd_util er_util tbdetect_qual ///
			hivtest_qual   pent_qual bcg_qual totaldel measles_qual opv3_qual pneum_qual ///
			sb_mort_num mat_mort_num neo_mort_num ///
			 ipd_mort_num, i(org*) j(month) string	
	
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

* Drop the other months
keep if month>=4 & month<=6

save "$user/$data/Data for analysis/Nepal_CCA_Q2.dta", replace


/***************************************************************
                 COMPLETE CASE ANALYSIS 
				   COMPARING QUATERS 3 (2020 vs. 2019)
****************************************************************
For analyses (Quater comparisons), we keep only those facilities 
that reported the months of interest) */

u "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_AN.dta", clear
foreach x of global all {
			 	preserve
					keep org* `x'*
					keep if `x'7_19!=. & `x'8_19!=. & `x'9_19!=. & ///
							`x'7_20!=. & `x'8_20!=. & `x'9_20!=.
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpfp_perm_util.dta", clear

	foreach x in  fp_sa_util fp_la_util anc_util del_util cs_util hyper_util diab_util pnc_util diarr_util ///
				pneum_util totaldel   opd_util ipd_util er_util  tbdetect_qual  ///
				hivtest_qual   pent_qual bcg_qual measles_qual opv3_qual pneum_qual  ///
			   sb_mort_num mat_mort_num ipd_mort_num neo_mort_num  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Nepal_CCA_Q3.dta", replace
		}
	foreach x of global all {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }
			 
/****************************************************************
         IDENTIFY OUTLIERS  BASED ON ANNUAL TREND
	               AND SET THEM TO MISSING 
*****************************************************************/

foreach x of global all {
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
			 
* Reshape for analyses
reshape long fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util pnc_util ///
			diarr_util pneum_util   opd_util ipd_util er_util tbdetect_qual hyper_util diab_util ///
			hivtest_qual   pent_qual bcg_qual totaldel measles_qual opv3_qual pneum_qual ///
			sb_mort_num mat_mort_num neo_mort_num ///
			 ipd_mort_num , i(org*) j(month) string	
	
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

* Drop the other months
keep if month>=7 & month<=9

save "$user/$data/Data for analysis/Nepal_CCA_Q3.dta", replace


