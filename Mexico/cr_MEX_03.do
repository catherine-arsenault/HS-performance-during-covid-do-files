* HS performance during Covid
* Oct 7, 2020 
* Mexico - IMSS, Edits to data from March-June 2020 (Sent by Svetlana Sept 11)

clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import spss using "$user/$data/Raw/Indicators_IMSS_June_2020.sav", clear

********************************************************************************
* VOLUMES
********************************************************************************
rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México  Oriente"
replace Delegation = "México Poniente" if Delegation== "México  Poniente"
* 35 delegations, data in wide form

* STI
rename (Indic2_ETS_mar2020 Indic2_ETS_abr2020 Indic2_ETS_may2020 Indic2_ETS_jun2020) ///
	  (sti_util3_20 sti_util4_20 sti_util5_20 sti_util6_20)

* ANC
egen anc_util3_20 = rowtotal(Indic3_mar_1raVez20 Indic3_mar_Subsec20), m
egen anc_util4_20 = rowtotal( Indic3_abr_1raVez20 Indic3_abr_Subsec20), m
egen anc_util5_20 = rowtotal( Indic3_may_1raVez20 Indic3_may_Subsec20), m
drop Indic3_*

* Deliveries
rename(Indic4_FD_mar2020 Indic4_FD_april2020 Indic4_FD_may2020 Indic4_FD_jun2020) ///
	  (del_util3_20 del_util4_20 del_util5_20 del_util6_20)

* Caesareans
rename (Indic5_Cesa_mar2020 Indic5_Cesa_april2020 Indic5_Cesa_may2020 ///
		Indic5_Cesa_jun2020) ///
		(cs_util3_20 cs_util4_20 cs_util5_20 cs_util6_20)

* Create total deliveries to calculate rates later on = number of deliveries + number of C-sections
egen totaldel3_20= rowtotal(del_util3_20 cs_util3_20), m
egen totaldel4_20= rowtotal(del_util4_20 cs_util4_20), m
egen totaldel5_20= rowtotal(del_util5_20 cs_util5_20), m
egen totaldel6_20= rowtotal(del_util6_20 cs_util6_20), m

* Diarrhea, pneumo, malnutrition
rename (Indic7_Gastro_jun2020 Indic8_Neumo_jun2020 Indic9_Desnu_jun2020) ///
		(diarr_util6_20 pneum_util6_20 malnu_util6_20)

* OPD = # of visits to family medicine + # of outpatient specialty consultations 		
egen opd_util6_20= rowtotal(Indic11_vmf_jun2020 Indic11_esp_jun2020) , m		

* ER
rename ( Indic11_urg_abr2020 Indic11_urg_may2020 Indic11_urg_jun2020) ///
		( er_util4_20 er_util5_20 er_util6_20)
		
* Dental 
rename Indic11_dntl_jun2020  dental_util6_20 
drop Indic11* 

* IPD admissions total (aggregated scheduled + emergency)
rename (In12_egrecc_mar20 In12_egrecc_abr20 In12_egrecc_may20 In12_egrecc_jun20) ///
		(ipd_util3_20 ipd_util4_20 ipd_util5_20 ipd_util6_20)
drop In12*

* Diabetes and hypertension visits among all (adult and children)
rename ( In15_DM_jun20 In16_HTA_jun20) (diab_util6_20 hyper_util6_20)

* VACCINES
* Penta vaccine #
egen pent_qual5_20 =rowtotal (Indic26_penta*may20) , m
egen pent_qual6_20 =rowtotal (Indic26_penta*jun20) , m
drop Indic26_penta*

* BCG any dose
egen bcg_qual5_20 =rowtotal (Indic27_BCG*May20 ndic27_BCG*May20 ) , m
egen bcg_qual6_20 =rowtotal (Indic27_BCG*Jun20 ) , m

* BCG unique dose
rename (Indic27_BCG_U_May20 Indic27_BCG_U_Jun20) ( bcgu_qual5_20 bcgu_qual6_20)
drop Indic27_BCG* ndic27_BCG* 
* MCV #
egen measles_qual5_20 =rowtotal ( Indic28*May20   ) , m
egen measles_qual6_20 =rowtotal ( Indic28*Jun20   ) , m
drop Indic28*

* OPV3 #
drop Indic29_SABIN_U_* Indic29_SABIN_P_* Indic29_SABIN_S_* Indic29_SABIN_R_* Indic29_SABIN_A_*
rename ( Indic29_SABIN_T_may20 Indic29_SABIN_T_jun20) ( opv3_qual5_20 opv3_qual6_20)

* Pneumococcal #
rename (Indic30_ANC_jun20 Indic30_ANC_may20 ) (pneum_qual5_20 pneum_qual6_20)

* Rotavirus #
rename (Indic31_RV_may20 Indic31_RV_jun20) (rota_qual5_20 rota_qual6_20)

********************************************************************************
* MERGE TO DATA FROM FIRST AND SECOND ROUNDS (Jan19-May20)
********************************************************************************
merge 1:1 Delegation using  "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/IMSS_Jan19-Jun20_WIDE.dta", replace
