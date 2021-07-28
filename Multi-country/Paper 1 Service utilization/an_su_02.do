* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, June 2021
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
	* Regression analysis: Level change during the first 6 months of the 
	* pandemic and resumption in the last quarter of 2020
********************************************************************************		
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {

	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	

	putexcel set "$analysis/Results/Tables/Results by country JUL26.xlsx", sheet("`c'")  modify
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
********************************************************************************
	* Relative % change for forest plots
********************************************************************************		
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {

	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear
	
	putexcel set "$analysis/Results/Tables/Relative %drop by country JUL26.xlsx", sheet("`c'")  modify
	putexcel A1 = "service" B1="Avg_preCovid" 
	
	putexcel C1= "pct_change" D1="LCL_pct_change" E1="UCL_pct_change" 
	local i = 1

	xtset reg rmonth 

	foreach var of global `c'all {
		
		local i = `i'+1
		xtreg `var' postCovid rmonth timeafter i.season resumption, i(reg) fe cluster(reg) 		
		mat m1= r(table) 
		mat b1 = m1[1, 1...]'
		scalar beta1 = b1[1,1]
		
		su `var' if postCovid==0 // average over the pre-Covid period
		scalar avg = r(mean) 
		scalar pct_chg1= (beta1/avg)*100
		putexcel A`i' = "`var'"		
		putexcel B`i' = `r(mean)'
		putexcel C`i'=pct_chg1
		
		* Call program to adjust for G-2 degrees of freedom
		adjpvalues, p(adjp) cil(adjci_l) ciu(adjci_u)  
		
		mat cil = adjci_l[1, 1...]'
		scalar lcl1= cil[1,1]
		scalar pct_lcl1= (lcl1/avg)*100
		putexcel D`i'=pct_lcl1

		mat ciu= adjci_u[1, 1...]'
		scalar ucl1 = ciu[1,1]
		scalar pct_ucl1= (ucl1/avg)*100
		putexcel E`i'=pct_ucl1
		
		putexcel F`i'="`c'"
		scalar drop _all
	}

}

********************************************************************************
	* Forest plots
