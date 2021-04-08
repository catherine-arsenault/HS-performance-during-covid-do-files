* HS performance during Covid
* April 8, 2021
* Mexico - IMSS, update Jan20-Dec20 ART data 
* MK Kim 

clear all
set more off	

// Received by Svetlana April 8, 2021
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
save "$user/$data/Data for analysis/IMSS_Jan19-Dec20complete_WIDE.dta", replace
