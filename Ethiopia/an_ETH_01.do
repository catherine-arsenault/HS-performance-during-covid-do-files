* HS performance during Covid
* Ethiopia 
* Analyses, measuring disruptions in real time
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

* Compare 2020 to 2019
u "$user/$data/Data for analysis/Ethiopia_Jan19-Jun20_clean2.dta", clear

* RMNCH 
by year, sort: tabstat  fp_util  anc_util del_util cs_util pnc_util diarr_util pneum_util ///
						sti_util sam_util if month>=4 & month<= 6, s(N sum) c(s)  format(%20.10f)
* Vaccines
by year, sort: tabstat vacc_qual pent_qual bcg_qual ///
		   measles_qual opv3_qual pneum_qual rota_qual if month>=4 & month<= 6, s(N sum) c(s)
* Other services
by year, sort: tabstat art_util  opd_util ipd_util er_util road_util  if month>=4 & month<= 6, s(N sum) c(s) format(%20.10f)

* Mortality 
by year, sort: tabstat  sb_mort_num newborn_mort_num mat_mort_num totaldel ///
			if month>=4 & month<= 6, s(N sum) c(s) 

by year, sort: tabstat   totalipd_mort ipd_util er_mort_num er_util if ///
month>=4 & month<= 6, s(N sum) c(s) 

* Quality
by year, sort: tabstat kmc_qual resus_qual cs_qual  hivsupp_qual if month>=4 & month<= 6, s(N mean) c(s)
		   
* By region
* Create a total for each category
table region year if month>=4 & month<=6 , c(N opd_util)
table region year if month>=4 & month<=6 , c(sum opd_util)

table region year if month>=4 & month<=6 , c(N del_util)
table region year if month>=4 & month<=6 , c(sum del_util)

