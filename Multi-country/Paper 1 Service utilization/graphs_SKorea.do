
********************************************************************************
* KOREA GRAPHS
********************************************************************************
* ANC
u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			qui xtreg anc_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_anc_util
			qui xtreg anc_util rmonth i.season if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_anc_util 
			
			collapse anc_util linear_anc_util season_anc_util   , by(rmonth)

			twoway (scatter anc_util rmonth, msize(vsmall)  sort) ///
			(line linear_anc_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_anc_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit anc_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit anc_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(22, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per delegation", size(vsmall)) ///
			graphregion(color(white)) title("South Korea ANC visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(5000)25000, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_anc_util.pdf", replace
* Deliveries
u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
		
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100)900, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_del_util.pdf", replace
* OPD		
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			qui xtreg opd_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("South Korea outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(500000)4500000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KOR_opd_util.pdf", replace
			
* Hypertension
u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
			qui xtreg hyper_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_hyper_util
			qui xtreg hyper_util rmonth i.season if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_hyper_util 
			
			collapse hyper_util linear_hyper_util season_hyper_util   , by(rmonth)

			twoway (scatter hyper_util rmonth, msize(vsmall)  sort) ///
			(line linear_hyper_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_hyper_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit hyper_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit hyper_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(22, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("South Korea Hypertension visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(50000)350000, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_hyper_util.pdf", replace			

rm "$user/$KORdata/Data for analysis/KORtmp.dta"
