*Multiple country percent change for dashboard 
*Jan 25th, 2021
*MK Kim 

clear 
set more off 

*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global folder "/Quest Center/Active projects/HS performance Covid (internal)/Data/Data viz/Country Comparison/Stata output"

*******************************************************************************
*Nepal 
global data "/HMIS Data for Health System Performance Covid (Nepal)"
u "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_MULTI.dta", clear 

global rmnch fp_perm_util fp_la_util fp_sa_util anc_util del_util cs_util ///
			 pnc_util diarr_util pneum_util  sam_util 
global other opd_util ipd_util er_util tbdetect_qual hivdiag_qual 
global vax pent_qual bcg_qual measles_qual opv3_qual pneum_qual 
global mortality sb_mort_num mat_mort_num totaldel ipd_mort_num neo_mort_num
global all $rmnch $other $vax $mortality 
by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s)  format(%20.10f)


*April-June 
preserve 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(orgunitlevel1 year)

	gen sb_mort = sb_mort_num/totaldel
	gen mat_mort = mat_mort_num/totaldel
	gen ipd_mort = ipd_mort_num/ipd_util
	gen neo_mort = neo_mort_num/totaldel
	drop $mortality 

	global revall $rmnch $vax $other sb_mort mat_mort ipd_mort neo_mort

	reshape wide $revall, i(orgunitlevel1) j(year)


	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/Nepal.xlsx", sheet(Nepal, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "Nepal_change"
	local i= 1
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}	
restore


*******************************************************************************
*KZN 
global data "/HMIS Data for Health System Performance Covid (South Africa)"
u "$user/$data/Data for analysis/KZN_Jan19-Sep20_WIDE_CCA_AN_Q2.dta", clear

global rmnch anc1_util  del_util cs_util pnc_util diarr_util pneum_util sam_util  
global vax vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual 
global other art_util opd_util road_util diab_util  icu_util trauma_util ipd_util 
global quality kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num  icu_mort_num trauma_mort_num
global denominator totaldel sb_mort_denom livebirths_denom
global all $rmnch $vax $other $quality $mortality $denominator

by year, sort: tabstat  $all if month>=4 & month<= 6, s(N sum) c(s)  format(%20.10f)

preserve 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(Province year)

	gen newborn_mort = newborn_mort_num/livebirths_denom
	gen sb_mort = sb_mort_num/sb_mort_denom
	gen mat_mort = mat_mort_num/livebirths_denom
	gen ipd_mort = ipd_mort_num/ipd_util
	gen icu_mort= icu_mort_num/icu_util
	gen trauma_mort = trauma_mort_num/trauma_util
	drop $mortality $denominator

	global revall $rmnch $vax $other $quality newborn_mort sb_mort mat_mort ///
	              ipd_mort icu_mort trauma_mort

	reshape wide $revall, i(Province) j(year)

	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/KZN.xlsx", sheet(KZN, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "KZN_change"
	local i= 2
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}		
restore	

*******************************************************************************
*Haiti 
global data "/HMIS Data for Health System Performance Covid (Haiti)"
use "$user/$data/Data for analysis/Haiti_Jan19-Jun20_clean_AN.dta", clear

global rmnch fp_util anc_util del_util cs_util pncm_util pncc_util diarr_util cerv_qual 
global other dental_util opd_util diab_util hyper_util 	
global mort mat_mort_num peri_mort_num totaldel
global all $rmnch $other $mort 

by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s)  format(%20.10f)
			   
*April-June 
preserve 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(orgunitlevel1 year)

	gen mat_mort = mat_mort_num/totaldel
	gen peri_mort = peri_mort_num/totaldel
	drop $mort 

	global revall $rmnch $other mat_mort peri_mort

	reshape wide $revall, i(orgunitlevel1) j(year)


	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/Haiti.xlsx", sheet(Haiti, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "Haiti_change"
	local i= 1
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}	
restore


*******************************************************************************
*Mexico
global data "/HMIS Data for Health System Performance Covid (Mexico)"
u "$user/$data/Data for analysis/IMSS_Jan19-Oct20_foranalysis.dta", replace

*combine cerv_denom into 1 variable 
gen cerv_denom = cerv_denom2019 if year==2019
replace cerv_denom = cerv_denom2020 if year==2020
drop cerv_denom2019 cerv_denom2020 

*combine breast_denom into 1 variable 
gen breast_denom = breast_denom2019 if year==2019
replace breast_denom = breast_denom2020 if year==2020
drop breast_denom2019 breast_denom2020 

global rmnch  fp_util sti_util anc_util del_util cs_util diarr_util pneum_util malnu_util  
global vax bcg_qual  pent_qual measles_qual opv3_qual pneum_qual rota_qual
global other  dental_util diab_util hyper_util art_util mental_util opd_util ///
			  er_util ipd_util 
global quality cerv_util cerv_denom breast_util breast_denom diab_qual_num ///
		       hyper_qual_num totaldel 
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num 

global all $rmnch $vax $other $quality $mortality			 

by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s)  format(%20.10f)
			   
*April-June 
preserve 
	gen country = "Mexico"
	order country 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(country year)

	gen cerv_qual = cerv_util/cerv_denom
	gen breast_qual = breast_util/breast_denom
	gen diab_qual = diab_qual_num/diab_util
	gen hyper_qual = hyper_qual_num/hyper_util 
	gen cs_qual = cs_util/totaldel
	gen newborn_mort = newborn_mort_num/totaldel
	gen sb_mort = sb_mort_num/totaldel
	gen mat_mort = mat_mort_num/totaldel 
	gen er_mort = er_mort_num/ er_util 
	gen ipd_mort = ipd_mort_num/ipd_util 

	drop $quality $mortality  

	global revall $rmnch $vax $other cerv_qual breast_qual diab_qual hyper_qual ///
				  cs_qual newborn_mort sb_mort mat_mort er_mort ipd_mort

	reshape wide $revall, i(country) j(year)


	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/Mexico.xlsx", sheet(Mexico, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "Mexico_change"
	local i= 1
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}	
restore



*******************************************************************************
*Ethiopia
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"
u "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_clean_AN.dta", clear 

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
			   sam_util opd_util ipd_util er_util road_util  cerv_qual art_util ///
			   hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual ///
			   pneum_qual rota_qual diab_util hyper_util diab_qual_num ///
			   hyper_qual_num kmc_qual_num kmc_qual_denom resus_qual_num ///
			   resus_qual_denom diab_detec hyper_detec
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel totalipd_mort 
global all $volumes $mortality
by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)

*April-June 
preserve 
	gen country = "Ethiopia"
	order country 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(country year)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen hyper_qual = hyper_qual_num / hyper_util
	gen cs_qual =  cs_util / totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / totaldel 
	gen ipd_mort = totalipd_mort / ipd_util 
	
	drop $mortality  

	global revall $volumes kmc_qual resus_qual hyper_qual cs_qual hivsupp_qual ///
					newborn_mort sb_mort mat_mort er_mort ipd_mort	   
	reshape wide $revall, i(country) j(year)

	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/Ethiopia.xlsx", sheet(Ethiopia, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "Ethiopia_change"
	local i= 1
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}	
restore

*******************************************************************************
*END
*******************************************************************************


































