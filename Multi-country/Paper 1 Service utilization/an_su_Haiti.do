
********************************************************************************
* Haiti (by département)
********************************************************************************

global HTIall opd_util fp_util anc_util del_util pnc_util vacc_qual diab_util ///
				hyper_util cerv_qual

use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear

rename orgunitlevel2 departement
collapse (sum) $HTIall, by (departement year month)
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

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Haiti)  modify
putexcel A1 = "Departement-level GEE linear"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global HTIall  {
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
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Haiti)  modify
putexcel E1 = "Facility GEE linear"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach var of global HTIall  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	putexcel F`i'= (_b[rr])
	putexcel G`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel H`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

*Negative binomial 
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Haiti)  modify
putexcel I1 = "Facility GEE Neg. binomial"
putexcel I2 = "Indicator" J2="RR postCovid" K2="LCL" L2="UCL" 

local i = 2

foreach var of global HTIall  {
	local i = `i'+1
	* Regression coefficients represent the expected change in the log of the 
	* mean of the dependent variable for each change in a covariate
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel I`i' = "`var'"
	putexcel J`i'= (_b[rr])
	putexcel K`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel L`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}



********************************************************************************
* Haiti GRAPHS
********************************************************************************
* Deliveries
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			 xtset dpt rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
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
* ANC	(scatter)		
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			
			collapse (sum) anc_util , by(rmonth)
			
			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<15) (lfit anc_util rmonth if rmonth>=15, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)80000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_anc_util.pdf", replace
						
* OPD		
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			xtset dpt rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100000)800000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/HTI_opd_util.pdf", replace
* Diabetes
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			 xtset dpt rmonth
			 xtgee diab_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename diab_util diab_util_real
			predict diab_util

			collapse (sum) diab_util_real diab_util , by(rmonth)

			twoway (line diab_util_real rmonth,  sort) (line diab_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(1000)7000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_diab_util.pdf", replace	
		
rm "$user/$HTIdata/Data for analysis/HTItmp.dta"


