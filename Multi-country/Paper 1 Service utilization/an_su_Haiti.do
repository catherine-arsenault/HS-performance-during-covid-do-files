
********************************************************************************
* Haiti (by département)
********************************************************************************
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear

rename orgunitlevel2 departement
collapse (sum) opd_util anc_util del_util, by (departement year month)
encode departement, gen(dpt)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort dpt rmonth
gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$HTIdata/Data for analysis/HTItmp.dta",  replace

* Call GEE, export RR to excel
xtset dpt rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Haiti)  modify
putexcel A1 = "Haiti departement GEE"
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
* Haiti by facility 
********************************************************************************
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort Number rmonth
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
xtset Number rmonth 

*Linear 
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Haiti)  modify
putexcel A7 = "Haiti Facility GEE linear"
putexcel A8 = "Indicator" B8="RR postCovid" C8="LCL" D8="UCL" 

local i = 8

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

*Negative binomial 
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(Haiti)  modify
putexcel A13 = "Haiti Facility GEE Neg. binomial"
putexcel A14 = "Indicator" B14="RR postCovid" C14="LCL" D14="UCL" 

local i = 14

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
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
* Haiti GRAPHS
********************************************************************************
* Deliveries
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>15
			 xtset dpt rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(2000)14000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_del_util.pdf", replace

* ANC			
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>15 
			 xtset dpt rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)80000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_anc_util.pdf", replace
			
* OPD		
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>15
			xtset dpt rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100000)800000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/HTI_opd_util.pdf", replace
			
rm "$user/$HTIdata/Data for analysis/HTItmp.dta"

