* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update the mortality data 
* by MK Kim 

clear all
set more off	
*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import excel using "$user/$data/Raw/link.xlsx", firstrow clear
save "$user/$data/Raw/link.dta", replace
import spss using "$user/$data/Raw/4. Hospital_mortality_June_October2020.sav", clear
drop if delegacion==""
sort delegacion
merge 1:1 delegacion using "$user/$data/Raw/link.dta"
drop if _merge==2 //not found in the mortality data 
drop _merge 

rename (hospit_covid_june hospit_covid_juliy hospit_covid_august hospit_covid_september hospit_covid_october) (hospit_covid6_20 hospit_covid7_20 hospit_covid8_20 hospit_covid9_20 hospit_covid10_20)

rename (hospit_pending_june hospit_pending_july hospit_pending_august hospit_pending_september hospit_pending_october ) (hospit_pending6_20 hospit_pending7_20 hospit_pending8_20 hospit_pending9_20 hospit_pending10_20)

rename (hospit_negative_june hospit_negative_july hospit_negative_august hospit_negative_september hospit_negative_october) (hospit_negative6_20 hospit_negative7_20 hospit_negative8_20 hospit_negative9_20 hospit_negative10_20 )	

rename (death_covid_june death_covid_july death_covid_august death_covid_september death_covid_october) (death_covid6_20 death_covid7_20 death_covid8_20 death_covid9_20 death_covid10_20)

rename (death_pending_june death_pending_july death_pending_august death_pending_september death_pending_october) (death_pending6_20 death_pending7_20 death_pending8_20 death_pending9_20 death_pending10_20)

rename (death_negative_june death_negative_july death_negative_august death_negative_september death_negative_october) (death_negative6_20 death_negative7_20 death_negative8_20 death_negative9_20 death_negative10_20)

keep Delegation hospit_covid6_20-death_negative10_20
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta"
drop _merge 
order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
population2019 men2020 women2020 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid3_20 hospit_covid4_20 hospit_covid5_20 hospit_covid6_20 hospit_covid7_20 ///
hospit_covid8_20 hospit_covid9_20 hospit_covid10_20 hospit_pending3_20 ///
hospit_pending4_20 hospit_pending5_20 hospit_pending6_20 hospit_pending7_20 ///
hospit_pending8_20 hospit_pending9_20 hospit_pending10_20 hospit_negative3_20 ///
hospit_negative4_20 hospit_negative5_20 hospit_negative6_20 hospit_negative7_20 ///
hospit_negative8_20 hospit_negative9_20 hospit_negative10_20 death_covid3_20 ///
death_covid4_20 death_covid5_20 death_covid6_20 death_covid7_20 death_covid8_20 ///
death_covid9_20 death_covid10_20 death_negative3_20 death_negative4_20 ///
death_negative5_20 death_negative6_20 death_negative7_20 death_negative8_20 ///
death_negative9_20 death_negative10_20 death_pending4_20 death_pending5_20 ///
death_pending6_20 death_pending7_20 death_pending8_20 death_pending9_20 death_pending10_20
sort num_del
save "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta", replace


***END***
*Note: even though the mortality data are available upto Oct 20, I've merged with Jan19-Aug20 dataset which is the latest one available. 





