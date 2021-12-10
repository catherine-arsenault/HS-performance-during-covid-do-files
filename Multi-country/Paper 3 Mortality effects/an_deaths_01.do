* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Descriptive analyses


********************************************************************************
* 1 CHILE (facility)

********************************************************************************
* 2 ETHIOPIA (facility/woreda)
 u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
	foreach v in newborn_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	gen er_mort_numrate= (er_mort_num/er_util)*1000
	
	collapse (mean) *rate , by(rmonth)
 
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
	(lfit ipd_ rmonth if rmonth<16, lcolor(green)) ///
	(lfit ipd_ rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) ytitle("Average per region", size(small))  ///
		graphregion(color(white)) title("Inpatient deaths per 1,000 admissions ", size(small)) ///
		xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5)40, labsize(vsmall))
	
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
