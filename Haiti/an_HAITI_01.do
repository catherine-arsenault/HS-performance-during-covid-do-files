* HS performance during Covid																									
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"

* First Covid case: March 20, 2020
**********************************************************************
* DESCRIPTIVES
**********************************************************************
u "$user/$data/Data for analysis/Haiti_Jan19-Jun20_clean.dta", clear 
*fp_util anc_util totaldel cs_util pncm_util pncc_util  diarr_util cerv_qual 

* dental_util opd_util diab_util hyper_util 

* mat_mort_num peri_mort_num 


by year, sort: tabstat fp_util anc_util totaldel cs_util pncm_util pncc_util  ///
					   diarr_util cerv_qual  if month>=4 & month<= 6, s(N sum) c(s) 
			   
by year, sort: tabstat dental_util opd_util diab_util hyper_util ///
			   if month>=4 & month<= 6, s(N sum) c(s) 

by year, sort: tabstat mat_mort_num peri_mort_num totaldel ///
			   if month>=4 & month<= 6, s(N sum) c(s) 


/* * Calculating number of facilities for each indicator
u  "$user/$data/Data for analysis/Haiti_Jan19-Jun20_WIDE.dta", clear 
global all  anc_util cs_util del_util diab_util diarr_util fp_util hyper_util live_birth malnu_util opd_util road_util tbdetect_qual cs_qual sb_mort mat_mort 

foreach x of global all {
	forval i=1/12 {
		egen nb`x'`i'_19 = count(`x'`i'_19) 
	}
	forval i=1/6 { // ends at june for now
		egen nb`x'`i'_20 = count(`x'`i'_20) 
	}
	egen maxfac`x' = rowmax (nb`x'*)
}
drop nb*
tabstat max* , s(min) c(s)


collapse (sum) *util (count) N_anc_util=anc_util N_cs_util=cs_util N_del_util=del_util (mean) cs_qual *mort, by(year month)
* N_diab_util= N_diarr_util= N_fp_util= N_hyper_util= N_malnu_util= N_opd_util= N_road_util= N_mat_mort= N_sb_mort= N_cs_qual= 
sort year month
gen time= _n
order year month time
	lab def time 1 "Jan 19" 2  "Feb 19" 3  "Mar 19" 4  "Apr 19" 5  "May 19" 6 "Jun 19" 7  "Jul 19" 8  "Aug 19" 9 "Sep 19" 10 "Oct 19" 11  "Nov 19"12  "Dec 19" 13  "Jan 20" 14 "Feb 20" 15 "Mar 20" 16 "Apr 20" 17  "May 20" 18  "Jun 20"
	lab val time time
	
* ANC
twoway (line anc_uti time ), xlabel(#18,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
	
* Delivery
twoway (line del_ time ), xlabel(#18,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
* Csect rate
twoway (line cs_qual time ),  ylabel(0(0.1)0.8) xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white))  
* Quality 
twoway (line cs_qual cerv_qual diab_qual hyper_qual time ), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 
* Vaccines
twoway (line bcg_qual  pent_qual measles_qual opv3_qual pneum_qual rota_qual time), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 

* Mortality
twoway (line newborn_mort sb_mort mat_mort er_mort ipd_mort time), xlabel(#17,  labsize(vsmall) valuelabel grid glwidth(thin) glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) 

