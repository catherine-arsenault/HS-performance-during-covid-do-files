* HS performance during Covid
*Jan 8, 2021
* Mexico - IMSS, new cancer indicator

clear all
set more off	

import excel using "$user/$data/Raw/Cancer/CAmama_02_2019[1].xlsx", sheet(Sheet1) firstrow clear
* 2019
rename A Delegation 
replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
* The data is cumulative over the year, need to take the difference each month
replace breast_util12_19= breast_util12_19-breast_util11_19
replace breast_util11_19= breast_util11_19-breast_util10_19
replace breast_util10_19= breast_util10_19-breast_util9_19
replace breast_util9_19=  breast_util9_19- breast_util8_19
replace breast_util8_19=  breast_util8_19- breast_util7_19
replace breast_util7_19=  breast_util7_19- breast_util6_19
replace breast_util6_19=  breast_util6_19- breast_util5_19
replace breast_util5_19=  breast_util5_19- breast_util4_19
replace breast_util4_19=  breast_util4_19- breast_util3_19
replace breast_util3_19=  breast_util3_19- breast_util2_19
replace breast_util2_19=  breast_util2_19- breast_util1_19
drop in 36/65

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta", replace
*2020 (Jan - Oct)
import excel using "$user/$data/Raw/Cancer/CAmama_02_2020[1].xlsx", sheet(Sheet1) firstrow clear
replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
* The data is cumulative over the year, need to take the difference each month
replace breast_util10_20= breast_util10_20-breast_util9_20
replace breast_util9_20=  breast_util9_20- breast_util8_20
replace breast_util8_20=  breast_util8_20- breast_util7_20
replace breast_util7_20=  breast_util7_20- breast_util6_20
replace breast_util6_20=  breast_util6_20- breast_util5_20
replace breast_util5_20=  breast_util5_20- breast_util4_20
replace breast_util4_20=  breast_util4_20- breast_util3_20
replace breast_util3_20=  breast_util3_20- breast_util2_20
replace breast_util2_20=  breast_util2_20- breast_util1_20
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Oct20_WIDE.dta"
drop _merge 

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta", replace

