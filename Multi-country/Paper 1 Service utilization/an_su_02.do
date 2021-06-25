* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, June 2021
* Program by Sebastian Bauhoff
********************************************************************************
* Collapse facility level datasets & create country codes

*1
use "$user/$CHLdata/Data for analysis/Chile_su_24months_for_analyses.dta",  clear
	collapse (sum) $CHLall, by (region year month)
	encode region, gen(reg)
	gen country="CHL"
save "$user/$CHLdata/Data for analysis/CHLtmp.dta", replace
*2
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear
	collapse (sum) $ETHall, by (region year month)
	encode region, gen(reg)
	gen country="ETH"
save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
* 3
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear
	encode region, gen(reg)	
	gen country="GHA"
save  "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace
* 4
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 departement
	collapse (sum) $HTIall, by (departement year month)
	encode departement, gen(reg)
	gen country="HTI"
save "$user/$HTIdata/Data for analysis/HTItmp.dta", replace
* 5
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
	collapse (sum) $KZNall, by (dist year month rmonth)
	drop rmonth
	rename dist reg
	gen country="KZN"
save "$user/$KZNdata/Data for analysis/KZNtmp.dta", replace
* 6
use "$user/$LAOdata/Data for analysis/LAO_su_24months_for_analyses.dta",  clear
	rename orgunitlevel2 Province
	collapse (sum) $LAOall, by (Province year month)
	encode Province, gen(reg)
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOtmp.dta", replace
* 7
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
	encode Deleg, gen(reg)	
	gen country="MEX"
save "$user/$MEXdata/Data for analysis/MEXtmp.dta", replace
* 8
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPtmp.dta", replace
* 9 
u "$user/$KORdata/Data for analysis/Korea_su_24months_for_analyses.dta", clear 
	encode region, gen(reg)
	cap drop country
	gen country="KOR"
save "$user/$KORdata/Data for analysis/KORtmp.dta", replace
* 10 
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear
	encode Province, gen(reg)	
	gen country="THA"
save "$user/$THAdata/Data for analysis/THAtmp.dta", replace
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
		
foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
	
********************************************************************************
	* Creates variables for analyses
********************************************************************************
	u "$user/$`c'data/Data for analysis/`c'tmp.dta", clear

		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		sort reg rmonth
		
		gen season = .
		recode season (.=1) if ( month>=3 & month<=5  )
		recode season (.=2) if ( month>=6 & month<=8  )
		recode season (.=3) if ( month>=9 & month<=11 )
		recode season (.=4) if inlist(month, 1, 2, 12)             
		la var season "Season"
		la def season 1 "Spring" 2 "Summer" 3 "Fall" 4 "Winter"
		la val season season

		* "Temporary" Covid period 
		gen postCovid=. 
		replace postCovid = rmonth>=16 & rmonth<=21 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<=20 if inlist(country, "ETH", "NEP") 
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=24 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace resumption = rmonth>=21 & rmonth<=24 if inlist(country, "ETH", "NEP") 
		
		* Slope change excludes Dec 2020
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country, "ETH", "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1

	save "$user/$`c'data/Data for analysis/`c'tmp.dta", replace	

********************************************************************************
	* Regression analysis: Level change during the first 6 months of the 
	* pandemic and resumption in the last quarter of 2020
********************************************************************************
	putexcel set "$analysis/Results/Tables/Results JUNE23_quarters.xlsx", sheet("`c'")  modify
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
