* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Dataset creation 

********************************************************************************
* 1 CHILE (facility)
u "$user/$CHLdata/Data for analysis/Chile_su_24months.dta", clear 

********************************************************************************
* 2 ETHIOPIA (facility/woreda)
u "$user/$ETHdata/Data for analysis/Ethiopia_su_24months.dta", replace 
	keep region-month totaldel er_util ipd_util *mort*
	collapse (sum) totaldel-totalipd_mort_num, by (region year month)
	rename totalipd_mort_num ipd_mort_num
	drop if region=="Tigray" // Tigray stopped reporting in October 2020 due to war	
	encode region, gen(reg)
	gen country="ETH"
save "$user/$ETHdata/Data for analysis/ETHtmp.dta", replace
********************************************************************************
* 3 GHANA (region)
u  "$user/$GHAdata/Data for analysis/Ghana_su_24months.dta", clear 
	keep region year month *mort* ipd_util totaldel 
	encode region, gen(reg)
	gen country="GHA"
save "$user/$GHAdata/Data for analysis/GHAtmp.dta", replace

********************************************************************************
	* Creates variables for analyses
********************************************************************************
* foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
foreach c in  ETH  {
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

		* Covid period 
		gen postCovid=. 
		replace postCovid = rmonth>=16 & rmonth<. if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<. if inlist(country,  "NEP") 
		
		* Slope change excludes Dec 2020
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country,  "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0

	save "$user/$`c'data/Data for analysis/`c'tmp.dta", replace	

}
