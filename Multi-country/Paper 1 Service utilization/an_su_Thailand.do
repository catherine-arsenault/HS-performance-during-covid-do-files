
********************************************************************************
* Thailand (Province level)
********************************************************************************
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
encode Province, gen(prov)	
sort prov rmonth
gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save  "$user/$THAdata/Data for analysis/THAtmp.dta", replace

* Call GEE, export RR to excel
xtset prov rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Thailand)  modify
putexcel A1 = "THA province-level GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var in opd_util totaldel  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

********************************************************************************
* THAILAND GRAPHS
********************************************************************************


* ANC			
			u "$user/$THAdata/Data for analysis/THAtmp.dta", clear
			 drop if rmonth>15
			 xtset prov rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$THAdata/Data for analysis/THAtmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)
			drop if rmonth< 10
			
			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(5000)30000, labsize(small))
			
			graph export "$analysis/Results/Graphs/THA_anc_util.pdf", replace
			
* OPD		
			u "$user/$THAdata/Data for analysis/THAtmp.dta", clear
			 drop if rmonth>15
			xtset prov rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$THAdata/Data for analysis/THAtmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(5000000(5000000)35000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/THA_opd_util.pdf", replace
* Deliveries		
			u "$user/$THAdata/Data for analysis/THAtmp.dta", clear
			
			collapse (sum) totaldel , by(rmonth)
			rename totaldel del_util
			twoway (scatter del_util rmonth,  sort msize(small)) (lfit del_util rmonth if rmonth<16) ///
			(lfit del_util rmonth if rmonth>=16, lcolor(green)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(6000)32000, labsize(small))
			
			graph export "$analysis/Results/Graphs/THA_opd_util.pdf", replace
						

rm "$user/$THAdata/Data for analysis/THAtmp.dta"
