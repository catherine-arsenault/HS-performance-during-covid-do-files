* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
********************************************************************************
* Haiti (by département)
********************************************************************************
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear

rename orgunitlevel2 departement
collapse (sum) $HTIall, by (departement year month)
encode departement, gen(reg)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020

sort reg rmonth
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
putexcel set "$analysis/Results/Tables/Results JUNE22.xlsx", sheet(Haiti)  modify
putexcel A1 = "Haiti"
putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
putexcel C2= "RD postCovid" D2="LCL" E2="UCL" F2="p-value" G2 ="% change"
local i = 2

xtset reg rmonth 

foreach var of global HTIall {
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

foreach var of global HTIall {
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
* Haiti GRAPHS
********************************************************************************
save "$user/$HTIdata/Data for analysis/HTItmp.dta", replace
* OPD
			xtreg opd_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
			predict linear_opd_util
			xtreg opd_util rmonth i.spring i.summer i.fall i.winter if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
			predict season_opd_util 
			
			collapse opd_util linear_opd_util season_opd_util  , by(rmonth)

			twoway (scatter opd_util rmonth, msize(vsmall)  sort) ///
			(line linear_opd_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_opd_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit opd_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit opd_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per département", size(vsmall)) ///
			graphregion(color(white)) title("Haiti Outpatient Visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(20000)80000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/HTI_opd_util.pdf", replace
			
* Deliveries
		u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			xtreg del_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
			predict linear_del_util
			xtreg del_util rmonth i.spring i.summer i.fall i.winter if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
			predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)

			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
			(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
			(line season_del_util rmonth , lpattern(vshortdash) lcolor(grey)) ///
			(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
			(lfit del_util rmonth if rmonth>=16, lcolor(red)), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("", size(small)) legend(off) ///
			ytitle("Average number per département", size(vsmall)) ///
			graphregion(color(white)) title("Haiti deliveries", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(150)1500, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/HTI_del_util.pdf", replace

rm "$user/$HTIdata/Data for analysis/HTItmp.dta"
