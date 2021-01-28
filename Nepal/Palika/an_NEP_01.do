* HS performance during Covid		
* Analyses: Nepal - Palika level
* Calculating differences in volumes																						
clear all 
set more off	

**********************************************************************
* DESCRIPTIVES
**********************************************************************
u "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_AN.dta", clear 

global rmnch fp_perm_util fp_la_util fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util  sam_util 
global other opd_util ipd_util er_util tbdetect_qual hivdiag_qual 
global vax pent_qual bcg_qual measles_qual opv3_qual pneum_qual 
global mortality sb_mort_num mat_mort_num totaldel ipd_mort_num ipd_util neo_mort_num live_births

* Comparing July-Sep 2020 vs. 2019
by year, sort: tabstat $rmnch  if month>=7 & month<= 9, s(N sum) c(s) 
			   
by year, sort: tabstat  $other if month>=7 & month<= 9, s(N sum) c(s) 

by year, sort: tabstat  $vax if month>=7 & month<= 9, s(N sum) c(s) 

by year, sort: tabstat $mortality  if month>=7 & month<= 9, s(N sum) c(s) 

  
