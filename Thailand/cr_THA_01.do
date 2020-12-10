* HS performance during Covid
* Created Dec 7, 2020 
* Thailand, January 2019 -   data at Province level 


*Outpatient 
import excel using "$user/$data/Raw data/Provincial - OPD Visit 2018 to 2020.xlsx", firstrow clear
drop  AA // drop November 2020, most likely not complete yet
rename (B-Z) ///
(opd_util10_18 opd_util11_18 opd_util12_18 opd_util1_19 opd_util2_19 opd_util3_19 ///
opd_util4_19 opd_util5_19 opd_util6_19 opd_util7_19 opd_util8_19 opd_util9_19 ///
opd_util10_19 opd_util11_19 opd_util12_19 opd_util1_20 opd_util2_20 opd_util3_20 ///
opd_util4_20  opd_util5_20  opd_util6_20  opd_util7_20  opd_util8_20 opd_util9_20 ///
opd_util10_20)
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace
   

*ANC visits 
import excel using "$user/$data/Raw data/Provincial - Complete 5 ANC Visits 2018 to 2020.xlsx", firstrow clear
rename (Q4_2018-Q3_2020) (anc_utilQ4_18 anc_utilQ1_19 anc_utilQ2_19 anc_utilQ3_19 ///
anc_utilQ4_19 anc_utilQ1_20 anc_utilQ2_20 anc_utilQ3_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*BCG vaccinations 
import excel using "$user/$data/Raw data/Provincial - BCG Vaccination in neonates 2018 to 2020.xlsx", firstrow clear
rename (Q4_2018-Q3_2020) (bcg_qualQ4_18 bcg_qualQ1_19 bcg_qualQ2_19 bcg_qualQ3_19 ///
bcg_qualQ4_19 bcg_qualQ1_20 bcg_qualQ2_20 bcg_qualQ3_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*IPD visits 
import excel using "$user/$data/Raw data/Provincial - IPD Visit 2018 to 2020.xlsx", firstrow clear
drop AA
rename (B-Z) (ipd_util10_18	ipd_util11_18	ipd_util12_18 ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	ipd_util10_20	)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*Malaria cases
import excel using "$user/$data/Raw data/Provincial - Malaria cases 2018 to 2020.xlsx", firstrow clear
drop AA
rename (B-Z) (mal_qual10_18	mal_qual11_18	mal_qual12_18 mal_qual1_19	mal_qual2_19	mal_qual3_19	mal_qual4_19	mal_qual5_19	mal_qual6_19	mal_qual7_19	mal_qual8_19	mal_qual9_19	mal_qual10_19	mal_qual11_19	mal_qual12_19 mal_qual1_20	mal_qual2_20	mal_qual3_20	mal_qual4_20	mal_qual5_20	mal_qual6_20	mal_qual7_20	mal_qual8_20	mal_qual9_20	mal_qual10_20	)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*TB diagnosis 
import excel using "$user/$data/Raw data/Provincial - Newly diagnosis of TB 2018 to 2020.xlsx", firstrow clear
rename (Q4_2018-Q3_2020) (tbdiag_qualQ4_18 tbdiag_qualQ1_19 tbdiag_qualQ2_19 tbdiag_qualQ3_19 ///
tbdiag_qualQ4_19 tbdiag_qualQ1_20 tbdiag_qualQ2_20 tbdiag_qualQ3_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*Pneumonia cases
import excel using "$user/$data/Raw data/Provincial - Pneumonia cases 2018 to 2020.xlsx", firstrow clear
drop AA
rename (B-Z) (pneum_qual10_18	pneum_qual11_18	pneum_qual12_18 pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


*Dental services 
import excel using "$user/$data/Raw data/Provincial - Dental services 2018 to 2020 (revised).xlsx", firstrow clear
drop AA
rename (B-Z) (dental_util10_18	dental_util11_18 dental_util12_18 dental_util1_19	///
dental_util2_19	dental_util3_19	dental_util4_19	dental_util5_19	dental_util6_19	///
dental_util7_19	dental_util8_19	dental_util9_19	dental_util10_19	dental_util11_19 ///
dental_util12_19 dental_util1_20	dental_util2_20	dental_util3_20	dental_util4_20	///
dental_util5_20	dental_util6_20	dental_util7_20	dental_util8_20	dental_util9_20	///
dental_util10_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace


order Province opd_util* dental_util* ipd_util* mal_qual* pneum_qual* anc_util* bcg_qual* tbdiag_qual* 
save  "$user/$data/Data for analysis/Thailand_Oct18-Oct20_WIDE.dta", replace

set obs 78
replace Province="National" if Province==""

*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
reshape long  opd_util dental_util ipd_util mal_qual pneum_qual anc_util bcg_qual tbdiag_qual, i(Prov) j(month) string
	
* Labels (And dashboard format)
lab var anc_util "Total number of antenatal care visits"	
lab var bcg_qual "Number children vaccinated with bcg vaccine"
lab var tbdiag_qual "Number TB new cases diagnosed"
lab var opd_util  "Number outpatient (family medicine clinic  & opd specialty) visits"
lab var dental_util "Number of dental visits"
lab var ipd_util "Number of inpatient admissions total"
lab var mal_qual "Number malaria cases diagnosed"	
lab var pneum_qual "Number of pneumonia cases"	
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="Q1_20" | month=="Q2_20" | ///
				   month=="Q3_20"
				   
replace year = 2019 if month=="1_19" |	month=="2_19" |	month=="3_19" |	month=="4_19" | ///
					   month=="5_19" |	month=="6_19"  | month=="7_19" | month=="8_19" | ///
				       month=="9_19" |	month=="10_19" | month=="11_19" | month=="12_19" | ///
					   month=="Q1_19" | month=="Q2_19" | month=="Q3_19" | month=="Q4_19" 
					   
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


gen qa = 1 if month=="Q1_19" | month=="Q1_20" 
replace qa = 2 if month=="Q2_19" | month=="Q2_20" 
replace qa = 3 if month=="Q3_19" | month=="Q3_20" 
replace qa = 4 if month=="Q4_18" | month=="Q4_19" 

order Province year mo qa 
drop month 
rename mo month 
rename qa quarter 


save "$user/$data/Data for analysis/Thailand_Oct18-Oct20_clean.dta", replace


***END***

	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
