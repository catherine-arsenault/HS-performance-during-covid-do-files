* HS performance during Covid
* Dec 10, 2020 
* Mexico - IMSS, Update with September data

clear all
set more off	

import spss using "$user/$data/Raw/8.Indicadores_IMSS_Septiembre2020_complete.sav", clear
replace Del = "D.F. Norte" if Del == "CDMX Norte" 
replace Del = "D.F. Sur" if Del=="CDMX Sur" 

* 35 delegations, data in wide form

*FP 
egen fp_util9_20 = rowtotal(Indic1_PF1vez_sept2020 Indic1_PFSub_sept2020), m
drop Indic1_PF*

*STI
rename (Indic2_ETS_sept2020) (sti_util9_20 )

*ANC
egen anc_util3_20 = rowtotal(Indic3_mar_1raVez20 Indic3_mar_Total20 ), m
egen anc_util4_20 = rowtotal(Indic3_abr_1raVez20 Indic3_abr_Total20), m
egen anc_util5_20 = rowtotal( Indic3_may_1raVez20 Indic3_may_Total20 ), m
egen anc_util6_20 = rowtotal(Indic3_jun_1raVez20 Indic3_jun_Total20), m 
egen anc_util7_20 = rowtotal( Indic3_jul_1raVez20 Indic3_jul_Total20 ), m 
egen anc_util8_20 = rowtotal(Indic3_ago_1raVez20 Indic3_ago_Total20 ), m 
egen anc_util9_20= rowtotal(Indic3_sept_1raVez20 Indic3_sept_Total20), m
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

save "$user/$data/Data for analysis/IMSS_Jan19-Sep20_WIDE.dta", replace


set obs 36
replace Delegation="National" if Deleg==""

*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
	reshape long  sti_util  del_util  cs_util  diarr_util  pneum_util  malnu_util ///
	art_util  er_util  ipd_util  dental_util diab_util   hyper_util  mental_util ///
	opv3_qual  pneum_qual  rota_qual  fp_util  anc_util  opd_util  cerv_util  ///
	diab_qual_num  hyper_qual_num   pent_qual ///
	bcg_qual  measles_qual newborn_mort_num  sb_mort_num mat_mort_num  er_mort_num ///
	ipd_mort_num death_covid  hospit_covid death_negative hospit_negative ///
	death_pending hospit_pending totaldel  , i(Deleg) j(month) string
	
* Labels (And dashboard format)
* Volume RMNCH services
	lab var fp_util "Number of new and current users of contraceptives"
	lab var sti_util "Number of consultations for STI care"
	lab var anc_util "Total number of antenatal care visits"
	lab var del_util "Number of facility deliveries"
	lab var cs_util "Number of caesarean sections "
	lab var diarr_util "Number of consultations for sick child care - diarrhea"
	lab var pneum_util "Number of consultations for sick child care - pneumonia"
	lab var malnu_util "Number of consultations for sick child care - malnutrition"
* Vaccines
	lab var bcg_qual "Nb children vaccinated with bcg vaccine"
	lab var pent_qual "Nb children vaccinated with 3rd dose pentavalent"
	lab var measles_qual "Nb children vaccinated with measles vaccine"
	lab var opv3_qual "Nb children vaccinated with 3rd dose oral polio vaccine"
	lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	
	lab var dental_util "Number of dental visits"
	lab var diab_util "Number of diabetic patients aged 20+  visited primary care clinics"
	lab var hyper_util "Number of hypertensive patients aged 20+  visited primary care clinics"
	lab var art_util "Number of adult and children on ART "
	lab var mental_util "Number consultations for attempted suicides"
	lab var opd_util  "Nb outpatient (family medicine clinic  & opd specialty) visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
* Quality 
	lab var cerv_util "Number of women 25-64 screened with VIA for cervical cancer"
	lab var diab_qual_num "Number of diabetic patients aged 20+  with controlled blood sugar"
	lab var hyper_qual_num "Number of hypertisive patients aged 20+ with controlled blood"
* Institutional mortality 
	lab var newborn_mort_num "Number of institutional newborn deaths"
	lab var totaldel "Total number of deliveries (facility + csections)"
	lab var sb_mort_num "Number of institutional stillbirths"
	lab var mat_mort_num "Number of institutional maternal deaths"
	lab var er_mort_num "Number of emergency department deaths"
	lab var ipd_mort_num "Number of deaths in ICU and inpatient deaths (not ED)"
* Institutional Covid mortality 	
	lab var death_covid "Hospital deaths per month in patients with a positive COVID test"
	lab var hospit_covid "Hospitalized IMSS patient with positive Covid test"
	lab var death_negative "Hospital deaths per month in patients with a negative COVID test"
	lab var hospit_negative "Hospitalized IMSS patient with probable COVID but with negative COVID test "
	lab var death_pending "Hospital deaths per month in patients with a pending COVID test"
	lab var hospit_pending "Hospitalized IMSS patients with pending COVID test "
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="11_20" | month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month num_del HF_tot-population2020

order Delegation year mo 
sort  year mo 
rename mo month

save "$user/$data/Data for analysis/IMSS_Jan19-Sep20_clean.dta", replace


***END***

