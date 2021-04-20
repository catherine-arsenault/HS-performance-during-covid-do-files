
********************************************************************************
* Lao (regional)
********************************************************************************
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta",  clear
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
gen postCovid = rmonth>15 // Starting April 

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$LAOdata/Data for analysis/LAOtmp.dta",  replace

* Call GEE, export RR to excel
xtset prov rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Lao)  modify
putexcel A1 = "LAO regional GEE"
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
* Lao (facility)
********************************************************************************
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta",  clear
egen unique_id = concat(orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname)
encode unique_id, gen(id)
/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort id rmonth
gen postCovid = rmonth>15 // Starting April 

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$LAOdata/Data for analysis/LAOtmp.dta",  replace

* Call GEE, export RR to excel
xtset id rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Lao)  modify
putexcel A9 = "LAO regional GEE"
putexcel A10 = "Indicator" B10="RR postCovid" C10="LCL" D10="UCL" 

local i = 10

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
