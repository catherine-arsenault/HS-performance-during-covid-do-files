
* OPD			
			u "$user/$THAdata/Data for analysis/THAtmp2.dta", clear
			qui xtreg opd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(scatter opd_util rmonth if rmonth>24, msize(vsmall) mcolor(orange)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Thailand outpatient visits (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(50000)450000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/THA_opd_util.pdf", replace
			
* IPD			
			u "$user/$THAdata/Data for analysis/THAtmp2.dta", clear
			qui xtreg ipd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util 
			
			collapse ipd_util linear_ipd_util season_ipd_util, by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(scatter ipd_util rmonth if rmonth>24, msize(vsmall) mcolor(orange)  sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit ipd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  /// 
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Thailand inpatient admissions (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(2000)14000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/THA_ipd_util.pdf", replace

* Deliveries			
			u "$user/$THAdata/Data for analysis/THAtmp2.dta", clear
			qui xtreg del_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util, by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(scatter del_util rmonth if rmonth>24, msize(vsmall) mcolor(orange)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit del_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xline(21, lpattern(dash) lcolor(gs10))  xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Thailand facility based deliveries (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(50)500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/THA_del_util.pdf", replace			

* Diabetes
			u  "$user/$THAdata/Data for analysis/THAtmp2.dta", clear 
			qui xtreg diab_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_diab_util
			qui xtreg diab_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_diab_util
			
			collapse diab_util linear_diab_util season_diab_util, by(rmonth)

			twoway (scatter diab_util rmonth, msize(vsmall)  sort) ///
			(scatter diab_util rmonth if rmonth>24, msize(vsmall) mcolor(orange)  sort) ///
			(line linear_diab_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_diab_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit diab_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit diab_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit diab_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Thailand diabetes visits (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(100)800, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/THA_diab_util.pdf", replace
