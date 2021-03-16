* HS performance during Covid
* Mar 16, 2021
* Mexico - IMSS, update to December 2020 data 
* C.Arsenault

clear all
set more off	

// Sent by Svetlana Mar 13, 2021
import spss using "$user/$data/Raw/Indicadores_IMSS_December2020v2.sav", clear

* 35 delegations, data in wide form
replace Deleg= "D.F. Norte" if Deleg=="CDMX. Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX. Sur"
replace Deleg= "México Oriente" if Deleg=="Estado de México Oriente"
replace Deleg= "México Poniente" if Deleg=="Estado de México Poniente"

*FP 
egen fp_util11_20 = rowtotal(Indic1_PF1vez_nov2020 Indic1_PFSub_nov2020), m
egen fp_util12_20= rowtotal(Indic1_PF1vez_dec2020 Indic1_PFSub_dec2020), m
drop Indic1_PF*


*STI
rename (Indic2_ETS_dec2020) (sti_util12_20 )

*ANC
rename (Indic3_ACTotal_dic2020) (anc_util12_20)
drop Indic3_AC1ravez_dec2020 IIndic3_ACSubsec_dec2020

* Deliveries , csections
rename Indic4_FD_dec2020 del_util12_20 
rename Indic5_Cesa_dec2020 cs_util12_20

egen totaldel12_20= rowtotal(del_util12_20 cs_util12_20), m

* Diarrhea, pneumonia, malnutrition
rename(Indic7_Gastro_dec2020 Indic8_Neumo_dec2020 Indic9_Desnu_dec2020) ///
		(diarr_util12_20 pneum_util12_20 malnu_util12_20)

* Outpatients
egen opd_util12_20= rowtotal(Indic11_vmf_dec2020 Indic11_esp_dec2020), m

*ER, dental 
rename (Indic11_urg_dec2020 Indic11_dntl_dec2020) (er_util12_20 dental_util12_20)	
drop Indic11* 

*IPD
rename Indic12_egrecc_dec2020 ipd_util12_20
drop Indic12_*

* Diabetes and hypertension visits 
rename (Indic15_DM_dec2020 Indic16_HTA_dec2020) ///
(diab_util12_20 hyper_util12_20 )

*Mental health
rename Indic17_sui_dec2020 mental_util12_20 

*Cervical cancer screening
rename Indic21cacu_dec2020 cerv_util12_20 

*Diabetic and hypertensive with controlled conditions
rename ( Indic24_dmctrl_dec20 Indic25_htactrl_dec20) (diab_qual_num12_20 hyper_qual_num12_20 )

*Newborn deaths - Oct-Nov20
rename (Indic32_NMN_oct20 Indic32_NMN_nov20) ///
	   (newborn_mort_num10_20 newborn_mort_num11_20)

* Stillbirths - Oct-Nov20 
rename (Indic33_NMF_oct20 Indic33_NMF_nov20) ///
	   (sb_mort_num10_20 sb_mort_num11_20)

*ER deaths - Nov-Dec20 
rename (In36_MortServUrg_nov20 In36_MortServUrg_dec20) ///
	   (er_mort_num11_20 er_mort_num12_20)

* Inpatient deaths - Nov-Dec20 
egen ipd_mort_num11_20  = rowtotal( In37_MortServCI_nov20 In38_MortHosp_nov20), m  
egen ipd_mort_num12_20  = rowtotal( In37_MortServCI_dec20 In38_MortHosp_dec20), m  
drop In37* In38*

********************************************************************************
* MERGE WITH PRIOR DATA 
********************************************************************************

merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Dec20v2_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", replace
