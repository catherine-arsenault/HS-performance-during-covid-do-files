* Nepal provincial analysis

global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/nek096/Dropbox (Harvard University)"
global NEPdata "/HMIS Data for Health System Performance Covid (Nepal)"
global analysis "/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Country-specific papers/Nepal/Service disruption/Results"

********************************************************************************
* COVID-19 cases data - changing from Western calendar to Nepali calendar 
********************************************************************************
clear all 
* Importing and Cleaning COVID case data at the district level
import excel using "$user/$NEPdata/Data for analysis/COVID Cases new one.xlsx", firstrow clear
drop sn  date patient_name age sex province district
drop if orgunitlevel3 == ""
collapse (sum) covid_case, by (year month day orgunitlevel3) 
sort month day year
** Changing Western dates to Nepali dates - January, February and March (mostly) are fine 
gen month_new = . 
*Magh: Jan 15 - Feb 12 is 1 
replace month_new = 1 if month == 1 & year == 2020
*Falgun: Feb 13 - Mar 13 is 2 
replace month_new = 2 if month == 2 & year == 2020
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
*Poush: Dec 16 - Jan 13 
replace month_new = 12 if month == 12 & month_new == . 
replace month_new = 12 if month == 1 & day == 1 | month == 1 & day == 2 | month == 1 & day == 3 | month == 1 & day == 4 | month == 1 & day == 5 | month == 1 & day == 6 | month == 1 & day == 7 | month == 1 & day == 8 | month == 1 & day == 9 | month == 1 & day == 10 | month == 1 & day == 11 | month == 1 & day == 12 | month == 1 & day == 13 
drop if month_new == . 
drop month day
rename month_new month

order orgunitlevel3 year month covid_case
replace year = 2020 
collapse (sum) covid_case, by (year month orgunitlevel3) 
save "$user/$NEPdata/Data for analysis/Nepal_covid_cases_prov.dta", replace


*****************************************************************************************************************
* Merge service utilization data, COVID-19 cases and eco-zones data, and collapse to province and eco-zone level 
*****************************************************************************************************************
clear all
import excel "$user/$NEPdata/Data for analysis/nep_eco_zones.xlsx", firstrow
lab def ez 1 "Mountain" 2 "Hills" 3 "Terrai"
lab val eco_zone ez
drop eco_zone_long

* Merge with service utilization data 
merge m:m orgunitlevel2 orgunitlevel3 using "$user/$NEPdata/Data for analysis/Nepal_su_24months.dta"

keep orgunitlevel2-unique_id fp_perm_util fp_sa_util fp_la_util anc_util ///
del_util cs_util pnc_util diarr_util pneum_util  opd_util ipd_util er_util ///
tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual measles_qual ///
pneum_qual

* Merge with COVID-19 case data 
merge m:m orgunitlevel3 month year using "$user/$NEPdata/Data for analysis/Nepal_covid_cases_prov.dta"
drop _merge
replace covid_case = 0 if covid_case == . 

* Number of palika per Province
egen Npalika= count(organisationunitname) if year==2019 & month==1, by(orgunitlevel2)
by orgunitlevel2, sort: carryforward Npalika, replace

* Running month from Jan 2019
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
rename orgunitlevel2 province
order province rmonth 
encode province, gen(prov)
		
gen season = .
recode season (.=1) if ( month>=3 & month<=5  )
recode season (.=2) if ( month>=6 & month<=8  )
recode season (.=3) if ( month>=9 & month<=11 )
recode season (.=4) if inlist(month, 1, 2, 12)             
la var season "Season"
la def season 1 "Spring" 2 "Summer" 3 "Fall" 4 "Winter"
la val season season
		
* Slope change 
gen timeafter= . 
replace timeafter = rmonth-14 
replace timeafter=0 if timeafter<0
		
preserve 
* Collapse to Province 
collapse (first) Npalika (sum) fp_perm_util fp_sa_util fp_la_util anc_util ///
del_util cs_util pnc_util diarr_util pneum_util  opd_util ipd_util er_util ///
tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual measles_qual ///
pneum_qual covid_case, by(province prov year month rmonth season timeafter)

save "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", replace
restore 

