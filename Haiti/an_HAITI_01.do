* HS performance during Covid		
* Analyses: Haiti 																							
clear all 
set more off	

* First Covid case: March 20, 2020
**********************************************************************
* DESCRIPTIVES
**********************************************************************
use "$user/$data/Data for analysis/Haiti_Jan19-Jun20_clean_AN.dta", clear

global rmnch fp_util anc_util del_util cs_util pncm_util pncc_util diarr_util cerv_qual 
global other dental_util opd_util diab_util hyper_util 	
global mort mat_mort_num peri_mort_num totaldel
			   
* Comparing April-June 2020 vs. 2019
by year, sort: tabstat $rmnch if month>=4 & month<= 6, s(N sum) c(s) 
by year, sort: tabstat $other if month>=4 & month<= 6, s(N sum) c(s) 
by year, sort: tabstat $mort if month>=4 & month<= 6, s(N sum) c(s) 


* By region
table orgunitlevel2 year if month>=4 & month<=6 , c(sum opd_util N opd_util)
table orgunitlevel2 year if month>=4 & month<=6 , c(sum totaldel N totaldel)			   
			   

* Counting number of facilities included for each indicator
global all fp_util anc_util totaldel cs_util pncm_util pncc_util diarr_util ///
		   cerv_qual dental_util opd_util diab_util hyper_util mat_mort_num ///
		   peri_mort_num totaldel
 
foreach v of global all {
					   	di "`v'"
					   	table year month , c(N `v')
					   }
