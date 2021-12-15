* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* CHILE GRAPHS
********************************************************************************
* Deliveries
		use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
		lab def rmonth 1"J19" 2"F19" 3"M19" 4"A19" 5"M19" 6"J19" 7"J19" 8"A19" 9"S19" 10"O19" 11"N19" 12"D19" ///
			13"J20" 14"F20" 15"M20" 16"A20" 17"M20" 18"J20" 19"J20" 20"A20" ///
			21"S20" 22"O20" 23"N20" 24"D20" 25"J21" 26"F21" 27"M21" 28"A21" 29"M21" 30"J21"
		lab val rmonth rmonth 
		
			qui xtreg del_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util, by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit del_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) 	graphregion(color(white)) ///
			title("Chile facility based deliveries (January 2019 to December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_del_util.pdf", replace
* Inpatient
	use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
	lab def rmonth 1"J19" 2"F19" 3"M19" 4"A19" 5"M19" 6"J19" 7"J19" 8"A19" 9"S19" 10"O19" 11"N19" 12"D19" ///
			13"J20" 14"F20" 15"M20" 16"A20" 17"M20" 18"J20" 19"J20" 20"A20" ///
			21"S20" 22"O20" 23"N20" 24"D20" 25"J21" 26"F21" 27"M21" 28"A21" 29"M21" 30"J21"
		lab val rmonth rmonth 
		
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
			(lfit ipd_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) 	graphregion(color(white)) ///
			title("Chile inpatient admissions (January 2019 to December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(2000)10000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_ipd_util.pdf", replace
		
* Diabetes
		use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
		lab def rmonth 1"J19" 2"F19" 3"M19" 4"A19" 5"M19" 6"J19" 7"J19" 8"A19" 9"S19" 10"O19" 11"N19" 12"D19" ///
			13"J20" 14"F20" 15"M20" 16"A20" 17"M20" 18"J20" 19"J20" 20"A20" ///
			21"S20" 22"O20" 23"N20" 24"D20" 25"J21" 26"F21" 27"M21" 28"A21" 29"M21" 30"J21"
		lab val rmonth rmonth 
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
			(lfit diab_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile diabetes visits (January 2019- December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(100)600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_diab_util.pdf", replace
			
* Pentavalent
		use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			lab def rmonth 1"J19" 2"F19" 3"M19" 4"A19" 5"M19" 6"J19" 7"J19" 8"A19" 9"S19" 10"O19" 11"N19" 12"D19" ///
			13"J20" 14"F20" 15"M20" 16"A20" 17"M20" 18"J20" 19"J20" 20"A20" ///
			21"S20" 22"O20" 23"N20" 24"D20" 25"J21" 26"F21" 27"M21" 28"A21" 29"M21" 30"J21"
		lab val rmonth rmonth 
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
			(lfit pent_qual rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile pentavalent vaccinations (January 2019-December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(400)1600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_pent_qual.pdf", replace			
* bcg vaccines
		use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			qui xtreg bcg_qual rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_bcg_qual
			qui xtreg bcg_qual rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_bcg_qual 
			
			collapse bcg_qual linear_bcg_qual season_bcg_qual, by(rmonth)

			twoway (scatter bcg_qual rmonth, msize(vsmall)  sort) ///
			(line linear_bcg_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_bcg_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit bcg_qual rmonth if rmonth<16, lcolor(green)) ///
			(lfit bcg_qual rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit bcg_qual rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile bcg vaccination (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(400)1600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_bcg_qual.pdf", replace

* Hypertension
		use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear
			qui xtreg hyper_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_hyper_util
			qui xtreg hyper_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_hyper_util 
			
			collapse hyper_util linear_hyper_util season_hyper_util, by(rmonth)

			twoway (scatter hyper_util rmonth, msize(vsmall)  sort) ///
			(line linear_hyper_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_hyper_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit hyper_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit hyper_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit hyper_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Chile hypertension visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(250)1500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_hyper_util.pdf", replace



