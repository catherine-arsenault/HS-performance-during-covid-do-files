
********************************************************************************
* KOREA GRAPHS
********************************************************************************
graph set window fontface "Arial"
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
			(lfit opd_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)) ///
			(lfit opd_util rmonth if rmonth>=22 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("South Korea outpatient visits (2019-2020)", size(msmall) color(black)) ///
			xlabel(1(1)24) xlabel(, labsize(msmall)) ylabel(0(1250000)5000000, labsize(msmall))
			
			graph export "$analysis/Results/Graphs/Fig1/KOR_opd_util.pdf", replace
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
			title("South Korea facility based deliveries (January 2019-December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(100)900, labsize(small))
			
			graph export "$analysis/Results/Graphs/KOR_del_util.pdf", replace
* Inpatient
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
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
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("South Korea inpatient admissions (January 2019- December 2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(20000)100000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KOR_ipd_util.pdf", replace

* Diabetes		
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
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
			graphregion(color(white)) title("South Korea diabetes visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labels valuelabels labsize(tiny)) ylabel(0(25000)225000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KOR_diab_util.pdf", replace
			
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
* ART		
			u "$user/$KORdata/Data for analysis/KORtmp.dta", clear
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
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("South Korea outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(50)500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/KOR_art_util.pdf", replace
