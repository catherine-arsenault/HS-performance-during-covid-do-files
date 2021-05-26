
********************************************************************************
* GHANA (Region level)
********************************************************************************

global GHAall opd_util ipd_util fp_util sti_util anc_util del_util cs_util ///
pnc_util diarr_util pneum_util malnu_util vacc_qual bcg_qual pent_qual ///
measles_qual opv3_qual pneum_qual rota_qual malaria_util tbdetect_qual ///
diab_util hyper_util road_util

use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

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

/* Create % var for graphs
foreach x in opd anc del {
		gen ref_`x' = `x'_util if rmonth==1
		by reg, sort: carryforward ref_`x', replace
		gen `x'_pct = `x'_util*100/ref_`x' 
	} */
	
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace

* Call GEE, export RR to excel
xtset reg rmonth 

putexcel set "$analysis/Results/Prelim results MAY4.xlsx", sheet(Ghana)  modify
putexcel A1 = "GHA region-level GEE"
putexcel A2 = "Indicator" B2="RR postCovid" C2="LCL" D2="UCL" 

local i = 2

foreach var of global GHAall  {
	local i = `i'+1
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	putexcel A`i' = "`var'"
	putexcel B`i'= (_b[rr])
	putexcel C`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel D`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	
	xtgee `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter ///
	, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
	
	margins, at(timeafter= (1 9)) post
	nlcom (_b[2._at]/_b[1._at]), post

}

********************************************************************************
* PREDICTED LEVEL
********************************************************************************
	xtgee opd_util rmonth i.spring i.summer i.fall i.winter if rmonth<16 , ///
	family(gaussian) link(identity) corr(exchangeable) vce(robust)		
	
	predict prd_opd // linear predictions based on preCovid months
	predict stdp_opd, stdp // SEs of the predictions
	collapse (sum) opd prd_opd , by(rmonth)
	
********************************************************************************
* GHANA GRAPHS
********************************************************************************
* Deliveries
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			 drop if rmonth>14 
			 xtset reg rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Ghana", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)80000, labsize(small))
			
			graph export "$analysis/Results/Graphs/GHA_del_util.pdf", replace
* TB case detection
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			 drop if rmonth>15 
			 xtset reg rmonth
			 xtgee tbdetect_qual rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename tbdetect_qual tbdetect_qual_real
			predict tbdetect_qual

			collapse (sum) tbdetect_qual_real tbdetect_qual , by(rmonth)

			twoway (line tbdetect_qual_real rmonth,  sort) (line tbdetect_qual rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("TB case detection in Ghana", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(1000)3000, labsize(small))
			
			graph export "$analysis/Results/Graphs/GHA_tbdetect_qual.pdf", replace

* ANC			
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			 drop if rmonth>15
			 xtset reg rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(150000)450000, labsize(small))
			
			graph export "$analysis/Results/Graphs/GHA_anc_util.pdf", replace
* ANC (scatter)			
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			
			collapse (sum)  anc_util , by(rmonth)
			
			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<15) (lfit anc_util rmonth if rmonth>=15, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100000)450000, labsize(small))
			
			graph export "$analysis/Results/Graphs/GHA_anc_util.pdf", replace			
* OPD		
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			drop if rmonth>15
			xtset reg rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (mean) opd_util_real opd_util , by(rmonth)

			twoway (scatter opd_util_real rmonth, msize(vsmall)  sort) ///
			(line opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util_real rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			ytitle("Average number per region", size(small)) ///
			graphregion(color(white)) title("Ghana", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(25000)200000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_opd_util.pdf", replace
* Diabetes
			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			 drop if rmonth>14 
			 xtset reg rmonth
			 xtgee diab_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			rename diab_util diab_util_real
			predict diab_util

			collapse (sum) diab_util_real diab_util , by(rmonth)

			twoway (line diab_util_real rmonth,  sort) (line diab_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Ghana", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(2000)18000, labsize(small))
			
			graph export "$analysis/Results/Graphs/GHA_diab_util.pdf", replace
			

rm "$user/$GHAdata/Data for analysis/GHAtmp.dta"
