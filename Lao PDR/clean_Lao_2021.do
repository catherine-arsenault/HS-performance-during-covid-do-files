*Lao, 2019-2021 
* Data cleaning

clear all
set more off	

u "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", clear
merge 1:1 org* using "$user/$data/Data for analysis/Lao_Jan19-Dec20_WIDE.dta" 
drop _merge 
******************************************************************
* 1304 facilities. Dropping all facilities that don't report any indicators all year
egen all_visits = rowtotal(pent_qual1_21-totaldel12_19), m
drop if all_visits==.
drop all_visits 
* 21 with no data
******************************************************************

global volumes del_util  pent_qual  diab_util  opd_util ipd_util 

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                         FOR DASHBOARD 
****************************************************************
Completeness is an issue, particularly Oct and Nov 2020. Some palikas have
not reported yet. For each variable, keep only heath facilities that 
have reported at least 19 out of 22 months (incl the latest 2 months) 
This brings completeness up "generally" above 90% for all variables. */
	foreach x of global volumes {
			 	preserve
					keep org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=19
					/* keep if at least 19 of 30 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmpdel_util.dta", clear
	* All variables except the first 
	foreach x in   pent_qual  diab_util  opd_util ipd_util  {
			 	merge 1:1 org* using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/Lao_Jan19-Dec20_WIDE_CCA_DB.dta", replace
		}
	foreach x of global volumes {
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
foreach x of global volumes  {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 ///
				  1_21 2_21 3_21 4_21 5_21 6_21 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}


* Reshaping for data visualisations / dashboard
reshape long   del_util  pent_qual  diab_util  opd_util ipd_util , i(org*) j(month) string
			  
* Month and year
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year =2021 if month=="1_21" | month=="2_21" | month=="3_21" | month=="4_21" | month=="5_21" ///
				| month=="6_21" 
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20" | month =="1_21"
replace mo = 2 if month =="2_19" | month =="2_20" | month =="2_21"
replace mo = 3 if month =="3_19" | month =="3_20" | month =="3_21"
replace mo = 4 if month =="4_19" | month =="4_20" | month =="4_21"
replace mo = 5 if month =="5_19" | month =="5_20" | month =="5_21"
replace mo = 6 if month =="6_19" | month =="6_20" | month =="6_21"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort org* year month
order org* year month 

save "$user/$data/Data for analysis/Lao_su_30months.dta", replace











































