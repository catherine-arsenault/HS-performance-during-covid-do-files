* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* KZN GRAPHS
********************************************************************************
* OPD
			u  "$user/$data/Data for analysis/KZNtmp_2021.dta", clear 
			qui xtreg opd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("KwaZulu-Natal outpatient visits (Jan 2019- June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(vsmall)) ylabel(0(5000)45000, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/KZN_opd_util.pdf", replace

* Pentavalent
			u  "$user/$data/Data for analysis/KZNtmp_2021.dta", clear 
			qui xtreg pent_qual rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_pent_qual
			qui xtreg pent_qual rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pent_qual 
			
			collapse pent_qual linear_pent_qual season_pent_qual, by(rmonth)

			twoway (scatter pent_qual rmonth, msize(vsmall)  sort) ///
			(line linear_pent_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pent_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pent_qual rmonth if rmonth<16, lcolor(green)) ///
			(lfit pent_qual rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit pent_qual rmonth if rmonth>=22 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("KwaZulu-Natal pentavalent vaccinations (Jan 2019- June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(vsmall)) ylabel(0(500)3000, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/KZN_pent_qual.pdf", replace


* Diabetes
			u  "$user/$data/Data for analysis/KZNtmp_2021.dta", clear 
			qui xtreg diab_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_diab_util
			qui xtreg diab_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_diab_util
			
			collapse diab_util linear_diab_util season_diab_util, by(rmonth)

			twoway (scatter diab_util rmonth, msize(vsmall)  sort) ///
			(line linear_diab_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_diab_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit diab_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit diab_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit diab_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("KwaZulu-Natal diabetes visits (Jan 2019- June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(vsmall)) ylabel(0(1500)12000, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/KZN_diab_util.pdf", replace

* Deliveries
			u  "$user/$data/Data for analysis/KZNtmp_2021.dta", clear 
			qui xtreg totaldel rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_totaldel
			qui xtreg totaldel rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_totaldel
			
			collapse totaldel linear_totaldel season_totaldel, by(rmonth)

			twoway (scatter totaldel rmonth, msize(vsmall)  sort) ///
			(line linear_totaldel rmonth, lpattern(dash) lcolor(green)) ///
			(line season_totaldel rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit totaldel rmonth if rmonth<16, lcolor(green)) ///
			(lfit totaldel rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit totaldel rmonth if rmonth>=22 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("KwaZulu-Natal deliveries (Jan 2019- June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(vsmall)) ylabel(0(500)1500, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/KZN_del_util.pdf", replace
			
* IPD
	u  "$user/$data/Data for analysis/KZNtmp_2021.dta", clear 
			qui xtreg ipd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util
			
			collapse ipd_util linear_ipd_util season_ipd_util, by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit ipd_util rmonth if rmonth>=22 & rmonth<=30 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("KwaZulu-Natal IPD visits (Jan 2019- June 2021)", size(small)) ///
			xlabel(1(1)30) xlabel(, labels valuelabels labsize(vsmall)) ylabel(0(1000)6000, labsize(vsmall))
		
			graph export "$analysis/Results/Graphs/2021/KZN_ipd_util.pdf", replace

