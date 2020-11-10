* HS performance during Covid		
* Analyses: Nepal - Palika level																						
set more off	
*global user "/Users/acatherine/Dropbox (Harvard University)"
global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"

**********************************************************************
* DESCRIPTIVES
**********************************************************************
u "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_clean_AN.dta", clear 
order org*  

* Counting number of palika reporting each indicator
global all fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
 totaldel sam_util opd_util ipd_util er_util tbdetect_qual hivdiag_qual ///
 pent_qual bcg_qual measles_qual opv3_qual pneum_qual  sb_mort_num ///
 mat_mort_num ipd_mort_num peri_mort_num

foreach v of global all {
					   	di "`v'"
					   	table year month , c(N `v')
					   }
					   

* Comparing April-June 2020 vs. 2019
by year, sort: tabstat fp_util anc_util del_util cs_util totaldel ///
					   pnc_util diarr_util pneum_util  sam_util  ///
					   if month>=4 & month<= 6, s(N sum) c(s) 
			   
by year, sort: tabstat  opd_util ipd_util er_util tbdetect_qual hivdiag_qual ///
			   if month>=4 & month<= 6, s(N sum) c(s) 

by year, sort: tabstat pent_qual bcg_qual measles_qual opv3_qual pneum_qual ///
			   if month>=4 & month<= 6, s(N sum) c(s) 

by year, sort: tabstat  sb_mort_num mat_mort_num ipd_mort_num peri_mort_num ///
			   totaldel ipd_util if month>=4 & month<= 6, s(N sum) c(s) 

  
