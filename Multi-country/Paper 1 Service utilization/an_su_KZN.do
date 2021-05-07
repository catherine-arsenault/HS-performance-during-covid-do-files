* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* KwaZulu-Natal - regression models, at district level
********************************************************************************

global KZNall opd_util ipd_util anc_util del_util cs_util kmc_qual pnc_util ///
		diarr_util pneum_util malnu_util vacc_qual bcg_qual pent_qual measles_qual ///
		pneum_qual rota_qual tbscreen_qual tbdetect_qual art_util diab_util ///
		road_util cerv_qual

use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear

collapse (sum) $KZNall, by (dist year month rmonth)

/* Vars needed for ITS (we expect both a change in level and in slope): 
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

* GEE models at district level, linear distribution, exchangeable correlation structure
xtset dist rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(KZN)  modify
putexcel A1 = "KZN district-level GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global KZNall {
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
* KwaZulu-Natal - regression models, at lowest level of analysis: facilities
********************************************************************************

use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear

egen unique_id = concat(dist subdist Facility)
encode unique_id, gen(id)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
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

* GEE models at facility level, linear distribution, exchangeable corr structure
xtset id rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(KZN)  modify
putexcel E1 = "KZN facility-level GEE linear"
putexcel E2 = "Indicator" F2="RR postCovid" G2="LCL" H2="UCL" 

local i = 2

foreach var of global KZNall  {
	local i = `i'+1
	
	cap xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	cap margins postCovid, post
	cap nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	cap putexcel F`i'= (_b[rr])
	cap putexcel G`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	cap putexcel H`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}
* GEE models at facility level, poisson distribution, log link, exchangeable corr structure
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(KZN)  modify
putexcel  I1 = "KZN facility-level GEE poisson w. log link"
putexcel I2 = "Indicator" J2="RR postCovid" K2="LCL" L2="UCL" 

local i = 2

foreach var in opd_util anc_util del_util  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(poisson) link(log) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel E`i' = "`var'"
	putexcel J`i'= (_b[rr])
	putexcel K`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel L`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}

* GEE models at facility level, negative binomial distribution, power link, exchangeable corr structure
putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(KZN)  modify
putexcel M1 = "KZN facility-level GEE neg binomia w. power link"
putexcel M2 = "Indicator" N2="RR postCovid" O2="LCL" P2="UCL" 

local i = 2

foreach var of global KZNall  {
	local i = `i'+1
	* POWER LINK OR LOG LINK?
	cap xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	family(nbinomial) link(power) corr(exchangeable) vce(robust)	
	
	cap margins postCovid, post
	cap nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel M`i' = "`var'"
	cap putexcel N`i'= (_b[rr])
	cap putexcel O`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	cap putexcel P`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
}



/********************************************************************************
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
