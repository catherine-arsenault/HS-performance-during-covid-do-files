* HS performance during Covid
* Oct 7, 2020 
* Mexico - IMSS, Edits to data from March-June 2020 (Sent by Svetlana Sept 11)

clear all
set more off	
*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
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

* BCG #
egen bcg_qual5_20 =rowtotal (Indic27_BCG*May20 ndic27_BCG*May20 ) , m
egen bcg_qual6_20 =rowtotal (Indic27_BCG*Jun20 ) , m
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
set obs 36 
replace Delegation = "National" if Delegation==""
merge 1:1 Delegation using  "$user/$data/Data for analysis/IMSS_Jan19-May20_WIDE.dta"
drop _merge

********************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
	reshape long  sti_util  del_util  cs_util  diarr_util  pneum_util  malnu_util ///
	art_util  er_util  ipd_util  dental_util diab_util   hyper_util  mental_util ///
	opv3_qual  pneum_qual  rota_qual  fp_util  anc_util  opd_util  cerv_util  ///
	diab_qual_num diab_qual_denom hyper_qual_num hyper_qual_denom  pent_qual ///
	bcg_qual  measles_qual newborn_mort_num  sb_mort_num mat_mort_num  er_mort_num ///
	ipd_mort_num death_covid  hospit_covid death_negative hospit_negative ///
	death_pending hospit_pending totaldel  , i(num_del) j(month) string
	
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
	lab var diab_util "Number of diabetic patients visits PC clinics"
	lab var hyper_util "Number of hypertensive patients visits PC clinics"
	lab var art_util "Number of adult and children on ART "
	lab var mental_util "Number consultations for attempted suicides"
	lab var opd_util  "Nb outpatient (family medicine clinic  & opd specialty) visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
* Quality 
	lab var cerv_util "Number of women 25-64 screened with VIA for cervical cancer"
	lab var diab_qual_num "Number of diabetic patients aged 20+  with controlled blood sugar"
	lab var diab_qual_denom "Number of diabetic patients aged 20+  visited primary care clinics"
	lab var hyper_qual_num "Number of hypertisive patients aged 20+ with controlled blood"
	lab var hyper_qual_denom "Number of hypertisive patients aged 20+ visited primary care clinics"
	*lab var cerv_qual "% women 25-64 screened with VIA for cervical cancer"
	*lab var diab_qual "% diabetic patients aged 20+  with controlled blood sugar"
	*lab var hyper_qual "% hypertisive patients aged 20+ with controlled blood pressure" 
	*lab var cs_qual "Caesarean section rate"
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

********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************
foreach v in cerv_denom2019 cerv_denom2020 diab_qual_denom hyper_qual_denom sti_util ///
del_util cs_util diarr_util pneum_util malnu_util art_util er_util dental_util ///
ipd_util diab_util hyper_util mental_util cerv_util diab_qual_num hyper_qual_num /// 
opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num mat_mort_num er_mort_num /// 
fp_util anc_util totaldel opd_util pent_qual bcg_qual measles_qual ipd_mort_num ///
death_covid hospit_covid death_negative hospit_negative death_pending hospit_pending {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Delegation=="National"
	drop `v'tot
}
save "$user/$data/Data for analysis/IMSS_Jan19-Jun20_clean.dta", replace

********************************************************************************
* RESHAPE FOR DASHBOARD
********************************************************************************
preserve
	keep if year == 2020
	global varlist cerv_denom2019 cerv_denom2020 diab_qual_denom hyper_qual_denom ///
	sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util ///
	dental_util ipd_util diab_util hyper_util mental_util cerv_util diab_qual_num ///
	hyper_qual_num opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num ///
	mat_mort_num er_mort_num fp_util anc_util totaldel opd_util pent_qual bcg_qual ///
	measles_qual ipd_mort_num death_covid hospit_covid death_negative hospit_negative ///
	death_pending hospit_pending
				   
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year cerv_denom2019
	save "$user/$data/temp.dta", replace
restore

keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
}
drop year cerv_denom2020
merge m:m  Delegation month using "$user/$data/temp.dta"
drop  _merge 

export delimited using "$user/$data/IMSS_Jan19-May20_fordashboard.csv", replace

rm "$user/$data/temp.dta"











