* HS performance during Covid
* Ethiopia 
* Analyses, measuring disruptions in real time
clear all
set more off

use "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_clean_AN.dta", clear

global rmnch fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util  sam_util  cerv_qual          
global other ipd_util er_util road_util opd_util art_util hivsupp_qual_num 
global vax vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual  
global mortality  sb_mort_num newborn_mort_num mat_mort_num totaldel er_mort_num er_util totalipd_mort ipd_util 

* diab_util hyper_util diab_qual_num hyper_qual_num Available October 2019-August 2020

* RMNCH 
by year, sort: tabstat $rmnch if month>=4 & month<= 8, s(N sum) c(s)  format(%20.10f)
* Other 
by year, sort: tabstat $other if month>=4 & month<= 8, s(N sum) c(s)  format(%20.10f)
* Vaccines
by year, sort: tabstat $vax if month>=4 & month<= 8, s(N sum) c(s)  format(%20.10f)
* Mortality 
by year, sort: tabstat $mortality if month>=4 & month<= 8, s(N sum) c(s)	  
	  
	  
* By region
* Create a total for each category
table region year if month>=4 & month<=8 , c(N opd_util)
table region year if month>=4 & month<=8 , c(sum opd_util) format(%20.10f)

table region year if month>=4 & month<=8 , c(N del_util)
table region year if month>=4 & month<=8 , c(sum del_util)

table region year if month>=4 & month<=8 , c(N diarr_util)
table region year if month>=4 & month<=8 , c(sum diarr_util)

table region year if month>=4 & month<=8 , c(N ipd_util)
table region year if month>=4 & month<=8 , c(sum ipd_util)

table region year if month>=4 & month<=8 , c(N er_util)
table region year if month>=4 & month<=8 , c(sum er_util)

********************************************************************************
* Comparing Q1 and Q2 2020
u  "$user/$data/Data for analysis/Ethiopia_Q1_Q2_2020_comparisons.dta", replace

*new Q1 variable 
gen Q1 = 1 if month>=1 & month<=3
replace Q1 = 0 if month>=4 & month <=6
order Q1 

*Calling globals 
global rmnch fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util

global other diab_util hyper_util diab_detec hyper_detec art_util opd_util er_util ///
			 ipd_util road_util cerv_qual 
global quality kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom ///
			   diab_qual_num hyper_qual_num hivsupp_qual_num  
global vax vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual  
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel ///
				 totalipd_mort 
global all $rmnch $other $quality $vax $mortality 

* Tables 
by region, sort: tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $rmnch if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $other if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $other if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $quality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $quality if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $vax if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $mortality if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)


*STATA calculation 
preserve
	keep if year==2020
	keep if month>=1 & month <=6 
	collapse (sum) $all, by(region Q1)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen diab_qual = diab_qual_num/diab_util
	gen hyper_qual = hyper_qual_num / hyper_util 
	gen cs_qual = cs_util/totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / er_util 
	gen ipd_mort = totalipd_mort / ipd_util 

	drop $quality $mortality 
	global reval $rmnch $other $vax kmc_qual resus_qual diab_qual hyper_qual cs_qual ///
				 hivsupp_qual newborn_mort sb_mort mat_mort er_mort ipd_mort 

	reshape wide $reval, i(region) j(Q1)

	foreach var in $reval {
		gen `var'cal = (`var'0-`var'1)/`var'1
		}
	keep region *cal 
	
	* Copy paste to excel
	bro region fp_utilcal-sam_utilcal 
	bro region diab_utilcal-cerv_qualcal
	bro region kmc_qualcal-hivsupp_qualcal
	bro region vacc_qualcal-rota_qualcal
	bro region newborn_mortcal-ipd_mortcal
	
restore 

********************************************************************************
*National total 
tabstat $all if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
tabstat $all if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  format(%20.10f)

*Stata calculation 
preserve
	gen country = "Ethiopia"
	order country 
	keep if year==2020
	keep if month>=1 & month <=6 
	collapse (sum) $all, by(country Q1)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen diab_qual = diab_qual_num/diab_util
	gen hyper_qual = hyper_qual_num / hyper_util 
	gen cs_qual = cs_util/totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / er_util 
	gen ipd_mort = totalipd_mort / ipd_util 

	drop $quality $mortality 
	global reval $rmnch $other $vax kmc_qual resus_qual diab_qual hyper_qual cs_qual ///
				 hivsupp_qual newborn_mort sb_mort mat_mort er_mort ipd_mort 

	reshape wide $reval, i(country) j(Q1)

	foreach var in $reval {
		gen `var'cal = (`var'0-`var'1)/`var'1
		}
	keep country *cal 
	bro country *cal 
