* HS performance during Covid
* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update with June, July data

clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import spss using "$user/$data/Raw/6.Indicators_IMSS_June_July_2020.sav", clear

rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México  Oriente"
replace Delegation = "México Poniente" if Delegation== "México  Poniente"
* 35 delegations, data in wide form

rename ( Indic2_ETS_ene20-Indic2_ETS_jul2020) ///
(sti_util1_20 sti_util2_20 sti_util3_20 sti_util4_20 sti_util5_20 sti_util6_20 ///
sti_util7_20 )

egen anc_util3_20 = rowtotal(Indic3_mar_1raVez20 Indic3_mar_Subsec20 ), m
egen anc_util4_20 = rowtotal(Indic3_abr_1raVez20 Indic3_abr_Subsec20 ), m
egen anc_util5_20 = rowtotal(Indic3_may_1raVez20 Indic3_may_Subsec20), m
rename (Indic3_jun_Total20 Indic3_jul_Total20) (anc_util6_20 anc_util7_20)
drop Indic3_*

rename (Indic4_FD_mar2020-Indic4_FD_jul2020) ///
(del_util3_20 del_util4_20 del_util5_20 del_util6_20 del_util7_20)

rename (Indic5_Cesa_mar2020-Indic5_Cesa_jul2020) /// 
(cs_util3_20 cs_util4_20 cs_util5_20 cs_util6_20 cs_util7_20 )

rename (Indic7_Gastro_jun2020 Indic7_Gastro_jul2020 Indic8_Neumo_jun2020 ///
Indic8_Neumo_jul2020 Indic9_Desnu_jun2020 Indic9_Desnu_jul2020) ///
( diarr_util6_20 diarr_util7_20 pneum_util6_20 pneum_util7_20 malnu_util6_20 ///
malnu_util7_20)

* Outpatients
egen opd_util6_20= rowtotal(Indic11_vmf_jun2020 Indic11_esp_jun2020), m
egen opd_util7_20= rowtotal(Indic11_vmf_jul2020 Indic11_esp_jul2020) , m 
* update for may byt only one of the 2 variables needed to calculate outpatient...

rename (Indic11_urg_abr2020-Indic11_urg_jul2020) (er_util4_20 er_util5_20 ///
er_util6_20 er_util7_20 )

rename (Indic11_dntl_jun2020 Indic11_dntl_jul2020) (dental_util6_20 dental_util7_20 )
drop Indic11* 

rename (In12_egrecc_ene20 In12_egrecc_feb20 In12_egrecc_mar20 In12_egrecc_abr20 ///
In12_egrecc_may20 In12_egrecc_jun20 In12_egrecc_jul20) /// 
(ipd_util1_20 ipd_util2_20 ipd_util3_20 ipd_util4_20 ipd_util5_20 ipd_util6_20 ///
ipd_util7_20)
drop In12* 

* Diabetes and hypertension visits among all (adult and children)
rename (In15_DM_jun20 In15_DM_jul20 In16_HTA_jun20 In16_HTA_jul20) ///
( diab_util6_20 diab_util7_20 hyper_util6_20 hyper_util7_20 )

rename (Indic17_sui_jun20 Indic17_sui_jul20) (mental_util6_20 mental_util7_20)

rename (Indic21cacu_jan2020-Indic21cacu_july2020) (cerv_util1_20 cerv_util2_20 ///
cerv_util3_20 cerv_util4_20 cerv_util5_20 cerv_util6_20 cerv_util7_20 ) 

rename (Indic24_dmctrl_jun20 Indic24_dmctrl_jul20 ///
Indic25_htactrl_jun20 Indic25_htactrl_jul20) ( diab_qual_num6_20 diab_qual_num7_20 ///
hyper_qual_num6_20 hyper_qual_num7_20)

* VACCINES
* Penta vaccine #
egen pent_qual5_20 =rowtotal (Indic26_penta*may20) , m
egen pent_qual6_20 =rowtotal (Indic26_penta*jun20) , m
egen pent_qual7_20 =rowtotal (Indic26_penta*jul20) , m
egen pent_qual8_20 =rowtotal (Indic26_penta*ago20) , m
drop Indic26_penta*

