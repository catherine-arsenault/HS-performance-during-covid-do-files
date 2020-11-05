* HS performance during Covid
* KZN, South Africa
* Analysis
clear all 
set more off	

global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
*global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"

global data "/HMIS Data for Health System Performance Covid (South Africa)"

********************************************************************************
* Preliminary analyses: comparing April-July 2020 to 2019
********************************************************************************
u "$user/$data/Data for analysis/KZN_Jan19-Jul20_clean2.dta", clear
*Compare April-July 2020 vs April-July 2019 
*1)RMNCH 
by year, sort: tabstat  anc1_util del_util cs_util pnc_util diarr_util ///
pneum_util sam_util if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)

*2) Vaccine 
by year, sort: tabstat  vacc_qual pent_qual bcg_qual measles_qual pneum_qual ///
rota_qual if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)


*3) Other volumes 
by year, sort: tabstat  art_util opd_util ipd_util road_util diab_util trauma_util ////
icu_util if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)


*4) Quality 
by year, sort: tabstat  kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual ///
 if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)



*5) Institutional Mortality 

by year, sort: tabstat  newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num ///
icu_mort_num trauma_mort_num if month>=4 & month<= 7, s(N sum) c(s) 

by year, sort: tabstat  totaldel  ipd_util icu_util trauma_util if month>=4 & ///
month<= 7, s(N sum) c(s) 

/********************************************************************************
tabstat cs_qual newborn_mort sb_mort mat_mort trauma_mort ipd_mort icu_mort, by(dist) c(s) s(mean)

collapse (sum) cs_util del_util newborn_mort_num sb_mort_num mat_mort_num trauma_mort_num ipd_mort_num icu_mort_num ///
	trauma_util ipd_util icu_util, by(dist)

	gen cs_qual = cs_util/del_util
	gen newborn_mort = newborn_mort_num/del_util
	gen sb_mort = sb_mort_num/del_util
	gen mat_mort = mat_mort_num/del_util
	gen trauma_mort = trauma_mort_num/trauma_util
	gen ipd_mort = ipd_mort_num/ipd_util
	gen icu_mort = icu_mort_num/icu_util
	
foreach v in newborn_mort sb_mort mat_mort trauma_mort ipd_mort icu_mort {
	replace `v' = `v' * 1000
}

tabstat cs_qual newborn_mort sb_mort mat_mort trauma_mort ipd_mort icu_mort, by(dist) c(s) s(mean)












