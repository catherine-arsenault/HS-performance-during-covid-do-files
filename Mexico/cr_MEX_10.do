* HS performance during Covid
* Feb 10, 2021
* Mexico - IMSS, Update the mortality data 
* Recode COVID mortality data from June20 to Dec 20 and merge with pervious dataset 
* by MK Kim 

clear all
set more off	

* Covid deaths sent by Svetlana Feb 3, 2021
import spss using "$user/$data/Raw/4. Hospital_mortality_COVID_IMSS_complete2020.sav", clear 
sort delegacion
merge 1:1 delegacion using "$user/$data/Raw/link.dta"
*3 delegations not merging. Covid deaths are by States=32
drop if _merge==2 
drop _merge 

order Delegation 
drop delegacion

/* COVID MORTALITY 
1) Covid mortality = Hospital deaths per month in patients with a positive COVID test  /Hospitalized IMSS patient with positive Covid test
  
2) Mortality in  IMSS patient with probable COVID but with negative COVID test  / Hospitalized IMSS patient with probable COVID but with negative COVID test 

3)Hospital deaths per month in patients with a pending COVID test April 2020 / Hospitalized IMSS patient in patients with a pending COVID test April 2020 */

* Covid deaths
rename (death_covid_june death_covid_july death_covid_august death_covid_september death_covid_october death_covid_november death_covid_december) (death_covid6_20 death_covid7_20 death_covid8_20 death_covid9_20 death_covid10_20 death_covid11_20 death_covid12_20)
* Covid hospitalisations
rename (hospit_covid_june hospit_covid_juliy hospit_covid_august hospit_covid_september hospit_covid_october hospit_covid_november hospit_covid_december) (hospit_covid6_20 hospit_covid7_20 hospit_covid8_20 hospit_covid9_20 hospit_covid10_20 hospit_covid11_20 hospit_covid12_20)

* Death negative
rename (death_negative_june death_negative_july death_negative_august death_negative_september death_negative_october death_negative_november death_negative_december) (death_negative6_20 death_negative7_20 death_negative8_20 death_negative9_20 death_negative10_20 death_negative11_20 death_negative12_20)
* Hospitalizations among negative Covid
rename (hospit_negative_june hospit_negative_july hospit_negative_august hospit_negative_september hospit_negative_october hospit_negative_november hospit_negativa_december) (hospit_negative6_20 hospit_negative7_20 hospit_negative8_20 hospit_negative9_20 hospit_negative10_20 hospit_negative11_20 hospit_negative12_20)	

*Death pending test
rename (death_pending_june death_pending_july death_pending_august death_pending_september death_pending_october death_pending_november death_pending_december) (death_pending6_20 death_pending7_20 death_pending8_20 death_pending9_20 death_pending10_20 death_pending11_20 death_pending12_20)
* Hospitalizations pending test
rename (hospit_pending_june hospit_pending_july hospit_pending_august hospit_pending_september hospit_pending_october hospit_pending_november hospit_pending_december) (hospit_pending6_20 hospit_pending7_20 hospit_pending8_20 hospit_pending9_20 hospit_pending10_20 hospit_pending11_20 hospit_pending12_20)

********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Oct20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Oct20_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20m_WIDE.dta", replace
























