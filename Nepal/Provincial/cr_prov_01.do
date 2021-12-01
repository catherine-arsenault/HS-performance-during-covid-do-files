* Nepal provincial analysis

global user "/Users/acatherine/Dropbox (Harvard University)"
global NEPdata "/HMIS Data for Health System Performance Covid (Nepal)"
global analysis "/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Country-specific papers/Service disruption/Results"

use "$user/$NEPdata/Data for analysis/Nepal_su_24months.dta", clear

keep orgunitlevel1-unique_id fp_perm_util fp_sa_util fp_la_util anc_util ///
del_util cs_util pnc_util diarr_util pneum_util  opd_util ipd_util er_util ///
tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual measles_qual ///
pneum_qual

* Number of palika per Province
egen Npalika= count(organisationunitname) if year==2019 & month==1, by(orgunitlevel2)
by orgunitlevel2, sort: carryforward Npalika, replace

* Collapse to Province level
collapse (first) Npalika (sum) fp_perm_util fp_sa_util fp_la_util anc_util ///
del_util cs_util pnc_util diarr_util pneum_util  opd_util ipd_util er_util ///
tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual measles_qual ///
pneum_qual, by(orgunitlevel2 year month)

* Running month from Jan 2019
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
rename orgunitlevel2 province
order province rmonth 
		
gen season = .
recode season (.=1) if ( month>=3 & month<=5  )
recode season (.=2) if ( month>=6 & month<=8  )
recode season (.=3) if ( month>=9 & month<=11 )
recode season (.=4) if inlist(month, 1, 2, 12)             
la var season "Season"
la def season 1 "Spring" 2 "Summer" 3 "Fall" 4 "Winter"
la val season season
		
* Slope change 
gen timeafter= . 
replace timeafter = rmonth-14 
replace timeafter=0 if timeafter<0
		
encode province, gen(prov)

********************************************************************************
* Create ecological divisions / regions by categorizing districts
********************************************************************************


save "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", replace

********************************************************************************
* Merge with monthly new COVID cases per Province and population size (fixed value)
********************************************************************************
* NEENA


