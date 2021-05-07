* Master do file: Health system performance during Covid-19 - IMSS
* PI Catherine Arsenault
* Analyst MK Kim
* Updated Jan 8, 2020 
* Mexico - IMSS, formatting dataset for the dashboard

use "$user/$data/Data for analysis/IMSS_Jan19-Dec20complete_WIDE.dta", clear

*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
	set obs 36
	replace Delegation="National" if Deleg==""

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

drop month num_del-population2020

order Delegation year mo 
sort  year mo 
rename mo month

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20_foranalysis.dta", replace

drop if Delegation=="National"

save "$user/$data/Data for analysis/Mexico_su_24months.dta", replace 
********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************
u "$user/$data/Data for analysis/IMSS_Jan19-Dec20_foranalysis.dta", clear

foreach v in cerv_denom2019 cerv_denom2020 breast_denom2019 breast_denom2020 ///
sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util ///
dental_util ipd_util diab_util hyper_util mental_util cerv_util breast_util ///
diab_qual_num hyper_qual_num opv3_qual pneum_qual rota_qual newborn_mort_num ///
sb_mort_num mat_mort_num er_mort_num fp_util anc_util totaldel opd_util ///
pent_qual bcg_qual measles_qual ipd_mort_num death_covid hospit_covid ///
death_negative hospit_negative death_pending hospit_pending {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Delegation=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/IMSS_Jan19-Dec20_foranalysis.dta", replace 


********************************************************************************
* RESHAPE FOR DASHBOARD
********************************************************************************
preserve
	keep if year == 2020
	global varlist cerv_denom2019 cerv_denom2020  breast_denom2019 breast_denom2020 ///
	sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util ///
	dental_util ipd_util diab_util hyper_util mental_util cerv_util diab_qual_num ///
	hyper_qual_num opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num ///
	mat_mort_num er_mort_num fp_util anc_util totaldel opd_util pent_qual bcg_qual ///
	measles_qual ipd_mort_num death_covid hospit_covid death_negative hospit_negative ///
	death_pending hospit_pending breast_util
				   
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year cerv_denom2019 breast_denom2019
	save "$user/$data/temp.dta", replace
restore

keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
}
drop year cerv_denom2020 breast_denom2020
merge m:m  Delegation month using "$user/$data/temp.dta"
drop  _merge 

export delimited using "$user/$data/IMSS_Jan19-Dec20_fordashboard.csv", replace

rm "$user/$data/temp.dta"











	
