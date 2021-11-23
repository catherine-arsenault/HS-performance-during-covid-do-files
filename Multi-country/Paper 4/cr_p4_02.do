* Health system resilience during Covid-19 
* Associations between COVID-19 lockdowns and health service disruptions in 10 countries 
* Created October 28th, 2021

clear all
set more off 
cd "$user/$analysis/Data"

************** Stringency Index Dataset **************
******************************************************

* Import latest stringency data from github 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/stringency_index.csv", varnames(1)
* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"
*Drop country ID 
drop v1
* Renaming variables to label name 		
foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' stringency`lbl'
}
* Only keep data from April - December 2020 
drop stringency_01Jan2020-stringency_31Mar2020 
keep country_code-stringency_13Jan2021
* Reshaping dataset to long 
reshape long stringency_01 stringency_02 stringency_03 stringency_04 stringency_05 /// 
			 stringency_06 stringency_07 stringency_08 stringency_09 stringency_10 ///
			 stringency_11 stringency_12 stringency_13 stringency_14 stringency_15 ///
			 stringency_16 stringency_17 stringency_18 stringency_19 stringency_20 ///
			 stringency_21 stringency_22 stringency_23 stringency_24 stringency_25 ///
			 stringency_26 stringency_27 stringency_28 stringency_29 stringency_30 ///
			 stringency_31, i(country_code country_name) j(mo) string
reshape long stringency, i(country_code country_name mo) j(day) string
gen month = .
replace month = 4 if mo == "Apr2020"
replace month = 5 if mo == "May2020"
replace month = 6 if mo == "Jun2020"
replace month = 7 if mo == "Jul2020"
replace month = 8 if mo == "Aug2020"
replace month = 9 if mo == "Sep2020"
replace month = 10 if mo == "Oct2020"
replace month = 11 if mo == "Nov2020"
replace month = 12 if mo == "Dec2020"
replace month = 1 if mo == "Jan2021"
drop mo
drop if stringency == . 

*For Nepali calendar 
global twelve 01 02 03 04 05 06 07 08 09 10 11 12 
global thirteen 01 02 03 04 05 06 07 08 09 10 11 12 13 
global fourteen 01 02 03 04 05 06 07 08 09 10 11 12 13 14
global fifteen 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
global sixteen 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 
* April 
foreach x of global twelve {
	drop if country_code == "NPL" & month == 4 & day == "_`x'"
}
foreach x of global thirteen {
	replace month = 4 if country_code == "NPL" & month == 5 & day == "_`x'"
}
* May
foreach x of global fourteen {
	replace month = 5 if country_code == "NPL" & month == 6 & day == "_`x'"
}
* June 
foreach x of global fifteen {
	replace month = 6 if country_code == "NPL" & month == 7 & day == "_`x'"
}
* July 
foreach x of global sixteen {
	replace month = 7 if country_code == "NPL" & month == 8 & day == "_`x'"
}
* August
foreach x of global sixteen {
	replace month = 8 if country_code == "NPL" & month == 9 & day == "_`x'"
}
* September
foreach x of global sixteen {
	replace month = 9 if country_code == "NPL" & month == 10 & day == "_`x'"
}
* October
foreach x of global fifteen {
	replace month = 10 if country_code == "NPL" & month == 11 & day == "_`x'"
}
* November 
foreach x of global fifteen {
	replace month = 11 if country_code == "NPL" & month == 12 & day == "_`x'"
}
* December 
foreach x of global thirteen {
	replace month = 12 if country_code == "NPL" & month == 1 & day == "_`x'"
}

drop if month == 1
gen year = 2020	

* Mean, median and max for stringency index 
gen stringency_mean = stringency
gen stringency_median = stringency 
gen stringency_max = stringency 
drop stringency 
collapse (mean) stringency_mean (median) stringency_median (max) stringency_max, by(country_code country_name month year)

rename country_code country 
replace country = "KZN" if country == "ZAF"
replace country = "NEP" if country == "NPL"
save "$user/$analysis/Data/stringency_index.dta", replace

