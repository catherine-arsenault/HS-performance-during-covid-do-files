/* 
  Health system performance during Covid-19. Created by Catherine Arsenault
  Paper title: Effect of Covid-19 on health service utilization in 10 countries
  This do file creates final datasets for the service utilisation paper, standardizesand
  variable names and creates an  appendix to assess completeness 
  (in countries with facility-level data).
  */

* global droplist holds the list of variables that are not in the analysis
global droplist sb_mort_num newborn_mort_num neo_mort_num mat_mort_num er_mort_num ///
				ipd_mort_num sb_mort_denom livebirths_denom ///
                totalipd_mort_num  tbnum_qual tbdenom_qual surg_util ///
				tt_qual trauma_util tbtreat_qual icu_mort_num trauma_mort_num icu_util ///
				fp_perm_util fp_la_util breast_denom2020 breast_denom2019 hospit_covid ///
				hospit_pending hospit_negative death_covid death_negative ///
				death_pending  mental_util diab_qual_num hyper_qual_num ///
				cerv_denom2020 cerv_denom2019 road_mort_num predel_util ///
				stroke_util heart_util dental_util dengue_util peri_mort_num 

********************************************************************************
* 1 CHILE (facility)

u "$user/$CHLdata/Data for analysis/Chile_su_22months.dta", clear 

local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 cap drop `dl_modif'
 
save "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", replace 
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
u  "$user/$KORdata/Data for analysis/Korea_su_21months.dta", clear
local dl_modif
    foreach x of global droplist {
       cap confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
cap drop `dl_modif'

save "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", replace
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
cap drop `dl_modif'

save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", replace 








