* HS Performance during COVID - Data quality analysis
* Created July 27, 2021 
* Ethiopia, Haiti, KZN, Lao, Nepal
* Completeness

clear all
set more off	

*** Ethiopia *** 

u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta", clear

* Sentinel indicators (These can be updated once they are decided)
global all anc_util cs_util del_util opd_util

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

**** OUTLIERS ****

foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		*replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

preserve 

collapse (sum) flag_outlier_anc_util1_19-flag_outlier_opd_util12_20, by(region)


export excel using "$analysis/Results/Results.xlsx", sheet(Eth_outliers) firstrow(variable) sheetreplace  

restore 


**** COMPLETENESS ****

preserve 

drop flag_outlier_*

reshape long fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util ///
		totaldel ipd_util er_util road_util diab_util hyper_util diab_detec hyper_detec   ///
				opd_util hivsupp_qual_num diab_qual_num hyper_qual_num vacc_qual pent_qual bcg_qual ///
				measles_qual opv3_qual pneum_qual rota_qual art_util  ///
				  newborn_mort_num sb_mort_num icu_mort_num ipd_mort_num ///
				mat_mort_num er_mort_num totalipd_mort_num, i(region zone org*) j(month) string	
	
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

collapse (count) fp_util-totalipd_mort_num , by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		

keep month year completeness_*

export excel using "$analysis/Results/Results.xlsx", sheet(Eth_completeness) firstrow(variable) sheetreplace  

restore 

