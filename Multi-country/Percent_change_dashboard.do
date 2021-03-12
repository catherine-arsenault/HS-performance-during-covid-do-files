*Multiple country percent change for dashboard 
*Jan 25th, 2021
*MK Kim 

clear 
set more off 

*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global folder "/Quest Center/Active projects/HS performance Covid (internal)/Data/Data viz/Country Comparison/Stata output"

*******************************************************************************
*1) Nepal 
global data "/HMIS Data for Health System Performance Covid (Nepal)"
u "$user/$data/Data for analysis/Nepal_CCA_Q2.dta", clear 

*Create empty variables for dashboard to read the dataset easily 
gen diab_util = . 
gen hyper_util = . 
gen newborn_mort = . 
gen cerv_qual = . 
gen road_util = . 
gen rota_qual = . 
gen art_util = . 
gen sti_util = . 
gen er_mort = . 
gen hyper_qual = . 
gen dental_util = . 
gen peri_mort = . 


global rmnch fp_perm_util fp_la_util fp_sa_util anc_util del_util cs_util ///
			 pnc_util diarr_util pneum_util  sam_util 
global other opd_util ipd_util er_util tbdetect_qual hivdiag_qual 
global vax pent_qual bcg_qual measles_qual opv3_qual pneum_qual 
global mortality sb_mort_num mat_mort_num totaldel ipd_mort_num neo_mort_num
global none diab_util hyper_util newborn_mort cerv_qual road_util rota_qual art_util sti_util er_mort hyper_qual dental_util peri_mort
global all $rmnch $other $vax $mortality $none

by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s)  format(%20.10f)


*April-June 
preserve 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(orgunitlevel1 year)

	gen sb_mort = sb_mort_num/totaldel
	gen mat_mort = mat_mort_num/totaldel
	gen ipd_mort = ipd_mort_num/ipd_util
	gen neo_mort = neo_mort_num/totaldel
	gen cs_qual = cs_util/totaldel 
	drop $mortality 

	global revall $rmnch $vax $other sb_mort mat_mort ipd_mort neo_mort cs_qual $none

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
*2) KZN 
global data "/HMIS Data for Health System Performance Covid (South Africa)"
u "$user/$data/Data for analysis/KZN_CCA_Q2.dta", clear

gen anc_util = .
gen fp_util = . 
gen sti_util = . 
gen opv3_qual = . 
gen hyper_util = . 
gen er_util = . 
gen dental_util = . 
gen er_mort = . 
gen peri_mort = .

global rmnch anc1_util  del_util cs_util pnc_util diarr_util pneum_util sam_util  
global vax vacc_qual pent_qual bcg_qual measles_qual pneum_qual rota_qual 
global other art_util opd_util road_util diab_util  icu_util trauma_util ipd_util 
global quality kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual
global mortality newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num  icu_mort_num trauma_mort_num
global denominator totaldel sb_mort_denom livebirths_denom
global none anc_util fp_util sti_util opv3_qual hyper_util er_util dental_util er_mort peri_mort
global all $rmnch $vax $other $quality $mortality $denominator $none

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
	gen cs_qual = cs_util/totaldel 
	drop $mortality $denominator

	global revall $rmnch $vax $other $quality  newborn_mort sb_mort mat_mort ///
	              ipd_mort icu_mort trauma_mort cs_qual $none

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
*3) Haiti 
global data "/HMIS Data for Health System Performance Covid (Haiti)"
use "$user/$data/Data for analysis/Haiti_CCA_Q2.dta", clear

gen pnc_util = . 
gen pneum_util = .	
gen sam_util = .
gen sti_util = .
gen bcg_qual = .
gen measles_qual = .
gen pent_qual = .
gen pneum_qual = .
gen opv3_qual = .
gen rota_qual = .
gen vacc_qual = .
gen ipd_util = .
gen road_util = .
gen art_util = .
gen er_util = .
gen sb_mort	= .
gen ipd_mort = .
gen newborn_mort = .
gen er_mort = .
gen tb_detect_qual = .
gen diab_qual = .
gen hyper_qual = .
gen kmcn_qual = .

global rmnch fp_util anc_util del_util cs_util pncm_util pncc_util diarr_util cerv_qual 
global other dental_util opd_util diab_util hyper_util 	
global mort mat_mort_num peri_mort_num totaldel
global none pnc_util pneum_util	sam_util sti_util bcg_qual measles_qual pent_qual pneum_qual opv3_qual rota_qual vacc_qual	ipd_util road_util art_util	er_util	sb_mort	ipd_mort newborn_mort er_mort tb_detect_qual diab_qual hyper_qual kmcn_qual
global all $rmnch $other $mort $none

by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s)  format(%20.10f)
			   
