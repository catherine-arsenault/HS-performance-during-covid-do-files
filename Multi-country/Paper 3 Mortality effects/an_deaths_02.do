* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Regression analyses
	
********************************************************************************
	* Regression analysis
********************************************************************************		
	u "$user/$CHLdata/Data for analysis/CHLtmp_deaths.dta", clear
	xtset reg rmonth 
	xtpoisson neo_mort postCovid rmonth timeafter i.season, i(reg) fe exposure(totaldel) vce(robust) irr
	
	
u "$user/$GHAdata/Data for analysis/GHAtmp_deaths.dta", clear
	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season, i(reg) fe  exposure(totaldel) irr //
	xtnbreg neo_ postCovid rmonth timeafter i.season, i(reg) fe cluster(reg) exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season, i(reg) fe cluster(reg) exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season, i(reg) cluster(reg) fe exposure(ipd_util) irr //
	
 u "$user/$ETHdata/Data for analysis/ETHtmp.dta", clear
 	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season, i(reg) fe exposure(totaldel) irr //
	xtnbreg neo_ postCovid rmonth timeafter i.season, i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season, i(reg) fe exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season, i(reg) fe exposure(ipd_util) irr //
	xtnbreg er_mort postCovid rmonth timeafter i.season, i(reg) fe exposure(er_util) irr //
	
u "$user/$NEPdata/Data for analysis/NEPtmp.dta", clear
 	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season if orgunitlevel3!="402 MANANG", // no deliveries in the district
		    i(reg) fe exposure(totaldel) irr 
	xtnbreg neo_ postCovid rmonth timeafter i.season if orgunitlevel3!="402 MANANG", ///
			i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season if orgunitlevel3!="402 MANANG" ///
			, i(reg) fe exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season if ipd_util!=0, i(reg) fe exposure(ipd_util) irr //
	
 u "$user/$MEXdata/Data for analysis/MEXtmp.dta", clear
 	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr //
	xtnbreg neo_ postCovid rmonth timeafter i.season ,  i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season , i(reg) fe exposure(ipd_util) irr //
	xtnbreg er_mort postCovid rmonth timeafter i.season, i(reg) fe exposure(er_util) irr //

u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr 
	xtnbreg mat_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr
	
 u "$user/$KZNdata/Data for analysis/KZNtmp.dta", clear	
	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr 
	xtnbreg neo_ postCovid rmonth timeafter i.season ,  i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season , i(reg) fe exposure(ipd_util) irr 
	xtnbreg trauma_mort postCovid rmonth timeafter i.season, i(reg) fe exposure(trauma_util) irr 

u "$user/$LAOdata/Data for analysis/LAOtmp.dta"	, clear
	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr 
	xtnbreg neo_ postCovid rmonth timeafter i.season ,  i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr
	
u "$user/$KORdata/Data for analysis/KORtmp.dta"	, clear
	xtset reg rmonth 
	xtnbreg sb_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr 
	xtnbreg neo_ postCovid rmonth timeafter i.season ,  i(reg) fe exposure(totaldel) irr
	xtnbreg mat_ postCovid rmonth timeafter i.season , i(reg) fe exposure(totaldel) irr
	xtnbreg ipd_mort postCovid rmonth timeafter i.season , i(reg) fe exposure(ipd_util) irr 
	
	
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {

	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	

	putexcel set "$analysis/Results/Tables/NOV23.xlsx", sheet("`c'")  modify
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
		 mat drop _all
	}

}