restore 
drop Q1 


global all $rmnch $other $vax $mortality 


by region, sort:  tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $rmnch if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  


by region, sort:  tabstat $other if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $other if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $vax if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $mortality if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

********************************************************************************
* Comparing Q1 and Q3 2020
u  "$user/$data/Data for analysis/Ethiopia_Q1_Q3_2020_comparisons.dta", replace

*new Q1 variable 
gen Q1 = 1 if month>=1 & month<=3
replace Q1 = 0 if month>=7 & month <=9
order Q1 

*Calling globals 
global rmnch fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util

global other diab_util hyper_util diab_detec hyper_detec art_util opd_util er_util ///
			 ipd_util road_util cerv_qual 
global quality kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom ///
			   diab_qual_num hyper_qual_num hivsupp_qual_num  
global vax vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual  
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel ///
				 totalipd_mort 
global all $rmnch $other $quality $vax $mortality 

* Tables 
by region, sort: tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $rmnch if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $other if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $other if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $quality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $quality if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $vax if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
by region, sort: tabstat $mortality if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)


*STATA calculation 
preserve
	keep if year==2020
	keep if month>=1 & month <=9
	collapse (sum) $all, by(region Q1)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen diab_qual = diab_qual_num/diab_util
	gen hyper_qual = hyper_qual_num / hyper_util 
	gen cs_qual = cs_util/totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / er_util 
	gen ipd_mort = totalipd_mort / ipd_util 

	drop $quality $mortality 
	global reval $rmnch $other $vax kmc_qual resus_qual diab_qual hyper_qual cs_qual ///
				 hivsupp_qual newborn_mort sb_mort mat_mort er_mort ipd_mort 

	reshape wide $reval, i(region) j(Q1)

	foreach var in $reval {
		gen `var'cal = (`var'0-`var'1)/`var'1
		}
	keep region *cal 
	
	* Copy paste to excel
	bro region fp_utilcal-sam_utilcal 
	bro region diab_utilcal-cerv_qualcal
	bro region kmc_qualcal-hivsupp_qualcal
	bro region vacc_qualcal-rota_qualcal
	bro region newborn_mortcal-ipd_mortcal
	
restore 

********************************************************************************
*National total 
tabstat $all if month>=1 & month<= 3 & year==2020, s(N sum) c(s)  format(%20.10f)
tabstat $all if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  format(%20.10f)

*Stata calculation 
preserve
	gen country = "Ethiopia"
	order country 
	keep if year==2020
	keep if month>=1 & month <=9 
	collapse (sum) $all, by(country Q1)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen diab_qual = diab_qual_num/diab_util
	gen hyper_qual = hyper_qual_num / hyper_util 
	gen cs_qual = cs_util/totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / er_util 
	gen ipd_mort = totalipd_mort / ipd_util 

	drop $quality $mortality 
	global reval $rmnch $other $vax kmc_qual resus_qual diab_qual hyper_qual cs_qual ///
				 hivsupp_qual newborn_mort sb_mort mat_mort er_mort ipd_mort 

	reshape wide $reval, i(country) j(Q1)

	foreach var in $reval {
		gen `var'cal = (`var'0-`var'1)/`var'1
		}
	keep country *cal 
	bro country *cal 
restore 
drop Q1 


global all $rmnch $other $vax $mortality 


by region, sort:  tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $rmnch if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  


by region, sort:  tabstat $other if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $other if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $vax if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $mortality if month>=7 & month<= 9 & year==2020, s(N sum) c(s)  
