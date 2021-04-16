* Health system performance during Covid-19 
* Created by Catherine Arsenault
* Effect of Covid-19 on health service utilization in 10 countries
* This do file creates final datasets for service utilisation paper and an 
* appendix to assess completeness

* global droplist holds the list of variables that are not in the analysis
global droplist sb_mort_num newborn_mort_num neo_mort_num mat_mort_num er_mort_num ///
				ipd_mort_num sb_mort_denom livebirths_denom ///
                totalipd_mort_num hivsupp_qual_num tbnum_qual tbdenom_qual surg_util ///
				tt_qual trauma_util tbtreat_qual icu_mort_num trauma_mort_num icu_util ///
				fp_perm_util fp_la_util breast_denom2020 breast_denom2019 hospit_covid ///
				hospit_pending hospit_negative death_covid death_negative ///
				death_pending breast_util mental_util diab_qual_num hyper_qual_num ///
				cerv_denom2020 cerv_denom2019 road_mort_num predel_util ///
				stroke_util heart_util dental_util dengue_util

********************************************************************************
* 1 CHILE (facility)

u "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear 

local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'
 
save "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", replace 
********************************************************************************
* 2 ETHIOPIA (facility/woreda)

u "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", replace 

local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'
* In Ethiopia, also drop hypertension, diabetes as they are incomplete
drop diab* hyper* 

save "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", replace 

* Creates appendix to assess completeness
collapse (count)fp_util-tbdetect_qual , by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Ethiopia) firstrow(variable) replace  

********************************************************************************
* 3 GHANA (region)
u  "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear 

local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'
 
save "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", replace 	 
	 
********************************************************************************
* 4 HAITI (facility)



********************************************************************************
* 5 KZN, SA (facility)
use "$user/$data/Data for analysis/KZN_su_24months_for_analyses.dta", clear 
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'

save "$user/$data/Data for analysis/KZN_su_24months_for_analyses.dta", replace 

collapse (count) anc1_util-rota_qual, by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(KZN) firstrow(variable)  

********************************************************************************
* 6 LAO (facility)
********************************************************************************
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", clear
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'
 
 
collapse (count) fp_sa_util-road_util , by (year month)
			  
foreach x of global LAOall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Lao) firstrow(variable)  

********************************************************************************
* 7 MEXICO (region)
********************************************************************************
use  "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear 
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
 capture drop `dl_modif'
save "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", replace
********************************************************************************
* 8 NEPAL (palika (municipality))

use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
capture drop `dl_modif'

save "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", replace

collapse (count) fp_sa_util-pneum_qual , by (year month)
			  
foreach x of global all {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Nepal) firstrow(variable)  


********************************************************************************
* 9 SOUTH KOREA (region)
u  "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", clear
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
capture drop `dl_modif'

save "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", replace
********************************************************************************
* 10 THAILAND (region)

u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear 
local dl_modif
    foreach x of global droplist {
       capture confirm variable `x'
	    if _rc==0 {
			local dl_modif `dl_modif' `x'
       }
 }
capture drop `dl_modif'

save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", replace 
