* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Anna Gage, June 2021
********************************************************************************

***Cumulative missed visits


putexcel set "$analysis/Results/Tables/Missed visits graph.xlsx", modify

putexcel set "$analysis/Results/Tables/Missed visits graph.xlsx", sheet("Missed visits") modify


local i=1
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {	
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	local i = `i'+1
	putexcel A`i' = "`c'"
	xtset reg rmonth
	local j=1
	foreach s in fp_util anc_util del_util cs_util pnc_util  diarr_util pneum_util ///
	   malnu_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
	   rota_qual hivtest_qual tbscreen_qual cerv_qual breast_util {

	   local j=`j'+1
	   excelcol `j'
	   local k = "`r(column)'"
	   putexcel `k'1 = "`s'"
	   

	cap qui xtreg `s' postCovid rmonth timeafter i.season resumption if postCovid==0 & resumption==0, i(reg) fe cluster(reg) // linear prediction
		cap predict pre_`s'
	cap qui xtreg `s' postCovid rmonth timeafter i.season resumption if postCovid==1 | resumption==0, i(reg) fe cluster(reg) // linear prediction
		cap predict post_`s'				
			
		gen missed_`s' = .
		cap replace missed_`s' = post_`s'-pre_`s' if postCovid==1 | resumption==1
		qui sum missed_`s'
	
		if `r(sum)'!=0 {
			putexcel `k'`i' = `r(sum)'
			}
		else if `r(sum)'==0 {
			putexcel `k'`i' = ""
		}
		}
		}
  
	   
