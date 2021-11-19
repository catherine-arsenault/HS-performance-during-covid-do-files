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
	encode Province, gen(reg)
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOp4.dta", replace
* 7
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
	collapse (sum) $MEXall, by (year month)
	encode Deleg, gen(reg)	
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