******************** Policy Datasets ********************
*********************************************************

******** School closures ********
clear all 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c1_school_closing.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' school_close`lbl'
}

* Only keep data from April - December 2020 
drop school_close_01Jan2020-school_close_31Mar2020 
keep country_code-school_close_13Jan2021

* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var school_close_01Apr2020-school_close_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

save school_close, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen school_close_Apr2020 = rowtotal(school_close_01Apr2020-school_close_30Apr2020)
egen school_close_May2020 = rowtotal(school_close_01May2020-school_close_31May2020)
egen school_close_Jun2020 = rowtotal(school_close_01Jun2020-school_close_30Jun2020)
egen school_close_Jul2020 = rowtotal(school_close_01Jul2020-school_close_31Jul2020)
egen school_close_Aug2020 = rowtotal(school_close_01Aug2020-school_close_31Aug2020)
egen school_close_Sep2020 = rowtotal(school_close_01Sep2020-school_close_30Sep2020)
egen school_close_Oct2020 = rowtotal(school_close_01Oct2020-school_close_31Oct2020)
egen school_close_Nov2020 = rowtotal(school_close_01Nov2020-school_close_30Nov2020)
egen school_close_Dec2020 = rowtotal(school_close_01Dec2020-school_close_31Dec2020)

drop school_close_01Apr2020-school_close_13Jan2021

foreach v of var school_close_Apr2020-school_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save school_close_all, replace

*** For Nepal *** 
use school_close
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen school_close_Apr2020 = rowtotal(school_close_13Apr2020-school_close_13May2020)
egen school_close_May2020 = rowtotal(school_close_14May2020-school_close_14Jun2020)
egen school_close_Jun2020 = rowtotal(school_close_15Jun2020-school_close_15Jul2020)
egen school_close_Jul2020 = rowtotal(school_close_16Jul2020-school_close_16Aug2020)
egen school_close_Aug2020 = rowtotal(school_close_17Aug2020-school_close_16Sep2020)
egen school_close_Sep2020 = rowtotal(school_close_17Sep2020-school_close_16Oct2020)
egen school_close_Oct2020 = rowtotal(school_close_17Oct2020-school_close_15Nov2020)
egen school_close_Nov2020 = rowtotal(school_close_16Nov2020-school_close_15Dec2020)
egen school_close_Dec2020 = rowtotal(school_close_16Dec2020-school_close_13Jan2021)

drop school_close_01Apr2020-school_close_13Jan2021

foreach v of var school_close_Apr2020-school_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using school_close_all

save "$user/$analysis/Data/school_close_tmp.dta", replace


******** Workplace closures ********
clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c2_workplace_closing.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' work_close`lbl'
}

* Only keep data from April - December 2020 
drop work_close_01Jan2020-work_close_31Mar2020 
keep country_code-work_close_13Jan2021

* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var work_close_01Apr2020-work_close_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

save work_close, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen work_close_Apr2020 = rowtotal(work_close_01Apr2020-work_close_30Apr2020)
egen work_close_May2020 = rowtotal(work_close_01May2020-work_close_31May2020)
egen work_close_Jun2020 = rowtotal(work_close_01Jun2020-work_close_30Jun2020)
egen work_close_Jul2020 = rowtotal(work_close_01Jul2020-work_close_31Jul2020)
egen work_close_Aug2020 = rowtotal(work_close_01Aug2020-work_close_31Aug2020)
egen work_close_Sep2020 = rowtotal(work_close_01Sep2020-work_close_30Sep2020)
egen work_close_Oct2020 = rowtotal(work_close_01Oct2020-work_close_31Oct2020)
egen work_close_Nov2020 = rowtotal(work_close_01Nov2020-work_close_30Nov2020)
egen work_close_Dec2020 = rowtotal(work_close_01Dec2020-work_close_31Dec2020)

drop work_close_01Apr2020-work_close_13Jan2021

foreach v of var work_close_Apr2020-work_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save work_close_all, replace

