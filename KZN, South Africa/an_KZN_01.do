* HS performance during Covid
* KZN, South Africa
* Analysis
clear all 
set more off	

********************************************************************************
* Preliminary analyses: comparing April-July 2020 to 2019
********************************************************************************
u "$user/$data/Data for analysis/KZN_Jan19-Sep20_WIDE_CCA_AN.dta", clear

global rmnch anc1_util  del_util cs_util pnc_util diarr_util pneum_util sam_util  
global vax vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual 
global other art_util opd_util ipd_util road_util diab_util   icu_util trauma_util
global quality kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual
global mortality newborn_mort_num sb_mort_num mat_mort_num totaldel ipd_mort_num ipd_util ///
	   icu_mort_num  icu_util trauma_mort_num trauma_util 

*Compare July-Sep 2020 vs July-Sep 2019 

by year, sort: tabstat  $rmnch if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)

by year, sort: tabstat $vax if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)

by year, sort: tabstat  $other if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)

by year, sort: tabstat  $quality if month>=7 & month<= 9, s(N sum) c(s)  format(%20.10f)

by year, sort: tabstat  $mortality if month>=7 & month<= 9, s(N sum) c(s) format(%20.10f)

 

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
*/

recode factype (1/7=1 "Hospital") (8/9 12 = 2 "CHC, clinc, post") (10 13 14 15 = 3 "Mobile and other"), gen(factype_rev)

by year factype_rev, sort: tabstat  anc1_util del_util cs_util pnc_util diarr_util pneum_util sam_util if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)
by year factype_rev, sort: tabstat  vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)
by year factype_rev, sort: tabstat  art_util opd_util ipd_util road_util diab_util trauma_util icu_util if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)
by year factype_rev, sort: tabstat  kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual  if month>=4 & month<= 7, s(N sum) c(s)  format(%20.10f)

*Mortality
by year factype_rev, sort: tabstat  newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num if month>=4 & month<= 7, s(N sum) c(s) 
by year factype_rev, sort: tabstat  totaldel  ipd_util icu_util trauma_util if month>=4 & month<= 7, s(N sum) c(s) 







