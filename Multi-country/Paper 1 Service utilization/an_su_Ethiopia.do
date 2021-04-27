* Level of analysis (facility and regional or regional everywhere?)
* Testing different models for opd_util anc_util del_util
********************************************************************************
* Ethiopia - regional analysis
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

collapse (sum) opd_util anc_util del_util, by (region year month)
encode region, gen(reg)

**************** Tigray is missing 3 last months *******************************
drop if reg==11

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort reg rmonth
gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta",  replace


* Call GEE, export RR to excel
xtset reg rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Ethiopia)  modify
putexcel A1 = "Ethiopia regional GEE"
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
* Ethiopia - facility/woreda
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

**************** Tigray is missing 3 last months *******************************
drop if region=="Tigray"


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

*Linear model
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Ethiopia)  modify
putexcel A9 = "Ethio facility-level GEE - linear model"
putexcel A10 = "Indicator" B10="RR postCovid" C10="LCL" D10="UCL" 

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

* Negative binomial with. power link
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Ethiopia)  modify
putexcel A20 = "Ethio facility-level GEE -  neg binomial w. power link"
putexcel A21 = "Indicator" B21="RR postCovid" C21="LCL" D21="UCL" 

local i = 21

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	* POWER LINK OR LOG LINK???
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
********************************************************************************
* Ethiopia GRAPHS
********************************************************************************
* Deliveries
			u "$user/$ETHdata/Data for analysis/Ethiopiatmp.dta", clear
			 drop if rmonth>15
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
			graphregion(color(white)) title("Deliveries", size(small)) ///
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
			
			graph export "$user/$analysis/Results/Graphs/Nepal_anc_util.pdf", replace
			
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
			graphregion(color(white)) title("Outpatient visits - Oromia", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) 
			
			ylabel(0(1500000)9000000, labsize(vsmall))
			
			graph export "$user/$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
			

rm "$user/$NEPdata/Data for analysis/Nepaltmp.dta"

