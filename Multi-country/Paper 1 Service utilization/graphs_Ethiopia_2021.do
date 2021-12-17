

* OPD			
			u "$user/$ETHdata/Data for analysis/ETHtmp2.dta", clear
			qui xtreg opd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(scatter opd_util rmonth if rmonth>24, msize(vsmall) mcolor(orange) sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia outpatient visits (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(250000)1000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/ETH_opd_util.pdf", replace
			
* IPD			
			u "$user/$ETHdata/Data for analysis/ETHtmp2.dta", clear
			qui xtreg ipd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util 
			
			collapse ipd_util linear_ipd_util season_ipd_util, by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(scatter ipd_util rmonth if rmonth>24, msize(vsmall) mcolor(orange) sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit ipd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  /// 
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Ethiopia inpatient admissions (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(2000)14000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/ETH_ipd_util.pdf", replace
			
* Deliveries			
			u "$user/$ETHdata/Data for analysis/ETHtmp2.dta", clear
			qui xtreg del_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util, by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(scatter del_util rmonth if rmonth>24, msize(vsmall) mcolor(orange) sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit del_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia facility based deliveries (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(2000)18000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/ETH_del_util.pdf", replace			
* Penta		
			u "$user/$ETHdata/Data for analysis/ETHtmp2.dta", clear
			qui xtreg pent_qual rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_pent_qual
			qui xtreg pent_qual rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pent_qual 
			
			collapse pent_qual linear_pent_qual season_pent_qual, by(rmonth)

			twoway (scatter pent_qual rmonth, msize(vsmall)  sort) ///
			(scatter pent_qual rmonth if rmonth>24, msize(vsmall) mcolor(orange) sort) ///
			(line linear_pent_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pent_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pent_qual rmonth if rmonth<16, lcolor(green)) ///
			(lfit pent_qual rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit pent_qual rmonth if rmonth>=22 & rmonth<=30 , lcolor(orange) lpattern(vshortdash)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia pentavalent vaccinations (January 2019 - June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(tiny))  ylabel(0(5000)30000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/ETH_pent_qual.pdf", replace			


