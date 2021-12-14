* HS performance during Covid
* Ethiopia 
* Data cleaning, January 2019-June 2021

clear all
set more off	

u "$user/$data/Data for analysis/Ethiopia_Jan19-Jun21_WIDE.dta", clear
keep org* del_util* opd_* ipd_util* pent_qual* 
********************************************************************
* 3965 woreda/facilities 
* Dropping all woreda/facilities that don't report any indicators all period
egen all_visits = rowtotal(del_util1_21-pent_qual12_20), m
drop if all_visits==.
drop all_visits 
* Retains 2243 woreda/facilities with some data from Jan19-Dec20
********************************************************************

global volumes del_util opd_util ipd_util pent_qual

/***************************************************************
                    COMPLETE CASE ANALYSIS 
                    FOR DASHBOARD AND ANALYSES
****************************************************************/
	foreach x in  del_util opd_util ipd_util pent_qual {
			  preserve
					keep  org* `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=19 
					/* keep if at least 19 out of 30 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	
	u "$user/$data/Data for analysis/tmpdel_util.dta", clear
		foreach x in opd_util ipd_util pent_qual {
			 	merge 1:1  org* using "$user/$data/Data for analysis/tmp`x'.dta", force 
				drop _merge
				save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun21_WIDE_CCA.dta", replace
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
= 34 indicators
*/

foreach x in  del_util opd_util ipd_util pent_qual  {
			egen rowmean`x'= rowmean(`x'*)
			egen rowsd`x'= rowsd(`x'*)
			gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold 
			foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				         1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 ///
						 1_21 2_21 3_21 4_21 5_21 6_21 {  
		gen flagout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flagout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flagout_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flagout_`x'*
}

save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun21_WIDE_CCA.dta", replace

			  

