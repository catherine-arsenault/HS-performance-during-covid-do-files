* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off

* Import policy data 
* For each month, from July to August 2020, did the palika "ease" containment policies
import excel using "$user/$data/Analyses/District-level Diff-in-diff Analysis/policy_data.xlsx", firstrow clear

* Merge policy data with health service utilization data 
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE_CCA_easing.dta"
drop _merge

*******************************************************************************
* RESHAPES FROM WIDE TO LONG FOR ANALYSES
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			 opd_util ipd_util er_util tbdetect_qual hivdiag_qual pent_qual bcg_qual ///
			 totaldel measles_qual opv3_qual pneum_qual eased_ ///
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
order org* year month 

*******************************************************************************
* For now, drop the pre-lockdown period
* Pre intervention = lockdown period which coincides with dhis2 months of Mar-July 2020
* Pre intervention = 3_20 4_20 5_20 6_20 7_20 
* Post intervention = easing perio which coincides with Aug-November
* Post intervention = 8_20 9_20 10_20 11_20 
drop if year==2019
drop if month==1 | month==2
* Retains 9 months of data per palika 
* Need to drop November which is Actually Nov15-Dec16 2020 (MK downloaded the data in early Jan)
drop if month==11

/* Edit July to be 0 (still under lockdown, allows for a lag, also, data quality
 issue for policy change in july)*/
*replace eased = 0 if month==7
*******************************************************************************
* Creates a "post" dummy, policies change starting august
gen post = month>=7 & month<=11 
order org* year month post

* Creates interaction term (variable treatment)
gen did_eased = post*eased
order org* year month post did

* Creates a single policy change (non-varying treatment)
gen eased_8_20 = 1 if eased_==1 & month==8
order org* year month post did eased_ eased_8_20 
by organisationunitname,  sort: egen temp= sum(eased_8_20 )
replace eased_8_20 = temp if eased_8_20==.
drop temp 
order org* year month post did eased_ eased_8_20 

* Creates interaction term (fixed treatment)
gen did_eased_8_20 = post*eased_8_20

lab var eased_ "Treated/control: Variable policy change"
lab var did_eased "Interaction term based on variable treatment"
lab var eased_8_20 "Treated/control: Fixed policy change based on August"
lab var did_eased_8_20 "Interaction term based on fixed treatment"

order org* year month post did_eased eased_ eased_8_20 did_eased_8_20

* Creates an id for palika 
encode organisationunitname, gen(palikaid)
* Creates a tag for palika
egen tag = tag(organisationunitname)

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_easing.dta", replace

/* 
Older code:
gen post = .
replace post = 0 if year == 2020 
** Not sure about month 7 
replace post = 1 if year == 2020 & month == 8 | year == 2020 & month == 9 | year == 2020 & month == 10 | year == 2020 & month == 11 


/*Create pre/post indicator for placebo test and DID analysis
gen post_plac = 0 if year == 2020 & month == 1 | year == 2020 & month == 2 | year == 2020 & month == 3
replace post_plac = 1 if year == 2020 & month == 4 | year == 2020 & month == 5 | year == 2020 & month == 6


**** IF TREATMENT WERE EASED_8_20, month of August as Treatment 
* Create interaction term - Placebo DID 
gen did_eased_8_20_plac = post_plac*eased_8_20

* Create interaction term - DID 
gen did_eased_8_20 = post*eased_8_20

**** FOR MULTIPLE POST PERIODS
gen did_eased_9_20 = post*eased_9_20
gen did_eased_10_20 = post*eased_10_20
gen did_eased_11_20 = post*eased_11_20

**** IF TREATMENT CHANGED OVER TIME 
gen eased_treated = .
replace eased_treated = 0 if year == 2020
** Not sure about month 7 
replace eased_treated = 1 if year == 2020 & month == 8 & eased_8_20 == 1
replace eased_treated = 1 if year == 2020 & month == 9 & eased_9_20 == 1
replace eased_treated = 1 if year == 2020 & month == 10 & eased_10_20 == 1
replace eased_treated = 1 if year == 2020 & month == 11 & eased_11_20 == 1

* Create interaction term - DID 
gen did_eased = post*eased_treated */