

* OPD			
			u "$user/$NEPdata/Data for analysis/NEPtmp2.dta", clear
			qui xtreg opd_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=21 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal outpatient visits (2019-2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labsize(vsmall)) ylabel(0(5000)30000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/NEP_opd_util.pdf", replace
			
* IPD			
			u "$user/$NEPdata/Data for analysis/NEPtmp2.dta", clear
			qui xtreg ipd_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util 
			
			collapse ipd_util linear_ipd_util season_ipd_util, by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit ipd_util rmonth if rmonth>=21 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10))  /// 
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal inpatient admissions (2019-2020)", size(small)) ///
			xlabel(1(1)30) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/NEP_ipd_util.pdf", replace
* Deliveries			
			u "$user/$NEPdata/Data for analysis/NEPtmp2.dta", clear
			qui xtreg del_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util, by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit del_util rmonth if rmonth>=21 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Nepal facility based deliveries (2019-2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/NEP_del_util.pdf", replace			
* MMR vax			
			u "$user/$NEPdata/Data for analysis/NEPtmp2.dta", clear
			qui xtreg measles_qual rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_measles_qual
			qui xtreg measles_qual rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_measles_qual 
			
			collapse measles_qual linear_measles_qual season_measles_qual, by(rmonth)

			twoway (scatter measles_qual rmonth, msize(vsmall)  sort) ///
			(line linear_measles_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_measles_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit measles_qual rmonth if rmonth<15, lcolor(green)) ///
			(lfit measles_qual rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit measles_qual rmonth if rmonth>=21 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal MMR vaccine (2019-2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labsize(vsmall)) ylabel(0(200)1600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/NEP_measles_qual.pdf", replace
* hiv			
			u "$user/$NEPdata/Data for analysis/NEPtmp2.dta", clear
			qui xtreg hivtest_qual rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_hivtest_qual
			qui xtreg hivtest_qual rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_hivtest_qual 
			
			collapse hivtest_qual linear_hivtest_qual season_hivtest_qual, by(rmonth)

			twoway (scatter hivtest_qual rmonth, msize(vsmall)  sort) ///
			(line linear_hivtest_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_hivtest_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit hivtest_qual rmonth if rmonth<15, lcolor(green)) ///
			(lfit hivtest_qual rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit hivtest_qual rmonth if rmonth>=21 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10))  ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal HIV tests (2019-2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labsize(vsmall)) ylabel(0(250)2000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/2021/NEP_hivtest_qual.pdf", replace
