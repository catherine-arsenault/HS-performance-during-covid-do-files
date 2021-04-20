* Level of analysis (facility and regional or regional everywhere?)
* Testing different models for opd_util anc_util del_util
********************************************************************************
* Nepal (regional)
********************************************************************************
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
rename orgunitlevel2 Province
collapse (sum) opd_util anc_util del_util, by (Province year month)
encode Province, gen(prov)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort prov rmonth
gen postCovid = rmonth>13 // Starting February

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-13
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$NEPdata/Data for analysis/Nepaltmp.dta",  replace

* Call GEE, export RR to excel
xtset prov rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Nepal)  modify
putexcel A1 = "Nepal regional GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a predictor
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
********************************************************************************
* Nepal (Palika)
********************************************************************************
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort unique_id rmonth
gen postCovid = rmonth>13 // Starting February

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-13
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

gen cases = 0 if rmonth>=1 & rmonth<=12
replace cases = 1 if rmonth==13
replace cases = 1 if rmonth==14
replace cases =  5 if rmonth==15
replace cases =57 if rmonth==16
replace cases = 1572 if rmonth==17
replace cases = 13564 if rmonth==18
replace cases = 19771 if rmonth==19
replace cases = 39460 if rmonth==20
replace cases = 77817 if rmonth==21
replace cases = 170743 if rmonth==22
replace cases = 233452 if rmonth==23
replace cases = 260593 if rmonth==24

* Call GEE, export RR to excel
xtset unique_id rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Nepal)  modify
putexcel A9 = "Nepal Palika GEE"
putexcel A10 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 10

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
********************************************************************************
* Nepal GRAPHS
********************************************************************************
* Deliveries
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>13 
			 xtset prov rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)70000, labsize(small))
			
			graph export "$analysis/Results/Graphs/Nepal_del_util.pdf", replace

* ANC			
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>13 
			 xtset prov rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)70000, labsize(small))
			
			graph export "$analysis/Results/Graphs/Nepal_anc_util.pdf", replace
			
* OPD		
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>13 
			xtset prov rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(250000)2000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Nepal_opd_util.pdf", replace
			

rm "$user/$NEPdata/Data for analysis/Nepaltmp.dta"


