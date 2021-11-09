* HS performance during Covid
* Dec 10, 2020 
* Mexico - IMSS, Update with September data

clear all
set more off	

import spss using "$user/$data/Raw/8.Indicadores_IMSS_Septiembre2020_complete.sav", clear

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
*FP 
egen fp_util9_20 = rowtotal(Indic1_PF1vez_sept2020 Indic1_PFSub_sept2020), m
drop Indic1_PF*

*STI
rename (Indic2_ETS_sept2020) (sti_util9_20 )

*ANC
rename(Indic3_mar_Total20 Indic3_abr_Total20 Indic3_may_Total20 Indic3_jun_Total20 Indic3_jul_Total20 Indic3_ago_Total20 Indic3_sept_Total20 ) (anc_util3_20 ///
anc_util4_20 anc_util5_20 anc_util6_20 anc_util7_20 anc_util8_20 anc_util9_20 )
drop Indic3_*

* Deliveries , csections
rename (Indic4_FD_jul2020 Indic4_FD_ago2020 Indic4_FD_sept2020 ) ///
(del_util7_20 del_util8_20 del_util9_20)
rename (Indic5_Cesa_ago2020 Indic5_Cesa_sept2020) (cs_util8_20 cs_util9_20)

egen totaldel8_20= rowtotal(del_util8_20 cs_util8_20), m
egen totaldel9_20= rowtotal(del_util9_20 cs_util9_20), m

* Diarrhea, pneumonia, malnutrition
rename(Indic7_Gastro_sept2020 Indic8_Neumo_sept2020 Indic9_Desnu_sept2020) ///
		(diarr_util9_20 pneum_util9_20 malnu_util9_20)
		
* Outpatients
egen opd_util9_20= rowtotal(Indic11_vmf_sept2020 Indic11_esp_sept2020), m

*ER, dental 
rename (Indic11_urg_sept2020 Indic11_dntl_sept2020) (er_util9_20 dental_util9_20)	
drop Indic11* 

*IPD
rename Indic12_egrecc_sept2020 ipd_util9_20
drop Indic12_*

* Diabetes and hypertension visits among all (adult and children)
rename (Indic15_DM_sept20 Indic16_HTA_sept20) ///
(diab_util9_20 hyper_util9_20 )
 
rename Indic17_sui_sept20 mental_util9_20 

rename Indic21cacu_sep2020 cerv_util9_20 

rename ( Indic24_dmctrl_sept20 Indic25_htactrl_sept20) (diab_qual_num9_20 hyper_qual_num9_20 )

* Penta vaccine 
egen pent_qual9_20 =rowtotal (Indic26_penta*sept20) , m
drop Indic26_penta*

* BCG 
egen bcg_qual9_20 =rowtotal(Indic27_BCG_U_sept20 Indic27_BCG_P_sept20 Indic27_BCG_S_sept20 Indic27_BCG_T_sept20 Indic27_BCG_R_sept20 Indic27_BCG_A_sept20) , m
*rename Indic27_BCG_U_sept20  bcg_qual9_20 
drop Indic27_BCG*

* MCV 
egen measles_qual9_20 =rowtotal ( Indic28_srp_sept20 Indic28_SR_sept20) , m
drop Indic28*

* OPV3 #
rename Indic29_SABIN_T_sept20 opv3_qual9_20
drop Indic29_SABIN* 

* Pneumococcal #
rename Indic30_ANC_sept20 pneum_qual9_20

* Rotavirus #
rename Indic31_RV_sept20 rota_qual9_20

*Newborn deaths
rename (Indic32_NMN_jul20 Indic32_NMN_ago20) (newborn_mort_num7_20 newborn_mort_num8_20)

* Stillbirths
rename (Indic33_NMF_jul20 Indic33_NMF_ago20) (sb_mort_num7_20 sb_mort_num8_20)

*Maternal deaths
rename (In34_NMM_sept20 Indic34_NMM_oct20 Indic34_NMM_nov20)  (mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20)

*ER deaths
rename (In36_MortServUrg_may20 In36_MortServUrg_jun20 In36_MortServUrg_jul20 ///
In36_MortServUrg_sept20) (er_mort_num5_20 er_mort_num6_20 er_mort_num7_20 er_mort_num9_20)

* Inpatient deaths 
egen ipd_mort_num9_20  = rowtotal( In37_MortServCI_sept20 In38_MortHosp_sept20), m  
drop In37* In38*
* March & April 2020 corrected in cr_MEX_04

********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Aug20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Sep20_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Sep20v2_WIDE.dta", replace