*** For Nepal *** 
use work_close
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen work_close_Apr2020 = rowtotal(work_close_13Apr2020-work_close_13May2020)
egen work_close_May2020 = rowtotal(work_close_14May2020-work_close_14Jun2020)
egen work_close_Jun2020 = rowtotal(work_close_15Jun2020-work_close_15Jul2020)
egen work_close_Jul2020 = rowtotal(work_close_16Jul2020-work_close_16Aug2020)
egen work_close_Aug2020 = rowtotal(work_close_17Aug2020-work_close_16Sep2020)
egen work_close_Sep2020 = rowtotal(work_close_17Sep2020-work_close_16Oct2020)
egen work_close_Oct2020 = rowtotal(work_close_17Oct2020-work_close_15Nov2020)
egen work_close_Nov2020 = rowtotal(work_close_16Nov2020-work_close_15Dec2020)
egen work_close_Dec2020 = rowtotal(work_close_16Dec2020-work_close_13Jan2021)

drop work_close_01Apr2020-work_close_13Jan2021

foreach v of var work_close_Apr2020-work_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using work_close_all


save "$user/$analysis/Data/work_close_tmp.dta", replace


******** Public events canceled ********
clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c3_cancel_public_events.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' public_event`lbl'
}

* Only keep data from April - December 2020 
drop public_event_01Jan2020-public_event_31Mar2020 
keep country_code-public_event_13Jan2021

* Recoding values to a binary - "0" no measures and recommended canceling, "1" required canceling public events 
foreach v of var public_event_01Apr2020-public_event_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

save public_event, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen public_event_Apr2020 = rowtotal(public_event_01Apr2020-public_event_30Apr2020)
egen public_event_May2020 = rowtotal(public_event_01May2020-public_event_31May2020)
egen public_event_Jun2020 = rowtotal(public_event_01Jun2020-public_event_30Jun2020)
egen public_event_Jul2020 = rowtotal(public_event_01Jul2020-public_event_31Jul2020)
egen public_event_Aug2020 = rowtotal(public_event_01Aug2020-public_event_31Aug2020)
egen public_event_Sep2020 = rowtotal(public_event_01Sep2020-public_event_30Sep2020)
egen public_event_Oct2020 = rowtotal(public_event_01Oct2020-public_event_31Oct2020)
egen public_event_Nov2020 = rowtotal(public_event_01Nov2020-public_event_30Nov2020)
egen public_event_Dec2020 = rowtotal(public_event_01Dec2020-public_event_31Dec2020)

drop public_event_01Apr2020-public_event_13Jan2021

foreach v of var public_event_Apr2020-public_event_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save public_event_all, replace

*** For Nepal *** 
use public_event
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen public_event_Apr2020 = rowtotal(public_event_13Apr2020-public_event_13May2020)
egen public_event_May2020 = rowtotal(public_event_14May2020-public_event_14Jun2020)
egen public_event_Jun2020 = rowtotal(public_event_15Jun2020-public_event_15Jul2020)
egen public_event_Jul2020 = rowtotal(public_event_16Jul2020-public_event_16Aug2020)
egen public_event_Aug2020 = rowtotal(public_event_17Aug2020-public_event_16Sep2020)
egen public_event_Sep2020 = rowtotal(public_event_17Sep2020-public_event_16Oct2020)
egen public_event_Oct2020 = rowtotal(public_event_17Oct2020-public_event_15Nov2020)
egen public_event_Nov2020 = rowtotal(public_event_16Nov2020-public_event_15Dec2020)
egen public_event_Dec2020 = rowtotal(public_event_16Dec2020-public_event_13Jan2021)

drop public_event_01Apr2020-public_event_13Jan2021

foreach v of var public_event_Apr2020-public_event_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using public_event_all

save "$user/$analysis/Data/public_event_tmp.dta", replace

******** Restrictions on gatherings ********
clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c4_restrictions_on_gatherings.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' restrict_gather`lbl'
}

* Only keep data from April - December 2020 
drop restrict_gather_01Jan2020-restrict_gather_31Mar2020 
keep country_code-restrict_gather_13Jan2021

* Recoding values to a binary - "0" no measures, restricted to more than 1000 or restricted from 101-1000; "1" restricted 10-100 or <10
foreach v of var restrict_gather_01Apr2020-restrict_gather_13Jan2021 {
	recode `v' (0/2 = 0) 
	recode `v' (3/4 = 1)
}

save restrict_gather, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen restrict_gather_Apr2020 = rowtotal(restrict_gather_01Apr2020-restrict_gather_30Apr2020)
egen restrict_gather_May2020 = rowtotal(restrict_gather_01May2020-restrict_gather_31May2020)
egen restrict_gather_Jun2020 = rowtotal(restrict_gather_01Jun2020-restrict_gather_30Jun2020)
egen restrict_gather_Jul2020 = rowtotal(restrict_gather_01Jul2020-restrict_gather_31Jul2020)
egen restrict_gather_Aug2020 = rowtotal(restrict_gather_01Aug2020-restrict_gather_31Aug2020)
egen restrict_gather_Sep2020 = rowtotal(restrict_gather_01Sep2020-restrict_gather_30Sep2020)
egen restrict_gather_Oct2020 = rowtotal(restrict_gather_01Oct2020-restrict_gather_31Oct2020)
egen restrict_gather_Nov2020 = rowtotal(restrict_gather_01Nov2020-restrict_gather_30Nov2020)
egen restrict_gather_Dec2020 = rowtotal(restrict_gather_01Dec2020-restrict_gather_31Dec2020)

drop restrict_gather_01Apr2020-restrict_gather_13Jan2021

foreach v of var restrict_gather_Apr2020-restrict_gather_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save restrict_gather_all, replace

*** For Nepal *** 
use restrict_gather
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen restrict_gather_Apr2020 = rowtotal(restrict_gather_13Apr2020-restrict_gather_13May2020)
egen restrict_gather_May2020 = rowtotal(restrict_gather_14May2020-restrict_gather_14Jun2020)
egen restrict_gather_Jun2020 = rowtotal(restrict_gather_15Jun2020-restrict_gather_15Jul2020)
egen restrict_gather_Jul2020 = rowtotal(restrict_gather_16Jul2020-restrict_gather_16Aug2020)
egen restrict_gather_Aug2020 = rowtotal(restrict_gather_17Aug2020-restrict_gather_16Sep2020)
egen restrict_gather_Sep2020 = rowtotal(restrict_gather_17Sep2020-restrict_gather_16Oct2020)
egen restrict_gather_Oct2020 = rowtotal(restrict_gather_17Oct2020-restrict_gather_15Nov2020)
egen restrict_gather_Nov2020 = rowtotal(restrict_gather_16Nov2020-restrict_gather_15Dec2020)
egen restrict_gather_Dec2020 = rowtotal(restrict_gather_16Dec2020-restrict_gather_13Jan2021)

drop restrict_gather_01Apr2020-restrict_gather_13Jan2021

foreach v of var restrict_gather_Apr2020-restrict_gather_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using restrict_gather_all

save "$user/$analysis/Data/restrict_gather_tmp.dta", replace

******** Public transport closures ********

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c5_close_public_transport.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' public_trnsprt`lbl'
}

* Only keep data from April - December 2020 
drop public_trnsprt_01Jan2020-public_trnsprt_31Mar2020 
keep country_code-public_trnsprt_13Jan2021

* Recoding values to a binary - "0" no measures and recommend reducing volume, "1" required closing public transport 
foreach v of var public_trnsprt_01Apr2020-public_trnsprt_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