********************************************************************************		
	import excel using "$analysis/Results/Tables/Relative %drop by country JUL26.xlsx", sheet(CHL) firstrow clear
	save "$analysis/Results/Tables/tmp.dta", replace
	foreach c in  ETH GHA HTI KZN LAO MEX NEP KOR THA {
		import excel using "$analysis/Results/Tables/Relative %drop by country JUL26.xlsx", sheet(`c') firstrow clear
		append using "$analysis/Results/Tables/tmp.dta"
		save "$analysis/Results/Tables/tmp.dta", replace
	}
	rename F country
	save "$analysis/Results/Tables/tmp.dta", replace
	********************************************************************************
	* Summative measures 
	keep if inlist(service, "opd_util", "er_util", "ipd_util", "surg_util", "trauma_util")
	sort service pct_change
	replace service = "Outpatient visits" if service=="opd_util"
	replace service = "Emergency room visits" if service=="er_util"
	replace service = "Inpatient Admissions" if service=="ipd_util"
	replace service = "Surgeries" if service=="surg_util"
	replace service = "Trauma admissions" if service=="trauma_util"
	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(blue) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(blue)) title("Summative measures of health system contacts", size(vsmall))
	********************************************************************************
	* Reproductive and maternal
	u "$analysis/Results/Tables/tmp.dta", clear
	keep if inlist(service, "fp_util", "anc_util", "cs_util", "del_util")
	sort service pct_change
	replace service = "Contraceptive users" if service=="fp_util"
	replace service = "Antenatal care visits" if service=="anc_util"
	replace service = "Caesarean sections" if service=="cs_util"
	replace service = "Deliveries" if service=="del_util"

	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(pink) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(pink)) title("Reproductive and maternal health services", size(vsmall))
	********************************************************************************
	* Child care 
	u "$analysis/Results/Tables/tmp.dta", clear
	keep if inlist(service,  "pnc_util", "pneum_util", "diarr_util", "malnu_util")
	sort service pct_change
	replace service = "Postnatal care visits" if service=="pnc_util"
	replace service = "Sick child visits: pneumonia" if service=="pneum_util"
	replace service = "Sick child visits: diarrhea" if service=="diarr_util"
	replace service = "Sick child visits: malnutrition" if service=="malnu_util"

	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(green) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(green)) title("Child health services", size(vsmall))
	********************************************************************************
	* Vaccinations 
	u "$analysis/Results/Tables/tmp.dta", clear
	keep if inlist(service,  "vacc_qual", "pent_qual", "measles_qual", "pneum_qual", "bcg_qual") 
	sort service pct_change
	replace service = "Fully vaccinated children by age 1" if service=="vacc_qual"
	replace service = "Pentavalent vaccinations" if service=="pent_qual"
	replace service = "Measles vaccinations" if service=="measles_qual"
	replace service = "Pneumococcal vaccinations" if service=="pneum_qual"
	replace service = "BCG vaccinations" if service=="bcg_qual"
	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(orange) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(orange)) title("Child vaccinations", size(vsmall)) 
	 ********************************************************************************  	   
	* HIV TB Malaria
	u "$analysis/Results/Tables/tmp.dta", clear
	keep if inlist(service,  "art_util", "hivtest_qual", "tbdetect_qual", ///
							 "tbscreen_qual", "tbtreat_qual", "malaria_util" ) 
	sort service pct_change
	replace service = "Number of people on ART" if service=="art_util"
	replace service = "Number of people tested for HIV" if service=="hivtest_qual"
	replace service = "Number of TB cases detected" if service=="tbdetect_qual"
	replace service = "Number of people screened for TB" if service=="tbscreen_qual"
	replace service = "Number of people initiated on TB treatment" if service=="tbtreat_qual"
	replace service = "Number of visits for malaria" if service=="malaria_util"
	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(red) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(red)) title("HIV, TB and malaria services", size(vsmall)) texts(75)
	********************************************************************************  	   
	* Chronic diseases and accidents
	u "$analysis/Results/Tables/tmp.dta", clear
	keep if inlist(service,  "diab_util", "hyper_util", "cerv_qual", ///
							 "breast_util", "mental_util", "road_util" ) 
	sort service pct_change
	replace service = "Diabetes visits" if service=="diab_util"
	replace service = "Hypertension visits" if service=="hyper_util"
	replace service = "Cervical cancer screening" if service=="cerv_qual"
	replace service = "Breast cancer screening" if service=="breast_util"
	replace service = "Mental health visits" if service=="mental_util"
	replace service = "Road traffic accidents" if service=="road_util"
	*Forest plot
	metan pct_change LCL_pct_change UCL_pct_change, by(service) nosubgroup nooverall ///
		   nobox force graphregion(color(white)) label(namevar=country) effect(Percent change from pre-Covid level) ///
		   xlabel(-100, -50, 0, 50, 100) xtick (-100, -50, 0, 50, 100) ciopt(lcolor(purple) lwidth(thin)) ///
		   pointopt(msize(tiny) mcolor(purple)) title("Chronic diseases and accidents", size(vsmall))
	
		   
		   
		   
		   
		   
/*
		gen postCovid=.
		replace postCovid = rmonth>14 if inlist(country, "ETH", "NEP") // remove last month?
		// pandemic period is month 15 to 24 in ETH and NEP
		replace postCovid = rmonth>15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		// pandemic period is month 16 to 24 in all other countries
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country, "ETH", "NEP")
		replace timeafter = rmonth-15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		
		
		* Variables to assess resumption by Dec 31, 2020
		* "Temporary" post-Covid period now excludes december
		gen postCovid_dec=. 
		replace postCovid_dec = rmonth>14 if inlist(country, "ETH", "NEP") 
		replace postCovid_dec = rmonth>15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace postCovid_dec=0 if rmonth==24
		* Indicator for December (withdrawal of the postCovid period)
		gen dec20= rmonth==24 
		* Slope change excludes Dec 2020
		gen timeafter_dec= . 
		replace timeafter_dec = rmonth-14 if inlist(country, "ETH", "NEP")
		replace timeafter_dec = rmonth-15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter_dec=0 if timeafter_dec<0
		replace timeafter_dec=0 if rmonth==24

		
		* ME REML
		mixed factor1_sd log_n i.fac_type rural st_hh_lbpl st_hh_black st_p_age_60 i.province i.test_year ///
		|| H_MUNIC: || fac_id: , residuals(ar,t(test_year)) reml
		
		* GEE Exchangeable
		xtgee `var' postCovid rmonth timeafter i.season resumption ///
		, family(gaussian) link(identity) corr(exchangeable) vce(robust)	
		
		* GEE AR1
		xtgee `var' postCovid rmonth timeafter i.season resumption ///
		, family(gaussian) link(identity) corr(ar1) vce(robust)	
		
		* Fourier terms for seasonality adjustment: result in overfitted model
		gen degrees=(rmonth/12)*360
		fourier degrees, n(2)
		* Stata package "Circular" is needed for Fourier transformation

********************************************************************************
	* Descriptives for table 1: average before and during Covid
	* For sentinel services
********************************************************************************	
putexcel set "$analysis/Results/Tables/Results JUL8.xlsx", sheet("`c'")  modify
	local i = 29
	putexcel A29="Average before and during Covid"
		foreach x of global sentinel {
			local i = `i'+1
			putexcel A`i'="`x'"
				cap confirm variable `x'
				if _rc==0 {
					su `x' if postCovid==0 
						putexcel B`i'= `r(mean)'
					su `x' if postCovid==1
						putexcel C`i'= `r(mean)'
					}
		} 
