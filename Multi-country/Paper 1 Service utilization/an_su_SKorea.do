* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* South Korea (regional level)
********************************************************************************
u "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", clear 

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
encode region, gen(reg)
sort reg rmonth
gen postCovid = rmonth>15 // pandemic period is months 16-24
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save  "$user/$KORdata/Data for analysis/KORtmp.dta", replace

********************************************************************************
* Level change during the pandemic
********************************************************************************
xtset reg rmonth 

putexcel set "$analysis/Results/Tables/Results MAY28.xlsx", sheet(SKorea)  modify
putexcel A1 = "S Korea Region OLS FE"
putexcel A2 = "Health service" B2="Intercept" C2="RR postCovid" D2="LCL" E2="UCL" 
putexcel F2 ="p-value"
local i = 2

foreach var of global KORall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg)
	// we will adjust SEs for small number of clusters
	
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
foreach var of global KORall {
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
* KOREA GRAPHS
********************************************************************************
* Deliveries
			qui xtreg del_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.spring i.summer i.fall i.winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per delegation", size(vsmall)) ///
			graphregion(color(white)) title("South Korea deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100)900, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_del_util.pdf", replace
* OPD		
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			qui xtreg opd_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.spring i.summer i.fall i.winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util  , by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per delegation", size(vsmall)) ///
			graphregion(color(white)) title("South Korea outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(500000)4000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KOR_opd_util.pdf", replace
			
/* * ANC			
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			 drop if rmonth>15
			 xtset reg rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(75000)400000, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_anc_util.pdf", replace
			*/
rm "$user/$KORdata/Data for analysis/KORtmp.dta"
