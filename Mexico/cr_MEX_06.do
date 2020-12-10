* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update the mortality data 
* Recode COVID mortality data from June20 to Oct 20 and merge with pervious dataset 
* by MK Kim 

clear all
set more off	

import excel using "$user/$data/Raw/link.xlsx", firstrow clear
save "$user/$data/Raw/link.dta", replace
import spss using "$user/$data/Raw/4. Hospital_mortality_June_October2020.sav", clear
sort delegacion
merge 1:1 delegacion using "$user/$data/Raw/link.dta"
*3 delegacion is not found in the COVID mortality data 
drop if _merge==2 
drop _merge 

rename (hospit_covid_june hospit_covid_juliy hospit_covid_august hospit_covid_september hospit_covid_october) (hospit_covid6_20 hospit_covid7_20 hospit_covid8_20 hospit_covid9_20 hospit_covid10_20)

rename (hospit_pending_june hospit_pending_july hospit_pending_august hospit_pending_september hospit_pending_october ) (hospit_pending6_20 hospit_pending7_20 hospit_pending8_20 hospit_pending9_20 hospit_pending10_20)

rename (hospit_negative_june hospit_negative_july hospit_negative_august hospit_negative_september hospit_negative_october) (hospit_negative6_20 hospit_negative7_20 hospit_negative8_20 hospit_negative9_20 hospit_negative10_20 )	

rename (death_covid_june death_covid_july death_covid_august death_covid_september death_covid_october) (death_covid6_20 death_covid7_20 death_covid8_20 death_covid9_20 death_covid10_20)

rename (death_pending_june death_pending_july death_pending_august death_pending_september death_pending_october) (death_pending6_20 death_pending7_20 death_pending8_20 death_pending9_20 death_pending10_20)

rename (death_negative_june death_negative_july death_negative_august death_negative_september death_negative_october) (death_negative6_20 death_negative7_20 death_negative8_20 death_negative9_20 death_negative10_20)


keep Delegation hospit_covid6_20-death_negative10_20


********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Aug20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Sep20_WIDE.dta", replace