save public_trnsprt, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen public_trnsprt_Apr2020 = rowtotal(public_trnsprt_01Apr2020-public_trnsprt_30Apr2020)
egen public_trnsprt_May2020 = rowtotal(public_trnsprt_01May2020-public_trnsprt_31May2020)
egen public_trnsprt_Jun2020 = rowtotal(public_trnsprt_01Jun2020-public_trnsprt_30Jun2020)
egen public_trnsprt_Jul2020 = rowtotal(public_trnsprt_01Jul2020-public_trnsprt_31Jul2020)
egen public_trnsprt_Aug2020 = rowtotal(public_trnsprt_01Aug2020-public_trnsprt_31Aug2020)
egen public_trnsprt_Sep2020 = rowtotal(public_trnsprt_01Sep2020-public_trnsprt_30Sep2020)
egen public_trnsprt_Oct2020 = rowtotal(public_trnsprt_01Oct2020-public_trnsprt_31Oct2020)
egen public_trnsprt_Nov2020 = rowtotal(public_trnsprt_01Nov2020-public_trnsprt_30Nov2020)
egen public_trnsprt_Dec2020 = rowtotal(public_trnsprt_01Dec2020-public_trnsprt_31Dec2020)

drop public_trnsprt_01Apr2020-public_trnsprt_13Jan2021

foreach v of var public_trnsprt_Apr2020-public_trnsprt_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save public_trnsprt_all, replace

*** For Nepal *** 
use public_trnsprt
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen public_trnsprt_Apr2020 = rowtotal(public_trnsprt_13Apr2020-public_trnsprt_13May2020)
egen public_trnsprt_May2020 = rowtotal(public_trnsprt_14May2020-public_trnsprt_14Jun2020)
egen public_trnsprt_Jun2020 = rowtotal(public_trnsprt_15Jun2020-public_trnsprt_15Jul2020)
egen public_trnsprt_Jul2020 = rowtotal(public_trnsprt_16Jul2020-public_trnsprt_16Aug2020)
egen public_trnsprt_Aug2020 = rowtotal(public_trnsprt_17Aug2020-public_trnsprt_16Sep2020)
egen public_trnsprt_Sep2020 = rowtotal(public_trnsprt_17Sep2020-public_trnsprt_16Oct2020)
egen public_trnsprt_Oct2020 = rowtotal(public_trnsprt_17Oct2020-public_trnsprt_15Nov2020)
egen public_trnsprt_Nov2020 = rowtotal(public_trnsprt_16Nov2020-public_trnsprt_15Dec2020)
egen public_trnsprt_Dec2020 = rowtotal(public_trnsprt_16Dec2020-public_trnsprt_13Jan2021)

drop public_trnsprt_01Apr2020-public_trnsprt_13Jan2021

foreach v of var public_trnsprt_Apr2020-public_trnsprt_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using public_trnsprt_all

save "$user/$analysis/Data/public_trnsprt_tmp.dta", replace

******** Stay at home requirements ********

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c6_stay_at_home_requirements.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' stay_home`lbl'
}

* Only keep data from April - December 2020 
drop stay_home_01Jan2020-stay_home_31Mar2020 
keep country_code-stay_home_13Jan2021

* Recoding values to a binary - "0" no measures and recommend staying home, "1" required with some or no exceptions 
foreach v of var stay_home_01Apr2020-stay_home_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

save stay_home, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen stay_home_Apr2020 = rowtotal(stay_home_01Apr2020-stay_home_30Apr2020)
egen stay_home_May2020 = rowtotal(stay_home_01May2020-stay_home_31May2020)
egen stay_home_Jun2020 = rowtotal(stay_home_01Jun2020-stay_home_30Jun2020)
egen stay_home_Jul2020 = rowtotal(stay_home_01Jul2020-stay_home_31Jul2020)
egen stay_home_Aug2020 = rowtotal(stay_home_01Aug2020-stay_home_31Aug2020)
egen stay_home_Sep2020 = rowtotal(stay_home_01Sep2020-stay_home_30Sep2020)
egen stay_home_Oct2020 = rowtotal(stay_home_01Oct2020-stay_home_31Oct2020)
egen stay_home_Nov2020 = rowtotal(stay_home_01Nov2020-stay_home_30Nov2020)
egen stay_home_Dec2020 = rowtotal(stay_home_01Dec2020-stay_home_31Dec2020)

drop stay_home_01Apr2020-stay_home_13Jan2021

foreach v of var stay_home_Apr2020-stay_home_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save stay_home_all, replace

