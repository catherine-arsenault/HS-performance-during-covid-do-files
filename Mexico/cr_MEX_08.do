* HS performance during Covid
*Jan 8, 2021
* Mexico - IMSS, new cancer indicator

clear all
set more off	

import excel using "$user/$data/Raw/Cancer/CAmama_02_2019[1].xlsx", sheet(Sheet1) firstrow clear
* 2019
rename A Delegation 
replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
* The data is cumulative over the year, need to take the difference each month
replace breast_util12_19= breast_util12_19-breast_util11_19
replace breast_util11_19= breast_util11_19-breast_util10_19
replace breast_util10_19= breast_util10_19-breast_util9_19
replace breast_util9_19=  breast_util9_19- breast_util8_19
replace breast_util8_19=  breast_util8_19- breast_util7_19
replace breast_util7_19=  breast_util7_19- breast_util6_19
replace breast_util6_19=  breast_util6_19- breast_util5_19
replace breast_util5_19=  breast_util5_19- breast_util4_19
replace breast_util4_19=  breast_util4_19- breast_util3_19
replace breast_util3_19=  breast_util3_19- breast_util2_19
replace breast_util2_19=  breast_util2_19- breast_util1_19
drop in 36/65

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta", replace
*2020 (Jan - Oct)
import excel using "$user/$data/Raw/Cancer/CAmama_02_2020[1].xlsx", sheet(Sheet1) firstrow clear
replace Deleg= "D.F. Norte" if Deleg=="CDMX Norte"
replace Deleg = "D.F. Sur" if Deleg=="CDMX Sur"
* The data is cumulative over the year, need to take the difference each month
replace breast_util10_20= breast_util10_20-breast_util9_20
replace breast_util9_20=  breast_util9_20- breast_util8_20
replace breast_util8_20=  breast_util8_20- breast_util7_20
replace breast_util7_20=  breast_util7_20- breast_util6_20
replace breast_util6_20=  breast_util6_20- breast_util5_20
replace breast_util5_20=  breast_util5_20- breast_util4_20
replace breast_util4_20=  breast_util4_20- breast_util3_20
replace breast_util3_20=  breast_util3_20- breast_util2_20
replace breast_util2_20=  breast_util2_20- breast_util1_20
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta"
drop _merge 

********************************************************************************
* MERGE TO DATA FROM PRIOR ROUNDS (Jan19-Oct20)
********************************************************************************
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Sep20v2_WIDE.dta"
drop _merge 

order num_del Delegation HF_tot HF1level HF2level HF3level men2019 women2019 ///
men2020 women2020 population2019 population2020 sti_util6_20-ipd_mort_num12_19 ///
hospit_covid*_20  hospit_pending*_20 hospit_negative*_20 ///
death_covid*_20 death_negative*_20 death_pending*_20 
sort num_del

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_WIDE.dta", replace

set obs 36
replace Delegation="National" if Deleg==""

*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
	reshape long  sti_util  del_util  cs_util  diarr_util  pneum_util  malnu_util ///
	art_util  er_util  ipd_util  dental_util diab_util   hyper_util  mental_util ///
	opv3_qual  pneum_qual  rota_qual  fp_util  anc_util  opd_util  cerv_util  ///
	breast_util  diab_qual_num  hyper_qual_num   pent_qual ///
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
	lab var breast_util "Number of women 50-69 screened for breast cancer (mammography)"
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

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_clean.dta", replace




