* Health system resilience during Covid-19 
* Effect of Covid on health service utilization in 10 countries

* global droplist holds the list of variables not included in the analysis
global droplist sb_mort_num newborn_mort_num neo_mort_num mat_mort_num er_mort_num ///
				ipd_mort_num sb_mort_denom livebirths_denom sti_util kmc_qual ///
                totalipd_mort_num  tbnum_qual tbdenom_qual ///
				tt_qual  icu_mort_num trauma_mort_num icu_util ///
				fp_perm_util fp_la_util breast_denom2020 breast_denom2019 hospit_covid ///
				hospit_pending hospit_negative death_covid death_negative ///
				death_pending  diab_qual_num hyper_qual_num ///
				cerv_denom2020 cerv_denom2019 road_mort_num predel_util ///
				stroke_util heart_util dental_util dengue_util peri_mort_num hivsupp_qual_num

********************************************************************************
* 1 CHILE (facility)
u "$user/$CHLdata/Data for analysis/Chile_su_24months.dta", clear 
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
save "$user/$CHLdata/Data for analysis/Chile_su_24months_for_analyses.dta", replace 
preserve
	* Count of observations per month
	collapse (count) pneum_util-er_util, by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(CHL, replace) firstrow(variable)  
restore
		* Counts units ever reporting
	drop if facilityname=="" // drops region and community data
	collapse (sum) ipd_util-er_util, by(region facilityname )
	egen nb_reporting=rowtotal(ipd_util-er_util), m
	drop if nb_reporting==. 
	count 
********************************************************************************
* 2 ETHIOPIA (facility/woreda)

u "$user/$ETHdata/Data for analysis/Ethiopia_su_24months.dta", replace 

local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 drop if region=="Tigray" // Tigray stopped reporting in October 2020 due to violence	
 rename sam_util malnu_util
 drop orgunitlevel1 tbdetect_qual // only available quarterly
save "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", replace 