*** For Nepal *** 
use stay_home
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen stay_home_Apr2020 = rowtotal(stay_home_13Apr2020-stay_home_13May2020)
egen stay_home_May2020 = rowtotal(stay_home_14May2020-stay_home_14Jun2020)
egen stay_home_Jun2020 = rowtotal(stay_home_15Jun2020-stay_home_15Jul2020)
egen stay_home_Jul2020 = rowtotal(stay_home_16Jul2020-stay_home_16Aug2020)
egen stay_home_Aug2020 = rowtotal(stay_home_17Aug2020-stay_home_16Sep2020)
egen stay_home_Sep2020 = rowtotal(stay_home_17Sep2020-stay_home_16Oct2020)
egen stay_home_Oct2020 = rowtotal(stay_home_17Oct2020-stay_home_15Nov2020)
egen stay_home_Nov2020 = rowtotal(stay_home_16Nov2020-stay_home_15Dec2020)
egen stay_home_Dec2020 = rowtotal(stay_home_16Dec2020-stay_home_13Jan2021)

drop stay_home_01Apr2020-stay_home_13Jan2021

foreach v of var stay_home_Apr2020-stay_home_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using stay_home_all

save "$user/$analysis/Data/stay_home_tmp.dta", replace

******** Restrictions on internal movement ********

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c7_movementrestrictions.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' move_restr`lbl'
}

* Only keep data from April - December 2020 
drop move_restr_01Jan2020-move_restr_31Mar2020 
keep country_code-move_restr_13Jan2021

* Recoding values to a binary - "0" no measures and recommend not to travel between regions/cities, "1" internal movement restrictions in place
foreach v of var move_restr_01Apr2020-move_restr_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

save move_restr, replace


*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen move_restr_Apr2020 = rowtotal(move_restr_01Apr2020-move_restr_30Apr2020)
egen move_restr_May2020 = rowtotal(move_restr_01May2020-move_restr_31May2020)
egen move_restr_Jun2020 = rowtotal(move_restr_01Jun2020-move_restr_30Jun2020)
egen move_restr_Jul2020 = rowtotal(move_restr_01Jul2020-move_restr_31Jul2020)
egen move_restr_Aug2020 = rowtotal(move_restr_01Aug2020-move_restr_31Aug2020)
egen move_restr_Sep2020 = rowtotal(move_restr_01Sep2020-move_restr_30Sep2020)
egen move_restr_Oct2020 = rowtotal(move_restr_01Oct2020-move_restr_31Oct2020)
egen move_restr_Nov2020 = rowtotal(move_restr_01Nov2020-move_restr_30Nov2020)
egen move_restr_Dec2020 = rowtotal(move_restr_01Dec2020-move_restr_31Dec2020)

drop move_restr_01Apr2020-move_restr_13Jan2021

foreach v of var move_restr_Apr2020-move_restr_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save move_restr_all, replace

*** For Nepal *** 
use move_restr
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen move_restr_Apr2020 = rowtotal(move_restr_13Apr2020-move_restr_13May2020)
egen move_restr_May2020 = rowtotal(move_restr_14May2020-move_restr_14Jun2020)
egen move_restr_Jun2020 = rowtotal(move_restr_15Jun2020-move_restr_15Jul2020)
egen move_restr_Jul2020 = rowtotal(move_restr_16Jul2020-move_restr_16Aug2020)
egen move_restr_Aug2020 = rowtotal(move_restr_17Aug2020-move_restr_16Sep2020)
egen move_restr_Sep2020 = rowtotal(move_restr_17Sep2020-move_restr_16Oct2020)
egen move_restr_Oct2020 = rowtotal(move_restr_17Oct2020-move_restr_15Nov2020)
egen move_restr_Nov2020 = rowtotal(move_restr_16Nov2020-move_restr_15Dec2020)
egen move_restr_Dec2020 = rowtotal(move_restr_16Dec2020-move_restr_13Jan2021)

drop move_restr_01Apr2020-move_restr_13Jan2021

foreach v of var move_restr_Apr2020-move_restr_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using move_restr_all

save "$user/$analysis/Data/move_restr_tmp.dta", replace

