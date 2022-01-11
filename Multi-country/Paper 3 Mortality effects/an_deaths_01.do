* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Descriptive analyses


********************************************************************************
* 1 CHILE (facility)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia outpatient visits (2019-2020)", size(small))  ///
			xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(250000)1000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
********************************************************************************
* 2 ETHIOPIA (facility/woreda)
 u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
	foreach v in newborn_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	gen er_mort_numrate= (er_mort_num/er_util)*1000
	
	qui xtreg ipd_mort_numrate rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_ipd_mort
	qui xtreg ipd_mort_numrate rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_ipd_mort
	collapse (mean) *rate linear season_ipd , by(rmonth)
 
 * Newborn
	twoway (scatter newborn rmonth, msize(vsmall)  sort) ///
	(lfit newborn rmonth if rmonth<16, lcolor(green)) ///
	(lfit newborn rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Newborn deaths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(2)16, labsize(vsmall))
	
	*Stillbirths
	twoway (scatter sb_ rmonth, msize(vsmall)  sort) ///
	(lfit sb_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit sb_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Stillbirths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(4)32, labsize(vsmall))
		
	*Maternal deaths
	twoway (scatter mat_ rmonth, msize(vsmall)  sort) ///
	(lfit mat_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit mat_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Maternal deaths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(0.5)4, labsize(vsmall))

	*Inpatient deaths
	twoway (scatter ipd_ rmonth, msize(vsmall)  sort) ///
	(line linear_ipd rmonth, lpattern(dash) lcolor(green)) ///
	(line season_ipd rmonth , lpattern(vshortdash) lcolor(grey)) ///
	(lfit ipd_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit ipd_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small))  ///
		graphregion(color(white)) title("Inpatient deaths per 1,000 admissions ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall))
		ylabel(0(5)40, labsize(vsmall))
	
	*ER deaths
	twoway (scatter er_ rmonth, msize(vsmall)  sort) ///
	(lfit er_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit er_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small))  ///
		graphregion(color(white)) title("Emergency room deaths per 1,000 admissions ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1)10, labsize(vsmall))
			
		
********************************************************************************
* 3 GHANA (region)
 u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 
	foreach v in newborn_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	
	collapse (mean) *rate , by(rmonth)
	
	* Newborn
	twoway (scatter newborn rmonth, msize(vsmall)  sort) ///
	(lfit newborn rmonth if rmonth<16, lcolor(green)) ///
	(lfit newborn rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Newborn deaths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1)10, labsize(vsmall))
	
	*Stillbirths
	twoway (scatter sb_ rmonth, msize(vsmall)  sort) ///
	(lfit sb_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit sb_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Stillbirths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1)12, labsize(vsmall))
		
	*Maternal deaths
	twoway (scatter mat_ rmonth, msize(vsmall)  sort) ///
	(lfit mat_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit mat_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small)) ///
		graphregion(color(white)) title("Maternal deaths per 1,000 deliveries ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(0.2)2, labsize(vsmall))

	*Inpatient deaths
	twoway (scatter ipd_ rmonth, msize(vsmall)  sort) ///
	(lfit ipd_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit ipd_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small))  ///
		graphregion(color(white)) title("Inpatient deaths per 1,000 admissions ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5)30, labsize(vsmall))
