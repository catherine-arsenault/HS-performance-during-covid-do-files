
********************************************************************************
* NEPAL GRAPHS
********************************************************************************	
u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
	
lab def rmonth 1"J" 2"F" 3"M" 4"A" 5"M" 6"J" 7"J" 8"A" 9"S" 10"O" 11"N" 12"D" ///
			13"J" 14"F" 15"M" 16"A" 17"M" 18"J" 19"J" 20"A" ///
			21"S" 22"O" 23"N" 24"D"
			lab val rmonth rmonth 
* OPD			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
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
				(lfit opd_util rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)30000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_opd_util.pdf", replace

* IPD			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
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
				(lfit ipd_util rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal inpatient admissions (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_ipd_util.pdf", replace
* Deliveries			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
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
				(lfit del_util rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Nepal facility based deliveries (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_del_util.pdf", replace			
* MMR vax			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
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
				(lfit measles_qual rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal MMR vaccine (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1600, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_measles_qual.pdf", replace
* hiv			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
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
				(lfit hivtest_qual rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(20, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(250)2000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_hivtest_qual.pdf", replace
/* ANC			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
			qui xtreg anc_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_anc_util
			qui xtreg anc_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_anc_util 
			
			collapse anc_util linear_anc_util season_anc_util, by(rmonth)

			twoway (scatter anc_util rmonth, msize(vsmall)  sort) ///
			(line linear_anc_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_anc_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit anc_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit anc_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit anc_util rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal ANC visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1200, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_anc_util.pdf", replace

* Penta
		u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
			qui xtreg pent_qual rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_pent_qual
			qui xtreg pent_qual rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pent_qual 
			
			collapse pent_qual linear_pent_qual season_pent_qual, by(rmonth)

			twoway (scatter pent_qual rmonth, msize(vsmall)  sort) ///
			(line linear_pent_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pent_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pent_qual rmonth if rmonth<15, lcolor(green)) ///
			(lfit pent_qual rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
			(lfit pent_qual rmonth if rmonth>=21 & rmonth<=24, lcolor(blue)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Nepal pentavalent vaccinations (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_pent_qual.pdf", replace

* Diabetes			
			u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
			qui xtreg diab_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_diab_util
			qui xtreg diab_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_diab_util 
			
			collapse diab_util linear_diab_util season_diab_util, by(rmonth)

			twoway (scatter diab_util rmonth, msize(vsmall)  sort) ///
			(line linear_diab_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_diab_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit diab_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit diab_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)) ///
				(lfit diab_util rmonth if rmonth>=21 & rmonth<=24 , lcolor(blue)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Nepal diabetes visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(100)800, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_diab_util.pdf", replace

* Deliveries
		u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
			qui xtreg del_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util, by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Nepal deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_del_util.pdf", replace

* Penta vax
		u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
			qui xtreg pent_qual rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_pent_qual
			qui xtreg pent_qual rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pent_qual 
			
			collapse pent_qual linear_pent_qual season_pent_qual, by(rmonth)

			twoway (scatter pent_qual rmonth, msize(vsmall)  sort) ///
			(line linear_pent_qual rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pent_qual rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pent_qual rmonth if rmonth<15, lcolor(green)) ///
			(lfit pent_qual rmonth if rmonth>=15 & rmonth<=20, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Nepal pentavalent vaccines", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1200, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/NEP_pent_qual.pdf", replace
			
			
rm "$user/$NEPdata/Data for analysis/NEPtmp.dta"


