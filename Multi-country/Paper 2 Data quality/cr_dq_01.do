* HS Performance during COVID - Data quality analysis
* Created July 27, 2021 
* Ethiopia, Haiti, KZN, Lao, Nepal
* Completeness

clear all
set more off	
********************************************************************************
* Use dataset before cleaning
* Ethiopia 
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta", clear

* Sentinel indicators (These can be updated once they are decided)
global sentinel opd_util anc_util totaldel pnc_util pent_qual 

* Region names	
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname 

* OUTLIERS 
foreach x of global sentinel {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 
	keep region-orgunitlevel4 opd_util* anc_util* totaldel* pnc_util* pent_qual* flag*
	reshape long opd_util anc_util totaldel pnc_util pent_qual flag_outlier_opd_util ///
				 flag_outlier_anc_util  flag_outlier_totaldel flag_outlier_pnc_util ///
				 flag_outlier_pent_qual, i(region zone org*) j(month) string		
	* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month
	collapse (count) anc_util-totaldel (sum) flag_outlier* , by (year month )
	foreach x of global sentinel {
		gen pct_outlier`x' = flag_outlier_`x' / `x'
	}
	export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Eth_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS 

keep region-orgunitlevel4 opd_util* anc_util* totaldel* pnc_util* pent_qual*  diab_util*
reshape long opd_util anc_util totaldel pnc_util pent_qual, ///
             i(region zone org*) j(month) string		
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
		month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
		month=="9_20" |	month=="10_20" | ///
		month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month
sort org* year mo 
order org* year mo 
rename mo month

collapse (count) anc_util-totaldel , by (year month)
			  
foreach x of global sentinel {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year opd_util anc_util totaldel pnc_util pent_qual completeness_*

export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Eth_completeness) firstrow(variable) sheetreplace  

********************************************************************************
* Use dataset before cleaning
* Haiti
clear
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear

* Sentinel indicators (These can be updated once they are decided)
global sentinel opd_util anc_util del_util pnc_util vacc_qual diab_util

* OUTLIERS 
foreach x of global sentinel {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 
	keep orgunitlevel1-orgunitlevel3 ID Number opd_util* anc_util* del_util* pnc_util* vacc_qual* diab_util* flag*
	reshape long opd_util anc_util del_util pnc_util vacc_qual diab_util flag_outlier_opd_util ///
				 flag_outlier_anc_util  flag_outlier_del_util flag_outlier_pnc_util ///
				 flag_outlier_vacc_qual flag_outlier_diab_util, ///
				 i(orgunitlevel1 orgunitlevel2 orgunitlevel3 ID Number) j(month) string	
	* Month and year
	drop if month == "1_21" | month == "2_21" | month == "3_21"
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month
	collapse (count) anc_util-vacc_qual (sum) flag_outlier* , by (year month )
	foreach x of global sentinel {
		gen pct_outlier`x' = flag_outlier_`x' / `x'
	}
	export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Hat_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS 

keep orgunitlevel1-orgunitlevel3 ID Number opd_util* anc_util* del_util* pnc_util* vacc_qual* diab_util*
reshape long opd_util anc_util del_util pnc_util vacc_qual diab_util, ///
             i(orgunitlevel1 orgunitlevel2 orgunitlevel3 ID Number) j(month) string		
* Month and year
drop if month == "1_21" | month == "2_21" | month == "3_21"
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
		month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
		month=="9_20" |	month=="10_20" | ///
		month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month
sort org* year mo 
order org* year mo 
rename mo month

collapse (count) anc_util-vacc_qual , by (year month)
			  
foreach x of global sentinel {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year opd_util anc_util del_util pnc_util vacc_qual diab_util completeness_*

export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Hat_completeness) firstrow(variable) sheetreplace  

********************************************************************************
* Use dataset before cleaning
* KZN
clear
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide.dta", clear

* Sentinel indicators (These can be updated once they are decided)
global sentinel opd_util anc1_util totaldel pnc_util pent_qual diab_util

* OUTLIERS 
foreach x of global sentinel {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1 2 3 4 5 6 7 8 9 10 11 12 ///
				 13 14 15 16 17 18 19 20 21 22 23 24 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 
	keep Province dist subdist Facility opd_util* anc1_util* totaldel* pnc_util* pent_qual* diab_util* flag*
	reshape long opd_util anc1_util totaldel pnc_util pent_qual diab_util flag_outlier_opd_util ///
				 flag_outlier_anc1_util  flag_outlier_totaldel flag_outlier_pnc_util ///
				 flag_outlier_pent_qual flag_outlier_diab_util, ///
				 i(Province dist subdist Facility) j(month)	
	*Month and year
	gen year = 2019
	replace year= 2020 if month>=13	
	replace month=month-12 if month>=13
	collapse (count) anc1_util-pent_qual (sum) flag_outlier* , by (year month )
	foreach x of global sentinel {
		gen pct_outlier`x' = flag_outlier_`x' / `x'
	}
	export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(KZN_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS 

keep Province dist subdist Facility opd_util* anc1_util* totaldel* pnc_util* pent_qual* diab_util*
reshape long opd_util anc1_util totaldel pnc_util pent_qual diab_util, ///
             i(Province dist subdist Facility) j(month)	
* Month and year
gen year = 2019
replace year= 2020 if month>=13	
replace month=month-12 if month>=13

*** NOT SURE WHAT's HAPPENING HERE - If you so sum instead the values are as expected 

* collapse (sum) anc1_util-pent_qual , by (year month)

collapse (count) anc1_util-pent_qual , by (year month)


			  
foreach x of global sentinel {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year opd_util anc1_util totaldel pnc_util pent_qual diab_util completeness_*

export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(KZN_completeness) firstrow(variable) sheetreplace  

********************************************************************************
* Use dataset before cleaning
* Lao
clear
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_Jan19-Dec20_WIDE.dta", clear


* Sentinel indicators (These can be updated once they are decided)
global sentinel opd_util anc_util totaldel pnc_util pent_qual diab_util

* OUTLIERS 
foreach x of global sentinel {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 
	keep org* opd_util* anc_util* totaldel* pnc_util* pent_qual* diab_util* flag*
	reshape long opd_util anc_util totaldel pnc_util pent_qual diab_util flag_outlier_opd_util ///
				 flag_outlier_anc_util  flag_outlier_totaldel flag_outlier_pnc_util ///
				 flag_outlier_pent_qual flag_outlier_diab_util, ///
				 i(orgunitlevel2-organisationunitname) j(month) string
	*Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month
	collapse (count) opd_util-totaldel (sum) flag_outlier* , by (year month )
	foreach x of global sentinel {
		gen pct_outlier`x' = flag_outlier_`x' / `x'
	}
	export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Lao_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS 

keep org* opd_util* anc_util* totaldel* pnc_util* pent_qual* diab_util*
reshape long opd_util anc_util totaldel pnc_util pent_qual diab_util, ///
             i(orgunitlevel2-organisationunitname) j(month) string
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month

collapse (count) opd_util-totaldel, by (year month)
			  
foreach x of global sentinel {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year opd_util anc_util totaldel pnc_util pent_qual diab_util completeness_*

export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Lao_completeness) firstrow(variable) sheetreplace  

********************************************************************************
* Use dataset before cleaning
* Nepal
clear
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", clear

* Sentinel indicators (These can be updated once they are decided)
global sentinel opd_util anc_util totaldel pnc_util pent_qual diab_util

* OUTLIERS 
foreach x of global sentinel {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 
	keep org* opd_util* anc_util* totaldel* pnc_util* pent_qual* diab_util* flag*
	reshape long opd_util anc_util totaldel pnc_util pent_qual diab_util flag_outlier_opd_util ///
				 flag_outlier_anc_util  flag_outlier_totaldel flag_outlier_pnc_util ///
				 flag_outlier_pent_qual flag_outlier_diab_util, ///
				 i(orgunitlevel1-organisationunitname) j(month) string
	*Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month
	collapse (count) diab_util-totaldel (sum) flag_outlier* , by (year month )
	foreach x of global sentinel {
		gen pct_outlier`x' = flag_outlier_`x' / `x'
	}
	export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Nep_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS 

keep org* opd_util* anc_util* totaldel* pnc_util* pent_qual* diab_util*
reshape long opd_util anc_util totaldel pnc_util pent_qual diab_util, ///
             i(orgunitlevel1-organisationunitname) j(month) string
* Month and year
	gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	///
			month=="5_20" |	month=="6_20"  | month=="7_20" |	month=="8_20" |	///
			month=="9_20" |	month=="10_20" | ///
			month=="11_20" |	month=="12_20"
	replace year = 2019 if year==.
	gen mo = 1 if month =="1_19" | month =="1_20"
	replace mo = 2 if month =="2_19" | month =="2_20"
	replace mo = 3 if month =="3_19" | month =="3_20"
	replace mo = 4 if month =="4_19" | month =="4_20"
	replace mo = 5 if month =="5_19" | month =="5_20"
	replace mo = 6 if month =="6_19" | month =="6_20"
	replace mo = 7 if month =="7_19" | month =="7_20"
	replace mo = 8 if month =="8_19" | month =="8_20"
	replace mo = 9 if month =="9_19" | month =="9_20"
	replace mo = 10 if month =="10_19" | month =="10_20"
	replace mo = 11 if month =="11_19" | month =="11_20"
	replace mo = 12 if month =="12_19" | month =="12_20"
	drop month
	sort org* year mo 
	order org* year mo 
	rename mo month

collapse (count) diab_util-totaldel, by (year month)
			  
foreach x of global sentinel {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year opd_util anc_util totaldel pnc_util pent_qual diab_util completeness_*

export excel using "$user/$analysis/Results/ResultsAUG30.xlsx", sheet(Nep_completeness) firstrow(variable) sheetreplace  


