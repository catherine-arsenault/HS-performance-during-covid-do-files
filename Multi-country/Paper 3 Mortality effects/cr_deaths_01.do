* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 
* Dataset creation 

********************************************************************************
* 1 CHILE (facility)
u "$user/$CHLdata/Data for analysis/Chile_su_24months.dta", clear 
	keep region-month *mort* ipd_util totaldel
	collapse (sum) ipd_mort_num-totaldel , by(region year month)
	*encode region, gen(reg)
	rename ipd_util discharge
	gen ipd_util = discharge + ipd_mort_num
	drop discharge
	gen country="CHL"
save "$user/$CHLdata/Data for analysis/CHLtmp_deaths.dta", replace
********************************************************************************
* 2 ETHIOPIA (facility/woreda)
u "$user/$ETHdata/Data for analysis/Ethiopia_su_24months.dta", replace 
	keep region-month totaldel  ipd_util *mort*
	collapse (sum) totaldel-totalipd_mort_num, by (region year month)
	rename (totalipd_mort_num newborn_mort_num) (ipd_mort_num neo_mort_num)
	drop if region=="Tigray" // Tigray stopped reporting in October 2020 due to war	
	*encode region, gen(reg)
	gen country="ETH"
	drop er_mort_num
save "$user/$ETHdata/Data for analysis/ETHtmp_deaths.dta", replace
********************************************************************************
* 3 GHANA (region)
u  "$user/$GHAdata/Data for analysis/Ghana_su_24months.dta", clear 
	keep region year month *mort* ipd_util totaldel 
	rename (newborn_mort_num) (neo_mort_num)
	*encode region, gen(reg)
	gen country="GHA"
save "$user/$GHAdata/Data for analysis/GHAtmp_deaths.dta", replace
********************************************************************************
* 4 HAITI (facility)
use "$user/$HTIdata/Data for analysis/Haiti_su_24months.dta", clear
	keep orgunitlevel1-ID sb_mort_num mat_mort_num del_util
	rename del_util totaldel
	collapse (sum) sb_mort_num mat_mort_num totaldel, by (orgunitlevel2 year month)
	*encode orgunitlevel2, gen(reg)
	rename orgunitlevel2 region
	gen country="HTI"
save "$user/$HTIdata/Data for analysis/HTItmp_deaths.dta", replace
********************************************************************************
* 5 KZN, SA (facility)
use "$user/$KZNdata/Data for analysis/KZN_su_24months.dta", clear 
	keep Province-month newborn_mort_num sb_mort_num mat_mort_num totaldel ///
		 ipd_mort_num ipd_util  
	rename newborn_mort_num neo_mort_num	 
	collapse (sum) totaldel-ipd_mort_num, by(dist year month)
	*rename dist reg
	decode dist, gen(region)
	drop dist
	gen country="KZN"
save "$user/$KZNdata/Data for analysis/KZNtmp_deaths.dta", replace
********************************************************************************
* 6 LAO (facility)
use "$user/$LAOdata/Data for analysis/Lao_su_24months.dta", clear
	keep orgunitlevel2-month neo_mort_num sb_mort_num mat_mort_num totaldel
	collapse (sum) neo_mort_num sb_mort_num mat_mort_num totaldel, ///
	by(orgunitlevel2 year month)
	*encode orgunitlevel2 , gen(reg)
	rename orgunitlevel2 region
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOtmp_deaths.dta", replace
********************************************************************************
* 7 MEXICO (region)
use  "$user/$MEXdata/Data for analysis/Mexico_su_24months.dta", clear 
keep Delegation year month newborn_mort_num mat_mort_num  ///
	 ipd_mort_num  ipd_util totaldel del_util 
	 rename newborn_mort_num neo_mort_num
	 *encode Delegation, gen(reg)
	 rename Delegation region
	 gen country="MEX"
save "$user/$MEXdata/Data for analysis/MEXtmp_deaths.dta", replace	 
********************************************************************************
* 8 NEPAL (palika (municipality))
use "$user/$NEPdata/Data for analysis/Nepal_su_24months.dta", clear
	keep org* year month sb_mort_num mat_mort_num ipd_mort_num neo_mort_num ///
	del_util ipd_util
	rename del_util totaldel
	collapse (sum) sb_mort_num mat_mort_num ipd_mort_num neo_mort_num totaldel ///
	ipd_util , by (orgunitlevel3 year month)
	*encode orgunitlevel3, gen(reg)
	rename orgunitlevel3 region
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPtmp_deaths.dta", replace
********************************************************************************
* 9 SOUTH KOREA (region)
u  "$user/$KORdata/Data for analysis/Korea_su_24months.dta", clear
	keep reg year month newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num ///
		 totaldel ipd_util 
	rename newborn_mort_num neo_mort_num
	*encode region, gen(reg)
	gen country="KOR"
save "$user/$KORdata/Data for analysis/KORtmp_deaths.dta", replace

********************************************************************************
	* Combine datasets and create variables for analyses
********************************************************************************

foreach c in CHL ETH GHA HTI KZN LAO MEX NEP  {
	append using "$user/$`c'data/Data for analysis/`c'tmp_deaths.dta"
	save "$analysis/Data/multicountry_deaths.dta",  replace
}

		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		sort reg rmonth
		lab def rmonth 1"J19" 2"F19" 3"M19" 4"A19" 5"M19" 6"J19" 7"J19" 8"A19" 9"S19" 10"O19" 11"N19" 12"D19" ///
		13"J20" 14"F20" 15"M20" 16"A20" 17"M20" 18"J20" 19"J20" 20"A20" ///
		21"S20" 22"O20" 23"N20" 24"D20" 25"J21" 26"F21" 27"M21" 28"A21" 29"M21" 30"J21"
		lab val rmonth rmonth 
		
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
		replace postCovid = rmonth>=16 & rmonth<. if inlist(country, ///
				"CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<. if inlist(country,  "NEP") 
		
		* Slope change excludes Dec 2020
		gen timeafter= . 
		replace timeafter = rmonth-14 if inlist(country,  "NEP")
		replace timeafter= rmonth-15 if inlist(country, ///
				"CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0

		order country reg year month rmonth 
		sort country reg year month
		encode region, gen(reg)
		encode country, gen(co)
	save "$analysis/Data/multicountry_deaths.dta",  replace	




