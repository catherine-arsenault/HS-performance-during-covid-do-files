* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
* Program by Sebastian Bauhoff
********************************************************************************
* Ethiopia - regression models, at regional level
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear

collapse (sum) $ETHall, by (region year month)
encode region, gen(reg)

/* Vars needed for ITS regression (we expect both a change in level and in slope) 
	rmonth from 1 to 24 = underlying trend in the outcome before the pandemic
	PostCovid = level change in the outcome when pandemic began
	timeafter = slope change during the pandemic 
	Month 14 in Ethiopia is actually Feb9-Mar9 according to western calendar, 
	so pandemic starts month 15 (declared Mar 11, 2020) */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort reg rmonth

gen postCovid = rmonth>14 // pandemic period is month 15 to 24 
gen timeafter= rmonth-14
replace timeafter=0 if timeafter<0

gen season = .
recode season (.=1) if ( month>=3 & month<=5  )
recode season (.=2) if ( month>=6 & month<=8  )
recode season (.=3) if ( month>=9 & month<=11 )
recode season (.=4) if inlist(month, 1, 2, 12)             
la var season "Season"
la def season 1 "Spring" 2 "Summer" 3 "Fall" 4 "Winter"
la val season season

* To assess resumption by Dec 31, 2020
* "Temporary" post-Covid period now excludes december
gen postCovid_dec = rmonth>14 
replace postCovid_dec=0 if rmonth==24
* Indicator for December (withdrawal of the postCovid period)
gen dec20= rmonth==24 

********************************************************************************
* Program for G-2 adjustment (call after xtreg)
********************************************************************************
* Add adjusted p-value and 95% CI to -xtreg, cluster()- estimation output
* Use t(G-2) distribution instead of Stata's t(G-1) where G = number of clusters as per Donald and Lang (2007)
			
cap program drop adjpvalues
program adjpvalues, rclass
			
version 11
				
syntax , p( string ) cil( string ) ciu( string )
			
