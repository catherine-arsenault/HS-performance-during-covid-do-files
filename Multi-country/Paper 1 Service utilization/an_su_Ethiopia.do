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
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid 
	Month 14 is actually Feb9-Mar9, so pandemic starts month 15 */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort reg rmonth
gen postCovid = rmonth>14 // Starting April, timing of interruption might change.

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-14
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta",  replace


* GEE models at regional level, linear, exchangeable correlation structure
xtset reg rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(EthiopiaMar)  modify
putexcel A1 = "Ethiopia regional GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global ETHall {
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
* Region level, OLS with FEs
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ethiopia OLS)  modify
putexcel E1 = "Ethiopia Region OLS FE"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg)
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	putexcel F`i'= (_b[rr])
	putexcel G`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel h`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

********************************************************************************
* Ethiopia - OLS at zone level
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

collapse (sum) $ETHall, by (zone year month)
encode zone, gen(zo)

gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort zo rmonth

gen stringent = rmonth>=16 & rmonth<=20 // April to August
gen less_stringent= rmonth>=21 & rmonth <=24 // Sep to Dec

gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2


* Zone level, OLS with FEs
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ethiopia OLS)  modify
putexcel A1 = "Ethiopia Zone OLS FE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global ETHall {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a predictor
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(zo) fe cluster(zo)
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}


********************************************************************************
* Ethiopia - regression models, at lowest level of analysis: facility/woreda
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

/* Vars needed for ITS (we expect both a change in level and in slope) 
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


* GEE models, linear, exchangeable correlation structure
xtset unique_id rmonth 

*Linear model
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ethiopia)  modify
putexcel E1 = "Ethio facility-level GEE - linear model"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach var of global ETHall {
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

* GEE models, negative binomial distribution, power link, exchangeable correlation

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ethiopia)  modify
putexcel I1 = "Ethio facility-level GEE -  neg binomial w. power link"
putexcel I2 = "Indicator" J2="RR postCovid" K2="LCL" L2="UCL" 

local i = 2

foreach var of global ETHall {
	local i = `i'+1
	* POWER LINK OR LOG LINK???
	cap xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	cap margins postCovid, post
	cap nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel I`i' = "`var'"
	cap putexcel J`i'= (_b[rr])
	cap putexcel K`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	cap putexcel L`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}


********************************************************************************
* Ethiopia GRAPHS
********************************************************************************
* Deliveries
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			 drop if rmonth>14
			 xtset reg rmonth
			 xtgee del_util rmonth , family(poisson) ///
				link(identity) corr(exchangeable) vce(robust)

			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(40000)200000, labsize(small))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_del_util.pdf", replace

* ANC			
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			 drop if rmonth>15 
			 xtset reg rmonth
			reg anc_util rmonth, vce(robust)	

			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(40000)140000, labsize(small))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_anc_util.pdf", replace
* ANC(scatter)			
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			
			collapse (sum) anc_util , by(rmonth)
			
			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<15) (lfit anc_util rmonth if rmonth>=15, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(50000)350000, labsize(small))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_anc_util.pdf", replace			
* OPD		
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			 drop if rmonth>15
			xtset reg rmonth
			 reg opd_util rmonth , vce(robust)	

			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(1500000)9000000, labsize(vsmall))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
			

rm "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta"

/* ********************************************************************************
* Region level, OLS with FEs - multiple period
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ethiopia OLS)  modify
putexcel I1 = "Ethiopia Region OLS FE - multiple periods"
putexcel I2 = "Indicator" J2="RR April-August" K2="LCL" L2="UCL" 

local i = 2

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var'  i.stringent i.less_stringent rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg)
	
	margins stringent, post
	nlcom (rr: (_b[1.stringent]/_b[0.stringent])) , post
	putexcel I`i' = "`var'"
	putexcel J`i'= (_b[rr])
	putexcel K`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel L`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	
	xtreg `var'  i.stringent i.less_stringent rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg)
	
	putexcel M2="RR Sept-December" N2="LCL" O2="UCL" 
	margins less_stringent, post
	nlcom (rr: (_b[1.less_stringent]/_b[0.less_stringent])) , post
	putexcel M`i'= (_b[rr])
	putexcel N`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel O`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
