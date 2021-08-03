* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, August 3, 2021
* Program by Sebastian Bauhoff

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
* Country appendices: full regression results
********************************************************************************
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	
	putexcel set "$analysis/Appendices/Country profiles AUG03.xlsx", sheet("`c'")  modify
	putexcel A1= "`c'" B1="Nb of units" F1="Pandemic impact"
	putexcel A2= "Health service" B2="Average over the pre-Covid period" 
	putexcel C2="Avg monthly change before the pandemic" D2="LCL" E2="UCL" F2="p-value"
	putexcel G2= "Level change due to COVID-19" H2="LCL"  I2="UCL" J2="p-value"
	putexcel K2="Avg monthly change during the pandemic" L2="LCL" M2="UCL" N2="p-value"
	putexcel O2="Remaining level change at the end of 2020" P2="LCL" Q2="UCL" R2="p-value"
	
	local i = 2

	xtset reg rmonth 

	foreach var of global `c'all {
		
		local i = `i'+1
		
		putexcel A`i' = "`var'"
		su `var' if postCovid==0 
		scalar avg = r(mean) 
		putexcel B`i' = `r(mean)' // average over the pre-Covid period
		* Regression
		xtreg `var' postCovid rmonth timeafter i.season resumption, i(reg) fe cluster(reg) 		
		putexcel C1=`e(N_clust)' // number of regions
		
		mat m1= r(table) 
		mat betas = m1[1, 1...]' 
		scalar beta1 = betas[1,1] // postCovid coeff.
		scalar beta2 = betas[2,1] // rmonth coeff.
		scalar beta3 = betas[3,1] // timeafter coeff.
		scalar beta8 = betas[8,1] // resumption period coeff.
		
		putexcel C`i'=beta2
		putexcel G`i'=beta1
		putexcel K`i'=beta3
		putexcel O`i'=beta8
		
		* Call program to adjust for G-2 degrees of freedom
		adjpvalues, p(adjp) cil(adjci_l) ciu(adjci_u)  
		
		mat cil = adjci_l[1, 1...]'
		scalar lcl1= cil[1,1]
		scalar lcl2= cil[2,1]
		scalar lcl3= cil[3,1]
		scalar lcl8= cil[8,1]
		
		mat ciu= adjci_u[1, 1...]'
		scalar ucl1 = ciu[1,1]
		scalar ucl2 = ciu[2,1]
		scalar ucl3 = ciu[3,1]
		scalar ucl8 = ciu[8,1]
		
		mat pval= adjp[1, 1...]'
		scalar p1 = pval[1,1]
		scalar p2 = pval[2,1]
		scalar p3 = pval[3,1]
		scalar p8 = pval[8,1]
		
		putexcel D`i'=lcl2 E`i'=ucl2 F`i'=p2
		putexcel H`i'=lcl1 I`i'=ucl1 J`i'=p1
		putexcel L`i'=lcl3 M`i'=ucl3 N`i'=p3
		putexcel P`i'=lcl8 Q`i'=ucl8 R`i'=p8
		
		scalar drop _all
	}

}
