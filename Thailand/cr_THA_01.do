* HS performance during Covid
* Created Dec 7, 2020 
* Thailand, January 2019 -   data at Province level 


import excel using "$user/$data/Raw data/Provincial - OPD Visit 2018 to 2020.xlsx", firstrow clear

drop  AA // drop November 2020, most likely not complete yet

rename (B-Z) ///
(opd_util10_18 opd_util11_18 opd_util12_18 opd_util1_19 opd_util2_19 opd_util3_19 ///
opd_util4_19 opd_util5_19 opd_util6_19 opd_util7_19 opd_util8_19 opd_util9_19 ///
opd_util10_19 opd_util11_19 opd_util12_19 opd_util1_20 opd_util2_20 opd_util3_20 ///
opd_util4_20  opd_util5_20  opd_util6_20  opd_util7_20  opd_util8_20 opd_util9_20 ///
opd_util10_20)

save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace
   



