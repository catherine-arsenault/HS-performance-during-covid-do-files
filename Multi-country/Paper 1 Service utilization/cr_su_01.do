/* 
  Health system performance during Covid-19. Created by Catherine Arsenault
  Paper title: Effect of Covid-19 on health service utilization in 10 countries
  This do file creates final datasets for the service utilisation paper, standardizesand
  variable names and creates an  appendix to assess completeness 
  (in countries with facility-level data).
  */

* global droplist holds the list of variables that are not in the analysis
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
save "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", replace 

* Creates appendix to assess completeness
collapse (count) fp_util-tbdetect_qual , by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$analysis/Appendices/Data completeness.xlsx", sheet(Ethiopia) firstrow(variable) replace  

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
 drop surg_util malnu_util // too many outliers for surgeries, too few visits for malnutrition
save "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", replace 	 
	 
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

collapse (count) anc_util-rota_qual, by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$analysis/Appendices/Data completeness.xlsx", sheet(KZN) firstrow(variable)  

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

collapse (count) fp_util-road_util , by (year month)
			  
foreach x of global LAOall {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$analysis/Appendices/Data completeness.xlsx", sheet(Lao) firstrow(variable)  

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
save "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", replace
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

collapse (count) fp_util-pneum_qual , by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$analysis/Appendices/Data completeness.xlsx", sheet(Nepal) firstrow(variable)  

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

save "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", replace
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

save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", replace 

********************************************************************************
* Collapse facility level datasets & create country codes

*1
use "$user/$CHLdata/Data for analysis/Chile_su_24months_for_analyses.dta",  clear
	collapse (sum) $CHLall, by (region year month)
	encode region, gen(reg)
	gen country="CHL"
save "$user/$CHLdata/Data for analysis/CHLtmp.dta", replace
*2
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
	collapse (sum) $ETHall, by (region year month)
	encode region, gen(reg)
	gen country="ETH"
save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
* 3
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear
	encode region, gen(reg)	
	gen country="GHA"
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
* 4
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 departement
	collapse (sum) $HTIall, by (departement year month)
	encode departement, gen(reg)
	gen country="HTI"
save "$user/$HTIdata/Data for analysis/HTItmp.dta", replace
* 5
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
	collapse (sum) $KZNall, by (dist year month rmonth)
	drop rmonth
	rename dist reg
	gen country="KZN"
save "$user/$KZNdata/Data for analysis/KZNtmp.dta", replace
* 6
use "$user/$LAOdata/Data for analysis/LAO_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 Province
	collapse (sum) $LAOall, by (Province year month)
	encode Province, gen(reg)
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOtmp.dta", replace
* 7
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
	encode Deleg, gen(reg)	
	gen country="MEX"
save "$user/$MEXdata/Data for analysis/MEXtmp.dta", replace
* 8
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPtmp.dta", replace
* 9 
u "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", clear 
	encode region, gen(reg)
	cap drop country
	gen country="KOR"
save "$user/$KORdata/Data for analysis/KORtmp.dta", replace
* 10 
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear
	encode Province, gen(reg)	
	gen country="THA"
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
		replace postCovid = rmonth>=16 & rmonth<=21 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<=20 if inlist(country, "ETH", "NEP") 
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=24 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace resumption = rmonth>=21 & rmonth<=24 if inlist(country, "ETH", "NEP") 
		
		* Slope change excludes Dec 2020
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country, "ETH", "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1

	save "$user/$`c'data/Data for analysis/`c'tmp.dta", replace	

}


