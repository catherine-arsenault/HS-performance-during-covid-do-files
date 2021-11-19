* Collapse each dataset at the national level
*1
use "$user/$CHLdata/Data for analysis/Chile_su_24months_for_analyses.dta",  clear
	collapse (sum) $CHLall, by (year month)
	gen country="CHL"
save "$user/$CHLdata/Data for analysis/CHLp4.dta", replace
*2
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
	collapse (sum) $ETHall, by (year month)
	gen country="ETH"
save "$user/$ETHdata/Data for analysis/ETHp4.dta", replace
* 3
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear
	collapse (sum) $GHAall, by (year month)	
	gen country="GHA"
save  "$user/$GHAdata/Data for analysis/GHAp4.dta", replace
* 4
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear
	collapse (sum) $HTIall, by (year month)
	gen country="HTI"
save "$user/$HTIdata/Data for analysis/HTIp4.dta", replace
* 5
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
	collapse (sum) $KZNall, by (year month rmonth)
	drop rmonth
	gen country="KZN"
save "$user/$KZNdata/Data for analysis/KZNp4.dta", replace
* 6
use "$user/$LAOdata/Data for analysis/LAO_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 Province
	collapse (sum) $LAOall, by (year month)
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOp4.dta", replace
* 7
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
	collapse (sum) $MEXall, by (year month)
	gen country="MEX"
save "$user/$MEXdata/Data for analysis/MEXp4.dta", replace
* 8
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (year month)
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPp4.dta", replace
* 9 
u "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", clear 
	collapse (sum) $KORall, by (year month)
	cap drop country
	gen country="KOR"
save "$user/$KORdata/Data for analysis/KORp4.dta", replace
* 10 
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear
	collapse (sum) $THAall, by (year month)
	gen country="THA"
save "$user/$THAdata/Data for analysis/THAp4.dta", replace

********************************************************************************
	* Calculate relative monthly volumes after April 2020
********************************************************************************
foreach c in CHL ETH GHA HTI KZN LAO MEX  KOR THA {
	
	u "$user/$`c'data/Data for analysis/`c'p4.dta", clear
		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		
	foreach x in $`c'all {
		egen preCOmean`x'= mean(`x') if rmonth<16 	
		carryforward preCOmean`x', replace
		gen rel_`x'= `x'/ preCOmean`x'
	}
	drop if rmonth <16
	keep country year month rmonth rel* 
	
	save "$user/$`c'data/Data for analysis/`c'p4.dta", replace
}
* Nepal separately, different calendar
	u "$user/$NEPdata/Data for analysis/NEPp4.dta", clear
		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		
	foreach x in $NEPall {
		egen preCOmean`x'= mean(`x') if rmonth<15	
		carryforward preCOmean`x', replace
		gen rel_`x'= `x'/ preCOmean`x'
	}
	drop if rmonth <15
	keep country year month rmonth rel_*
	save "$user/$NEPdata/Data for analysis/NEPp4.dta", replace
	
	save "$user/$analysis/Multip4.dta", replace

********************************************************************************
	* Append, combine indicators by type and reshape
********************************************************************************
* Append
foreach c in CHL ETH GHA HTI KZN LAO MEX  KOR THA {
	 u "$user/$`c'data/Data for analysis/`c'p4.dta", clear
	append using "$user/$analysis/Multip4.dta"
	save "$user/$analysis/Multip4.dta", replace
}
rename rel_del_util rmn1
rename rel_anc_util rmn2
rename rel_cs_util rmn3
rename rel_fp_util rmn4
rename rel_pnc_util rmn5

rename rel_opd_util summ1
rename rel_ipd_util summ2
rename rel_road_util summ3 
rename rel_er_util summ4
rename rel_trauma_util summ5
rename rel_surg_util summ6

rename rel_malaria_util child1
rename rel_diarr_util  child2
rename rel_pneum_util  child3
rename rel_malnu_util  child4
rename rel_bcg_qual child5
rename rel_pent_qual child6
rename rel_measles_qual child7
rename rel_opv3_qual  child8
rename rel_pneum_qual  child9
rename rel_rota_qual child10
rename rel_vacc_qual child11

rename rel_art_util art1

rename rel_hyper_util chronic1 
rename rel_diab_util chronic2
rename rel_mental_util chronic3
rename rel_cerv_qual chronic4
rename rel_breast_util chronic5
rename rel_tbscreen_qual chronic6 
rename rel_tbdetect_qual chronic7
rename rel_tbtreat_qual  chronic8
rename rel_hivtest_qual chronic9

sort country rmonth 

reshape long rmn summ child art chronic, i(rmonth country ) j( service_type )

rename (rmn summ child art chronic) (relative_vol1 relative_vol2 relative_vol3 relative_vol4 relative_vol5 )
reshape long relative_vol, i(country rmonth service_type) j( service )
drop service_type
drop if relative_vol ==.
lab def service 1"RMN" 2 "Summ" 3 "Child" 4 "ART" 5"Chronic"
lab val service service 

sort country rmonth service

save "$user/$analysis/Multip4.dta", replace