******** Restrictions on internal movement ********

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c8_internationaltravel.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' int_trav`lbl'
}

* Only keep data from April - December 2020 
drop int_trav_01Jan2020-int_trav_31Mar2020 
keep country_code-int_trav_13Jan2021

* Recoding values to a binary - "0" no measures, screening, or quarantine , "1" ban arrivals from some regions or total border closure 
foreach v of var int_trav_01Apr2020-int_trav_13Jan2021 {
	recode `v' (0/2 = 0) 
	recode `v' (3/4= 1)
}

save int_trav, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen int_trav_Apr2020 = rowtotal(int_trav_01Apr2020-int_trav_30Apr2020)
egen int_trav_May2020 = rowtotal(int_trav_01May2020-int_trav_31May2020)
egen int_trav_Jun2020 = rowtotal(int_trav_01Jun2020-int_trav_30Jun2020)
egen int_trav_Jul2020 = rowtotal(int_trav_01Jul2020-int_trav_31Jul2020)
egen int_trav_Aug2020 = rowtotal(int_trav_01Aug2020-int_trav_31Aug2020)
egen int_trav_Sep2020 = rowtotal(int_trav_01Sep2020-int_trav_30Sep2020)
egen int_trav_Oct2020 = rowtotal(int_trav_01Oct2020-int_trav_31Oct2020)
egen int_trav_Nov2020 = rowtotal(int_trav_01Nov2020-int_trav_30Nov2020)
egen int_trav_Dec2020 = rowtotal(int_trav_01Dec2020-int_trav_31Dec2020)

drop int_trav_01Apr2020-int_trav_13Jan2021

foreach v of var int_trav_Apr2020-int_trav_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save int_trav_all, replace

*** For Nepal *** 
use int_trav
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen int_trav_Apr2020 = rowtotal(int_trav_13Apr2020-int_trav_13May2020)
egen int_trav_May2020 = rowtotal(int_trav_14May2020-int_trav_14Jun2020)
egen int_trav_Jun2020 = rowtotal(int_trav_15Jun2020-int_trav_15Jul2020)
egen int_trav_Jul2020 = rowtotal(int_trav_16Jul2020-int_trav_16Aug2020)
egen int_trav_Aug2020 = rowtotal(int_trav_17Aug2020-int_trav_16Sep2020)
egen int_trav_Sep2020 = rowtotal(int_trav_17Sep2020-int_trav_16Oct2020)
egen int_trav_Oct2020 = rowtotal(int_trav_17Oct2020-int_trav_15Nov2020)
egen int_trav_Nov2020 = rowtotal(int_trav_16Nov2020-int_trav_15Dec2020)
egen int_trav_Dec2020 = rowtotal(int_trav_16Dec2020-int_trav_13Jan2021)

drop int_trav_01Apr2020-int_trav_13Jan2021

foreach v of var int_trav_Apr2020-int_trav_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using int_trav_all

save "$user/$analysis/Data/int_trav_tmp.dta", replace

******** Public Information campaigns ********

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/h1_public_information_campaigns.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

*Drop country ID 
drop v1

* Renaming variables to label name 		

foreach v of var jan2020-v690 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' info_camp`lbl'
}

* Only keep data from April - December 2020 
drop info_camp_01Jan2020-info_camp_31Mar2020 
keep country_code-info_camp_13Jan2021

* Recoding values to a binary - "0" no measures or public officials urging caution, "1" coordinated campaign
foreach v of var info_camp_01Apr2020-info_camp_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2= 1)
}

