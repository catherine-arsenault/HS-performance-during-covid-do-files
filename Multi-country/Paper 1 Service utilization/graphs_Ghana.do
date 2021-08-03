
********************************************************************************
* GHANA GRAPHS
********************************************************************************
u  "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 
lab def rmonth 1"J" 2"F" 3"M" 4"A" 5"M" 6"J" 7"J" 8"A" 9"S" 10"O" 11"N" 12"D" ///
			13"J" 14"F" 15"M" 16"A" 17"M" 18"J" 19"J" 20"A" ///
			21"S" 22"O" 23"N" 24"D"
			lab val rmonth rmonth 
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
* anc		
		
			graphregion(color(white)) title("Ghana ANC Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)30000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_anc_util.pdf", replace
* OPD		
		u  "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 
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
			graphregion(color(white)) title("Ghana outpatient visits (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(50000)250000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_opd_util.pdf", replace
* Penta		
		u  "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 
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
			graphregion(color(white)) title("Ghana pentavalent vaccinations (2019-2020)", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1000)7000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_pent_qual.pdf", replace
			

* Csections	
	u  "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 	
			qui xtreg cs_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_cs_util
			qui xtreg cs_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_cs_util 
			
			collapse cs_util linear_cs_util season_cs_util, by(rmonth)

			twoway (scatter cs_util rmonth, msize(vsmall)  sort) ///
			(line linear_cs_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_cs_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit cs_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit cs_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ghana C-sections", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_cs_util.pdf", replace
			
* PNC	
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			qui xtreg pnc_util rmonth if rmonth<16  , i(reg) fe cluster(reg) // linear prediction
				predict linear_pnc_util
			qui xtreg pnc_util rmonth i.season if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pnc_util 
			
			collapse pnc_util linear_pnc_util season_pnc_util, by(rmonth)

			twoway (scatter pnc_util rmonth, msize(vsmall)  sort) ///
			(line linear_pnc_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pnc_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pnc_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit pnc_util rmonth if rmonth>=16 & rmonth<=21, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ghana PNC visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)5000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_pnc_util.pdf", replace		
			

* DELIVERIES
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			
			graphregion(color(white)) title("Ghana Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1000)5000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_del_util.pdf", replace
* FP		
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			
			graphregion(color(white)) title("Ghana family planning users", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(2000)22000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_fp_util.pdf", replace
			
* Diabetes	
u  "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear 
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
			graphregion(color(white)) title("Ghana Diabetes Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1200, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_diab_util.pdf", replace


* Malaria
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear		
		
			graphregion(color(white)) title("Ghana malaria visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(10000)100000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_malaria_util.pdf", replace
* Road
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear	
			
			graphregion(color(white)) title("Ghana road traffic injuries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(100)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_road_util.pdf", replace
* pneum
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear	
		
			graphregion(color(white)) title("Ghana child pneumonia visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(250)3000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_pneum_util.pdf", replace
* bcg
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear	
			
			graphregion(color(white)) title("Ghana child bcg ", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1000)10000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_bcg_qual.pdf", replace
* Penta
			u "$user/$LAOdata/Data for analysis/LAOtmp.dta", clear
			
			graphregion(color(white)) title("Lao PDR Pentavalent vaccinations", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/LAO_pent_qual.pdf", replace			
rm "$user/$GHAdata/Data for analysis/GHAtmp.dta"

/********************************************************************************
* Level change during the pandemic
********************************************************************************
xtset reg rmonth 

putexcel set "$analysis/Results/Tables/Results MAY28.xlsx", sheet(Ghana)  modify
putexcel A1 = "Ghana Region OLS FE"
putexcel A2 = "Health service" B2="Intercept" C2="RR postCovid" D2="LCL" E2="UCL" 
putexcel F2 ="p-value"
local i = 2

foreach var of global GHAall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
		i(reg) fe cluster(reg)
	// we will adjust SEs for small number of clusters
	
	putexcel A`i' = "`var'"
	putexcel B`i'=(_b[_cons]) // intercept, 95% CI and p-value?

	margins postCovid, post
	nlcom (rr: (_b[1.postCovid]/_b[0.postCovid])) , post
	test (_b[rr]) =1 // tests whether calculated ratio is diff. from 1

	putexcel c`i'= (_b[rr])
	putexcel d`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel e`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	putexcel f`i'= `r(p)'	 	
}
********************************************************************************
* Resumption at Dec 31, 2020: ratio of predicted
********************************************************************************
putexcel G2="%predicted" H2="LCL" I2="UCL" J2 ="p-value"
local i = 2
foreach var of global GHAall {
	local i = `i'+1
	xtreg `var' i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
		i(reg) fe cluster(reg)
	
	margins, at(postCovid=(0 1) timeafter=(0 10) rmonth==24) post 
	nlcom (rr: (_b[4._at]/_b[1bn._at])), post
	// nlcom is testing the null hypothesis the the ratio is equal to zero.
	test (_b[rr]) =1 // tests whether calculated ratio is diff. from 1
	
	putexcel g`i'= (_b[rr])
	putexcel h`i'= (_b[rr]-invnormal(1-.05/2)*_se[rr])  
	putexcel i`i'= (_b[rr]+invnormal(1-.05/2)*_se[rr])
	putexcel j`i'= `r(p)'
}
