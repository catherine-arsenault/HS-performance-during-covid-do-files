* HS performance during Covid		
* Analyses: Haiti 																							
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"

* First Covid case: March 20, 2020
**********************************************************************
* DESCRIPTIVES
**********************************************************************
u "$user/$data/Data for analysis/Haiti_Jan19-Jun20_clean2.dta", clear 

* Counting number of facilities included for each indicator
global all fp_util anc_util totaldel cs_util pncm_util pncc_util diarr_util ///
		   cerv_qual dental_util opd_util diab_util hyper_util mat_mort_num ///
		   peri_mort_num totaldel
 
foreach v of global all {
					   	di "`v'"
					   	table year month , c(N `v')
					   }
					   
* Comparing April-June 2020 vs. 2019
by year, sort: tabstat fp_util anc_util totaldel cs_util pncm_util pncc_util  ///
					   diarr_util cerv_qual  if month>=4 & month<= 6, s(N sum) c(s) 
			   
by year, sort: tabstat dental_util opd_util diab_util hyper_util ///
			   if month>=4 & month<= 6, s(N sum) c(s) 

by year, sort: tabstat mat_mort_num peri_mort_num totaldel ///
			   if month>=4 & month<= 6, s(N sum) c(s) 

* By region
table orgunitlevel2 year if month>=4 & month<=6 , c(sum opd_util)
table orgunitlevel2 year if month>=4 & month<=6 , c(sum totaldel N totaldel)			   
			   
