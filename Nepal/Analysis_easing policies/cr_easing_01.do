* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

/********************************************************************
SUMMARY: THIS DO FILE CREATES THE DATASET FOR ANALYSIS

1 Merges COVID-19 cases and deaths data, containment policy (exposure status)
  data, and DHIS2 data (service volumes outcomes)

2 Reshapes data from wide to long 

NOTE: Pre-period is months 3,4,5,6 and post-period is months 8,9 
Month 7 dropped since policy lifting happened mid-month
********************************************************************/

clear all
set more off

* Importing and Cleaning COVID case data at the district level
import excel using "$user/$analysis/COVID Cases new one.xlsx", firstrow clear
drop sn  date patient_name age sex province district
drop if orgunitlevel3 == ""
drop if year == 2021
collapse (sum) covid_case, by (year month day orgunitlevel3) 
sort org year month day
** Changing Western dates to Nepali dates - January, February and March (mostly) are fine 
gen month_new = . 
*Magh: Jan 15 - Feb 12 is 1 
replace month_new = 1 if month == 1
*Falgun: Feb 13 - Mar 13 is 2 
replace month_new = 2 if month == 2
*Chaitra: Mar 14 - Apr 12 is 3
replace month_new = 3 if month == 3
replace month_new = 3 if month == 4 & day == 2 | month == 4 & day == 4 | month == 4 & day == 11 | month == 4 & day == 12
*Baisakh: Apr 13 - May 13 is 4 
replace month_new = 4 if month == 4 & month_new == . 
replace month_new = 4 if month == 5 & day == 1 | month == 5 & day == 2 | month == 5 & day == 3 | month == 5 & day == 4 | month == 5 & day == 5 | month == 5 & day == 6 | month == 5 & day == 7 | month == 5 & day == 8 | month == 5 & day == 9 | month == 5 & day == 10 | month == 5 & day == 11 | month == 5 & day == 12 | month == 5 & day == 13
*Jestha: May 14 - Jun 14 is 5 
replace month_new = 5 if month == 5 & month_new == .
replace month_new = 5 if month == 6 & day == 1 | month == 6 & day == 2 | month == 6 & day == 3 | month == 6 & day == 4 | month == 6 & day == 5 | month == 6 & day == 6 | month == 6 & day == 7 | month == 6 & day == 8 | month == 6 & day == 9 | month == 6 & day == 10 | month == 6 & day == 11 | month == 6 & day == 12 | month == 6 & day == 13 | month == 6 & day == 14
*Asadh/Ashar: Jun 15 - Jul 15 
replace month_new = 6 if month == 6 & month_new == .
replace month_new = 6 if month == 7 & day == 1 | month == 7 & day == 2 | month == 7 & day == 3 | month == 7 & day == 4 | month == 7 & day == 5 | month == 7 & day == 6 | month == 7 & day == 7 | month == 7 & day == 8 | month == 7 & day == 9 | month == 7 & day == 10 | month == 7 & day == 11 | month == 7 & day == 12 | month == 7 & day == 13 | month == 7 & day == 14 | month == 7 & day == 15
*Shrawan: Jul 16 - Aug 16
replace month_new = 7 if month == 7 & month_new == . 
replace month_new = 7 if month == 8 & day == 1 | month == 8 & day == 2 | month == 8 & day == 3 | month == 8 & day == 4 | month == 8 & day == 5 | month == 8 & day == 6 | month == 8 & day == 7 | month == 8 & day == 8 | month == 8 & day == 9 | month == 8 & day == 10 | month == 8 & day == 11 | month == 8 & day == 12 | month == 8 & day == 13 | month == 8 & day == 14 | month == 8 & day == 15 | month == 8 & day == 16
*Bhadra: Aug 17 - Sept 16 
replace month_new = 8 if month == 8 & month_new == . 
replace month_new = 8 if month == 9 & day == 1 | month == 9 & day == 2 | month == 9 & day == 3 | month == 9 & day == 4 | month == 9 & day == 5 | month == 9 & day == 6 | month == 9 & day == 7 | month == 9 & day == 8 | month == 9 & day == 9 | month == 9 & day == 10 | month == 9 & day == 11 | month == 9 & day == 12 | month == 9 & day == 13 | month == 9 & day == 14 | month == 9 & day == 15 | month == 9 & day == 16
*Ashwin: Sept 17 - Oct 16
replace month_new = 9 if month == 9 & month_new == . 
replace month_new = 9 if month == 10 & day == 1 | month == 10 & day == 2 | month == 10 & day == 3 | month == 10 & day == 4 | month == 10 & day == 5 | month == 10 & day == 6 | month == 10 & day == 7 | month == 10 & day == 8 | month == 10 & day == 9 | month == 10 & day == 10 | month == 10 & day == 11 | month == 10 & day == 12 | month == 10 & day == 13 | month == 10 & day == 14 | month == 10 & day == 15 | month == 10 & day == 16
*Kartik: Oct 17 - Nov 15
replace month_new = 10 if month == 10 & month_new == .
replace month_new = 10 if month == 11 & day == 1 | month == 11 & day == 2 | month == 11 & day == 3 | month == 11 & day == 4 | month == 11 & day == 5 | month == 11 & day == 6 | month == 11 & day == 7 | month == 11 & day == 8 | month == 11 & day == 9 | month == 11 & day == 10 | month == 11 & day == 11 | month == 11 & day == 12 | month == 11 & day == 13 | month == 11 & day == 14 | month == 11 & day == 15 
*Mangshir: Nov 16 - Dec 15 
replace month_new = 11 if month == 11 & month_new == .
replace month_new = 11 if month == 12 & day == 1 | month == 12 & day == 2 | month == 12 & day == 3 | month == 12 & day == 4 | month == 12 & day == 5 | month == 12 & day == 6 | month == 12 & day == 7 | month == 12 & day == 8 | month == 12 & day == 9 | month == 12 & day == 10 | month == 12 & day == 11 | month == 12 & day == 12 | month == 12 & day == 13 | month == 12 & day == 14 | month == 12 & day == 15 

