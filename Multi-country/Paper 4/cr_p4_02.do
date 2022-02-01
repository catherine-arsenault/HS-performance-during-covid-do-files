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

* Save school close flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c1_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_school_close`lbl'
}
save school_close_flag, replace

* Import school close data
clear 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c1_school_closing.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' school_close`lbl'
}

* Merge with flag data and trim data 
merge 1:1 v1 country_code country_name using school_close_flag
keep country_code country_name school* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"


* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var school_close_01Apr2020-school_close_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1) 
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var school_close_01Apr2020-school_close_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop school_close_01Jan2020-school_close_31Mar2020 
drop flag*
save school_close, replace

*** For all countries except Nepal *** 
drop if country_code == "NPL"
* From daily policy to monthly policy - if policy in place for 10 or more days of the month (do this for both national and not)
egen school_close_Apr2020 = rowtotal(school_close_01Apr2020-school_close_30Apr2020)
egen school_close_May2020 = rowtotal(school_close_01May2020-school_close_31May2020)
egen school_close_Jun2020 = rowtotal(school_close_01Jun2020-school_close_30Jun2020)
egen school_close_Jul2020 = rowtotal(school_close_01Jul2020-school_close_31Jul2020)
egen school_close_Aug2020 = rowtotal(school_close_01Aug2020-school_close_31Aug2020)
egen school_close_Sep2020 = rowtotal(school_close_01Sep2020-school_close_30Sep2020)
egen school_close_Oct2020 = rowtotal(school_close_01Oct2020-school_close_31Oct2020)
egen school_close_Nov2020 = rowtotal(school_close_01Nov2020-school_close_30Nov2020)
egen school_close_Dec2020 = rowtotal(school_close_01Dec2020-school_close_31Dec2020)
* National
egen school_close_Apr2020_ntnl = rowtotal(school_close_01Apr2020_ntnl-school_close_30Apr2020_ntnl)
egen school_close_May2020_ntnl = rowtotal(school_close_01May2020_ntnl-school_close_31May2020_ntnl)
egen school_close_Jun2020_ntnl = rowtotal(school_close_01Jun2020_ntnl-school_close_30Jun2020_ntnl)
egen school_close_Jul2020_ntnl = rowtotal(school_close_01Jul2020_ntnl-school_close_31Jul2020_ntnl)
egen school_close_Aug2020_ntnl = rowtotal(school_close_01Aug2020_ntnl-school_close_31Aug2020_ntnl)
egen school_close_Sep2020_ntnl = rowtotal(school_close_01Sep2020_ntnl-school_close_30Sep2020_ntnl)
egen school_close_Oct2020_ntnl = rowtotal(school_close_01Oct2020_ntnl-school_close_31Oct2020_ntnl)
egen school_close_Nov2020_ntnl = rowtotal(school_close_01Nov2020_ntnl-school_close_30Nov2020_ntnl)
egen school_close_Dec2020_ntnl = rowtotal(school_close_01Dec2020_ntnl-school_close_31Dec2020_ntnl)

drop school_close_01Apr2020-school_close_13Jan2021_ntnl

