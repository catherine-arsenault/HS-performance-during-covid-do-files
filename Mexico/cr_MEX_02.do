* HS performance during Covid
* Aug 26, 2020 
* Mexico - IMSS, Second round of data (March-June 2020)
* And Merging to first round of data (Jan19-Feb20)
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import spss using "$user/$data/Raw/Indicators_IMSS_March_Mayo_2020.sav", clear
rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México  Oriente"
replace Delegation = "México Poniente" if Delegation== "México  Poniente"
* 35 delegations, data in wide form

********************************************************************************
* VOLUMES
********************************************************************************
* FP
egen fp_util3_20 = rowtotal(Indic1_PF1vez_march2020 Indic1_PFSub_mar2020 ), m
egen fp_util4_20 = rowtotal(Indic1_PF1vez_april2020 Indic1_PFSub_april2020 ), m
egen fp_util5_20 = rowtotal(Indic1_PF1vez_may2020 Indic1_PFSub_may2020 ), m
egen fp_util6_20 = rowtotal( Indic1_PF1vez_jun2019 Indic1_PFSub_jun2020), m
drop Indic1_*  
* STI
rename (Indic2_ETS_mar2020 Indic2_ETS_april2020 Indic2_ETS_may2020) (sti_util3_20 sti_util4_20 sti_util5_20	)
* ANC
egen anc_util3_20 = rowtotal(Indic3_AC1ravez_mar2020 Indic3_ACSub_mar2020), m
egen anc_util4_20 = rowtotal( Indic3_AC1ravez_april2020 Indic3_ACSub_april2020), m
egen anc_util5_20 = rowtotal( Indic3_AC1ravez_may2020 Indic3_ACSub_may2020), m
drop Indic3_*
* Deliveries
rename(Indic4_FD_mar2020 Indic4_FD_april2020 Indic4_FD_may2020)  (del_util3_20 del_util4_20 del_util5_20)
*Caesareans
rename (Indic5_Cesa_mar2020 Indic5_Cesa_april2020 Indic5_Cesa_may2020 )(cs_util3_20 cs_util4_20 cs_util5_20)
* Create total deliveries to calculate rates later on = number of deliveries + number of C-sections
egen totaldel3_20= rowtotal(del_util3_20 cs_util3_20), m
egen totaldel4_20= rowtotal(del_util4_20 cs_util4_20), m
egen totaldel5_20= rowtotal(del_util5_20 cs_util5_20), m
* Diarrhea , pneumonia, malnutrition
rename (Indic7_Gastro_mar2020 Indic7_Gastro_april2020 Indic7_Gastro_may2020 Indic8_Neumo_mar2020 Indic8_Neumo_april2020 ///
		Indic8_Neumo_may2020 Indic9_Desnu_mar2020 Indic9_Desnu_april2020 Indic9_Desnu_may2020) ///
		(diarr_util3_20 diarr_util4_20 diarr_util5_20 pneum_util3_20 pneum_util4_20 ///
		pneum_util5_20 malnu_util3_20 malnu_util4_20 malnu_util5_20)
* OPD = (# of visits to family medicine) + (# of outpatient specialty consultations) 	
egen opd_util3_20=rowtotal( Indic11_vmf_mar2020 Indic11_esp_mar2020), m
egen opd_util4_20= rowtotal( Indic11_vmf_abr2020 Indic11_esp_abr2020) , m		
egen opd_util5_20= rowtotal(Indic11_vmf_may2020 Indic11_esp_may2020 ) , m		
* ER
rename (Indic11_urg_mar2020 Indic11_urg_abr2020 Indic11_urg_may2020) (er_util3_20 er_util4_20 er_util5_20)
* Dental 
rename (Indic11_dntl_mar2020 Indic11_dntl_abr2020 Indic11_dntl_may2020) (dental_util3_20 dental_util4_20 dental_util5_20 )
drop Indic11* 
* IPD admissions total (scheduled + emergency)
rename (In12_egrecc_mar20 In12_egrecc_abr20 In12_egrecc_may20) (ipd_util3_20 ipd_util4_20 ipd_util5_20)
drop In12*
* Diabetes and hypertension visits among all (adult and children)
rename ( In15_DM_ene20 In15_DM_feb20 In15_DM_mar20 In15_DM_abr20 In15_DM_may20) ///
       (diab_util1_20 diab_util2_20 diab_util3_20 diab_util4_20 diab_util5_20)
rename (In16_HTA_ene20 In16_HTA_feb20 In16_HTA_mar20 In16_HTA_abr20 In16_HTA_may20 ) ///
       ( hyper_util1_20 hyper_util2_20 hyper_util3_20 hyper_util4_20 hyper_util5_20)
* Mental health, attempted suicide
rename (In17_sui_mar20 In17_sui_abr20 In17_sui_may20) (mental_util3_20 mental_util4_20 mental_util5_20)
********************************************************************************
* QUALITY (just numerators)
********************************************************************************
* Cervical cancer screening
rename In21_EneDen20 cerv_denom2020
rename (Indic21cacu_jan2020-Indic21cacu_may2020) (cerv_util1_20 cerv_util2_20 cerv_util3_20 cerv_util4_20 cerv_util5_20 ) 
* DM blood sugar control 
rename(Indic24_dmctrl_jan20 Indic24_dmctrl_feb20 Indic24_dmctrl_mar20 Indic24_dmctrl_abr20 Indic24_dmctrl_may20) ///
		(diab_qual_num1_20 diab_qual_num2_20 diab_qual_num3_20 diab_qual_num4_20 diab_qual_num5_20 )
rename(numberDM_jan20 numberDM_feb2020 numberDM_mar20 numberDM_abr20 numberDM_may20) ///
		(diab_qual_denom1_20 diab_qual_denom2_20 diab_qual_denom3_20 diab_qual_denom4_20 diab_qual_denom5_20)
* HTN blood pressure control 
rename( Indic25_htactrl_ene20 Indic25_htactrl_feb20 Indic25_htactrl_mar20 Indic25_htactrl_abr20 Indic25_htactrl_may20) ///
	  (hyper_qual_num1_20 hyper_qual_num2_20 hyper_qual_num3_20 hyper_qual_num4_20 hyper_qual_num5_20)
	 rename(numberHBP_ene20 numberHBP_feb20 numberHBP_mar20 numberHBP_apr20 numberHBP_may20) ///
	 (hyper_qual_denom1_20 hyper_qual_denom2_20 hyper_qual_denom3_20 hyper_qual_denom4_20 hyper_qual_denom5_20) 
* TB (only annual, drop for now)
drop In20_tuber_total20
********************************************************************************
* MORTALITY (just numerators)
********************************************************************************
rename (In32_NMN_ene20 In32_NMN_feb20 In32_NMN_mar20) (newborn_mort_num1_20 newborn_mort_num2_20 newborn_mort_num3_20)
replace newborn_mort_num2_20= 0 if newborn_mort_num2_20==. // there were no deliveries in 1 delegation in Feb 2020
rename (In34_NMM_ene20 In34_NMM_feb20 In34_NMM_mar20 In34_NMM_abr20 In34_NMM_may20) (mat_mort_num1_20 mat_mort_num2_20 ///
		mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20)
* ER and Inpatient were updated Sept 5th 2020
drop In36* In37* In38* 
save "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta", replace
import spss using "$user/$data/Raw/Indicators_IMSS__mortality indic36_37_38January_July2020.sav", clear
rename Delegación Delegation
replace Deleg="México Oriente" if Deleg=="México  Oriente"
replace Deleg="México Poniente" if Deleg=="México  Poniente"
rename (In36_MortServUrg_ene20 In36_MortServUrg_feb20 In36_MortServUrg_mar20 In36_MortServUrg_abr20 In36_MortServUrg_may20 /// 
		In36_MortServUrg_jun20 In36_MortServUrg_jul20) (er_mort_num1_20 er_mort_num2_20 er_mort_num3_20 er_mort_num4_20 ///
		er_mort_num5_20 er_mort_num6_20 er_mort_num7_20)
egen ipd_mort_num1_20 = rowtotal(In37_MortServCI_ene20 In38_MortHosp_ene20), m 
egen ipd_mort_num2_20 = rowtotal(In37_MortServCI_feb20 In38_MortHosp_feb20), m
egen ipd_mort_num3_20= rowtotal(In37_MortServCI_mar20 In38_MortHosp_mar20), m
egen ipd_mort_num4_20 = rowtotal(In37_MortServCI_abr20 In38_MortHosp_abr20) , m 
egen ipd_mort_num5_20  = rowtotal(In37_MortServCI_may20 In38_MortHosp_may20), m 	
egen ipd_mort_num6_20  = rowtotal(In37_MortServCI_jun20 In38_MortHosp_jun20), m 
egen ipd_mort_num7_20  = rowtotal(In37_MortServCI_jul20 In38_MortHosp_jul20), m 
drop ipd_mort_num6_20 ipd_mort_num7_20 				// we dont have the denominator yet
drop In37* In38* 

merge 1:1 Deleg using "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta", replace

********************************************************************************
* MERGE TO DATA FROM FIRST ROUND (Jan19-Feb20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Feb20_WIDE.dta"
drop _merge VAR00001 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 population2019 men2020 women2020 population2020
sort Delegation
save "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta", replace


/* COVID MORTALITY 
1) Covid mortality = Hospital deaths per month in patients with a positive COVID test  /Hospitalized IMSS patient with positive Covid test  
2) Mortality in  IMSS patient with probable COVID but with negative COVID test  / Hospitalized IMSS patient with probable COVID but with negative COVID test 
3)Hospital deaths per month in patients with a pending COVID test April 2020 / Hospitalized IMSS patient in patients with a pending COVID test April 2020 */
import excel using "$user/$data/Raw/link.xlsx", firstrow clear
save "$user/$data/Raw/link.dta", replace
import spss using "$user/$data/Raw/Hospital_mortalityCOVID_march-july2020.sav", clear
drop if delegacion==""
sort delegacion
merge 1:1 delegacion using "$user/$data/Raw/link.dta"
rename (death_covid_march death_covid_april death_covid_may death_covid_june death_covid_july) ///
	  (death_covid3_20 death_covid4_20 death_covid5_20 death_covid6_20 death_covid7_20)
rename (hospit_covid_march hospit_covid_april hospit_covid_may hospit_covid_june hospit_covid_juliy) ///
		(hospit_covid3_20 hospit_covid4_20 hospit_covid5_20 hospit_covid6_20 hospit_covid7_20)
rename (death_negative_march death_negative_april death_negative_mayo death_negative_june death_negative_july) ///
		(death_negative3_20 death_negative4_20 death_negative5_20 death_negative6_20 death_negative7_20)
rename (hospit_negative_march hospit_negative_april hospit_negative_mayo hospit_negative_june hospit_negative_july) ///
		(hospit_negative3_20 hospit_negative4_20 hospit_negative5_20 hospit_negative6_20 hospit_negative7_20 )	
rename (death_pending_april death_pending_may death_pending_june death_pending_july) ///
		(death_pending4_20 death_pending5_20 death_pending6_20 death_pending7_20)
rename (hospit_pending_march hospit_pending_april hospit_pending_may hospit_pending_june hospit_pending_july ) ///
	   (hospit_pending3_20 hospit_pending4_20 hospit_pending5_20 hospit_pending6_20 hospit_pending7_20)
	   
keep Deleg hospit_covid3_20-hospit_negative7_20 death_covid3_20-death_negative7_20
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta"
drop _merge 
set obs 36 
replace Delegation = "National" if Delegation==""

save "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta", replace