* Drops months not included in this analysis (Jan, July, Oct, Nov, Dec)
drop if month == 1 | month_new == 7 | month_new == 9 |month_new == 10 | month_new == 11 | month == 12 
drop month day
rename month_new month

order orgunitlevel3 year month covid_case
collapse (sum) covid_case, by (year month orgunitlevel3) 
save "$user/$data/Data for analysis/Nepal_covid_cases.dta", replace

* Importing and saving COVID death data as .dta file at the district level
import excel using "$user/$analysis/Death_DistrictWise_EDCD Data_2033 Cases.xlsx", sheet("Sheet1") firstrow clear
drop District K L
save "$user/$data/Data for analysis/Nepal_covid_deaths.dta", replace

* Importing and saving palika population data as .dta file
import excel using "$user/$data/Data for analysis/preliminary-data-of-national-population-and-housing-census-2021-english.xlsm", clear firstrow
drop Totalfamilynumber Totalhouseholdnumber TotalMale TotalFemale Notes Site
save "$user/$data/Data for analysis/Nepal_palika_population.dta", replace

* Importing policy data for merging. This is at the palika level
* For each month, did the palika "ease" containment policies or not 
import excel using "$user/$analysis/policy_data.xlsx", firstrow clear 
drop eased_7_20 eased_9_20 eased_10_20 eased_11_20 // remove July, Sept, Oct, Nov

* Merge policy data with health service utilization data (DHIS2)
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_WIDE.dta"
drop if _merge == 1 // One palika in master-only - dropped during cleaning 
drop _merge

* Merge data with Covid deaths data 
merge m:1 orgunitlevel3 using "$user/$data/Data for analysis/Nepal_covid_deaths.dta"
drop covid_death_7_20 covid_death_9_20 covid_death_10_20 covid_death_11_20 covid_death_12_20 _merge

* RESHAPES FROM WIDE TO LONG FOR ANALYSES 
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util opd_util ipd_util er_util ///
	tbdetect_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual hyper_util diab_util hivtest_qual /// 
	eased_ covid_death_ , i(org*) j(month) string	
drop if month== "7_20" | month== "9_20" | month== "10_20"  | month== "11_20"  | month== "12_20" // drop months 9 to 12 2020
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  |	month=="8_20" 
replace year = 2019 if year==.
gen mo = . 
replace mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" 
replace mo = 8 if month =="8_19" | month =="8_20" 
replace mo = 9 if month =="9_19" 
replace mo = 10 if month =="10_19" 
replace mo = 11 if month =="11_19" 
replace mo = 12 if month =="12_19" 

gen month_graph = mo
replace month_graph = mo + 12 if year == 2020
drop month
sort orgunitlevel1 orgunitlevel2 orgunitlevel3 organisationunitname year mo 
rename mo month
order org* year month 

* Merge with Covid cases 
merge m:1 orgunitlevel3 year month using "$user/$data/Data for analysis/Nepal_covid_cases.dta"
drop _merge

* Shortened palika name to merge on population size
gen districtkey = substr(orgunitlevel3, 4, .)
gen palikakey = substr(organisationunitname, 7, .)

* Merge with palika population data 
merge m:m palikakey using "$user/$data/Data for analysis/Nepal_palika_population.dta"
* Drop empty row and one palika that was dropped during complete case analysis 
drop if _merge == 2
drop District LocalLevelName _merge

* Other cleaning 
* If covid case or death is missing, 0 cases or deaths 
replace covid_death_ = 0 if covid_death_ == .
replace covid_case = 0 if covid_case == .

* Renaming family planning
rename fp_sa_util fp_util

* Creates an id for palika 
encode organisationunitname, gen(palikaid)

* Creates a tag for palika
egen tag = tag(organisationunitname)


*******************************************************************************
* Assign time-varying treatment status 
*******************************************************************************
rename eased_ eased

* Applying treatment status in month 8 to the full post period - fixed treatment status (eased in month 8/early) 
gen eased_fixed = 1 if eased == 1 & month == 8
by organisationunitname,  sort: egen temp= sum(eased_fixed) // here you could use the carryforward command
replace eased_fixed = temp if eased_fixed==.
drop temp

gen post = 0 if month_graph == 15 | month_graph == 16 | month_graph == 17 | month_graph == 18
replace post = 1 if month_graph == 20 

order org* year month eased* 
sort organisationunitname month

lab var eased "Eased policies in month 8"
lab var eased_fixed "Fixed treatment status (eased in month 8)"

save "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", replace

