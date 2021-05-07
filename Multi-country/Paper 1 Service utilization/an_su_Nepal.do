* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* Nepal (regional)
********************************************************************************
global NEPall opd_util er_util ipd_util fp_util anc_util del_util cs_util pnc_util ///
		diarr_util pneum_util bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
		tbdetect_qual hivtest_qual diab_util hyper_util

use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
rename orgunitlevel2 Province

collapse (sum) $NEPall, by (Province year month)
encode Province, gen(prov)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
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

save "$user/$NEPdata/Data for analysis/Nepaltmp.dta",  replace

* Call GEE, export RR to excel
xtset prov rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Nepal)  modify
putexcel A1 = "Nepal regional GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global NEPall  {
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
gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

* Call GEE, export RR to excel
xtset unique_id rmonth 

*Linear 
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Nepal)  modify
putexcel E1 = "Nepal Palika GEE linear"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach  var of global NEPall  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
	cap xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	cap margins postCovid, post
	cap nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	cap putexcel F`i'= (_b[rr])
	cap putexcel G`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	cap putexcel H`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

* Neg binomial, power link
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Nepal)  modify
putexcel i1 = "Nepal Palika GEE neg binomial"
putexcel i2 = "Indicator" j2="RR postCovid" k2="LCL" l2="UCL" 

local i = 2

foreach  var of global NEPall  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel i`i' = "`var'"
	putexcel j`i'= (_b[rr])
	putexcel k`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel l`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}



/********************************************************************************
* Nepal GRAPHS
********************************************************************************
* Deliveries
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>15
			 xtset prov rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)70000, labsize(small))
			
			graph export "$analysis/Results/Graphs/Nepal_del_util.pdf", replace

* ANC			
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>15 
			 xtset prov rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)70000, labsize(small))
			
			graph export "$analysis/Results/Graphs/Nepal_anc_util.pdf", replace
			
* OPD		
			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			 drop if rmonth>15
			xtset prov rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$NEPdata/Data for analysis/Nepaltmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(250000)2000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Nepal_opd_util.pdf", replace
			

rm "$user/$NEPdata/Data for analysis/Nepaltmp.dta"


