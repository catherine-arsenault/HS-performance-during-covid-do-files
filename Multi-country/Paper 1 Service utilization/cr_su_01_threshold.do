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
foreach m in 12 15 18 24 {
********************************************************************************
* 2 ETHIOPIA (facility/woreda)

u "$user/$ETHdata/Data for analysis/Ethiopia_su_24months`m'.dta", replace 

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
save "$user/$ETHdata/Data for analysis/Ethiopia_su_24months`m'_for_analyses.dta", replace 

preserve
	* Counts units per month
	collapse (count) fp_util-art_util , by (year month)
	export excel using "$analysis/Results/Tables/CountsDEC15.xlsx", sheet(ETH`m', replace) firstrow(variable)  
restore

	* Counts units ever reporting
	collapse (sum) fp_util-art_util, by(region regtype zone organisationunitname orgunitlevel4 unique_id )
	egen nb_reporting=rowtotal(fp_util-art_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 4 HAITI (facility)
use "$user/$HTIdata/Data for analysis/Haiti_su_24months`m'.dta", clear

local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
	drop cerv_qual // too few visits
save "$user/$HTIdata/Data for analysis/Haiti_su_24months`m'_for_analyses.dta", replace
preserve  
	* Count of observations
	collapse (count) fp_util-vacc_qual, by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC15.xlsx", sheet(HTI`m', replace) firstrow(variable)  
restore
egen unique_id=concat(orgunitlevel1 orgunitlevel2 orgunitlevel3 Number ID)

* Counts units ever reporting
	collapse (sum) fp_util-vacc_qual, by(orgunitlevel1 orgunitlevel2 orgunitlevel3 Number ID )
	egen nb_reporting=rowtotal(fp_util-vacc_qual), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 5 KZN, SA (facility)
use "$user/$KZNdata/Data for analysis/KZN_su_24months`m'.dta", clear 
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
save "$user/$KZNdata/Data for analysis/KZN_su_24months`m'_for_analyses.dta", replace 
preserve 
	* Count of observations
	collapse (count) anc_util-trauma_util, by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC15.xlsx", sheet(KZN`m', replace) firstrow(variable) 
restore
* Counts units ever reporting
	collapse (sum) anc_util-trauma_util, by(Province dist subdist Facility)
	egen nb_reporting=rowtotal(anc_util-trauma_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 6 LAO (facility)
use "$user/$LAOdata/Data for analysis/Lao_su_24months`m'.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 rename fp_sa_util fp_util 
save "$user/$LAOdata/Data for analysis/Lao_su_24months`m'_for_analyses.dta", replace
preserve
	* Count observations
	collapse (count) fp_util-road_util , by (year month)			  
	export excel using "$analysis/Results/Tables/CountsDEC15.xlsx", sheet(LAO`m', replace) firstrow(variable)  
restore
* Counts units ever reporting
	collapse (sum) fp_util-road_util, by(orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname)
	egen nb_reporting=rowtotal(fp_util-road_util), m
	drop if nb_reporting==.
	count 
********************************************************************************
* 8 NEPAL (palika (municipality))
use "$user/$NEPdata/Data for analysis/Nepal_su_24months`m'.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
cap drop `dl_modif'
rename fp_sa_util fp_util 
save "$user/$NEPdata/Data for analysis/Nepal_su_24months`m'_for_analyses.dta", replace
preserve 
	* Count of observations
	collapse (count) fp_util-pneum_qual , by (year month)		  
	export excel using "$analysis/Results/Tables/CountsDEC15.xlsx", sheet(NEP`m', replace) firstrow(variable)  
restore
* Counts units ever reporting
	collapse (sum) fp_util-pneum_qual, by(orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname)
	egen nb_reporting=rowtotal(fp_util-pneum_qual), m
	drop if nb_reporting==.
	count 
********************************************************************************
* Collapse facility level datasets & create country codes

*2
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months`m'_for_analyses.dta", clear
	collapse (sum) $ETHall, by (region year month)
	encode region, gen(reg)
	gen country="ETH"
	gen capital=1 if reg==1 // Addis Ababa
save "$user/$ETHdata/Data for analysis/ETHtmp_`m'.dta", replace
* 4
use "$user/$HTIdata/Data for analysis/Haiti_su_24months`m'_for_analyses.dta",  clear
	rename orgunitlevel2 departement
	collapse (sum) $HTIall, by (departement year month)
	encode departement, gen(reg)
	gen country="HTI"
	gen capital=1 if reg==8 // department Ouest Port Au Prince
save "$user/$HTIdata/Data for analysis/HTItmp_`m'.dta", replace
* 5
use "$user/$KZNdata/Data for analysis/KZN_su_24months`m'_for_analyses.dta",  clear
	collapse (sum) $KZNall, by (dist year month rmonth)
	drop rmonth
	rename dist reg
	gen country="KZN"
	gen capital=1 if reg==9 // eThekwini Metropolitan Municipality (contains Durban, largest city in KZN)
save "$user/$KZNdata/Data for analysis/KZNtmp_`m'.dta", replace
* 6
use "$user/$LAOdata/Data for analysis/LAO_su_24months`m'_for_analyses.dta",  clear
	rename orgunitlevel2 Province
	collapse (sum) $LAOall, by (Province year month)
	encode Province, gen(reg)
	gen country="LAO"
	gen capital=1 if reg==1
save "$user/$LAOdata/Data for analysis/LAOtmp_`m'.dta", replace
* 8
use "$user/$NEPdata/Data for analysis/Nepal_su_24months`m'_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
	gen capital=1 if reg==28 // Kathmandu
save "$user/$NEPdata/Data for analysis/NEPtmp_`m'.dta", replace

********************************************************************************
	* Creates variables for analyses
********************************************************************************
foreach c in ETH HTI KZN LAO NEP {

	u "$user/$`c'data/Data for analysis/`c'tmp_`m'.dta", clear

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

	save "$user/$`c'data/Data for analysis/`c'tmp_`m'.dta", replace	

}

}
