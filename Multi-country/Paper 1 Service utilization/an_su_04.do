* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, December 2021

********************************************************************************
	* CAPITAL REGION SUBANALYSIS: 
	* Regression analysis: Level change in the first 6 months of the pandemic 
********************************************************************************	
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	
	putexcel set "$analysis/Results/Tables/Capital region DEC6.xlsx", sheet("`c'")  modify
	putexcel A1 = "service" B1="Avg_preCovid" C1= "pct_change" D1="LCL_pct_change" E1="UCL_pct_change" 
	local i = 1
	keep if capital==1
	foreach var of global `c'all {	
		local i = `i'+1
		reg `var' postCovid rmonth timeafter i.season resumption , vce(robust)
	
		mat m1= r(table) 
		mat b1 = m1[1, 1...]'
		scalar beta1 = b1[1,1]
		su `var' if postCovid==0 // average over the pre-Covid period
		scalar avg = r(mean) 
		scalar pct_chg1= (beta1/avg)*100
		putexcel A`i' = "`var'"		
		putexcel B`i' = `r(mean)'
		putexcel C`i'=pct_chg1
		
		mat ll= m1[5, 1...]'
		scalar lcl = ll[1,1]
		scalar pct_lcl= (lcl/avg)*100
		putexcel D`i'=pct_lcl
		
		mat ul = m1[6, 1...]'
		scalar ucl=ul[1,1]
		scalar pct_ucl= (ucl/avg)*100
		putexcel E`i'=pct_ucl

		scalar drop _all
		
	}
}
