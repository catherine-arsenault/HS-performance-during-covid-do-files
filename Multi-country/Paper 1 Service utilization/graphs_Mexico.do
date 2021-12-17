* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* Mexico GRAPHS
********************************************************************************
* Outpatient
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
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
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(50000)300000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_opd_util.pdf", replace
* ART
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
			qui xtreg art_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_art_util
			qui xtreg art_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_art_util 
			
			collapse art_util linear_art_util season_art_util, by(rmonth)

			twoway (scatter art_util rmonth, msize(vsmall)  sort) ///
			(line linear_art_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_art_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit art_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit art_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit art_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(16, lpattern(dash) lcolor(black)) ///
			 xline(22, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) number on ART (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall))ylabel(0(200)1600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_art_util.pdf", replace
* Deliveries
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
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
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) outpatient visits (2019-2020)", size(small))  ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(50)650, labsize(vsmall))
		
			
			graph export "$analysis/Results/Graphs/MEX_del_util.pdf", replace


* Pentavalent
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
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
			xline(21, lpattern(dash) lcolor(gs10)) xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) pentavalent vaccinations (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)3000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_pent_qual.pdf", replace
			
* Diabetes
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
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
			graphregion(color(white)) title("Mexico (IMSS) diabetes visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)50000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_diab_util.pdf", replace

* ANC
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
			qui xtreg anc_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_anc_util
			qui xtreg anc_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_anc_util 
			
			collapse anc_util linear_anc_util season_anc_util, by(rmonth)

			twoway (scatter anc_util rmonth, msize(vsmall)  sort) ///
			(line linear_anc_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_anc_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit anc_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit anc_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit anc_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) ANC visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall))ylabel(0(1000)10000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_anc_util.pdf", replace

* Measles
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 
			qui xtreg measles_qual rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_measles_qual
			qui xtreg measles_qual rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_measles_qual 
			
			collapse measles_qual linear_measles_qual season_measles_qual, by(rmonth)

			twoway (scatter measles_qual rmonth, msize(vsmall)  sort) ///
			(line linear_measles_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_measles_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit measles_qual rmonth if rmonth<16, lcolor(green)) ///
			(lfit measles_qual rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit measles_qual rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xline(21, lpattern(dash) lcolor(gs10)) xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico (IMSS) measlesavalent vaccinations (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(100)500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_measles_qual.pdf", replace
* Inpatient
			u  "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear 			
			
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
			xline(21, lpattern(dash) lcolor(gs10)) xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Mexico inpatient admissions (January 2019- December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(2000)6000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/MEX_ipd_util.pdf", replace
