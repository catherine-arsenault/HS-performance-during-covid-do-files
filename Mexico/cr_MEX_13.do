* HS performance during Covid
* Mar 16, 2021
* Mexico - IMSS, breast cancer

clear all
set more off	
// Received March 3, 2021
import excel using "$user/$data/Raw/Cancer/rcvd Mar2021/CAmama_02_2020.xlsx", sheet(Sheet1) firstrow clear

replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
* The data is cumulative over the year, need to take the difference each month
replace breast_util12_20= breast_util12_20-breast_util11_20
replace breast_util11_20= breast_util11_20-breast_util10_20
replace breast_util10_20= breast_util10_20-breast_util9_20
replace breast_util9_20=  breast_util9_20- breast_util8_20
replace breast_util8_20=  breast_util8_20- breast_util7_20
replace breast_util7_20=  breast_util7_20- breast_util6_20
replace breast_util6_20=  breast_util6_20- breast_util5_20
replace breast_util5_20=  breast_util5_20- breast_util4_20
replace breast_util4_20=  breast_util4_20- breast_util3_20
replace breast_util3_20=  breast_util3_20- breast_util2_20
replace breast_util2_20=  breast_util2_20- breast_util1_20

merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20v1_WIDE.dta"
drop _merge

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20v2_WIDE.dta", replace
