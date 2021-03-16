* HS performance during Covid
* Jan 20, 2021
* Mexico - IMSS, Oct 2020 data 

clear all
set more off	

import spss using "$user/$data/Raw/Indicadores_IMSS_Octubre2020.sav", clear

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="CDMX. Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX. Sur"

*FP 
egen fp_util10_20 = rowtotal(Indic1_PF1vez_oct2020 Indic1_PFSub_oct2020), m
drop Indic1_PF*

*STI
rename (Indic2_ETS_oct2020) (sti_util10_20 )

*ANC
egen anc_util10_20= rowtotal(Indic3_oct_1raVez20 Indic3_oct_sub20), m
drop Indic3_*

* Deliveries , csections
rename Indic4_FD_oct2020 del_util10_20 
rename Indic5_Cesa_oct2020 cs_util10_20

egen totaldel10_20= rowtotal(del_util10_20 cs_util10_20), m

* Diarrhea, pneumonia, malnutrition
rename(Indic7_Gastro_oct2020 Indic8_Neumo_oct2020 Indic9_Desnu_oct2020) ///
		(diarr_util10_20 pneum_util10_20 malnu_util10_20)
		
* Outpatients
egen opd_util10_20= rowtotal(Indic11_vmf_oct2020 Indic11_esp_oct2020), m

*ER, dental 
rename (Indic11_urg_oct2020 Indic11_dntl_oct2020) (er_util10_20 dental_util10_20)	
drop Indic11* 

*IPD
rename Indic12_egrecc_oct2020 ipd_util10_20
drop Indic12_*

* Diabetes and hypertension visits among all (adult and children)
rename (Indic15_DM_oct20 Indic16_HTA_oct20) ///
(diab_util10_20 hyper_util10_20 )

*Mental health
rename Indic17_sui_oct20 mental_util10_20 

*Cervical cancer screening
rename Indic21cacu_oct2020 cerv_util10_20 

*Diabetic and hypertensive patients with controlled condition
rename ( Indic24_dmctrl_oct20 Indic25_htactrl_oct20) (diab_qual_num10_20 hyper_qual_num10_20 )

*Newborn deaths - Sep2020
rename Indic32_NMN_sept20 newborn_mort_num9_20

* Stillbirths - Sep2020
rename Indic33_NMF_sept20 sb_mort_num9_20

*Maternal deaths - Dec 2020
rename In34_NMM_dic20  mat_mort_num12_20

*ER deaths
rename In36_MortServUrg_oct20 er_mort_num10_20

* Inpatient deaths 
egen ipd_mort_num10_20  = rowtotal( In37_MortServCI_oct20 In38_MortHosp_oct20), m  
drop In37* In38*


save "$user/$data/Data for analysis/IMSS_Jan19-Oct20_WIDE.dta", replace

********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Oct20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20_WIDE.dta", replace







/* Will add these codes once the data are available:

Penta vaccine 
egen pent_qual9_20 =rowtotal (Indic26_penta*sept20) , m
drop Indic26_penta*

* BCG 
egen bcg_qual9_20 =rowtotal(Indic27_BCG_U_sept20 Indic27_BCG_P_sept20 Indic27_BCG_S_sept20 Indic27_BCG_T_sept20 Indic27_BCG_R_sept20 Indic27_BCG_A_sept20) , m
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
*/


















