* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

*Import policy data 
import excel using "$user/$data/Analyses/District-level Diff-in-diff Analysis/policy_data.xlsx", firstrow

* Merge policy data with health service utilization data 
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE_CCA_easing.dta"
drop _merge

*******************************************************************************
* RESHAPES FROM WIDE TO LONG FOR ANALYSES
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			 opd_util ipd_util er_util tbdetect_qual hivdiag_qual pent_qual bcg_qual ///
			 totaldel measles_qual opv3_qual pneum_qual  ///
			  , i(org*) j(month) string	
	
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

*******************************************************************************
* Creates exposure variables (policies eased or continued)


*Create pre/post indicator for DID 	- this is for placebo test, not real analysis 		
gen time = 0
replace time = 1 if year == 2020 & month == 4 | year == 2020 & month == 5 | year == 2020 & month == 6

* Treatment is eased_8_20
* Create interaction term - DID 
gen did_eased_8_20 = time*eased_8_20



save "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_easing.dta", replace


