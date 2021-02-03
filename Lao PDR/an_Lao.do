* HS performance during Covid
* Lao PDR
* Analysis
clear all 
set more off	

********************************************************************************
* Policy brief: Q2 (April-June)
********************************************************************************
u "$user/$data/Data for analysis/Lao_Jan19-Oct20_clean_AN_Q2.dta", clear

global rmnch fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util pnc_util 
global vax bcg_qual pent_qual measles_qual opv3_qual pneum_qual
global other diab_util hyper_util opd_util ipd_util road_util 
global mortality neo_mort_num sb_mort_num mat_mort_num totaldel 
	   
by year, sort: tabstat  $rmnch if month>=4 & month<= 6, s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat $vax if month>=4 & month<=6 , s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat $other if month>=4 & month<=6 , s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat  $mortality if month>=4 & month<= 6, s(N sum) c(s)  format(%20.10f)


********************************************************************************
* Policy brief: Q3 (July-Sep)
********************************************************************************
u "$user/$data/Data for analysis/Lao_Jan19-Oct20_clean_AN_Q3.dta", clear

by year, sort: tabstat  $rmnch if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat $vax if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat $other if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)
by year, sort: tabstat  $mortality if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)








