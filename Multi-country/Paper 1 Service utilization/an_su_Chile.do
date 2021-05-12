
********************************************************************************
* CHILE (region level )
********************************************************************************

global CHLall anc_util del_util cs_util pnc_util

use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear

collapse (sum)  anc_util del_util cs_util pnc_util, by (region year month )
/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
encode region, gen(reg)	
sort region rmonth
gen postCovid = rmonth>15 // Starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save  "$user/$CHLdata/Data for analysis/CHLtmp.dta", replace

* Call GEE, export RR to excel
xtset reg rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Chile)  modify
putexcel A1 = "CHILE region-level GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global CHLall  {
	local i = `i'+1
	
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
* CHILE (facility level )
********************************************************************************
use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort facid rmonth
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
xtset facid rmonth 

*Linear model
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Chile)  modify
putexcel E1 = "CHILE facility-level GEE linear model"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach var of global CHLall  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	putexcel F`i'= (_b[rr])
	putexcel G`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel H`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

*Poisson with log link
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Chile)  modify
putexcel I1 = "CHILE facility-level GEE poisson w. log link"
putexcel I2 = "Indicator" J2="RR postCovid" K2="LCL" L2="UCL" 

local i = 2

foreach var of global CHLall  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(poisson) link(log) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel I`i' = "`var'"
	putexcel J`i'= (_b[rr])
	putexcel K`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel L`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}


*Negative binomial with power link
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Chile)  modify
putexcel M1 = "CHILE facility-level GEE neg. binomial w. power link"
putexcel M2 = "Indicator" N2="RR postCovid" O2="LCL" P2="UCL" 

local i = 2

foreach var of global CHLall  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel M`i' = "`var'"
	putexcel N`i'= (_b[rr])
	putexcel O`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel P`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

********************************************************************************
* CHILE GRAPHS
********************************************************************************
* Deliveries
			u "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			 drop if rmonth>14 
			 xtset reg rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(2500)15000, labsize(small))
			
			graph export "$analysis/Results/Graphs/CHL_del_util.pdf", replace

* ANC			
			u "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			 drop if rmonth>15
			 xtset reg rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(5000)35000, labsize(small))
			
			graph export "$analysis/Results/Graphs/CHL_anc_util.pdf", replace
			
* ANC (scatter)			
			u "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			collapse (sum) anc_util , by(rmonth)
			
			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<15) (lfit anc_util rmonth if rmonth>=15, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(5000)20000, labsize(small))
			
			graph export "$analysis/Results/Graphs/CHL_anc_util.pdf", replace
			
			
			
			
rm "$user/$CHLdata/Data for analysis/CHLtmp.dta"
