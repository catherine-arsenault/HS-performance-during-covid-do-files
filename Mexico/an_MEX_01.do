* HS performance during Covid
* November 9th 2020 
* Mexico - IMSS, January 2019 - February 2020


u "$user/$data/Data for analysis/IMSS_Jan19-Oct20c_clean.dta", clear

keep if Deleg=="National"
**********************************************************************
* DESCRIPTIVES
**********************************************************************

*combine cerv_denom into 1 variable 
gen cerv_denom = cerv_denom2019 if year==2019
replace cerv_denom = cerv_denom2020 if year==2020
drop cerv_denom2019 cerv_denom2020 

global rmnch  fp_util anc_util sti_util del_util cs_util diarr_util pneum_util malnu_util  
global vax  pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual
global other  opd_util diab_util hyper_util art_util er_util ipd_util dental_util mental_util
global quality cs_util totaldel cerv_util cerv_denom diab_qual_num diab_util hyper_qual_num hyper_util
global mortality 

* death_covid hospit_covid death_negative hospit_negative death_pending hospit_pending 

* NATIONAL
by year, sort: tabstat $rmnch if month>=3 & month<=8 , s(N sum) c(s) format(%20.0f)
by year, sort: tabstat $vax if month>=3 & month<=8 , s(N sum) c(s) format(%20.0f)
by year, sort: tabstat $other if month>=3 & month<=8 , s(N sum) c(s) format(%20.0f)
by year, sort: tabstat $quality if month>=3 & month<=8 , s(N sum) c(s) format(%20.0f)
by year, sort: tabstat newborn_mort_num sb_mort_num totaldel if month>=3 & month<=6 , s(N sum) c(s)  format(%20.0f)
by year, sort: tabstat mat_mort_num sb_mort_num newborn_mort_num totaldel er_mort_num er_util ipd_mort_num ipd_util if month>=3 & month<=8 , s(N sum) c(s)  format(%20.0f)


* BY DELEGATION 
* Create a total for each category
u "$user/$data/Data for analysis/IMSS_Jan19-Oct20_clean.dta", clear
keep if Deleg !="National"

table Deleg year if month>=3 & month<=8, c (sum totaldel )
table Deleg year if month>=3 & month<=8, c (sum opd_util )

egen rmnch_total = rowtotal(fp_util	anc_util sti_util del_util cs_util	diarr_util	pneum_util	malnu_util ), m 
egen other_total = rowtotal(opd_util diab_util hyper_util art_util er_util ipd_util dental_util mental_util ), m
egen vacc_total = rowtotal(pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ), m


table Delega year if month>=3 & month<=8 , c(sum rmnch_total)
table Delega year if month>=3 & month<=8, c(sum other_total)
table Delega year if month>=3 & month<=8, c(sum vacc_total) 


table year month, c( sum cs_util sum totaldel)
/*********************************************************************
*   GRAPHS
**********************************************************************

collapse (sum) *util  pent_qual measles_qual bcg_qual opv3_qual pneum_qual rota_qual (mean) cs_qual hyper_qual cerv_qual diab_qual newborn_mort sb_mort mat_mort er_mort ipd_mort, by(year month)

	foreach var of varlist _all {
		replace `var'= . if `var'==0
	}
	gen time= _n
	order year month time
	lab def time 1 "Jan 19" 2  "Feb 19" 3  "Mar 19" 4  "Apr 19" 5  "May 19" 6 "Jun 19" 7  "Jul 19" 8  "Aug 19" 9 "Sep 19" 10 "Oct 19" 11  "Nov 19"12  "Dec 19" 13  "Jan 20" 14 "Feb 20" 15 "Mar 20" 16 "Apr 20" 17  "May 20"
	lab val time time
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
	lab var cs_qual "Caesarean section rate"
	lab var cerv_qual "% women 25-64 screened with VIA for cervical cancer"
	lab var diab_qual "% diabetic patients with controlled blood sugar"
	lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
* Institutional mortality 
	lab var newborn_mort "Institutional newborn mortality %"
	lab var sb_mort "Institutional stillbirth rate %"
	lab var mat_mort "Institutional maternal mortality rate %"
	lab var er_mort "Emergency room mortality  %"
	lab var ipd_mort "ICU and inpatient deaths (not ED) / inpatient admissions  %"
	

* Delivery
twoway (line del_ cs_util time ), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
* Csect rate
twoway (line cs_qual time ),  ylabel(0(0.1)0.8) xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white))  
* Quality 
twoway (line cs_qual cerv_qual diab_qual hyper_qual time ), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
* Vaccines
twoway (line bcg_qual  pent_qual measles_qual opv3_qual pneum_qual rota_qual time), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 

* Mortality
twoway (line newborn_mort sb_mort mat_mort er_mort ipd_mort time), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 


foreach v in  fp_ anc_ del_ cs_ {
	twoway (line `v' time), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
	graph export "$user/HMIS Data for Health System Performance Covid (Mexico)/Graphs/`v'.pdf", replace
}
