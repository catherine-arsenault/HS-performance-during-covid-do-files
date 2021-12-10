* HS performance during Covid
* April 5th, 2021
* Mexico - IMSS, update stillbirth and neonatal mortality data 
* MK Kim 

clear all
set more off	

* Sent by Svetlana March 22, 2021
* Stillbirth - overwrite previous data 
import excel "/$user/$data/Raw/Defunciones Neonalates_fetales 2020.xlsx", sheet("Stillbirth") firstrow clear

rename Delegación Delegation 
drop if Delegation == ""

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="Norte del D. F."
replace Deleg = "D.F. Sur" if Deleg=="Sur del D. F."
replace Deleg= "México Oriente" if Deleg=="México Ote"
replace Deleg= "México Poniente" if Deleg=="México Pte"
replace Deleg= "Veracruz Norte" if Deleg=="Veracruz Nte"


* Stillbirths - Jan 2020-Dec20 
rename (Enero - Diciembre) ///
	   (sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	///
	   sb_mort_num5_20	sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20	///
	   sb_mort_num9_20	sb_mort_num10_20 sb_mort_num11_20 sb_mort_num12_20)

merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta"
drop _merge

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace

*Neonatal mortality - only add Dec2020 data 
import excel "/$user/$data/Raw/Defunciones Neonalates_fetales 2020.xlsx", sheet("Neonatal death") firstrow clear

rename Delegación Delegation 
drop if Delegation == ""

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="Norte del D. F."
replace Deleg = "D.F. Sur" if Deleg=="Sur del D. F."
replace Deleg= "México Oriente" if Deleg=="México Ote"
replace Deleg= "México Poniente" if Deleg=="México Pte"
replace Deleg= "Veracruz Norte" if Deleg=="Veracruz Nte"

* Drop Jan20-Nov20 data
drop Enero - Noviembre

rename Diciembre newborn_mort_num12_20 
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta"
drop _merge 											 

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace
