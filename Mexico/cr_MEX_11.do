* HS performance during Covid
* Feb 10, 2021
* Mexico - IMSS, Nov 2020 data 

clear all
set more off	

// Sent by Svetlana Feb 3, 2021
import spss using "$user/$data/Raw/Indicadores_IMSS_Noviembre2020.sav", clear

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="CDMX. Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX. Sur"

*STI
rename (Indic2_ETS_nov2020) (sti_util11_20)

*ANC - Total antenatal care visits 
rename (Indic3_nov_Total20) (anc_util11_20)
drop Indic3_nov_1raVez20

*Deliveries
rename (Indic4_FD_nov2020) (del_util11_20)

*C-sections 
rename Indic5_Cesa_nov2020 cs_util11_20

*Total deliveries 
egen totaldel11_20= rowtotal(del_util11_20 cs_util11_20), m

* Diarrhea, pneumonia, malnutrition
rename(Indic7_Gastro_nov2020 Indic8_Neumo_nov2020 Indic9_Desnu_nov2020) ///
		(diarr_util11_20 pneum_util11_20 malnu_util11_20)
		
* Outpatients
egen opd_util11_20= rowtotal(Indic11_vmf_nov2020 Indic11_esp_nov2020), m

*ER, dental 
rename (Indic11_urg_nov2020 Indic11_dntl_nov2020) (er_util11_20 dental_util11_20)	
drop Indic11* 

*IPD total
rename Indic12_egrecc_nov2020 ipd_util11_20
drop Indic12_*

* Diabetes and hypertension visits among all (adult and children)
rename (Indic15_DM_nov20 Indic16_HTA_nov20) ///
(diab_util11_20 hyper_util11_20 )

*Mental health
rename Indic17_sui_nov20 mental_util11_20 

*Cervical cancer screening
rename Indic21cacu_nov2020 cerv_util11_20 

*Diabetic and hypertensive patients with controlled condition
rename (Indic24_dmctrl_nov20 Indic25_htactrl_nov20) ///
		(diab_qual_num11_20 hyper_qual_num11_20 )

*ER deaths
rename In36_MortServUrg_nov20 er_mort_num11_20

* Inpatient deaths (ICU+ Inpatient)
egen ipd_mort_num11_20  = rowtotal(In37_MortServCI_nov20 In38_MortHosp_nov20), m  
drop In37* In38*


save "$user/$data/Data for analysis/IMSS_Jan19-Nov20_WIDE.dta", replace

********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Oct20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Oct20m_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Nov20_WIDE.dta", replace







