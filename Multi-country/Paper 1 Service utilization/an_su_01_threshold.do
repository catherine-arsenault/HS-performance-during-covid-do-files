* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, June 2021
* Program by Sebastian Bauhoff

/********************************************************************************
	Program for G-2 adjustment (call after xtreg)
********************************************************************************
	Add adjusted p-value and 95% CI to -xtreg, cluster()- estimation output
	Use t(G-2) distribution instead of Stata's t(G-1) where G = number of clusters as per Donald and Lang (2007)*/			
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
/*******************************************************************************
	Regression analysis: Level change during the first 6 months of the 
	pandemic and resumption in the last quarter of 2020
********************************************************************************/		
foreach m in 12 15 18 24 {
foreach c in ETH HTI KZN LAO NEP  {

	u "$user/$`c'data/Data for analysis/`c'tmp_`m'.dta", clear
	

	putexcel set "$analysis/Results/Tables/Results by country THRESHOLD.xlsx", sheet("`c'`m'")  modify
	putexcel A1 = "`c'" B1="Nb of units" 
	putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
	putexcel C2= "RD Covid" D2="LCL" E2="UCL" F2="p-value" G2 ="% change from pre-Covid average"
	putexcel H2= "RD Q4 2020" I2="LCL" J2="UCL" K2="p-value" L2 ="% change from pre-Covid average"
	local i = 2

	xtset reg rmonth 

	foreach var of global `c'all {
		
		local i = `i'+1
		xtreg `var' postCovid rmonth timeafter i.season resumption, i(reg) fe cluster(reg) 		
		mat m1= r(table) 
		mat b1 = m1[1, 1...]'
		scalar beta1 = b1[1,1]
		scalar beta2 = b1[8,1]
		putexcel A`i' = "`var'"
		putexcel C1=`e(N_clust)'
		putexcel C`i'=(_b[postCovid])
		putexcel H`i'= (_b[resumption])
		
		* Call program to adjust for G-2 degrees of freedom
		adjpvalues, p(adjp) cil(adjci_l) ciu(adjci_u)  
		
		mat cil = adjci_l[1, 1...]'
		scalar lcl1= cil[1,1]
		scalar lcl2= cil[8,1]
		putexcel D`i'=lcl1
		putexcel I`i'=lcl2
		
		mat ciu= adjci_u[1, 1...]'
		scalar ucl1 = ciu[1,1]
		scalar ucl2 = ciu[8,1]
		putexcel E`i'=ucl1
		putexcel J`i'=ucl2	
		
		mat pval= adjp[1, 1...]'
		scalar p1 = pval[1,1]
		scalar p2 = pval[8,1]
		putexcel F`i'=p1
		putexcel K`i'=p2
		
		su `var' if postCovid==0 // average over the pre-Covid period
		scalar avg = r(mean) 
		putexcel B`i' = `r(mean)'
		scalar pct_chg1= beta1/avg
		scalar pct_chg2= beta2/avg
		putexcel G`i'=pct_chg1
		putexcel L`i'=pct_chg2
		
		scalar drop _all
	}

}
}
