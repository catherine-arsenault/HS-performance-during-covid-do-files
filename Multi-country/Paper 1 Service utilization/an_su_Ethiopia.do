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

save "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta",  replace
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
	xtreg `var'  i.postCovid rmonth timeafter i.month, ///
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
* Ethiopia GRAPHS
********************************************************************************
		
* OPD		
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			drop if rmonth>14
			xtset reg rmonth
			xtreg opd_util rmonth , i(reg) fe cluster(reg)

			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse opd_util_real opd_util , by(rmonth)
			/*lab def rmonth 1"JAN19" 2"FEB19" 3"MAR19" 4"APR19" 5"MAY19" 6"JUN19" ///
			7"JUL19" 8"AUG19" 9"SEP19" 10"OCT19" 11"NOV19" 12"DEC19" 13"JAN20" ///
			14"FEB20" 15"MAR20" 16"APR20" 17"MAY20" 18"JUN20" 19"JUL20" 20"AUG20" ///
			21"SEP20" 22"OCT20" 23"NOV20" 24"DEC20"
			lab val rmonth rmonth */
			
			twoway (scatter opd_util_real rmonth, msize(vsmall)  sort) ///
			(line opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth<15, lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ethiopia Outpatient Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(100000)1000000, labsize(vsmall))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
			
* Deliveries
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			 drop if rmonth>14
			 xtset reg rmonth
			 xtreg del_util rmonth , i(reg) fe cluster(reg)

			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse del_util_real del_util , by(rmonth)

			twoway (scatter del_util_real rmonth, msize(vsmall)  sort) ///
			(line del_util rmonth, lpattern(dash) lcolor(green)) ///
			(lfit del_util_real rmonth if rmonth<15, lcolor(green)) ///
			(lfit del_util_real rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(small)) ///
			graphregion(color(white)) title("Ethiopia Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)20000, labsize(vsmall))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_del_util.pdf", replace

rm "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta"a
