* HS performance during Covid
* July 16, 2021
* Mexico - IMSS, update Jan20-Dec20 ART data 
* MK Kim, C.Arsenault

clear all
set more off	

// Received April 8, 2021
import excel using "$user/$data/Raw/ART_2020_data_edit.xlsx", sheet(Data) firstrow clear

replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"

* Create a total number of adult and children on ART 
egen art_util1_20 = rowtotal(Enero_adult Enero_Children), m 
egen art_util2_20 = rowtotal(Febrero_Adults Febrero_Children), m 
egen art_util3_20 = rowtotal(Marzo_Adults Marzo_Children), m 
egen art_util4_20 = rowtotal(Abril_Adults Abril_Children), m 
egen art_util5_20 = rowtotal(Mayo_Adults Mayo_Children), m 
egen art_util6_20 = rowtotal(Junio_Adults Junio_Children), m 
egen art_util7_20 = rowtotal(Julio_Adults Julio_Children), m 
egen art_util8_20 = rowtotal(Agosto_Adults Agosto_Children), m 
egen art_util9_20 = rowtotal(Septiembre_Adults Septiembre_Children), m 
egen art_util10_20 = rowtotal(Octubre_Adults Octubre_Children), m 
egen art_util11_20 = rowtotal(Noviembre_Adults Noviembre_Children), m 
egen art_util12_20 = rowtotal(Diciembre_Adults Dicembre_Children), m 

keep Del art* 
rename Delegación Delegation

********************************************************************************
* MERGE WITH PRIOR DATA 
********************************************************************************
					 
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace

* Correcting measles vaccination data, Jul 16, 2021

drop measles_qual*
save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace

import excel using "$user/$data/Raw/26.Indic26_31_Vacunas2019.xlsx", sheet("SRP_formatted") firstrow clear
drop E
drop if year==.
egen yrmo= concat(year month)
drop year month
reshape wide srp, i(Deleg) j(yrmo) string

rename(srp20191 srp201910 srp201911 srp201912 srp20192 srp20193 srp20194 srp20195 ///
srp20196 srp20197 srp20198 srp20199 ) ///
(measles_qual1_19 measles_qual10_19 measles_qual11_19 measles_qual12_19 ///
measles_qual2_19 measles_qual3_19 measles_qual4_19 measles_qual5_19 ///
measles_qual6_19 measles_qual7_19 measles_qual8_19 measles_qual9_19 )

save "$user/$data/Data for analysis/tmp.dta", replace

import excel using "$user/$data/Raw/Vacunas_Aplicadas_Dosis_Deleg_Harvard_202001_202012.xlsx", sheet("SRP_formatted") firstrow clear
reshape wide srp , i(Deleg) j(date) string
rename (srp202001-srp202012) ///
(measles_qual1_20 measles_qual2_20 measles_qual3_20 measles_qual4_20 measles_qual5_20 ///
measles_qual6_20 measles_qual7_20 measles_qual8_20 measles_qual9_20 measles_qual10_20 ///
measles_qual11_20 measles_qual12_20)

merge 1:1 Delegation using "$user/$data/Data for analysis/tmp.dta"
drop _merge           
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta"
drop _merge

* Correction to cervical cancer screening in Sonora
* May and April were inverted
replace cerv_util4_20 = 1656 if Deleg=="Sonora"
replace cerv_util5_20 = 268 if Deleg=="Sonora"
replace cerv_util6_20 = 739 if Deleg=="Sonora"

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace

rm "$user/$data/Data for analysis/tmp.dta"
