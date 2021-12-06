
* 8 NEPAL (palika (municipality))
use "$user/$NEPdata/Data for analysis/Nepal_su_30months.dta", clear
rename fp_sa_util fp_util 
save "$user/$NEPdata/Data for analysis/Nepal_su_30months_for_analyses.dta", replace
* Count of observations
collapse (count) fp_util-pneum_qual , by (year month)		  
export excel using "$analysis/Results/Tables/CountsDEC3.xlsx", sheet(NEP, replace) firstrow(variable)  


use "$user/$NEPdata/Data for analysis/Nepal_su_30months_for_analyses.dta",  clear
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPtmp2.dta", replace

********************************************************************************
	* Creates variables for analyses
********************************************************************************
*foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
foreach c in NEP  {
	u "$user/$`c'data/Data for analysis/`c'tmp2.dta", clear

		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		replace rmonth = month+24 if year ==2021
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
		replace postCovid = rmonth>=16 & rmonth<=21 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<=20 if inlist(country,  "NEP") 
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=30 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace resumption = rmonth>=21 & rmonth<=30 if inlist(country,  "NEP") 
		
		* Slope change excludes resumption
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country,  "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1

	save "$user/$`c'data/Data for analysis/`c'tmp2.dta", replace	

}