* BCG #
egen bcg_qual5_20 =rowtotal (Indic27_BCG*May20 ndic27_BCG*May20 ) , m
egen bcg_qual6_20 =rowtotal (Indic27_BCG*Jun20 ) , m
egen bcg_qual7_20 =rowtotal (Indic27_BCG*Jul20 ) , m
egen bcg_qual8_20 =rowtotal (Indic27_BCG*Ago20 Indic27_BCG*ago20 ) , m
drop Indic27_BCG* ndic27_BCG*

* MCV #
egen measles_qual5_20 =rowtotal ( Indic28*May20   ) , m
egen measles_qual6_20 =rowtotal ( Indic28*Jun20   ) , m
egen measles_qual7_20 =rowtotal ( Indic28*Jul20   ) , m
egen measles_qual8_20 =rowtotal ( Indic28*Ago20   ) , m
drop Indic28*

* OPV3 #
drop Indic29_SABIN_U_* Indic29_SABIN_P_* Indic29_SABIN_S_* Indic29_SABIN_R_* Indic29_SABIN_A_*
rename ( Indic29_SABIN_T_may20 Indic29_SABIN_T_jun20 Indic29_SABIN_T_jul20 ///
Indic29_SABIN_T_ago20) ( opv3_qual5_20 opv3_qual6_20 opv3_qual7_20 opv3_qual8_20)

* Pneumococcal #
rename (Indic30_ANC_jun20 Indic30_ANC_may20 Indic30_ANC_jul20 Indic30_ANC_ago20) ///
(pneum_qual5_20 pneum_qual6_20 pneum_qual7_20 pneum_qual8_20)

* Rotavirus #
rename (Indic31_RV_may20 Indic31_RV_jun20 Indic31_RV_jul20 Indic31_RV_ago20) ///
(rota_qual5_20 rota_qual6_20 rota_qual7_20 rota_qual8_20)

rename (In32_NMN_abr20-In32_NMN_jun20) (newborn_mort_num4_20 newborn_mort_num5_20 newborn_mort_num6_20)

rename (Indic33_NMF_ene20-Indic33_NMF_jun20) (sb_mort_num1_20 sb_mort_num2_20 ///
sb_mort_num3_20 sb_mort_num4_20 sb_mort_num5_20 sb_mort_num6_20)

rename (In34_NMM_jun20-In34_NMM_sept20) (mat_mort_num6_20 mat_mort_num7_20 ///
mat_mort_num8_20 mat_mort_num9_20)

rename (In36_MortServUrg_ene20-In36_MortServUrg_ago20) (er_mort_num1_20 ///
er_mort_num2_20 er_mort_num3_20 er_mort_num4_20 er_mort_num5_20 er_mort_num6_20 ///
er_mort_num7_20 er_mort_num8_20)

egen ipd_mort_num1_20 = rowtotal(In37_MortServCI_ene20 In38_MortHosp_ene20 ), m 
egen ipd_mort_num2_20 = rowtotal( In37_MortServCI_feb20  In38_MortHosp_feb20), m
egen ipd_mort_num3_20= rowtotal(In37_MortServCI_mar20   In38_MortHosp_mar20), m
egen ipd_mort_num4_20 = rowtotal(In37_MortServCI_abr20  In38_MortHosp_abr20) , m 
egen ipd_mort_num5_20  = rowtotal(In37_MortServCI_may20  In38_MortHosp_may20 ), m 	
egen ipd_mort_num6_20  = rowtotal( In37_MortServCI_jun20 In38_MortHosp_jun20), m 
egen ipd_mort_num7_20  = rowtotal(In37_MortServCI_jul20  In38_MortHosp_jul20), m  
egen ipd_mort_num8_20  = rowtotal( In37_MortServCI_ago20  In38_MortHosp_ago20), m  
drop In37* In38* 
  
 
********************************************************************************
* MERGE TO DATA FROM FIRST AND SECOND ROUNDS (Jan19-Jun20)
********************************************************************************
merge 1:1 Delegation using  "$user/$data/Data for analysis/IMSS_Jan19-Jun20_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/IMSS_Jan19-Jul20_WIDE.dta", replace

  