*April-June 
preserve 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(orgunitlevel1 year)

	gen mat_mort = mat_mort_num/totaldel
	gen peri_mort = peri_mort_num/totaldel
	gen cs_qual = cs_util/totaldel 
	drop $mort 

	global revall $rmnch $other mat_mort peri_mort cs_qual $none

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
*4) Mexico
global data "/HMIS Data for Health System Performance Covid (Mexico)"
u "$user/$data/Data for analysis/IMSS_Jan19-Oct20_foranalysis.dta", replace

gen pnc_util = .
gen sam_util = .
gen vacc_qual = .
gen road_util = .
gen peri_mort = .
gen tb_detect_qual = .
gen kmcn_qual = .

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
global none pnc_util sam_util vacc_qual road_util peri_mort tb_detect_qual kmcn_qual
global all $rmnch $vax $other $quality $mortality $none		 

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
				  cs_qual newborn_mort sb_mort mat_mort er_mort ipd_mort $none

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
*5) Ethiopia
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"
u "$user/$data/Data for analysis/Ethiopia_CCA_Q2.dta", clear 

gen dental_util = .
gen tb_detec = . 
gen peri_mort = . 

global volumes fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
			   sam_util opd_util ipd_util er_util road_util  cerv_qual art_util ///
			   hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual ///
			   pneum_qual rota_qual kmc_qual_num kmc_qual_denom resus_qual_num ///
			   resus_qual_denom 
global mortality newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel ///
				 totalipd_mort 
global none dental_util tb_detec peri_mort
global all $volumes $mortality $none
by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)

*April-June 
preserve 
	gen country = "Ethiopia"
	order country 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(country year)

	gen kmc_qual = kmc_qual_num/kmc_qual_denom
	gen resus_qual = resus_qual_num/resus_qual_denom
	gen cs_qual =  cs_util / totaldel
	gen hivsupp_qual = hivsupp_qual_num / art_util
	gen newborn_mort = newborn_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 
	gen er_mort = er_mort_num / totaldel 
	gen ipd_mort = totalipd_mort / ipd_util 
	
	drop $mortality  

	global revall $volumes kmc_qual resus_qual cs_qual hivsupp_qual ///
					newborn_mort sb_mort mat_mort er_mort ipd_mort $none  
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
*6) Lao
global data "/HMIS Data for Health System Performance Covid (Lao PDR)"
u "$user/$data/Data for analysis/Lao_CCA_Q2.dta", clear

*Create empty variables for dashboard to read the dataset easily 
gen sti_util = . 
gen cerv_qual = . 
gen pneum_util = . 
gen malnu_util = . 
gen diarr_util = . 
gen vacc_qual = . 
gen rota_qual = . 
gen art_util = . 
gen er_util = . 
gen dental_util = . 
gen tb_detect_qual = . 
gen diab_qual = . 
gen hyper_qual = . 
gen kmc_qual = . 
gen newborn_mort = . 
gen er_mort = . 
gen ipd_mort = . 

global volumes fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util bcg_qual totaldel pent_qual measles_qual opv3_qual pneum_qual ///
			   diab_util hyper_util opd_util ipd_util road_util 
global mortality neo_mort_num sb_mort_num mat_mort_num 
global none sti_util cerv_qual pneum_util malnu_util diarr_util vacc_qual rota_qual art_util er_util dental_util tb_detect_qual diab_qual hyper_qual kmc_qual newborn_mort er_mort ipd_mort 
global all $volumes $mortality $none

by year, sort: tabstat $all  if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)


preserve 
	gen country = "Lao"
	order country 
	keep if month>=4 & month<= 6
	collapse (sum) $all, by(country year)
	
	gen cs_qual =  cs_util / totaldel
	gen neo_mort = neo_mort_num / totaldel 
	gen sb_mort = sb_mort_num / totaldel 
	gen mat_mort = mat_mort_num/ totaldel 

	drop $mortality  

	global revall $volumes cs_qual neo_mort sb_mort mat_mort $none
	
	reshape wide $revall, i(country) j(year)

	foreach var in $revall {
		gen `var'change = (`var'2020-`var'2019)/`var'2019
		}
		
	putexcel set "/$user/$folder/Lao.xlsx", sheet(Lao, replace) modify
	putexcel A1 ="Country"
	putexcel B1 = "Lao_change"
	local i= 1
	foreach var in $revall {
		local i = `i'+1
		putexcel A`i' = "`var'"
		putexcel B`i' = `var'change
		}	
restore


*******************************************************************************
*7) South Korea
global data "/HMIS Data for Health System Performance Covid (South Korea)"
import delimited "$user/$data/Kor_Jan19-Aug20_fordashboard.csv", clear

*only keep national totals 
drop if region !="National" 

