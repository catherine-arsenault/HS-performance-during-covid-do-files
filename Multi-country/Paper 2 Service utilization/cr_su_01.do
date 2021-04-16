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
				cerv_denom2020 cerv_denom2019

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
********************************************************************************
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
********************************************************************************


********************************************************************************
* 10 THAILAND (region)
********************************************************************************
use  "$user/$THAdata/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", clear
drop *18
reshape long opd_util ipd_util dental_util diab_util dengue_util diarr_util ///
             heart_util hyper_util stroke_util predel_util totaldel road_util ///
			 road_mort_num malaria_util pneum_util anc_util, i(Prov) j(month) string 

* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="11_20" | month=="12_20" 

				   
replace year = 2019 if month=="1_19" |	month=="2_19" |	month=="3_19" |	month=="4_19" | ///
					   month=="5_19" |	month=="6_19"  | month=="7_19" | month=="8_19" | ///
				       month=="9_19" |	month=="10_19" | month=="11_19" | month=="12_19" 					   
					   
gen mo = 1 if month =="1_19" | month =="1_20" 
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month=="10_18"| month =="10_19" | month =="10_20" 
replace mo = 11 if month=="11_18"| month =="11_19" | month =="11_20" 
replace mo = 12 if month=="12_18"| month =="12_19" | month =="12_20"
order Province year mo 
drop month 
rename mo month 
sort Province year month

* Save  dataset for analyses
save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta"
