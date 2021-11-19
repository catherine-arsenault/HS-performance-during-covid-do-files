* HS Performance during COVID - Factors associated with health systems disruption 
* Created October 28th, 2021

clear all
set more off 

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
keep country_code-stringency_31Dec2020

save "$user/$analysis/Data/stringency_index_daily.dta", replace


******************** Policy Datasets ********************
*********************************************************

******** School closures ********
clear all 
import delimited  "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/timeseries/c1_flag.csv"

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
keep country_code-school_close_31Dec2020

* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var school_close_01Apr2020-school_close_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

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

drop school_close_01Apr2020-school_close_31Dec2020

foreach v of var school_close_Apr2020-school_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}


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
keep country_code-work_close_31Dec2020

* Recoding values to a binary - "0" no measures and recommended closing, "1" required only at some levels and requiring at all levels 
foreach v of var work_close_01Apr2020-work_close_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

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

drop work_close_01Apr2020-work_close_31Dec2020

foreach v of var work_close_Apr2020-work_close_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}


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
keep country_code-public_event_31Dec2020

* Recoding values to a binary - "0" no measures and recommended canceling, "1" required canceling public events 
foreach v of var public_event_01Apr2020-public_event_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

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

drop public_event_01Apr2020-public_event_31Dec2020

foreach v of var public_event_Apr2020-public_event_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-restrict_gather_31Dec2020

* Recoding values to a binary - "0" no measures, restricted to more than 1000 or restricted from 101-1000; "1" restricted 10-100 or <10
foreach v of var restrict_gather_01Apr2020-restrict_gather_31Dec2020 {
	recode `v' (0/2 = 0) 
	recode `v' (3/4 = 1)
}

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

drop restrict_gather_01Apr2020-restrict_gather_31Dec2020

foreach v of var restrict_gather_Apr2020-restrict_gather_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-public_trnsprt_31Dec2020

* Recoding values to a binary - "0" no measures and recommend reducing volume, "1" required closing public transport 
foreach v of var public_trnsprt_01Apr2020-public_trnsprt_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

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

drop public_trnsprt_01Apr2020-public_trnsprt_31Dec2020

foreach v of var public_trnsprt_Apr2020-public_trnsprt_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-stay_home_31Dec2020

* Recoding values to a binary - "0" no measures and recommend staying home, "1" required with some or no exceptions 
foreach v of var stay_home_01Apr2020-stay_home_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2/3 = 1)
}

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

drop stay_home_01Apr2020-stay_home_31Dec2020

foreach v of var stay_home_Apr2020-stay_home_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-move_restr_31Dec2020

* Recoding values to a binary - "0" no measures and recommend not to travel between regions/cities, "1" internal movement restrictions in place
foreach v of var move_restr_01Apr2020-move_restr_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2 = 1)
}

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

drop move_restr_01Apr2020-move_restr_31Dec2020

foreach v of var move_restr_Apr2020-move_restr_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-int_trav_31Dec2020

* Recoding values to a binary - "0" no measures, screening, or quarantine , "1" ban arrivals from some regions or total border closure 
foreach v of var int_trav_01Apr2020-int_trav_31Dec2020 {
	recode `v' (0/2 = 0) 
	recode `v' (3/4= 1)
}

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

drop int_trav_01Apr2020-int_trav_31Dec2020

foreach v of var int_trav_Apr2020-int_trav_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

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
keep country_code-info_camp_31Dec2020

* Recoding values to a binary - "0" no measures or public officials urging caution, "1" coordinated campaign
foreach v of var info_camp_01Apr2020-info_camp_31Dec2020 {
	recode `v' (0/1 = 0) 
	recode `v' (2= 1)
}

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

drop info_camp_01Apr2020-info_camp_31Dec2020

foreach v of var info_camp_Apr2020-info_camp_Dec2020 {
	replace `v' = 0 if `v' < 10
	replace `v' = 1 if `v' >= 10
}

save "$user/$analysis/Data/info_camp_tmp.dta", replace

*** Merging all datasets to one *** 

merge using "$user/$analysis/Data/school_close_tmp.dta" "$user/$analysis/Data/work_close_tmp.dta" "$user/$analysis/Data/public_event_tmp.dta" "$user/$analysis/Data/restrict_gather_tmp.dta" "$user/$analysis/Data/public_trnsprt_tmp.dta" "$user/$analysis/Data/stay_home_tmp.dta" "$user/$analysis/Data/move_restr_tmp.dta" "$user/$analysis/Data/int_trav_tmp.dta" "$user/$analysis/Data/info_camp_tmp.dta"

* It says I'm using the old version of merge - is there a better way to do this? 
drop _merge*

save "$user/$analysis/Data/policy_data.dta", replace

* Remove temp files 
global policy school_close work_close public_event restrict_gather public_trnsprt ///
			  stay_home move_restr int_trav info_camp
foreach x of global policy {
		rm "$user/$analysis/Data/`x'_tmp.dta"
	}