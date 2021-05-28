* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
********************************************************************************
* GHANA (Region level)
********************************************************************************
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
encode region, gen(reg)	
sort region rmonth
gen postCovid = rmonth>15 // pandemic period is months 16-24
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
	
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
********************************************************************************
* Level change during the pandemic
********************************************************************************
xtset reg rmonth 

putexcel set "$analysis/Results/Tables/Results MAY28.xlsx", sheet(Ghana)  modify
putexcel A1 = "Ghana Region OLS FE"
putexcel A2 = "Health service" B2="Intercept" C2="RR postCovid" D2="LCL" E2="UCL" 
putexcel F2 ="p-value"
local i = 2

foreach var of global GHAall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.month, i(reg) fe cluster(reg)
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
foreach var of global GHAall {
	local i = `i'+1
	xtreg `var' i.postCovid rmonth timeafter i.month, ///
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
* GHANA GRAPHS
********************************************************************************
* OPD		
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			drop if rmonth>15
			xtset reg rmonth
			xtreg opd_util rmonth , i(reg) fe cluster(reg)

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse opd_util_real opd_util , by(rmonth)

			twoway (scatter opd_util_real rmonth, msize(vsmall)  sort) ///
			(line opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana Outpatient Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(25000)200000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_opd_util.pdf", replace
* DELIVERIES
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			drop if rmonth>15
			xtset reg rmonth
			xtreg del_util rmonth , i(reg) fe cluster(reg)

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse del_util_real del_util , by(rmonth)

			twoway (scatter del_util_real rmonth, msize(vsmall)  sort) ///
			(line del_util rmonth, lpattern(dash) lcolor(green)) ///
			(lfit del_util_real rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util_real rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1000)5000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_del_util.pdf", replace
			

rm "$user/$GHAdata/Data for analysis/GHAtmp.dta"
