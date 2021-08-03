* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, August 3, 2021

********************************************************************************
* Country appendices: full regression results
********************************************************************************
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	
	putexcel set "$analysis/Appendices/Country profiles AUG03.xlsx", sheet("`c'")  modify
	putexcel A1 = "`c'" B1="Nb of units" 
	putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
	putexcel C2= 
	putexcel H2= 
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
		mat m1= r(table) 
		mat betas = m1[1, 1...]' 
		scalar beta1 = betas[1,1] // postCovid coeff.
		scalar beta2 = betas[2,1] // rmonth coeff.
		scalar beta3 = betas[3,1] // timeafter coeff.
		scalar beta8 = betas[8,1] // resumption period coeff.
		
		putexcel C1=`e(N_clust)' // number of regions
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
		
		
		
		scalar drop _all
	}

}