* Use t-distribution with G-2 d.f. where G = e(N_clust) from xtreg
mata: st_matrix("adjp", 2*ttail( st_numscalar( "e(N_clust)")-2 , abs(  st_matrix("e(b)") :/ sqrt( diagonal( st_matrix("e(V)") )')   )) )				
mata: st_matrix("adjci_l", st_matrix("e(b)") - invttail( st_numscalar( "e(N_clust)")-2, 0.025 ) *sqrt( diagonal( st_matrix("e(V)") )') )
mata: st_matrix("adjci_u", st_matrix("e(b)") + invttail( st_numscalar( "e(N_clust)")-2, 0.025 ) *sqrt( diagonal( st_matrix("e(V)") )') )
			
* Need same varnames as e(b)
mat colnames adjp    = `: colnames e(b)'
mat colnames adjci_l = `: colnames e(b)'
mat colnames adjci_u = `: colnames e(b)'

end		

********************************************************************************
* Level change during the pandemic 
********************************************************************************
putexcel set "$analysis/Results/Tables/Results JUNE22.xlsx", sheet(Ethiopia)  modify
putexcel A1 = "Ethiopia"
putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
putexcel C2= "RD postCovid" D2="LCL" E2="UCL" F2="p-value" G2 ="% change"
local i = 2

xtset reg rmonth 

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var' i.postCovid rmonth timeafter i.season, i(reg) fe cluster(reg) 
	
	mat m1= r(table) 
	mat b1 = m1[1, 2...]'
	scalar beta = b1[1,1]
	putexcel A`i' = "`var'"
	putexcel C`i'=(_b[1.postCovid])

	* Call program to adjust for G-2 degrees of freedom
	adjpvalues, p(adjp) cil(adjci_l) ciu(adjci_u)  
	
	mat cil = adjci_l[1, 2...]'
	scalar lcl= cil[1,1]
	putexcel D`i'=lcl

	mat ciu= adjci_u[1, 2...]'
	scalar ucl = ciu[1,1]
	putexcel E`i'=ucl
	
	mat pval= adjp[1, 2...]'
	scalar p = pval[1,1]
	putexcel F`i'=p
	
	su `var' if postCovid==0 // average over the pre-Covid period
	scalar avg = r(mean) 
	putexcel B`i' = `r(mean)'
	scalar pct_chg= beta/avg
	putexcel G`i'=pct_chg
	
	scalar drop _all
}
********************************************************************************
* Resumption at Dec 31, 2020: remaining level change 
********************************************************************************
putexcel H2="RD remain. level change Dec" I2="LCL" J2="UCL" K2="p-value" L2="% change"
local i = 2

foreach var of global ETHall {
	local i = `i'+1
	xtreg `var' i.postCovid_dec rmonth timeafter dec20 i.season, i(reg) fe cluster(reg) 
	putexcel H`i'=(_b[dec20])
	mat m2= r(table)
	mat b2 = m2[1, 5...]'
	scalar beta = b2[1,1]
	
	* Call program to adjust for G-2 degrees of freedom
	adjpvalues, p(adjp) cil(adjci_l) ciu(adjci_u)  
	
	mat cil = adjci_l[1, 5...]'
	scalar lcl= cil[1,1]
	putexcel I`i'=lcl
	
	mat ciu= adjci_u[1, 5...]'
	scalar ucl = ciu[1,1]
	putexcel J`i'=ucl
	
	mat pval= adjp[1, 5...]'
	scalar p = pval[1,1]
	putexcel K`i'=p
	
	su `var' if postCovid==0 // average over the pre-Covid period
	scalar avg = r(mean) 
	scalar pct_chg= beta/avg
	putexcel L`i'=pct_chg
	
	scalar drop _all
}
/********************************************************************************
* Ethiopia GRAPHS
********************************************************************************	
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
			
* Deliveries
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg del_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth spring-winterif rmonth<15, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)20000, labsize(vsmall))
			graph export "$analysis/Results/Graphs/Ethiopia_del_util.pdf", replace
* Cs 		
			u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
			qui xtreg cs_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_cs_util
			qui xtreg cs_util rmonth spring-winter if rmonth<15, i(reg) fe cluster(reg) // w. seasonal adj
				predict season_cs_util 
			
			collapse cs_util linear_cs_util season_cs_util  , by(rmonth)

			twoway (scatter cs_util rmonth, msize(vsmall)  sort) ///
			(line linear_cs_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_cs_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit cs_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit cs_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia C-sections", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)1500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_cs_util.pdf", replace
* ART		
u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear	
			qui xtreg art_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_art_util
			qui xtreg art_util rmonth spring-winter if rmonth<15, i(reg) fe cluster(reg) // w. seasonal adj
				predict season_art_util 
			
			collapse art_util linear_art_util season_art_util  , by(rmonth)

			twoway (scatter art_util rmonth, msize(vsmall)  sort) ///
			(line linear_art_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_art_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit art_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit art_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia people on ART", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(5000)45000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/Ethiopia_art_util.pdf", replace
* IPD
u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear

			qui xtreg ipd_util rmonth if rmonth<15 , i(reg) fe cluster(reg) // linear prediction
				predict linear_ipd_util
			qui xtreg ipd_util rmonth spring-winter if rmonth<15, i(reg) fe cluster(reg) // w. seasonal adj
				predict season_ipd_util 
			
			collapse ipd_util linear_ipd_util season_ipd_util  , by(rmonth)

			twoway (scatter ipd_util rmonth, msize(vsmall)  sort) ///
			(line linear_ipd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_ipd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit ipd_util rmonth if rmonth<15, lcolor(green)) ///
			(lfit ipd_util rmonth if rmonth>=15, lcolor(red)), ///
			ylabel(, labsize(small) ) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title(" Ethiopia Inpatient Admissions", size(small)) ///
			xlabel(1(1)24 , labsize(vsmall) valuelabel)  ylabel(0(2000)12000,   labsize(vsmall) )
			
			graph export "$analysis/Results/Graphs/Ethiopia_ipd_util.pdf", replace		

rm  "$user/$ETHdata/Data for analysis/ETHtmp.dta"	
		
	/*lab def rmonth 1"JAN19" 2"FEB19" 3"MAR19" 4"APR19" 5"MAY19" 6"JUN19" ///
			7"JUL19" 8"AUG19" 9"SEP19" 10"OCT19" 11"NOV19" 12"DEC19" 13"JAN20" ///
			14"FEB20" 15"MAR20" 16"APR20" 17"MAY20" 18"JUN20" 19"JUL20" 20"AUG20" ///
			21"SEP20" 22"OCT20" 23"NOV20" 24"DEC20"
			lab val rmonth rmonth */


			
			
			
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
