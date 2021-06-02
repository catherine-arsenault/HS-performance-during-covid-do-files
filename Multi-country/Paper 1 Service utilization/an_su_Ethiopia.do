* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
********************************************************************************
* Ethiopia - regression models, at regional level
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

collapse (sum) $ETHall, by (region year month)
encode region, gen(reg)

/* Vars needed for ITS (we expect both a change in level and in slope) 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after pandemic began
	timeafter = slope change during the pandemic 
	Month 14 in Ethiopia is actually Feb9-Mar9 according to western calendar, 
	so pandemic starts month 15 (declared Mar 11, 2020) */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort reg rmonth
gen postCovid = rmonth>14 // pandemic period is months 15-24 
gen timeafter= rmonth-14
replace timeafter=0 if timeafter<0
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
********************************************************************************
* Level change during the pandemic
********************************************************************************
xtset reg rmonth 

putexcel set "$analysis/Results/Tables/Results MAY28.xlsx", sheet(Ethiopia)  modify
putexcel A1 = "Ethiopia Region OLS FE"
putexcel A2 = "Health service" B2="Intercept" C2="RR postCovid" D2="LCL" E2="UCL" 
putexcel F2 ="p-value"
local i = 2

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg) // we will adjust SEs for small number of clusters
	
	putexcel A`i' = "`var'"
	putexcel B`i'=(_b[_cons]) // intercept, 95% CI and p-value?
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	test (_b[rr]) =1 // tests whether calculated ratio is diff. from 1
	
	putexcel c`i'= (_b[rr])
	putexcel d`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel e`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	putexcel f`i'= `r(p)'	 	
}
********************************************************************************
* Resumption at Dec 31, 2020: ratio of predicted
********************************************************************************
putexcel G2="%predicted" H2="LCL" I2="UCL" J2 ="p-value"
local i = 2
foreach var of global ETHall {
	local i = `i'+1
	xtreg `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg)
	
	margins, at(postCovid=(0 1) timeafter=(0 10) rmonth==24) post 
	nlcom (rr: (_b[4._at]/_b[1bn._at])), post
	// nlcom is testing the null hypothesis the the ratio is equal to zero.
	test (_b[rr]) =1 // tests whether calculated ratio is diff. from 1
	
	putexcel g`i'= (_b[rr])
	putexcel h`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel i`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	putexcel j`i'= `r(p)'
}
********************************************************************************
* Ethiopia GRAPHS
********************************************************************************	
* OPD			
			qui xtreg opd_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.spring i.summer i.fall i.winter if rmonth<15, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util  , by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(150000)950000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
			
* Deliveries
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg del_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.spring i.summer i.fall i.winter if rmonth<15, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)20000, labsize(vsmall))
			graph export "$analysis/Results/Graphs/Ethiopia_del_util.pdf", replace
* Cs 		
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg cs_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_cs_util
			qui xtreg cs_util rmonth i.spring i.summer i.fall i.winter if rmonth<15, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_cs_util 
			
			collapse cs_util linear_cs_util season_cs_util  , by(rmonth)

			twoway (scatter cs_util rmonth, msize(vsmall)  sort) ///
			(line linear_cs_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_cs_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit cs_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit cs_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia C-sections", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)1500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_cs_util.pdf", replace
			
rm  "$user/$ETHdata/Data for analysis/ETHtmp.dta"			
	/*lab def rmonth 1"JAN19" 2"FEB19" 3"MAR19" 4"APR19" 5"MAY19" 6"JUN19" ///
			7"JUL19" 8"AUG19" 9"SEP19" 10"OCT19" 11"NOV19" 12"DEC19" 13"JAN20" ///
			14"FEB20" 15"MAR20" 16"APR20" 17"MAY20" 18"JUN20" 19"JUL20" 20"AUG20" ///
			21"SEP20" 22"OCT20" 23"NOV20" 24"DEC20"
			lab val rmonth rmonth */
