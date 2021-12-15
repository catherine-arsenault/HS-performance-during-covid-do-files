* HS performance during Covid
* Created Dec 8, 2020 
* Thailand, January 2019 -   data at Province level 

use  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", clear
*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
set obs 78
replace Province="National" if Province==""

reshape long opd_util ipd_util dental_util diab_util dengue_util diarr_util ///
             heart_util hyper_util stroke_util predel_util totaldel road_util ///
			 road_mort_num malaria_util pneum_util anc_util, i(Prov) j(month) string 

* Labels (And dashboard format) - monthly collected data 
lab var opd_util  "Number outpatient (family medicine clinic  & opd specialty) visits"
lab var ipd_util "Number of inpatient admissions total"
lab var dental_util "Number of dental visits"
lab var diab_util "Diabetes cases"
lab var dengue_util "Dengue cases"
lab var diarr_util "Diarrhea cases" 
lab var heart_util "Coronary heart disease cases"
lab var hyper_util "Hypertension cases "
lab var stroke_util "Stroke cases "
lab var predel_util "Preterm delivery cases"
lab var totaldel "Total delivery cases "
lab var road_util "Traffic accident cases "
lab var road_mort_num "Traffic deaths"
lab var malaria_util "Number malaria cases diagnosed"	
lab var pneum_util "Number of pneumonia cases"
lab var anc_util "Total number of antenatal care visits"	
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="11_20" | month=="12_20" 

				   
replace year = 2019 if month=="1_19" |	month=="2_19" |	month=="3_19" |	month=="4_19" | ///
					   month=="5_19" |	month=="6_19"  | month=="7_19" | month=="8_19" | ///
				       month=="9_19" |	month=="10_19" | month=="11_19" | month=="12_19" 
					   
replace year = 2018 if month=="10_18" | month=="11_18" | month=="12_18" | month=="Q4_18"					   
					   

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


********************************************************************************
* CREATE NATIONAL TOTALS FOR MONTHLY DATA
******************************************************************************** 
foreach v in opd_util ipd_util dental_util diab_util dengue_util diarr_util ///
              heart_util hyper_util stroke_util predel_util totaldel road_util ///
			  road_mort_num malaria_util pneum_util anc_util {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/Thailand_Oct18-Dec20_foranalysis.dta", replace

drop if Province=="National"
drop if year ==2018
save "$user/$data/Data for analysis/Thailand_su_24months.dta", replace
********************************************************************************
* RESHAPE FOR DASHBOARD FOR VARIABLES AVAILABLE MONTHLY
********************************************************************************
use "$user/$data/Data for analysis/Thailand_Oct18-Dec20_foranalysis.dta", clear
global varlist opd_util ipd_util dental_util diab_util dengue_util diarr_util ///
heart_util hyper_util stroke_util predel_util totaldel road_util road_mort_num ///
malaria_util pneum_util anc_util			   

preserve
	keep if year==2020
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year 
	save "$user/$data/Data for analysis/temp20.dta", replace
restore 

preserve
	keep if year==2019
	foreach v of global varlist {
	rename(`v')(`v'19)
	}
	drop year 
	save "$user/$data/Data for analysis/temp19.dta", replace
restore 

	keep if year==2018
	foreach v of global varlist {
	rename(`v')(`v'18)
	}
	drop year 
	
merge m:m Provinces month using "$user/$data/Data for analysis/temp19.dta"
drop  _merge

merge m:m Provinces month using"$user/$data/Data for analysis/temp20.dta"
drop  _merge

export delimited using "$user/$data/Thailand_Oct18-Dec20_monthly_dashboard.csv", replace

rm "$user/$data/Data for analysis/temp20.dta"
rm "$user/$data/Data for analysis/temp19.dta"



* Quarterly data are removed from the final analysis: 
/********************************************************************************
* CREATE SEPARATE DATA FOR MONTHLY DATA
********************************************************************************
* Monthly data 
keep Province year month opd_util dental_util ipd_util mal_qual pneum_qual
drop if month==. 


u  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_clean.dta", clear
********************************************************************************
* CREATE SEPARATE DATA FOR QUARTERLY DATA
********************************************************************************
keep Province year quarter anc_util bcg_qual tbdiag_qual 
drop if quarter==. 


********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************

foreach v in anc_util bcg_qual tbdiag_qual  {
	by year quarter, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Province=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/Thailand_Oct18-Oct20_quarter_clean.dta", replace

********************************************************************************
* RESHAPE FOR DASHBOARD FOR QUARTERLY DATA 
********************************************************************************
u "$user/$data/Data for analysis/Thailand_Oct18-Oct20_quarter_clean.dta", clear 

global varlist anc_util bcg_qual tbdiag_qual		   

preserve
	keep if year==2020
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	save "$user/$data/Data for analysis/temp20.dta", replace
restore 

preserve
	keep if year==2019
	foreach v of global varlist {
	rename(`v')(`v'19)
	}
	save "$user/$data/Data for analysis/temp19.dta", replace
restore 

preserve 
	keep if year==2018
	foreach v of global varlist {
	rename(`v')(`v'18)
	}
	save "$user/$data/Data for analysis/temp18.dta", replace
restore 


u "$user/$data/Data for analysis/temp20.dta", clear 
append using "$user/$data/Data for analysis/temp19.dta"
save "$user/$data/Data for analysis/temp19_20.dta", replace
append using "$user/$data/Data for analysis/temp18.dta"

export delimited using "$user/$data/Thailand_Oct18-Oct20_quarter_dashboard.csv", replace

rm "$user/$data/Data for analysis/temp20.dta"
rm "$user/$data/Data for analysis/temp19.dta"
rm "$user/$data/Data for analysis/temp18.dta"
rm "$user/$data/Data for analysis/temp19_20.dta"
*/















