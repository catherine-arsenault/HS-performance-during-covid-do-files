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

global rmnch fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util
global other ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec cerv_qual ///
	   opd_util hivsupp_qual_num diab_qual_num hyper_qual_num art_util ///
	   kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom
global vax vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual  
global mortality newborn_mort_num sb_mort_num mat_mort_num totaldel er_mort_num ///
       er_util totalipd_mort ipd_util 

global all $rmnch $other $vax $mortality 

by region, sort:  tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $rmnch if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $other if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $other if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $vax if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  

by region, sort:  tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s)
by region, sort:  tabstat $mortality if month>=4 & month<= 6 & year==2020, s(N sum) c(s)  
