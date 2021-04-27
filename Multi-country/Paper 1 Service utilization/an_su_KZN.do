* Level of analysis (facility and regional or regional everywhere?)
* Testing different models for opd_util anc_util del_util
********************************************************************************
* KZN (district)
********************************************************************************
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear

collapse (sum) opd_util anc_util del_util, by (dist year month rmonth)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
sort dist rmonth
gen postCovid = rmonth>15 // PostCovid starting April

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0

* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

save "$user/$KZNdata/Data for analysis/KZNtmp.dta",  replace

* Call GEE, export RR to excel
xtset dist rmonth 

putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(KZN)  modify
putexcel A1 = "KZN district-level GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var in opd_util anc_util del_util  {
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
* KZN facility level 
********************************************************************************
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
egen unique_id = concat(dist subdist Facility)
encode unique_id, gen(id)
/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
sort id rmonth
gen postCovid = rmonth>14 // Starting March

* Number of months since Covid / lockdowns 
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0
* Seasons
gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

* Call GEE, export RR to excel
xtset id rmonth 

* Linear model
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(KZN)  modify
putexcel A7 = "KZN facility-level GEE linear"
putexcel A8 = "Indicator" B8="RR postCovid" C8="LCL" D8="UCL" 

local i = 8

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
* Poisson with log link
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(KZN)  modify
putexcel A13 = "KZN facility-level GEE poisson w. log link"
putexcel A14 = "Indicator" B14="RR postCovid" C14="LCL" D14="UCL" 

local i = 14

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(poisson) link(log) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
* Negative binomial with. power link
putexcel set "$analysis/Results/Prelim results APR28.xlsx", sheet(KZN)  modify
putexcel A20 = "KZN facility-level GEE neg binomia w. power link"
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
* KZN GRAPHS
********************************************************************************
* Deliveries
			u "$user/$KZNdata/Data for analysis/KZNtmp.dta", clear
			
			collapse (sum)  del_util , by(rmonth)

			twoway (scatter del_util rmonth,  sort msize(small)) (lfit del_util rmonth if rmonth<16) ///
			(lfit del_util rmonth if rmonth>=16, lcolor(green)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(2500)15000, labsize(small))
			
			graph export "$analysis/Results/Graphs/KZN_del_util.pdf", replace

* ANC			
			u "$user/$KZNdata/Data for analysis/KZNtmp.dta", clear
		
			collapse (sum) anc_util , by(rmonth)

			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<16) (lfit anc_util rmonth if rmonth>=16, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(5000)30000, labsize(small))
			
			graph export "$analysis/Results/Graphs/KZN_anc_util.pdf", replace
			
* OPD		
			u "$user/$KZNdata/Data for analysis/KZNtmp.dta", clear
			 drop if rmonth>15
			xtset dist rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$KZNdata/Data for analysis/KZNtmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(50000)500000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KZN_opd_util.pdf", replace
			

rm "$user/$KZNdata/Data for analysis/KZNtmp.dta"
