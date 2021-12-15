* Health system resilience during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Trends in 2021

* ETHIOPIA
use "$user/$ETHdata/Data for analysis/Ethiopia_su_30months.dta", clear
collapse (sum) del_util-pent_qual , by (region year month)
	encode region, gen(reg)
	gen country="ETH"
save "$user/$ETHdata/Data for analysis/ETHtmp2.dta", replace

* KOREA
use "$user/$data/Data for analysis/Korea_su_29months.dta", clear 
	encode region, gen(reg)
	gen country="KOR"
save "$user/$KORdata/Data for analysis/KORtmp2.dta", replace
* LAOS 
u "$user/$LAOdata/Data for analysis/Lao_su_30months.dta", clear 
collapse (sum) del_util-ipd_util , by (orgunitlevel2 year month)
	encode orgunitlevel2, gen(reg)
	gen country="LAO"
save "$user/$LAOdata/Data for analysis/LAOtmp2.dta", replace

* MEXICO 
import excel using "$user/$MEXdata/Raw/2021/edited for analyses_Concentrado de indicadoresIMSS_04112021.xlsx", firstrow clear
gen del_util=totaldel-cs_util
append using "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta"
	encode Deleg, gen(reg)	
	gen country="MEX"
	drop if Deleg=="National"
save "$user/$MEXdata/Data for analysis/MEXtmp2.dta", replace

* NEPAL 
use "$user/$NEPdata/Data for analysis/Nepal_su_30months.dta", clear
rename fp_sa_util fp_util 
	rename (orgunitlevel2 orgunitlevel3) (Province District)
	collapse (sum) $NEPall, by (Dist year month)
	encode Dist, gen(reg)
	gen country="NEP"
save "$user/$NEPdata/Data for analysis/NEPtmp2.dta", replace

* KZN (separate do files)

* THAILAND
use "$user/$THAdata/Data for analysis/Thailand_su_30months.dta", clear
	encode Province, gen(reg)
	gen country="THA"
save "$user/$THAdata/Data for analysis/THAtmp2.dta", replace	
********************************************************************************
	* Creates variables for analyses
********************************************************************************
*foreach c in CHL ETH GHA HTI KZN LAO MEX NEP KOR THA {
foreach c in ETH KOR LAO NEP MEX THA {
	u "$user/$`c'data/Data for analysis/`c'tmp2.dta", clear

		gen rmonth= month if year==2019
		replace rmonth = month+12 if year ==2020
		replace rmonth = month+24 if year ==2021
		sort reg rmonth
		drop if rmonth==31 | rmonth==32
		
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

		* "Temporary" Covid period 
		gen postCovid=. 
		replace postCovid = rmonth>=16 & rmonth<=21 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace postCovid = rmonth>=15 & rmonth<=20 if inlist(country,  "NEP") 
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=30 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA")
		replace resumption = rmonth>=21 & rmonth<=30 if inlist(country,  "NEP") 
		
		* Slope change excludes resumption
		gen timeafter=. 
		replace timeafter = rmonth-14 if inlist(country,  "NEP")
		replace timeafter= rmonth-15 if inlist(country, "CHL", "ETH", "GHA", "HTI", "KZN", "LAO", "MEX", "KOR", "THA") 
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1
		
	save "$user/$`c'data/Data for analysis/`c'tmp2.dta", replace	

}