forval i = 19/20 {
	gen cs_qual`i' = cs_util`i'/totaldel`i'
	gen newborn_mort`i' = newborn_mort_num`i'/totaldel`i'
	gen sb_mort`i' = sb_mort_num`i'/totaldel`i'
	gen mat_mort`i' = mat_mort_num`i'/totaldel`i'
	gen ipd_mort`i' = ipd_mort_num`i'/ipd_util`i'
}

drop newborn_mort_num19-ipd_mort_num19 newborn_mort_num20-ipd_mort_num20 ///

global all sti_util19-ipd_mort20
 
tabstat $all if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)

keep if month>=4 & month<= 6
collapse (sum) $all 

global volume sti_util anc_util totaldel cs_util diarr_util pneum_util
global other diab_util hyper_util art_util mental_util opd_util er_util ///
			 ipd_util kmc_qual cs_qual 
global mortality newborn_mort sb_mort mat_mort ipd_mort
global all $volume $other $mortality


	foreach var in $all {
		gen `var' = (`var'20-`var'19)/`var'19
		}

				
*drop original variables 
drop sti_util19 - ipd_mort20

*create empty variables 
gen cerv_qual = .
gen pnc_util = .
gen malnu_util = .
gen vacc_qual = .
gen bcg_qual = .
gen pent_qual = .
gen measles_qual = .
gen opv3_qual = .
gen pneum_qual = .
gen rota_qual = .
gen road_util = .
gen dental_util = .
gen tb_detect_qual = .
gen diab_qual = .
gen hyper_qual = .
gen er_mort = .

export excel using "/$user/$folder/South Korea.xlsx", firstrow(variables) ///
		sheet("Transpose") keepcellfmt replace 

*******************************************************************************
*8) Ghana 
global data "/HMIS Data for Health System Performance Covid (Ghana)"
import delimited "$user/$data/Ghana_Jan19-Aug20_fordashboard.csv", clear

*only keep national totals 
drop if region !="National" 

forval i = 19/20 {
	gen newborn_mort`i' = newborn_mort_num`i'/totaldel`i'
	gen sb_mort`i' = sb_mort_num`i'/totaldel`i'
	gen mat_mort`i' = mat_mort_num`i'/totaldel`i'
	gen ipd_mort`i' = ipd_mort_num`i'/ipd_util`i'
	gen cs_qual`i' = cs_util`i'/totaldel`i'
}

drop newborn_mort_num19-mat_mort_num19 ipd_mort_num19 ipd_mort_num20 ///
newborn_mort_num20-mat_mort_num20 totaldel19 totaldel20 

global all fp_util19-cs_qual20

tabstat $all if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)

keep if month>=4 & month<= 6
collapse (sum) $all 

global volume fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
			  malnu_util
global vaccine vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual 
global other opd_util ipd_util road_util diab_util hyper_util malaria_util ///
			 tbdetect_qual surg_util cs_qual 
global mortality newborn_mort sb_mort mat_mort ipd_mort 
global all $volume $vaccine $other $mortality 

	foreach var in $all {
	gen `var' = (`var'20-`var'19)/`var'19
	}

*drop original variables 
drop fp_util19-cs_qual20

*create empty variables 	
gen cerv_qual = .
gen art_util = . 
gen er_util = . 
gen dental_util = . 
gen tb_detct_qual = . 
gen diab_qual = . 
gen hyper_qual = . 
gen kmc_qual = . 
gen er_mort = . 
		
export excel using "/$user/$folder/Ghana.xlsx", firstrow(variables) ///
		sheet("Transpose") keepcellfmt replace 


*******************************************************************************
*9) Thailand 
global data "/HMIS Data for Health System Performance Covid (Thailand)"
import delimited "$user/$data/Thailand_Oct18-Dec20_monthly_dashboard.csv", clear

*only keep national totals 
drop if provinces !="National" 

*drop 2018 data since no other countries have 2018 data 
drop road_mort_num18 - dengue_util18
		
global all road_mort_num20-dengue_util19

tabstat $all if month>=4 & month<= 6, s(sum) c(s) format(%20.10f)

keep if month>=4 & month<= 6
collapse (sum) $all 

global rmnch predel_util anc_util totaldel
global volume hyper_util stroke_util diab_util heart_util 
global other dengue_util diarr_util opd_util ipd_util dental_util road_util ///
	   road_mort_num mal_qual pneum_qual 
global all $rmnch $volume $other 

	foreach var in $all {
	gen `var' = (`var'20-`var'19)/`var'19
	}

*drop original variables 
drop road_mort_num20 - dengue_util19

		
export excel using "/$user/$folder/Thailand.xlsx", firstrow(variables) ///
		sheet("Transpose") keepcellfmt replace 
		
		
*******************************************************************************
*END
*******************************************************************************


































