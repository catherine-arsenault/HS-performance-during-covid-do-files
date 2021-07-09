
********************************************************************************
* Ethiopia GRAPHS
********************************************************************************	
	
lab def rmonth 1"J" 2"F" 3"M" 4"A" 5"M" 6"J" 7"J" 8"A" 9"S" 10"O" 11"N" 12"D" ///
			13"J" 14"F" 15"M" 16"A" 17"M" 18"J" 19"J" 20"A" ///
			21"S" 22"O" 23"N" 24"D"
			lab val rmonth rmonth 
save "$user/$ETHdata/Data for analysis/ETHtmp.dta",	replace	
* OPD
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg opd_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title("Ethiopia outpatient visits (2019-2020)", size(small))  ///
			xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(250000)1000000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace
* Deliveries
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
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
			graphregion(color(white)) title(" Ethiopia deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)20000, labsize(vsmall))
			graph export "$analysis/Results/Graphs/Ethiopia_del_util.pdf", replace
* CSections		
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			
			graphregion(color(white)) title(" Ethiopia C-sections", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)1500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_cs_util.pdf", replace
* ART		
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear	
			
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia people on ART", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)45000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_art_util.pdf", replace
* IPD
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg ipd_util rmonth if rmonth<15  , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth i.season if rmonth<15 , i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util 
			
			collapse ipd_util linear_ipd_util season_ipd_util, by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=15 & rmonth<=20, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			 xline(21, lpattern(dash) lcolor(gs10)) ///
			xtitle("", size(small)) legend(off) ///
			graphregion(color(white)) title(" Ethiopia Inpatient Admissions", size(small)) ///
			xlabel(1(1)24 , labsize(vsmall) valuelabel)  ylabel(0(2000)12000,   labsize(vsmall) )
			
			graph export "$analysis/Results/Graphs/Ethiopia_ipd_util.pdf", replace		

rm  "$user/$ETHdata/Data for analysis/ETHtmp.dta"	
		
	/*lab def rmonth 1"JAN19" 2"FEB19" 3"MAR19" 4"APR19" 5"MAY19" 6"JUN19" ///
			7"JUL19" 8"AUG19" 9"SEP19" 10"OCT19" 11"NOV19" 12"DEC19" 13"JAN20" ///
			14"FEB20" 15"MAR20" 16"APR20" 17"MAY20" 18"JUN20" 19"JUL20" 20"AUG20" ///
			21"SEP20" 22"OCT20" 23"NOV20" 24"DEC20"
			lab val rmonth rmonth */


			
/* ANNA's Code:
putexcel set "$analysis/Results/Tables/Missed visits graph.xlsx", modify

lab def rmonth 1"J" 2"F" 3"M" 4"A" 5"M" 6"J" 7"J" 8"A" 9"S" 10"O" 11"N" 12"D" ///
			13"J" 14"F" 15"M" 16"A" 17"M" 18"J" 19"J" 20"A" ///
			21"S" 22"O" 23"N" 24"D"
			lab val rmonth rmonth 
			
save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
* OPD			
			qui xtreg opd_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth i.season if rmonth<15, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util
			qui xtreg opd_util rmonth if rmonth>14 , i(reg) fe cluster(reg) // linear prediction
				predict linearpost_opd_util				
			
			gen missed_opd = linear_opd_util-linearpost_opd_util if rmonth>14
			qui sum missed_opd
			putexcel A2 = "Ethiopia"
			putexcel B1 = "OPD"
			putexcel B2 = `r(sum)'
			
			
			collapse opd_util linear_opd_util season_opd_util, by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(150000)950000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_opd_util.pdf", replace			
			
/*******************************************************************************
* Level change during the pandemic
********************************************************************************
xtset reg rmonth 

putexcel set "$analysis/Results/Tables/Results MAY28.xlsx", sheet(Ethiopia)  modify
putexcel A1 = "Ethiopia Region OLS FE"
putexcel A2 = "Health service" B2="Intercept" C2="RR postCovid" D2="LCL" E2="UCL" 
putexcel F2 ="p-value"
local i = 2

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var'  i.postCovid rmonth timeafter i.spring i.summer i.fall i.winter, ///
	i(reg) fe cluster(reg) // we will adjust SEs for small number of clusters
	
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
foreach var of global ETHall {
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