save info_camp, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen info_camp_Apr2020 = rowtotal(info_camp_01Apr2020-info_camp_30Apr2020)
egen info_camp_May2020 = rowtotal(info_camp_01May2020-info_camp_31May2020)
egen info_camp_Jun2020 = rowtotal(info_camp_01Jun2020-info_camp_30Jun2020)
egen info_camp_Jul2020 = rowtotal(info_camp_01Jul2020-info_camp_31Jul2020)
egen info_camp_Aug2020 = rowtotal(info_camp_01Aug2020-info_camp_31Aug2020)
egen info_camp_Sep2020 = rowtotal(info_camp_01Sep2020-info_camp_30Sep2020)
egen info_camp_Oct2020 = rowtotal(info_camp_01Oct2020-info_camp_31Oct2020)
egen info_camp_Nov2020 = rowtotal(info_camp_01Nov2020-info_camp_30Nov2020)
egen info_camp_Dec2020 = rowtotal(info_camp_01Dec2020-info_camp_31Dec2020)

drop info_camp_01Apr2020-info_camp_13Jan2021

foreach v of var info_camp_Apr2020-info_camp_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save info_camp_all, replace

*** For Nepal *** 
use info_camp
keep if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month 
egen info_camp_Apr2020 = rowtotal(info_camp_13Apr2020-info_camp_13May2020)
egen info_camp_May2020 = rowtotal(info_camp_14May2020-info_camp_14Jun2020)
egen info_camp_Jun2020 = rowtotal(info_camp_15Jun2020-info_camp_15Jul2020)
egen info_camp_Jul2020 = rowtotal(info_camp_16Jul2020-info_camp_16Aug2020)
egen info_camp_Aug2020 = rowtotal(info_camp_17Aug2020-info_camp_16Sep2020)
egen info_camp_Sep2020 = rowtotal(info_camp_17Sep2020-info_camp_16Oct2020)
egen info_camp_Oct2020 = rowtotal(info_camp_17Oct2020-info_camp_15Nov2020)
egen info_camp_Nov2020 = rowtotal(info_camp_16Nov2020-info_camp_15Dec2020)
egen info_camp_Dec2020 = rowtotal(info_camp_16Dec2020-info_camp_13Jan2021)

drop info_camp_01Apr2020-info_camp_13Jan2021

foreach v of var info_camp_Apr2020-info_camp_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using info_camp_all

save "$user/$analysis/Data/info_camp_tmp.dta", replace

******** Merging all policy datasets ********

global policy school_close work_close public_event restrict_gather public_trnsprt ///
			  stay_home move_restr int_trav info_camp
			  
* Merge with curfew and State of emergency (SOE) data (not collected by Oxford)
clear all
import excel "$user/$analysis/Data/curfew_soe.xlsx", firstrow

foreach x of global policy {
	merge 1:1 country_code country_name using "$user/$analysis/Data/`x'_tmp.dta"
	drop _merge
}

* Reshaping dataset to long 
reshape long curfew soe info_camp school_close work_close public_event ///
			 restrict_gather public_trnsprt stay_home move_restr int_trav, ///
			 i(country_code country_name) j(mo) string
gen year = 2020	
gen month = 4
replace month = 5 if mo == "_May2020"
replace month = 6 if mo == "_Jun2020"
replace month = 7 if mo == "_Jul2020"
replace month = 8 if mo == "_Aug2020"
replace month = 9 if mo == "_Sep2020"
replace month = 10 if mo == "_Oct2020"
replace month = 11 if mo == "_Nov2020"
replace month = 12 if mo == "_Dec2020"
drop mo
rename country_code country 
replace country = "KZN" if country == "ZAF"
replace country = "NEP" if country == "NPL"

save "$user/$analysis/Data/policy_data.dta", replace

* Remove temp files 
foreach x of global policy {
		rm "$user/$analysis/Data/`x'_tmp.dta"
		rm "$user/$analysis/Data/`x'.dta"
		rm "$user/$analysis/Data/`x'_all.dta"
	}

************* Merge stringency, policy and relative volume data ****************
********************************************************************************
use "$user/$analysis/Data/Multip4.dta", clear
merge m:1 country month year using "$user/$analysis/Data/stringency_index.dta"
drop _merge
merge m:1 country month year using "$user/$analysis/Data/policy_data.dta"
drop if month == 3 // Nepal March data removed (due to different calendar month 3 was Mar 14-April 12)
drop _merge country_name
order country rmonth year month service relative_vol

save "$user/$analysis/Data/Multip4_combined.dta", replace