preserve
	* Counts units per month
	collapse (count) fp_util-art_util , by (year month)
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(ETH, replace) firstrow(variable)  
restore

	* Counts units ever reporting
	collapse (sum) fp_util-art_util, by(region regtype zone organisationunitname orgunitlevel4 unique_id )
	egen nb_reporting=rowtotal(fp_util-art_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 3 GHANA (region)
u  "$user/$GHAdata/Data for analysis/Ghana_su_24months.dta", clear 

local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 drop  malnu_util //  too few visits for malnutrition
save "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", replace 	 
* Count of observations
collapse (count) fp_util-totaldel, by (year month)
export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(GHA, replace) firstrow(variable) 
********************************************************************************
* 4 HAITI (facility)
use "$user/$HTIdata/Data for analysis/Haiti_su_24months.dta", clear

local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
	drop cerv_qual // too few visits
save "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta", replace
preserve  
	* Count of observations
	collapse (count) fp_util-vacc_qual, by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(HTI, replace) firstrow(variable)  
restore
egen unique_id=concat(orgunitlevel1 orgunitlevel2 orgunitlevel3 Number ID)

* Counts units ever reporting
	collapse (sum) fp_util-vacc_qual, by(orgunitlevel1 orgunitlevel2 orgunitlevel3 Number ID )
	egen nb_reporting=rowtotal(fp_util-vacc_qual), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 5 KZN, SA (facility)
use "$user/$KZNdata/Data for analysis/KZN_su_24months.dta", clear 
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'

 rename (kmcn_qual sam_util anc1_util)  (kmc_qual malnu_util anc_util)
 drop malnu_util // too few visits
save "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta", replace 
preserve 
	* Count of observations
	collapse (count) anc_util-trauma_util, by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(KZN, replace) firstrow(variable) 
restore
* Counts units ever reporting
	collapse (sum) anc_util-trauma_util, by(Province dist subdist Facility)
	egen nb_reporting=rowtotal(anc_util-trauma_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 6 LAO (facility)
use "$user/$LAOdata/Data for analysis/Lao_su_24months.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 rename fp_sa_util fp_util 
save "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", replace
preserve
	* Count observations
	collapse (count) fp_util-road_util , by (year month)			  
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(LAO, replace) firstrow(variable)  
restore
* Counts units ever reporting
	collapse (sum) fp_util-road_util, by(orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname)
	egen nb_reporting=rowtotal(fp_util-road_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 7 MEXICO (region)
use  "$user/$MEXdata/Data for analysis/Mexico_su_24months.dta", clear 
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 rename cerv_util cerv_qual
 order  Delegation year month population2019 population2020
save "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", replace
* Count observations
collapse (count) measles_qual-bcg_qual , by (year month)			  
export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(MEX, replace) firstrow(variable)  
********************************************************************************
* 8 NEPAL (palika (municipality))
use "$user/$NEPdata/Data for analysis/Nepal_su_24months.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
cap drop `dl_modif'
rename fp_sa_util fp_util 
save "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", replace
preserve 
	* Count of observations
	collapse (count) fp_util-pneum_qual , by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(NEP, replace) firstrow(variable)  
restore
* Counts units ever reporting
	collapse (sum) fp_util-pneum_qual, by(orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname)
	egen nb_reporting=rowtotal(fp_util-pneum_qual), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 9 SOUTH KOREA (region)
u  "$user/$KORdata/Data for analysis/Korea_su_24months.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
cap drop `dl_modif'
drop totaldel
save "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", replace
* Count of observations
collapse (count) anc_util-del_util, by (year month)		  
export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(KOR, replace) firstrow(variable)  
********************************************************************************
* 10 THAILAND (region)
u "$user/$THAdata/Data for analysis/Thailand_su_24months.dta", clear 
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
rename totaldel del_util
cap drop `dl_modif'
drop anc_util
save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", replace 
* Count of observations
collapse (count) road_util-diarr_util, by (year month)		  
export excel using "$analysis/Results/Tables/CountsDEC7.xlsx", sheet(THA, replace) firstrow(variable)  
********************************************************************************
* Collapse facility level datasets & create country codes

*1
use "$user/$CHLdata/Data for analysis/Chile_su_24months_for_analyses.dta",  clear
	collapse (sum) $CHLall, by (region year month)
	encode region, gen(reg)
	gen country="CHL"
	gen capital=1 if reg==13 // Santiago
save "$user/$CHLdata/Data for analysis/CHLtmp.dta", replace
*2
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
	collapse (sum) $ETHall, by (region year month)
	encode region, gen(reg)
	gen country="ETH"
	gen capital=1 if reg==1 // Addis Ababa
save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
* 3
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear
	encode region, gen(reg)	
	gen country="GHA"
	gen capital=1 if reg==7 // Greater Accra
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
* 4
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 departement
	collapse (sum) $HTIall, by (departement year month)
	encode departement, gen(reg)
	gen country="HTI"
	gen capital=1 if reg==8 // department Ouest Port Au Prince
save "$user/$HTIdata/Data for analysis/HTItmp.dta", replace
* 5
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
	collapse (sum) $KZNall, by (dist year month rmonth)
	drop rmonth
	rename dist reg
	gen country="KZN"
	gen capital=1 if reg==9 // eThekwini Metropolitan Municipality (contains Durban, largest city in KZN)
save "$user/$KZNdata/Data for analysis/KZNtmp.dta", replace
* 6
use "$user/$LAOdata/Data for analysis/LAO_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 Province
	collapse (sum) $LAOall, by (Province year month)
	encode Province, gen(reg)
	gen country="LAO"
	gen capital=1 if reg==1
save "$user/$LAOdata/Data for analysis/LAOtmp.dta", replace
* 7
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
	encode Deleg, gen(reg)	
	gen country="MEX"
	gen capital=1 if reg==9 | reg==10 // DF Norte + DF Sur
save "$user/$MEXdata/Data for analysis/MEXtmp.dta", replace
* 8
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
	gen capital=1 if reg==28 // Kathmandu
save "$user/$NEPdata/Data for analysis/NEPtmp.dta", replace
* 9 
u "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", clear 
	encode region, gen(reg)
	cap drop country
	gen country="KOR"
	gen capital=1 if reg==16 // Seoul
save "$user/$KORdata/Data for analysis/KORtmp.dta", replace
* 10 
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear
	encode Province, gen(reg)	
	gen country="THA"
	gen capital=1 if reg==4 // Bangkok
save "$user/$THAdata/Data for analysis/THAtmp.dta", replace

********************************************************************************
	* Creates variables for analyses
********************************************************************************
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {

	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear

		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		sort reg rmonth
		
		gen season = .
		recode season (.=1) if ( month>=3 & month<=5  )
		recode season (.=2) if ( month>=6 & month<=8  )
		recode season (.=3) if ( month>=9 & month<=11 )
		recode season (.=4) if inlist(month, 1, 2, 12)             
		la var season "Season"
		la def season 1 "Spring" 2 "Summer" 3 "Fall" 4 "Winter"
		la val season season

		* "Temporary" Covid period 
		gen postCovid=. 
		replace postCovid = rmonth>=16 & rmonth<=21 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<=20 if inlist(country,  "NEP") 
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=24 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace resumption = rmonth>=21 & rmonth<=24 if inlist(country,  "NEP") 
		
		* Slope change excludes "resumption period"
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country,  "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1

	save "$user/$`c'data/Data for analysis/`c'tmp.dta", replace	

}


