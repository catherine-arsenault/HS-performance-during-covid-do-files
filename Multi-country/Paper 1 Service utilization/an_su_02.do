* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Anna Gage, June 2021
********************************************************************************

***Cumulative missed visits

*putexcel set "$analysis/Results/Tables/Missed visits graph.xlsx", modify
*putexcel set "$analysis/Results/Tables/Missed visits graph.xlsx", sheet("Missed visits") modify

foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {	
	
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	
	foreach s in fp_util pnc_util bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///   
	   rota_qual hivtest_qual tbscreen_qual diab_util hyper_util cerv_qual breast_util mental_util {


	cap qui xtreg `s' rmonth i.season if postCovid==0 & resumption==0, i(reg) fe cluster(reg) // linear prediction
		//postCovid, timeafter and resumption drop out of the pre-period regression
		cap predict pre_`s'
		cap predict pre_`s'_sd, stdp
	cap qui xtreg `s' rmonth i.season if postCovid==1 | resumption==1, i(reg) fe cluster(reg) // linear prediction
		//Treats the post-covid and resumption periods as a single period (no timeafter or resumption)
		cap predict post_`s'
			
		gen missed_`s' = .
		replace missed_`s' = round(post_`s'-pre_`s') if (postCovid==1 | resumption==1) //Full covid period: postCovid and resumption period
		replace missed_`s'=. if missed_`s'==0
			
		gen se2_`s' = pre_`s'_sd^2
			replace se2_`s' = . if missed_`s'==.
		}
		cap collapse (sum) missed_* se2_*
	
	foreach s in fp_util pnc_util bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///   
	   rota_qual hivtest_qual tbscreen_qual diab_util hyper_util cerv_qual breast_util mental_util {	
		gen lcl`s'=.
		gen ucl`s'=.
		replace lcl`s' = round(missed_`s'-(invnormal(1-.05/2)*sqrt(se2_`s')))
		replace ucl`s' = round(missed_`s'+(invnormal(1-.05/2)*sqrt(se2_`s')))
		egen ci_`s' = concat(lcl`s' ucl`s'), punct(,) 
		
		rename missed_`s' `s'
		drop se2_`s' lcl`s' ucl`s'
		order ci_`s', after(`s')
		}
		
		gen country = "`c'"
		order country, first
		save "$user/$`c'data/Data for analysis/`c'tmp_missed.dta", replace

		}
		
 use "$user/$CHLdata/Data for analysis/CHLtmp_missed.dta", clear
 
 foreach c in ETH GHA HTI KZN LAO MEX NEP KOR THA {	
 append using "$user/$`c'data/Data for analysis/`c'tmp_missed.dta"
 }
 
 export excel "$analysis/Results/Tables/Missed visits graphSEP2.xlsx", sheet("Missed visits") sheetreplace firstrow(var) 
	   
	   
