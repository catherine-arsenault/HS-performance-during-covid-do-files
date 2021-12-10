* HS performance during Covid
* KZN, South Africa
* Data cleaning,
* Created by Catherine Arsenault, September 2020
/********************************************************************
SUMMARY: This do file contains methods to address data quality issues
in Dhis2. It uses a dataset in wide form (1 row per health facility)

1 Impute 0s for missing values: 
	- For mortality, 0s are imputed if the facility offers the
	  service the mortality indicator relates to.

2 Identify extreme outliers and set them to missing

3 Complete case analysis: keep only health facilities that have 
  reported consistently 
  
4 Creates 2 dataset: one for the dashboard and one for analyses
********************************************************************/
clear all 
set more off	

u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide21.dta", clear

global volumes totaldel opd_util ipd_util diab_util pent_qual 
	
/****************************************************************
              Keep facilities with 19/30 months
****************************************************************/
	foreach x of global volumes {
			 	preserve
					keep Facility Province subdist dist `x'* 
					egen total`x'= rownonmiss(`x'*)
					keep if total`x'>=19
					/* keep if at least 19 out of 30 months are reported */
					drop total`x'
					save "$user/$data/Data for analysis/tmp`x'.dta", replace
				restore
				}
	u "$user/$data/Data for analysis/tmptotaldel.dta", clear
	
	foreach x in opd_util ipd_util diab_util pent_qual {
			 	merge 1:1 Facility Province subdist dist using "$user/$data/Data for analysis/tmp`x'.dta"
				drop _merge
				save "$user/$data/Data for analysis/KZN_2021_WIDE_CCA.dta", replace
		}
	foreach x of global volumes {
			 rm "$user/$data/Data for analysis/tmp`x'.dta"
			 }	

/****************************************************************
              IDENTIFY OUTLIERS AND SET TO MISSING 
****************************************************************/
use "$user/$data/Data for analysis/KZN_2021_WIDE_CCA.dta", clear
foreach x of global volumes {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	forval v = 1/24 {
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}	

/****************************************************************
              Collapse to Dist level
****************************************************************/
	drop Province
	encode Facility, gen(facname)
	collapse (sum) totaldel1-pent_qual30 , by(dist)
			 
/****************************************************************
              Reshape
****************************************************************/
reshape long totaldel opd_util ipd_util diab_util pent_qual, i(dist) j(rmonth) 
	
gen month= rmonth
replace month=month-12 if month>=13
replace month=month-12 if month>=13
gen year = 2019
replace year= 2020 if rmonth>=13	
replace year= 2021 if rmonth>=25

/****************************************************************
              Covid and resumption periods
****************************************************************/
	
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
		replace postCovid = rmonth>=16 & rmonth<=21
		* Resumption period 
		gen resumption=. 
		replace resumption = rmonth>=22 & rmonth<=24 
		
		* Slope change excludes "resumption period"
		gen timeafter= . 
		replace timeafter= rmonth-15
		replace timeafter=0 if timeafter<0
		replace timeafter=0 if resumption==1
		
rename dist reg		

	save "$user/$data/Data for analysis/KZNtmp_2021.dta", replace	



