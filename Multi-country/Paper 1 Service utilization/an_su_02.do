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
		
		gen postCovid=.
		replace postCovid = rmonth>14 if inlist(country, "ETH", "NEP") 
		// pandemic period is month 15 to 24 in ETH and NEP
		replace postCovid = rmonth>15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "NEP", "KOR", "THA") 
		// pandemic period is month 16 to 24 in all other countries
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country, "ETH", "NEP")
		replace timeafter = rmonth-15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "NEP", "KOR", "THA") 
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
		gen postCovid_dec=. 
		replace postCovid_dec = rmonth>14 if inlist(country, "ETH", "NEP") 
		replace postCovid_dec = rmonth>15 if inlist(country, "CHL", "GHA", "HTI", "KZN", "LAO", "MEX", "NEP", "KOR", "THA") 
		replace postCovid_dec=0 if rmonth==24
		* Indicator for December (withdrawal of the postCovid period)
		gen dec20= rmonth==24 

	save "$user/$`c'data/Data for analysis/`c'tmp.dta", replace	
	
	********************************************************************************
	* Level change during the pandemic 
	********************************************************************************
	putexcel set "$analysis/Results/Tables/Results JUNE23.xlsx", sheet("`c'")  modify
	putexcel A1 = "`c'"
	putexcel A2 = "Health service" B2="Average over the pre-Covid period" 
	putexcel C2= "RD postCovid" D2="LCL" E2="UCL" F2="p-value" G2 ="% change"
	local i = 2

	xtset reg rmonth 

	foreach var of global `c'all {
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

	foreach var of global `c'all {
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
}
