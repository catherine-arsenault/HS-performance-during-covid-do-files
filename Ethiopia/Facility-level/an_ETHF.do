* HS performance during Covid
* Ethiopia 
* Analyses, measuring disruptions in real time
clear all
set more off

********************************************************************************
* Comparing Q1 and Q2 2020

u  "$user/$data/Data for analysis/Ethiopia_Facility_Q1_Q2_2020_comparisons.dta", replace

global rmnch fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util
global vax vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual
global volumes art_util opd_util er_util ipd_util  			
global mortality newborn_mort_num totaldel mat_mort_num totaldel er_mort_num totaldel totalipd_mort_num ipd_util

by region, sort:  tabstat $rmnch if month>=1 & month<= 3 & year==2020, s(N sum) c(s) format(%20.10f)
by region, sort:  tabstat $rmnch if month>=4 & month<= 6 & year==2020, s(N sum) c(s) format(%20.10f)

by region, sort:  tabstat $vax if month>=1 & month<= 3 & year==2020, s(N sum) c(s) format(%20.10f)
by region, sort:  tabstat $vax if month>=4 & month<= 6 & year==2020, s(N sum) c(s) format(%20.10f) 

by region, sort:  tabstat $volumes if month>=1 & month<= 3 & year==2020, s(N sum) c(s) format(%20.10f)
by region, sort:  tabstat $volumes if month>=4 & month<= 6 & year==2020, s(N sum) c(s) format(%20.10f) 

by region, sort:  tabstat $mortality if month>=1 & month<= 3 & year==2020, s(N sum) c(s) format(%20.10f)
by region, sort:  tabstat $mortality if month>=4 & month<= 6 & year==2020, s(N sum) c(s) format(%20.10f) 