foreach v of var school_close_Apr2020-school_close_Dec2020_ntnl {
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
* National
egen school_close_Apr2020_ntnl = rowtotal(school_close_13Apr2020_ntnl-school_close_13May2020_ntnl)
egen school_close_May2020_ntnl = rowtotal(school_close_14May2020_ntnl-school_close_14Jun2020_ntnl)
egen school_close_Jun2020_ntnl = rowtotal(school_close_15Jun2020_ntnl-school_close_15Jul2020_ntnl)
egen school_close_Jul2020_ntnl = rowtotal(school_close_16Jul2020_ntnl-school_close_16Aug2020_ntnl)
egen school_close_Aug2020_ntnl = rowtotal(school_close_17Aug2020_ntnl-school_close_16Sep2020_ntnl)
egen school_close_Sep2020_ntnl = rowtotal(school_close_17Sep2020_ntnl-school_close_16Oct2020_ntnl)
egen school_close_Oct2020_ntnl = rowtotal(school_close_17Oct2020_ntnl-school_close_15Nov2020_ntnl)
egen school_close_Nov2020_ntnl = rowtotal(school_close_16Nov2020_ntnl-school_close_15Dec2020_ntnl)
egen school_close_Dec2020_ntnl = rowtotal(school_close_16Dec2020_ntnl-school_close_13Jan2021_ntnl)
drop school_close_01Apr2020-school_close_13Jan2021_ntnl

foreach v of var school_close_Apr2020-school_close_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using school_close_all

save "$user/$analysis/Data/school_close_tmp.dta", replace


******** Workplace closures ********
clear all 

* Save workplace close flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c2_flag.csv"
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_work_close`lbl'
}
save work_close_flag, replace

*Import work close data 
clear
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c2_workplace_closing.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' work_close`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using work_close_flag
keep country_code country_name work* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var work_close_01Apr2020-work_close_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var work_close_01Apr2020-work_close_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop work_close_01Jan2020-work_close_31Mar2020 
drop flag*
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
* National 
egen work_close_Apr2020_ntnl = rowtotal(work_close_01Apr2020_ntnl-work_close_30Apr2020_ntnl)
egen work_close_May2020_ntnl = rowtotal(work_close_01May2020_ntnl-work_close_31May2020_ntnl)
egen work_close_Jun2020_ntnl = rowtotal(work_close_01Jun2020_ntnl-work_close_30Jun2020_ntnl)
egen work_close_Jul2020_ntnl = rowtotal(work_close_01Jul2020_ntnl-work_close_31Jul2020_ntnl)
egen work_close_Aug2020_ntnl = rowtotal(work_close_01Aug2020_ntnl-work_close_31Aug2020_ntnl)
egen work_close_Sep2020_ntnl = rowtotal(work_close_01Sep2020_ntnl-work_close_30Sep2020_ntnl)
egen work_close_Oct2020_ntnl = rowtotal(work_close_01Oct2020_ntnl-work_close_31Oct2020_ntnl)
egen work_close_Nov2020_ntnl = rowtotal(work_close_01Nov2020_ntnl-work_close_30Nov2020_ntnl)
egen work_close_Dec2020_ntnl = rowtotal(work_close_01Dec2020_ntnl-work_close_31Dec2020_ntnl)

drop work_close_01Apr2020-work_close_13Jan2021_ntnl

foreach v of var work_close_Apr2020-work_close_Dec2020_ntnl {
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
* National 
egen work_close_Apr2020_ntnl = rowtotal(work_close_13Apr2020_ntnl-work_close_13May2020_ntnl)
egen work_close_May2020_ntnl = rowtotal(work_close_14May2020_ntnl-work_close_14Jun2020_ntnl)
egen work_close_Jun2020_ntnl = rowtotal(work_close_15Jun2020_ntnl-work_close_15Jul2020_ntnl)
egen work_close_Jul2020_ntnl = rowtotal(work_close_16Jul2020_ntnl-work_close_16Aug2020_ntnl)
egen work_close_Aug2020_ntnl = rowtotal(work_close_17Aug2020_ntnl-work_close_16Sep2020_ntnl)
egen work_close_Sep2020_ntnl = rowtotal(work_close_17Sep2020_ntnl-work_close_16Oct2020_ntnl)
egen work_close_Oct2020_ntnl = rowtotal(work_close_17Oct2020_ntnl-work_close_15Nov2020_ntnl)
egen work_close_Nov2020_ntnl = rowtotal(work_close_16Nov2020_ntnl-work_close_15Dec2020_ntnl)
egen work_close_Dec2020_ntnl = rowtotal(work_close_16Dec2020_ntnl-work_close_13Jan2021_ntnl)

drop work_close_01Apr2020-work_close_13Jan2021_ntnl

foreach v of var work_close_Apr2020-work_close_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using work_close_all

save "$user/$analysis/Data/work_close_tmp.dta", replace


******** Public events canceled ********
clear all 

* Save public event flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c3_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_public_event`lbl'
}
save public_event_flag, replace

*Import public event cancelation data 
clear
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c3_cancel_public_events.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' public_event`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using public_event_flag
keep country_code country_name public* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures and recommended canceling, "1" required canceling public events 
foreach v of var public_event_01Apr2020-public_event_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var public_event_01Apr2020-public_event_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop public_event_01Jan2020-public_event_31Mar2020
drop flag* 
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
* National
egen public_event_Apr2020_ntnl = rowtotal(public_event_01Apr2020_ntnl-public_event_30Apr2020_ntnl)
egen public_event_May2020_ntnl = rowtotal(public_event_01May2020_ntnl-public_event_31May2020_ntnl)
egen public_event_Jun2020_ntnl = rowtotal(public_event_01Jun2020_ntnl-public_event_30Jun2020_ntnl)
egen public_event_Jul2020_ntnl = rowtotal(public_event_01Jul2020_ntnl-public_event_31Jul2020_ntnl)
egen public_event_Aug2020_ntnl = rowtotal(public_event_01Aug2020_ntnl-public_event_31Aug2020_ntnl)
egen public_event_Sep2020_ntnl = rowtotal(public_event_01Sep2020_ntnl-public_event_30Sep2020_ntnl)
egen public_event_Oct2020_ntnl = rowtotal(public_event_01Oct2020_ntnl-public_event_31Oct2020_ntnl)
egen public_event_Nov2020_ntnl = rowtotal(public_event_01Nov2020_ntnl-public_event_30Nov2020_ntnl)
egen public_event_Dec2020_ntnl = rowtotal(public_event_01Dec2020_ntnl-public_event_31Dec2020_ntnl)

drop public_event_01Apr2020-public_event_13Jan2021_ntnl

foreach v of var public_event_Apr2020-public_event_Dec2020_ntnl {
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
* National 
egen public_event_Apr2020_ntnl = rowtotal(public_event_13Apr2020_ntnl-public_event_13May2020_ntnl)
egen public_event_May2020_ntnl = rowtotal(public_event_14May2020_ntnl-public_event_14Jun2020_ntnl)
egen public_event_Jun2020_ntnl = rowtotal(public_event_15Jun2020_ntnl-public_event_15Jul2020_ntnl)
egen public_event_Jul2020_ntnl = rowtotal(public_event_16Jul2020_ntnl-public_event_16Aug2020_ntnl)
egen public_event_Aug2020_ntnl = rowtotal(public_event_17Aug2020_ntnl-public_event_16Sep2020_ntnl)
egen public_event_Sep2020_ntnl = rowtotal(public_event_17Sep2020_ntnl-public_event_16Oct2020_ntnl)
egen public_event_Oct2020_ntnl = rowtotal(public_event_17Oct2020_ntnl-public_event_15Nov2020_ntnl)
egen public_event_Nov2020_ntnl = rowtotal(public_event_16Nov2020_ntnl-public_event_15Dec2020_ntnl)
egen public_event_Dec2020_ntnl = rowtotal(public_event_16Dec2020_ntnl-public_event_13Jan2021_ntnl)

drop public_event_01Apr2020-public_event_13Jan2021_ntnl

foreach v of var public_event_Apr2020-public_event_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using public_event_all

save "$user/$analysis/Data/public_event_tmp.dta", replace

******** Restrictions on gatherings ********
clear all 
* Save gathering flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c4_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_restrict_gather`lbl'
}
save restrict_gather_flag, replace

* Import gathering restrictions data 
clear 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c4_restrictions_on_gatherings.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' restrict_gather`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using restrict_gather_flag
keep country_code country_name restrict* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures, restricted to more than 1000 or restricted from 101-1000; "1" restricted 10-100 or <10
foreach v of var restrict_gather_01Apr2020-restrict_gather_13Jan2021 {
	recode `v' (0/2 = 0) 
	recode `v' (3/4 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var restrict_gather_01Apr2020-restrict_gather_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop restrict_gather_01Jan2020-restrict_gather_31Mar2020 
drop flag*
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
* National
egen restrict_gather_Apr2020_ntnl = rowtotal(restrict_gather_01Apr2020_ntnl-restrict_gather_30Apr2020_ntnl)
egen restrict_gather_May2020_ntnl = rowtotal(restrict_gather_01May2020_ntnl-restrict_gather_31May2020_ntnl)
egen restrict_gather_Jun2020_ntnl = rowtotal(restrict_gather_01Jun2020_ntnl-restrict_gather_30Jun2020_ntnl)
egen restrict_gather_Jul2020_ntnl = rowtotal(restrict_gather_01Jul2020_ntnl-restrict_gather_31Jul2020_ntnl)
egen restrict_gather_Aug2020_ntnl = rowtotal(restrict_gather_01Aug2020_ntnl-restrict_gather_31Aug2020_ntnl)
egen restrict_gather_Sep2020_ntnl = rowtotal(restrict_gather_01Sep2020_ntnl-restrict_gather_30Sep2020_ntnl)
egen restrict_gather_Oct2020_ntnl = rowtotal(restrict_gather_01Oct2020_ntnl-restrict_gather_31Oct2020_ntnl)
egen restrict_gather_Nov2020_ntnl = rowtotal(restrict_gather_01Nov2020_ntnl-restrict_gather_30Nov2020_ntnl)
egen restrict_gather_Dec2020_ntnl = rowtotal(restrict_gather_01Dec2020_ntnl-restrict_gather_31Dec2020_ntnl)

drop restrict_gather_01Apr2020-restrict_gather_13Jan2021_ntnl

foreach v of var restrict_gather_Apr2020-restrict_gather_Dec2020_ntnl {
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
*National 
egen restrict_gather_Apr2020_ntnl = rowtotal(restrict_gather_13Apr2020_ntnl-restrict_gather_13May2020_ntnl)
egen restrict_gather_May2020_ntnl = rowtotal(restrict_gather_14May2020_ntnl-restrict_gather_14Jun2020_ntnl)
egen restrict_gather_Jun2020_ntnl = rowtotal(restrict_gather_15Jun2020_ntnl-restrict_gather_15Jul2020_ntnl)
egen restrict_gather_Jul2020_ntnl = rowtotal(restrict_gather_16Jul2020_ntnl-restrict_gather_16Aug2020_ntnl)
egen restrict_gather_Aug2020_ntnl = rowtotal(restrict_gather_17Aug2020_ntnl-restrict_gather_16Sep2020_ntnl)
egen restrict_gather_Sep2020_ntnl = rowtotal(restrict_gather_17Sep2020_ntnl-restrict_gather_16Oct2020_ntnl)
egen restrict_gather_Oct2020_ntnl = rowtotal(restrict_gather_17Oct2020_ntnl-restrict_gather_15Nov2020_ntnl)
egen restrict_gather_Nov2020_ntnl = rowtotal(restrict_gather_16Nov2020_ntnl-restrict_gather_15Dec2020_ntnl)
egen restrict_gather_Dec2020_ntnl = rowtotal(restrict_gather_16Dec2020_ntnl-restrict_gather_13Jan2021_ntnl)

drop restrict_gather_01Apr2020-restrict_gather_13Jan2021_ntnl

foreach v of var restrict_gather_Apr2020-restrict_gather_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using restrict_gather_all

save "$user/$analysis/Data/restrict_gather_tmp.dta", replace

******** Public transport closures ********
clear all 

* Save flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c5_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_public_trnsprt`lbl'
}
save public_trnsprt_flag, replace

* Import Public transport data
clear 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c5_close_public_transport.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' public_trnsprt`lbl'
}


* Merge flag data 
merge 1:1 v1 country_code country_name using public_trnsprt_flag
keep country_code country_name public* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"


* Recoding values to a binary - "0" no measures and recommend reducing volume, "1" required closing public transport 
foreach v of var public_trnsprt_01Apr2020-public_trnsprt_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var public_trnsprt_01Apr2020-public_trnsprt_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop public_trnsprt_01Jan2020-public_trnsprt_31Mar2020 
drop flag*
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
*National
egen public_trnsprt_Apr2020_ntnl = rowtotal(public_trnsprt_01Apr2020_ntnl-public_trnsprt_30Apr2020_ntnl)
egen public_trnsprt_May2020_ntnl = rowtotal(public_trnsprt_01May2020_ntnl-public_trnsprt_31May2020_ntnl)
egen public_trnsprt_Jun2020_ntnl = rowtotal(public_trnsprt_01Jun2020_ntnl-public_trnsprt_30Jun2020_ntnl)
egen public_trnsprt_Jul2020_ntnl = rowtotal(public_trnsprt_01Jul2020_ntnl-public_trnsprt_31Jul2020_ntnl)
egen public_trnsprt_Aug2020_ntnl = rowtotal(public_trnsprt_01Aug2020_ntnl-public_trnsprt_31Aug2020_ntnl)
egen public_trnsprt_Sep2020_ntnl = rowtotal(public_trnsprt_01Sep2020_ntnl-public_trnsprt_30Sep2020_ntnl)
egen public_trnsprt_Oct2020_ntnl = rowtotal(public_trnsprt_01Oct2020_ntnl-public_trnsprt_31Oct2020_ntnl)
egen public_trnsprt_Nov2020_ntnl = rowtotal(public_trnsprt_01Nov2020_ntnl-public_trnsprt_30Nov2020_ntnl)
egen public_trnsprt_Dec2020_ntnl = rowtotal(public_trnsprt_01Dec2020_ntnl-public_trnsprt_31Dec2020_ntnl)

drop public_trnsprt_01Apr2020-public_trnsprt_13Jan2021_ntnl

foreach v of var public_trnsprt_Apr2020-public_trnsprt_Dec2020_ntnl {
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
*National 
egen public_trnsprt_Apr2020_ntnl = rowtotal(public_trnsprt_13Apr2020_ntnl-public_trnsprt_13May2020_ntnl)
egen public_trnsprt_May2020_ntnl = rowtotal(public_trnsprt_14May2020_ntnl-public_trnsprt_14Jun2020_ntnl)
egen public_trnsprt_Jun2020_ntnl = rowtotal(public_trnsprt_15Jun2020_ntnl-public_trnsprt_15Jul2020_ntnl)
egen public_trnsprt_Jul2020_ntnl = rowtotal(public_trnsprt_16Jul2020_ntnl-public_trnsprt_16Aug2020_ntnl)
egen public_trnsprt_Aug2020_ntnl = rowtotal(public_trnsprt_17Aug2020_ntnl-public_trnsprt_16Sep2020_ntnl)
egen public_trnsprt_Sep2020_ntnl = rowtotal(public_trnsprt_17Sep2020_ntnl-public_trnsprt_16Oct2020_ntnl)
egen public_trnsprt_Oct2020_ntnl = rowtotal(public_trnsprt_17Oct2020_ntnl-public_trnsprt_15Nov2020_ntnl)
egen public_trnsprt_Nov2020_ntnl = rowtotal(public_trnsprt_16Nov2020_ntnl-public_trnsprt_15Dec2020_ntnl)
egen public_trnsprt_Dec2020_ntnl = rowtotal(public_trnsprt_16Dec2020_ntnl-public_trnsprt_13Jan2021_ntnl)

drop public_trnsprt_01Apr2020-public_trnsprt_13Jan2021_ntnl

foreach v of var public_trnsprt_Apr2020-public_trnsprt_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using public_trnsprt_all

save "$user/$analysis/Data/public_trnsprt_tmp.dta", replace

******** Stay at home requirements ********
clear all 
* Save stay-home flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c6_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_stay_home`lbl'
}
save stay_home_flag, replace

* Import stay home data
clear
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c6_stay_at_home_requirements.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' stay_home`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using stay_home_flag
keep country_code country_name stay* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures and recommend staying home, "1" required with some or no exceptions 
foreach v of var stay_home_01Apr2020-stay_home_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var stay_home_01Apr2020-stay_home_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop stay_home_01Jan2020-stay_home_31Mar2020 
drop flag*
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
* National
egen stay_home_Apr2020_ntnl = rowtotal(stay_home_01Apr2020_ntnl-stay_home_30Apr2020_ntnl)
egen stay_home_May2020_ntnl = rowtotal(stay_home_01May2020_ntnl-stay_home_31May2020_ntnl)
egen stay_home_Jun2020_ntnl = rowtotal(stay_home_01Jun2020_ntnl-stay_home_30Jun2020_ntnl)
egen stay_home_Jul2020_ntnl = rowtotal(stay_home_01Jul2020_ntnl-stay_home_31Jul2020_ntnl)
egen stay_home_Aug2020_ntnl = rowtotal(stay_home_01Aug2020_ntnl-stay_home_31Aug2020_ntnl)
egen stay_home_Sep2020_ntnl = rowtotal(stay_home_01Sep2020_ntnl-stay_home_30Sep2020_ntnl)
egen stay_home_Oct2020_ntnl = rowtotal(stay_home_01Oct2020_ntnl-stay_home_31Oct2020_ntnl)
egen stay_home_Nov2020_ntnl = rowtotal(stay_home_01Nov2020_ntnl-stay_home_30Nov2020_ntnl)
egen stay_home_Dec2020_ntnl = rowtotal(stay_home_01Dec2020_ntnl-stay_home_31Dec2020_ntnl)

drop stay_home_01Apr2020-stay_home_13Jan2021_ntnl

foreach v of var stay_home_Apr2020-stay_home_Dec2020_ntnl {
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
* National
egen stay_home_Apr2020_ntnl = rowtotal(stay_home_13Apr2020_ntnl-stay_home_13May2020_ntnl)
egen stay_home_May2020_ntnl = rowtotal(stay_home_14May2020_ntnl-stay_home_14Jun2020_ntnl)
egen stay_home_Jun2020_ntnl = rowtotal(stay_home_15Jun2020_ntnl-stay_home_15Jul2020_ntnl)
egen stay_home_Jul2020_ntnl = rowtotal(stay_home_16Jul2020_ntnl-stay_home_16Aug2020_ntnl)
egen stay_home_Aug2020_ntnl = rowtotal(stay_home_17Aug2020_ntnl-stay_home_16Sep2020_ntnl)
egen stay_home_Sep2020_ntnl = rowtotal(stay_home_17Sep2020_ntnl-stay_home_16Oct2020_ntnl)
egen stay_home_Oct2020_ntnl = rowtotal(stay_home_17Oct2020_ntnl-stay_home_15Nov2020_ntnl)
egen stay_home_Nov2020_ntnl = rowtotal(stay_home_16Nov2020_ntnl-stay_home_15Dec2020_ntnl)
egen stay_home_Dec2020_ntnl = rowtotal(stay_home_16Dec2020_ntnl-stay_home_13Jan2021_ntnl)

drop stay_home_01Apr2020-stay_home_13Jan2021_ntnl

foreach v of var stay_home_Apr2020-stay_home_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using stay_home_all

save "$user/$analysis/Data/stay_home_tmp.dta", replace

******** Restrictions on internal movement ********
clear all

* Save internal movement flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c7_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_move_restr`lbl'
}
save move_restr_flag, replace

* Import internal movement restrictions data  data
clear
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c7_movementrestrictions.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' move_restr`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using move_restr_flag
keep country_code country_name move* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures and recommend not to travel between regions/cities, "1" internal movement restrictions in place
foreach v of var move_restr_01Apr2020-move_restr_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var move_restr_01Apr2020-move_restr_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop move_restr_01Jan2020-move_restr_31Mar2020 
drop flag*
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
* National
egen move_restr_Apr2020_ntnl = rowtotal(move_restr_01Apr2020_ntnl-move_restr_30Apr2020_ntnl)
egen move_restr_May2020_ntnl = rowtotal(move_restr_01May2020_ntnl-move_restr_31May2020_ntnl)
egen move_restr_Jun2020_ntnl = rowtotal(move_restr_01Jun2020_ntnl-move_restr_30Jun2020_ntnl)
egen move_restr_Jul2020_ntnl = rowtotal(move_restr_01Jul2020_ntnl-move_restr_31Jul2020_ntnl)
egen move_restr_Aug2020_ntnl = rowtotal(move_restr_01Aug2020_ntnl-move_restr_31Aug2020_ntnl)
egen move_restr_Sep2020_ntnl = rowtotal(move_restr_01Sep2020_ntnl-move_restr_30Sep2020_ntnl)
egen move_restr_Oct2020_ntnl = rowtotal(move_restr_01Oct2020_ntnl-move_restr_31Oct2020_ntnl)
egen move_restr_Nov2020_ntnl = rowtotal(move_restr_01Nov2020_ntnl-move_restr_30Nov2020_ntnl)
egen move_restr_Dec2020_ntnl = rowtotal(move_restr_01Dec2020_ntnl-move_restr_31Dec2020_ntnl)

drop move_restr_01Apr2020-move_restr_13Jan2021_ntnl

foreach v of var move_restr_Apr2020-move_restr_Dec2020_ntnl {
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
* National
egen move_restr_Apr2020_ntnl = rowtotal(move_restr_01Apr2020_ntnl-move_restr_30Apr2020_ntnl)
egen move_restr_May2020_ntnl = rowtotal(move_restr_01May2020_ntnl-move_restr_31May2020_ntnl)
egen move_restr_Jun2020_ntnl = rowtotal(move_restr_01Jun2020_ntnl-move_restr_30Jun2020_ntnl)
egen move_restr_Jul2020_ntnl = rowtotal(move_restr_01Jul2020_ntnl-move_restr_31Jul2020_ntnl)
egen move_restr_Aug2020_ntnl = rowtotal(move_restr_01Aug2020_ntnl-move_restr_31Aug2020_ntnl)
egen move_restr_Sep2020_ntnl = rowtotal(move_restr_01Sep2020_ntnl-move_restr_30Sep2020_ntnl)
egen move_restr_Oct2020_ntnl = rowtotal(move_restr_01Oct2020_ntnl-move_restr_31Oct2020_ntnl)
egen move_restr_Nov2020_ntnl = rowtotal(move_restr_01Nov2020_ntnl-move_restr_30Nov2020_ntnl)
egen move_restr_Dec2020_ntnl = rowtotal(move_restr_01Dec2020_ntnl-move_restr_31Dec2020_ntnl)

drop move_restr_01Apr2020-move_restr_13Jan2021_ntnl

foreach v of var move_restr_Apr2020-move_restr_Dec2020_ntnl {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

append using move_restr_all

save "$user/$analysis/Data/move_restr_tmp.dta", replace

******** Restrictions on international travel ********

** No flag data for international travel 

clear all 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c8_internationaltravel.csv"

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Renaming variables to label name 		

foreach v of var jan2020-v382 {
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
* Save public info flag data 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/h1_flag.csv"
* Renaming variables 
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' flag_info_camp`lbl'
}
save info_camp_flag, replace

*Import public info campaign data 
clear 
import delimited "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/h1_public_information_campaigns.csv"
* Renaming variables to label name 		
foreach v of var jan2020-v382 {
    local lbl : var label `v'
    local lbl = strtoname("`lbl'")
    rename `v' info_camp`lbl'
}

* Merge flag data 
merge 1:1 v1 country_code country_name using info_camp_flag
keep country_code country_name info* flag*

* Keep countries that are in our study 
keep if country_name == "Chile" | country_name == "Ethiopia" | country_name == "Ghana" | /// 
		country_name == "Haiti" | country_name == "Laos" | country_name == "Mexico" | /// 
		country_name == "Nepal" | country_name == "South Africa" | country_name == "South Korea" | ///
		country_name == "Thailand"

* Recoding values to a binary - "0" no measures or public officials urging caution, "1" coordinated campaign
foreach v of var info_camp_01Apr2020-info_camp_13Jan2021 {
	recode `v' (0/1 = 0) 
	recode `v' (2= 1)
}

* Create duplicate variables to incorporate flag data - national policy or not 
foreach v of var info_camp_01Apr2020-info_camp_13Jan2021 {
	gen `v'_ntnl = `v'
	recode `v'_ntnl (1 = 0) if flag_`v' == 0
}

* Only keep data from April - December 2020 
drop info_camp_01Jan2020-info_camp_31Mar2020 
drop flag*
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
* National
egen info_camp_Apr2020_ntnl = rowtotal(info_camp_01Apr2020_ntnl-info_camp_30Apr2020_ntnl)
egen info_camp_May2020_ntnl = rowtotal(info_camp_01May2020_ntnl-info_camp_31May2020_ntnl)
egen info_camp_Jun2020_ntnl = rowtotal(info_camp_01Jun2020_ntnl-info_camp_30Jun2020_ntnl)
egen info_camp_Jul2020_ntnl = rowtotal(info_camp_01Jul2020_ntnl-info_camp_31Jul2020_ntnl)
egen info_camp_Aug2020_ntnl = rowtotal(info_camp_01Aug2020_ntnl-info_camp_31Aug2020_ntnl)
egen info_camp_Sep2020_ntnl = rowtotal(info_camp_01Sep2020_ntnl-info_camp_30Sep2020_ntnl)
egen info_camp_Oct2020_ntnl = rowtotal(info_camp_01Oct2020_ntnl-info_camp_31Oct2020_ntnl)
egen info_camp_Nov2020_ntnl = rowtotal(info_camp_01Nov2020_ntnl-info_camp_30Nov2020_ntnl)
egen info_camp_Dec2020_ntnl = rowtotal(info_camp_01Dec2020_ntnl-info_camp_31Dec2020_ntnl)

drop info_camp_01Apr2020-info_camp_13Jan2021_ntnl

foreach v of var info_camp_Apr2020-info_camp_Dec2020_ntnl {
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
* National 
egen info_camp_Apr2020_ntnl = rowtotal(info_camp_13Apr2020_ntnl-info_camp_13May2020_ntnl)
egen info_camp_May2020_ntnl = rowtotal(info_camp_14May2020_ntnl-info_camp_14Jun2020_ntnl)
egen info_camp_Jun2020_ntnl = rowtotal(info_camp_15Jun2020_ntnl-info_camp_15Jul2020_ntnl)
egen info_camp_Jul2020_ntnl = rowtotal(info_camp_16Jul2020_ntnl-info_camp_16Aug2020_ntnl)
egen info_camp_Aug2020_ntnl = rowtotal(info_camp_17Aug2020_ntnl-info_camp_16Sep2020_ntnl)
egen info_camp_Sep2020_ntnl = rowtotal(info_camp_17Sep2020_ntnl-info_camp_16Oct2020_ntnl)
egen info_camp_Oct2020_ntnl = rowtotal(info_camp_17Oct2020_ntnl-info_camp_15Nov2020_ntnl)
egen info_camp_Nov2020_ntnl = rowtotal(info_camp_16Nov2020_ntnl-info_camp_15Dec2020_ntnl)
egen info_camp_Dec2020_ntnl = rowtotal(info_camp_16Dec2020_ntnl-info_camp_13Jan2021_ntnl)

drop info_camp_01Apr2020-info_camp_13Jan2021_ntnl

foreach v of var info_camp_Apr2020-info_camp_Dec2020_ntnl {
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

*Renaming for reshape 
rename *_ntnl ntnl_*

* Reshaping dataset to long 
reshape long curfew soe info_camp school_close work_close public_event ///
			 restrict_gather public_trnsprt stay_home move_restr int_trav /// 
			 ntnl_info_camp ntnl_school_close ntnl_work_close ntnl_public_event ///
			 ntnl_restrict_gather ntnl_public_trnsprt ntnl_stay_home ntnl_move_restr, ///
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

* No flag data for international travel 
rm "$user/$analysis/Data/school_close_flag.dta"
rm "$user/$analysis/Data/work_close_flag.dta"
rm "$user/$analysis/Data/public_event_flag.dta"
rm "$user/$analysis/Data/restrict_gather_flag.dta"
rm "$user/$analysis/Data/public_trnsprt_flag.dta"
rm "$user/$analysis/Data/stay_home_flag.dta"
rm "$user/$analysis/Data/move_restr_flag.dta"
rm "$user/$analysis/Data/info_camp_flag.dta"

************* Merge stringency, policy and relative volume data ****************
********************************************************************************
use "$user/$analysis/Data/Multip4.dta", clear
merge m:1 country month year using "$user/$analysis/Data/stringency_index.dta"
drop _merge
merge m:1 country month year using "$user/$analysis/Data/policy_data.dta"
drop if month == 3 // Nepal March data removed (due to different calendar month 3 was Mar 14-April 12)
drop _merge country_name
order country rmonth year month service relative_vol

lab var stringency_mean "Mean stringency index for the month"
lab var stringency_median "Median stringency index for the month"
lab var stringency_max "Max stringency index for the month"

lab var curfew "Curfew in place"
lab var soe "State of emergency in place"

lab var school_close "School closures in place (any level)"
lab var work_close "Workplace closures in place (any level)"
lab var public_event "Canceling of public events (any level)"
lab var restrict_gather "Restrictions on gathering size (any level)"
lab var public_trnsprt "Public transport closures (any level)"
lab var stay_home "Stay at home requirements (any level)"
lab var move_restr "Restrictions on internal movement (any level)"
lab var int_trav "Restrictions on international travel (any level)" 
lab var info_camp "Public information campaign (any level)"

lab var ntnl_school_close "School closures in place (national level)"
lab var ntnl_work_close "Workplace closures in place (national level)"
lab var ntnl_public_event "Canceling of public events(national level)"
lab var ntnl_restrict_gather "Restrictions on gathering size (national level)"
lab var ntnl_public_trnsprt "Public transport closures (national level)"
lab var ntnl_stay_home "Stay at home requirements (national level)"
lab var ntnl_move_restr "Restrictions on internal movement (national level)"
lab var ntnl_info_camp "Public information campaign (national level)"

encode country, gen(co)

save "$user/$analysis/Data/Multip4_combined_v2.dta", replace

