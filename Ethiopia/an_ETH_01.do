* HS performance during Covid
* Ethiopia 
* Analyses, measuring disruptions in real time
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"
* Hello
* Compare 2020 to 2019
u "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_clean.dta", clear

* RMNCH 
by year, sort: tabstat  fp_util  anc_util del_util cs_util pnc_util diarr_util pneum_util ///
						sti_util sam_util if month>=4 & month<= 6, s(N sum) c(s)  format(%20.10f)
* Vaccines
by year, sort: tabstat vacc_qual pent_qual bcg_qual ///
		   measles_qual opv3_qual pneum_qual rota_qual if month>=4 & month<= 6, s(N sum) c(s)
* Other services
by year, sort: tabstat art_util  opd_util ipd_util er_util road_util  if month>=4 & month<= 6, s(N sum) c(s) format(%20.10f)

* Quality
by year, sort: tabstat kmc_qual resus_qual cs_qual  hivsupp_qual if month>=4 & month<= 6, s(N mean) c(s)

* Mortality 
by year, sort: tabstat newborn_mort sb_mort mat_mort er_mort  ipd_mort ///
				if month>=4 & month<= 6, s(N mean) c(s)
		   
	
*diab_util hyper_util (October 2019 - June 2020)
*diab_qual_num hyper_qual_num

* By region
* Create a total for each category
egen rmnch_total = rowtotal(fp_util  anc_util del_util cs_util pnc_util diarr_util pneum_util ///
						sti_util sam_util ), m
egen vaccines_total= rowtotal(pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual), m
egen other_total = rowtotal(art_util  opd_util ipd_util er_util road_util), m

replace region="SNNP" if region=="Sidama Regional Health Bureau" 
table region year if month>=4 & month<=6 , c(sum rmnch_total) format(%20.0f)
table region year if month>=4 & month<=6 , c(sum vaccines_total)
table region year if month>=4 & month<=6 , c(sum other_total)
table region year if month>=4 & month<=6 , c(sum opd_util)
table region year if month>=4 & month<=6 , c(sum ipd_util)
table region year if month>=4 & month<=6 , c(mean mat_mort)
table region year if month>=4 & month<=6 , c(mean sb_mort)

* Another test
