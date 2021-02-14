* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off

*Import and clean Covid case data 
import excel using "$user/BEHST Center/Active projects/HS performance Covid (internal)/Country-specific papers/Nepal/Policy removal/COVID Cases new one.xlsx", firstrow clear
drop sn  date patient_name age sex province district
drop if orgunitlevel3 == ""
drop if year == 2021
collapse (sum) covid_case, by (year month orgunitlevel3) 
** I'm not sure if this month/year is Nepali calendar or Western calendar? For now I assumed the months here matched our own health service utilization data (Nepali calendar), but if it is Western calendar will have to use the days to translate to Nepali calendar 
save "$user/$data/Data for analysis/Nepal_covid_cases.dta", replace
clear

*Import covid death data and save as .dta file 
import excel using "$user/BEHST Center/Active projects/HS performance Covid (internal)/Country-specific papers/Nepal/Policy removal/Death_DistrictWise_EDCD Data_2033 Cases.xlsx", sheet("Sheet1") firstrow clear
drop District K L
save "$user/$data/Data for analysis/Nepal_covid_deaths.dta", replace
clear

* Import policy data 
* For each month, from July to August 2020, did the palika "ease" containment policies
import excel using "$user/BEHST Center/Active projects/HS performance Covid (internal)/Country-specific papers/Nepal/Policy removal/policy_data.xlsx", firstrow clear

* Merge policy data with health service utilization data 
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE_CCA_easing.dta"
drop _merge

* Merge data with Covid data death data 
merge m:1 orgunitlevel3 using "$user/$data/Data for analysis/Nepal_covid_deaths.dta"
drop _merge

*******************************************************************************
* RESHAPES FROM WIDE TO LONG FOR ANALYSES
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
			 opd_util ipd_util er_util tbdetect_qual hivdiag_qual pent_qual bcg_qual ///
			 totaldel measles_qual opv3_qual pneum_qual eased_ covid_death_ ///
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

* Merge data with Covid case 
merge m:1 orgunitlevel3 year month using "$user/$data/Data for analysis/Nepal_covid_cases.dta"
drop _merge


* For now, drop the pre-lockdown period
* Pre intervention = lockdown period which coincides with dhis2 months of Mar-July 2020
* Pre intervention = 3_20 4_20 5_20 6_20 7_20 
* Post intervention = easing perio which coincides with Aug-November
* Post intervention = 8_20 9_20 10_20 11_20 
drop if year==2019
drop if month==1 | month==2
* Retains 9 months of data per palika 
* Need to drop November which is Actually Nov15-Dec16 2020 (MK downloaded the data in early Jan)
drop if month==11 | month ==12

/* Remove July from the analysis (lockdown happens mid-month, also, data quality
 issue for policy change in july)*/
replace eased = . if month==7
*******************************************************************************
* Creates a "post" dummy, policies change starting august
gen post = month>=8 & month<=11 
replace post = . if month == 7 
order org* year month post

* Creates interaction term (variable treatment)
gen did_eased = post*eased
order org* year month post did

*Simple comparison in means pre/post indicator 
gen post_simp = . 
replace post_simp = 0 if month == 4 | month == 5 | month == 6 
replace post_simp = 1 if month == 8 | month == 9 | month == 10 


* Created the three-part variable - districts that full eased in post-period, districts that fully maintained in post-period, districts that switched in the post-period
* There are no districts that maintaned 8,9,10 so just doing month 8 and 9 for now (will be updating this policy data soon though)
by organisationunitname, sort: egen temp= sum(eased_) if month>=8 & month<=9
gen eased_cat = 1 if temp==0
replace eased_cat = 2 if temp==2
replace eased_cat=3 if temp==1
lab def eased_cat 1 "fully maintained" 2 "fully eased " 3 "switch "
lab val eased_cat eased_cat
drop temp

gen post_cat = .
replace post_cat = 1 if month == 8 | month == 9
replace post_cat = 0 if month == 3 | month == 4 | month == 5 | month == 6 


* Creates a single policy change (non-varying treatment) based on month of August (used as a practice analysis)
gen eased_8_20 = 1 if eased_==1 & month==8
order org* year month post eased_ eased_8_20 
by organisationunitname,  sort: egen temp= sum(eased_8_20 )
replace eased_8_20 = temp if eased_8_20==.
drop temp 

* Creates interaction term (fixed treatment) (used as a practice analysis)
gen did_eased_8_20 = post*eased_8_20


*Create a two-part variable of fully maintained or fully eased 
gen eased_9_20 = 1 if eased_ == 1 & month == 9
by organisationunitname,  sort: egen temp= sum(eased_9_20 )
replace eased_9_20 = temp if eased_9_20==.
drop temp 
order org* year month post eased_ eased_8_20 eased_9_20 did*

gen eased_cat_2 = .
replace eased_cat_2 = 1 if eased_8_20 == 1 & eased_9_20 == 1
replace eased_cat_2 = 0 if eased_8_20 == 0 & eased_9_20 == 0

*Create interaction term
gen did_eased_cat_2 = post_cat*eased_cat_2

order org* year month post* eased_* did*

*Placebo test using the fully maintained or fully eased 
gen post_plac = .
replace post_plac = 1 if month == 5 | month == 6
replace post_plac = 0 if month == 3 | month == 4 

*Creates the placebo interaction term (two-part variable)
gen did_eased_cat_plac = post_plac*eased_cat_2

order org* year month post* eased* did* 

lab var eased_ "Treated/control: Variable policy change"
lab var did_eased "Interaction term based on variable treatment"
lab var eased_8_20 "Treated/control: Fixed policy change based on August"
lab var eased_cat "Three-category: fully eased, fully maintained and switched"
lab var eased_cat_2 "Two-category: fully eased and fully maintained"
lab var post_cat "Pre/post period for two and three category"
lab var did_eased_cat_2 "Interaction term for two-category"
lab var post_plac "Pre/post for placebo test"
lab var did_eased_cat_plac "Interaction term for placebo test, two-category"
lab var did_eased_8_20 "Interaction term based on fixed treatment"
lab var post "Pre/post period for analysis"
lab var post_simp "Pre/post period for simple means comparison"

* Creates an id for palika 
encode organisationunitname, gen(palikaid)
* Creates a tag for palika
egen tag = tag(organisationunitname)

save "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_easing.dta", replace

