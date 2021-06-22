* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
********************************************************************************
* GHANA (Region level)
********************************************************************************
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
encode region, gen(reg)	
sort region rmonth
gen postCovid = rmonth>15 // pandemic period is months 16-24
gen timeafter= rmonth-15
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
gen postCovid_dec = rmonth>15
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
mata: st_matrix("adjp", 2*ttail( st_numscalar( "e(N_clust)")-2 , abs(  st_matrix("e(b)") :/ sqrt( diagonal( st_matrix("e(V)") )')   ))  )				
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
putexcel set "$analysis/Results/Tables/Results JUNE22.xlsx", sheet(Ghana)  modify
putexcel A1 = "Ghana"
putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
putexcel C2= "RD postCovid" D2="LCL" E2="UCL" F2="p-value" G2 ="% change"
local i = 2

xtset reg rmonth 

foreach var of global GHAall {
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

foreach var of global GHAall {
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
* GHANA GRAPHS
********************************************************************************
lab def rmonth 1"J" 2"F" 3"M" 4"A" 5"M" 6"J" 7"J" 8"A" 9"S" 10"O" 11"N" 12"D" ///
			13"J" 14"F" 15"M" 16"A" 17"M" 18"J" 19"J" 20"A" ///
			21"S" 22"O" 23"N" 24"D"
			lab val rmonth rmonth 
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
* OPD		
			qui xtreg opd_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_opd_util
			qui xtreg opd_util rmonth spring-winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util  , by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana Outpatient Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(40000)220000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_opd_util.pdf", replace
			
* Csections		
			qui xtreg cs_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_cs_util
			qui xtreg cs_util rmonth i.season if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_cs_util 
			
			collapse cs_util linear_cs_util season_cs_util  , by(rmonth)

			twoway (scatter cs_util rmonth, msize(vsmall)  sort) ///
			(line linear_cs_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_cs_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit cs_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit cs_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana C-sections", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_cs_util.pdf", replace
			
* PNC	
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			qui xtreg pnc_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_pnc_util
			qui xtreg pnc_util rmonth i.season if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_pnc_util 
			
			collapse pnc_util linear_pnc_util season_pnc_util  , by(rmonth)

			twoway (scatter pnc_util rmonth, msize(vsmall)  sort) ///
			(line linear_pnc_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_pnc_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit pnc_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit pnc_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana PNC visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)5000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_pnc_util.pdf", replace			

* DELIVERIES
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			qui xtreg del_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_del_util
			qui xtreg del_util rmonth spring-winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana Deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(1000)5000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_del_util.pdf", replace
* FP		
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear
			qui xtreg fp_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_fp_util
			qui xtreg fp_util rmonth spring-winter if rmonth<16, i(reg) fe cluster(reg) // w. seasonal adj
				predict season_fp_util 
			
			collapse fp_util linear_fp_util season_fp_util  , by(rmonth)

			twoway (scatter fp_util rmonth, msize(vsmall)  sort) ///
			(line linear_fp_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_fp_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit fp_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit fp_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana family planning users", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(2000)22000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_fp_util.pdf", replace
			
* Diabetes
u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear		
			qui xtreg diab_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_diab_util
			qui xtreg diab_util rmonth spring-winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_diab_util 
			
			collapse  diab_util linear_diab_util season_diab_util  , by(rmonth)

			twoway (scatter diab_util rmonth, msize(vsmall)  sort) ///
			(line linear_diab_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_diab_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit diab_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit diab_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana Diabetes Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(200)1200, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_diab_util.pdf", replace


u "$user/$GHAdata/Data for analysis/GHAtmp.dta", clear	
			qui xtreg diarr_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
				predict linear_diarr_util
			qui xtreg diarr_util rmonth spring-winter if rmonth<16, ///
				i(reg) fe cluster(reg) // w. seasonal adj
				predict season_diarr_util 
			
			collapse  diarr_util linear_diarr_util season_diarr_util  , by(rmonth)

			twoway (scatter diarr_util rmonth, msize(vsmall)  sort) ///
			(line linear_diarr_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_diarr_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit diarr_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit diarr_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per region", size(vsmall)) ///
			graphregion(color(white)) title("Ghana child diarrhea visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(500)4000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/GHA_diarr_util.pdf", replace

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
