* HS resilience during covid
* Thailand, 2021 data

* IPD Visit 
import excel using "$user/$data/Raw data/2021/Provincial - IPD Visit 2018 to SEP2021.xlsx", sheet("formatted") firstrow clear
drop AI
rename (B-AH) ( ipd_util10_18	ipd_util11_18	ipd_util12_18 ipd_util1_19 ///
	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	///
	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	///
	ipd_util10_19	ipd_util11_19	ipd_util12_19 ipd_util1_20	///
	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	///
	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	///
	ipd_util10_20	ipd_util11_20 ipd_util12_20  ipd_util1_21	///
	ipd_util2_21	ipd_util3_21	ipd_util4_21	ipd_util5_21	///
	ipd_util6_21)
save  "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta", replace

* New diabetes cases 
import excel using "$user/$data/Raw data/2021/Provincial - New diabetes cases 2018 to SEP2021.xlsx", sheet("formatted") firstrow clear 
rename (B-AH) (diab_util10_18 diab_util11_18 diab_util12_18 diab_util1_19 ///
diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	///
diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	///
diab_util10_19	diab_util11_19	diab_util12_19 diab_util1_20	///
diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	///
diab_util6_20	diab_util7_20	diab_util8_20	diab_util9_20	///
diab_util10_20	diab_util11_20	diab_util12_20 diab_util1_21	///
diab_util2_21	diab_util3_21	diab_util4_21	diab_util5_21	///
diab_util6_21)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta", replace

*Outpatient visits
import excel using "$user/$data/Raw data/2021/Provincial - OPD Visit 2018 to SEP2021.xlsx", sheet("formatted") firstrow clear
rename (B-AH) (opd_util10_18 opd_util11_18 opd_util12_18 opd_util1_19 opd_util2_19 opd_util3_19 ///
opd_util4_19 opd_util5_19 opd_util6_19 opd_util7_19 opd_util8_19 opd_util9_19 ///
opd_util10_19 opd_util11_19 opd_util12_19 opd_util1_20 opd_util2_20 opd_util3_20 ///
opd_util4_20  opd_util5_20  opd_util6_20  opd_util7_20  opd_util8_20 opd_util9_20 ///
opd_util10_20 opd_util11_20 opd_util12_20 opd_util1_21 opd_util2_21 opd_util3_21 ///
opd_util4_21  opd_util5_21  opd_util6_21 )
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta", replace

*Total delivery cases
import excel using "$user/$data/Raw data/2021/Provincial - Total delivery cases 2018 to SEP2021.xlsx", sheet("formatted") firstrow clear
rename (B-AH) (del_util10_18 del_util11_18 del_util12_18 del_util1_19 ///
	del_util2_19	del_util3_19	del_util4_19	del_util5_19	///
	del_util6_19	del_util7_19	del_util8_19	del_util9_19	///
	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20 ///
	del_util6_20	del_util7_20	del_util8_20	del_util9_20	del_util10_20 ///
	del_util11_20	del_util12_20 del_util1_21	del_util2_21	del_util3_21	del_util4_21		   del_util5_21 del_util6_21)
merge 1:1 Province using  "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Jun21_WIDE.dta", replace 

reshape long  del_util opd_util ipd_util  diab_util , ///
			  i(Province) j(month) string
drop if regexm(month, "_18")			
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year =2021 if month=="1_21" | month=="2_21" | month=="3_21" | month=="4_21" | month=="5_21" ///
				| month=="6_21" 
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20" | month =="1_21"
replace mo = 2 if month =="2_19" | month =="2_20" | month =="2_21"
replace mo = 3 if month =="3_19" | month =="3_20" | month =="3_21"
replace mo = 4 if month =="4_19" | month =="4_20" | month =="4_21"
replace mo = 5 if month =="5_19" | month =="5_20" | month =="5_21"
replace mo = 6 if month =="6_19" | month =="6_20" | month =="6_21"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort Prov year month
order Prov year month 

save "$user/$data/Data for analysis/Thailand_su_30months.dta", replace

