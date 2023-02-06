* HS Performance during COVID - Data quality analysis
* Created July 27, 2021 
* Ethiopia, Haiti, KZN, Lao, Nepal
* Completeness

clear all
set more off	
********************************************************************************
* ETHIOPIA
* Use dataset before cleaning

u "$user/HMIS Data for Health System Performance Covid (all countries)/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_Jan19-Dec20_WIDE_dq.dta", clear

* All indicators 
global all fp_util anc_util totaldel cs_util pnc_util diarr_util pneum_util ///
           sam_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
           rota_qual art_util opd_util er_util ipd_util  road_util hivsupp_qual_num /// 
		   diab_util hyper_util diab_detec hyper_detec cerv_qual kmc_qual_num /// 
		   kmc_qual_denom resus_qual_num resus_qual_denom sb_mort_num ///
		   newborn_mort_num mat_mort_num ipd_mort_num er_mort_num icu_mort_num

drop sti_util* del_util* diab_qual_num* hyper_qual_num*	 
		   
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

*Treating mortality as it was in first paper: if the service is provided, replace to missing. If it is not provided, keep missing.
egen total_del = rowtotal(totaldel*)
foreach var in mat_mort_num newborn_mort_num {
egen total`var' = rowtotal(`var'*)
forval i=1/12 {
	replace `var'`i'_19=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_19=. if total_del==0 & total`var'==0
	replace `var'`i'_20=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_20=. if total_del==0 & total`var'==0	
}
}
foreach k in ipd er {
egen total_`k' = rowtotal(`k'_util*)
egen total_`k'mort = rowtotal(`k'_mort_num*)
forval i=1/12 {
replace `k'_mort_num`i'_19 = 0 if total_`k'>0 & total_`k'<. & total_`k'mort==0
replace `k'_mort_num`i'_19 = . if total_`k'==0 & total_`k'mort==0
replace `k'_mort_num`i'_20 = 0 if total_`k'>0 & total_`k'<. & total_`k'mort==0
replace `k'_mort_num`i'_20 = . if total_`k'==0 & total_`k'mort==0
}
}

* For outlier assessment 
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) 
	gen neg_out`x' = rowmean`x'-(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_pout_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		gen flag_nout_`x'`v'= 1 if `x'`v'<neg_out`x' & `x'`v'<. 
		replace flag_pout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace flag_nout_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 

	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x'
}

* Reshaping from wide to long 
reshape long fp_util anc_util totaldel cs_util pnc_util  diarr_util ///
	        pneum_util sam_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual ///
			pneum_qual rota_qual art_util opd_util er_util ipd_util  road_util /// 
			hivsupp_qual_num diab_util hyper_util diab_detec hyper_detec /// 
			cerv_qual kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
			sb_mort_num newborn_mort_num mat_mort_num ipd_mort_num er_mort_num icu_mort_num ///
			flag_pout_fp_util flag_pout_anc_util ///
			flag_pout_totaldel flag_pout_cs_util flag_pout_pnc_util /// 
			flag_pout_diarr_util flag_pout_pneum_util flag_pout_sam_util flag_pout_vacc_qual /// 
			flag_pout_bcg_qual flag_pout_pent_qual flag_pout_measles_qual flag_pout_opv3_qual /// 
			flag_pout_pneum_qual flag_pout_rota_qual flag_pout_art_util flag_pout_opd_util /// 
			flag_pout_er_util flag_pout_ipd_util  flag_pout_road_util /// 
			flag_pout_hivsupp_qual_num flag_pout_diab_util flag_pout_hyper_util /// 
			flag_pout_diab_detec flag_pout_hyper_detec flag_pout_cerv_qual flag_pout_kmc_qual_num ///
			flag_pout_kmc_qual_denom flag_pout_resus_qual_num flag_pout_resus_qual_denom ///
			flag_pout_sb_mort_num flag_pout_newborn_mort_num flag_pout_mat_mort_num ///
			flag_pout_ipd_mort_num flag_pout_er_mort_num flag_pout_icu_mort_num /// 		
			flag_nout_fp_util flag_nout_anc_util ///
			flag_nout_totaldel flag_nout_cs_util flag_nout_pnc_util /// 
			flag_nout_diarr_util flag_nout_pneum_util flag_nout_sam_util flag_nout_vacc_qual /// 
			flag_nout_bcg_qual flag_nout_pent_qual flag_nout_measles_qual flag_nout_opv3_qual /// 
			flag_nout_pneum_qual flag_nout_rota_qual flag_nout_art_util flag_nout_opd_util /// 
			flag_nout_er_util flag_nout_ipd_util  flag_nout_road_util /// 
			flag_nout_hivsupp_qual_num flag_nout_diab_util flag_nout_hyper_util /// 
			flag_nout_diab_detec flag_nout_hyper_detec flag_nout_cerv_qual flag_nout_kmc_qual_num ///
			flag_nout_kmc_qual_denom flag_nout_resus_qual_num flag_nout_resus_qual_denom ///
			flag_nout_sb_mort_num flag_nout_newborn_mort_num flag_nout_mat_mort_num ///
			flag_nout_ipd_mort_num flag_nout_er_mort_num flag_nout_icu_mort_num, /// 			
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
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIERS TABLE 
preserve

	collapse (count) sb_mort_num-totaldel (sum) flag_pout* flag_nout* , by (year month preCovid)
	foreach x of global all {
		gen pct_pout`x' = flag_pout_`x' / `x'
		gen pct_nout`x' = flag_nout_`x' / `x'
		rename `x' c_`x'
	}
	collapse (mean) c_* pct_pout* pct_nout*, by(preCovid)
	reshape long c_ pct_pout pct_nout, i(preCovid) j(service) string
	reshape wide c_ pct_pout pct_nout, i(service) j(preCovid)
	rename (c_0 pct_pout0 pct_nout0 c_1 pct_pout1 pct_nout1) (Pre_Count Pre_PosOutlier Pre_NegOutlier Post_count post_PosOutlier post_NegOutlier) 
	export excel using "$user/$analysis/Results/ResultsMar29.xlsx", sheet(Eth_outliers) firstrow(variable) sheetreplace  

restore 

* Note: The few missing for pct_out is because there were 0 in the count for some diab and hyper indicators 
* COMPLETENESS GRAPHS
preserve
collapse (count) sb_mort_num-totaldel , by (year month preCovid)			  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	cap replace complete`x' = complete`x'*100
	*cap drop max`x'
	}		
	gen rmonth = month if year==2019
	replace rmonth= month+12 if year==2020
	
	* OPD
	twoway (line completeopd_util rmonth, lcolor(blue)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("Completeness in reporting of outpatient visits Ethiopia", size(msmall) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
restore
* COMPLETENESS TABLE 
preserve
	collapse (count) sb_mort_num-totaldel , by (year month preCovid)			  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	*cap drop max`x'
	}	
	export excel year month preCovid complete* using "$user/$analysis/Results/completeness_table.xlsx", sheet(Ethiopia_completeness) firstrow(variable) sheetreplace
	
	collapse (mean) complete* max*, by(preCovid)
	reshape long complete max, i(preCovid) j(service) string
	reshape wide complete max, i(service) j(preCovid) 
	**Calculate pvalue of two proportion t test:
	gen diff = complete0-complete1
	gen z = diff/(sqrt(complete1*(1-complete1)/max1))
	gen pval = 2*(1-normal(abs(z)))
	rename (complete0 complete1 max0) (postCovid preCovid Nfac) 
	drop z max1
	order service Nfac preCovid postCovid diff pval
	export excel using "$analysis/Results/ResultsMar10.xlsx", sheet(Eth_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* HAITI
* Use dataset before cleaning
clear all
u "$user/HMIS Data for Health System Performance Covid (all countries)/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear

global all opd_util fp_util anc_util cerv_qual del_util pnc_util vacc_qual diab_util ///
           hyper_util mat_mort_num sb_mort_num
keep orgunitlevel1-orgunitlevel3 ID Number opd_util* fp_util* anc_util* cerv_qual* del_util* /// 
	 pnc_util* vacc_qual* diab_util* hyper_util* mat_mort_num* sb_mort_num*

	
*Facilities also report mortality inconsistently. Treating mortality as it was in first paper
egen total_del = rowtotal(del_util*)
foreach var in mat_mort_num sb_mort_num {
egen total`var' = rowtotal(`var'*)
forval i=1/12 {
	replace `var'`i'_19=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_19=. if total_del==0 & total`var'==0
	replace `var'`i'_20=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_20=. if total_del==0 & total`var'==0	
}
}
	
* For Outlier assessment 
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	gen neg_out`x' = rowmean`x'-(3.5*(rowsd`x'))
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_poutlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		gen flag_noutlier_`x'`v'= 1 if `x'`v'<neg_out`x' & `x'`v'<. 
		replace flag_poutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
		replace flag_noutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 	
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}


reshape long opd_util fp_util anc_util cerv_qual del_util pnc_util vacc_qual diab_util ///
				 hyper_util mat_mort_num sb_mort_num flag_poutlier_opd_util flag_poutlier_fp_util flag_poutlier_anc_util  /// 
				 flag_poutlier_cerv_qual flag_poutlier_del_util flag_poutlier_pnc_util /// 
				 flag_poutlier_vacc_qual flag_poutlier_diab_util flag_poutlier_hyper_util flag_poutlier_mat_mort_num flag_poutlier_sb_mort_num ///
				 flag_noutlier_cerv_qual flag_noutlier_del_util flag_noutlier_pnc_util flag_noutlier_opd_util flag_noutlier_fp_util flag_noutlier_anc_util /// 
				 flag_noutlier_vacc_qual flag_noutlier_diab_util flag_noutlier_hyper_util flag_noutlier_mat_mort_num flag_noutlier_sb_mort_num, ///				 
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
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIERS TABLE 
preserve

	collapse (count) mat_mort_num-vacc_qual (sum) flag_poutlier* flag_noutlier*, by (year month preCovid)
	foreach x of global all {
		gen pct_pout`x' = flag_poutlier_`x' / `x'
		gen pct_nout`x' = flag_noutlier_`x' / `x'		
		rename `x' c_`x'
	}
	collapse (mean) c_* pct_pout* pct_nout*, by(preCovid)
	reshape long c_ pct_pout pct_nout, i(preCovid) j(service) string
	reshape wide c_ pct_pout pct_nout, i(service) j(preCovid)
	rename (c_0 pct_pout0 pct_nout0 c_1 pct_pout1 pct_nout1) (Pre_Count Pre_PosOutlier Pre_NegOutlier Post_count post_PosOutlier post_NegOutlier) 
	export excel using "$analysis/Results/ResultsMar29.xlsx", sheet(Hat_outliers) firstrow(variable) sheetreplace  

restore 
* COMPLETENESS GRAPHS
preserve 
collapse (count) mat_mort_num-vacc_qual , by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	cap replace complete`x' = complete`x'*100
	*cap drop max`x'
	}			
	gen rmonth = month if year==2019
	replace rmonth= month+12 if year==2020
	
	twoway (line completeopd_util rmonth, lcolor(blue)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("Completeness in reporting of outpatient visits Haiti", size(msmall) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
	/*ANC
	twoway (line completeanc_util rmonth ) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("", size(small) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
	
	Full vax
	twoway (line completevacc_qual rmonth, lcolor(green)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("", size(small) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
	
	*Diabetes
	twoway (line completeopd_util rmonth, lcolor(cyan)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("", size(small) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
	
	*Newborn deaths
	twoway (line completenewborn_mort_num rmonth, lcolor(purple)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("", size(small) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
*/
restore 
* COMPLETENESS TABLE 

preserve
	collapse (count) mat_mort_num-vacc_qual , by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	*cap drop max`x'
	}	
	export excel year month preCovid complete* using "$user/$analysis/Results/completeness_table.xlsx", sheet(Haiti_completeness) firstrow(variable) sheetreplace
	collapse (mean) complete* max*, by(preCovid)
	reshape long complete max, i(preCovid) j(service) string
	reshape wide complete max, i(service) j(preCovid) 
	**Calculate pvalue of two proportion t test:
	gen diff = complete0-complete1
	gen z = diff/(sqrt(complete1*(1-complete1)/max1))
	gen pval = 2*(1-normal(abs(z)))
	rename (complete0 complete1 max0) (postCovid preCovid Nfac) 
	drop z max1
	order service Nfac preCovid postCovid diff pval
export excel using "$analysis/Results/ResultsMar10.xlsx", sheet(Hat_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* KWAZULU NATAL, SOUTH AFRICA
* Use dataset before cleaning
clear
u "$user/HMIS Data for Health System Performance Covid (all countries)/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide.dta", clear

global all anc1_util totaldel cs_util pnc_util diarr_util pneum_util  ///
           art_util opd_util ipd_util road_util diab_util cerv_qual tbscreen_qual ///
           tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
           pneum_qual rota_qual  trauma_util icu_util kmcn_qual sam_util ///
		   newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num
keep Province dist subdist Facility factype anc1_util* totaldel* cs_util* pnc_util* diarr_util* pneum_util*  ///
     art_util* opd_util* ipd_util* road_util* diab_util* cerv_qual* tbscreen_qual* ///
     tbdetect_qual* tbtreat_qual* vacc_qual* bcg_qual* pent_qual* measles_qual* ///
     pneum_qual* rota_qual*  trauma_util* icu_util* kmcn_qual* sam_util* ///
	 newborn_mort_num* sb_mort_num* mat_mort_num* ipd_mort_num* icu_mort_num* trauma_mort_num*
	   
* Outpatient visits are missing in 2019 and then 0 in 2020
* set all to missing as these facilities do not report that indicator (it's a hospital-level indicator only)
egen totalopd=rowtotal(opd_util*)
forval i=1/24 {
	replace opd_util`i'=. if totalopd==0
}
drop totalopd

*Facilities that don't do csections inconsistently report 0 or ., switch all to . if none reported
egen totalcs = rowtotal(cs_util*)
forval i=1/24 {
	replace cs_util`i'=. if totalcs==0
}
drop totalcs

*Facilities also report mortality inconsistently. Treating mortality as it was in first paper
egen total_del = rowtotal(totaldel*)
foreach var in mat_mort_num sb_mort_num newborn_mort_num {
egen total`var' = rowtotal(`var'*)
forval i=1/24 {
	replace `var'`i'=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'=. if total_del==0 & total`var'==0
}
}

* For Outlier assessment  
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x'))
	gen neg_out`x' = rowmean`x'-(3.5*(rowsd`x')) // + threshold
	foreach v in 1 2 3 4 5 6 7 8 9 10 11 12 ///
				 13 14 15 16 17 18 19 20 21 22 23 24 { 
		gen flag_poutlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		gen flag_noutlier_`x'`v'= 1 if `x'`v'<neg_out`x' & `x'`v'<. 
		replace flag_poutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 		
		replace flag_noutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x'
}

* Reshaping from wide to long 
reshape long anc1_util totaldel cs_util pnc_util diarr_util pneum_util  ///
             art_util opd_util ipd_util road_util diab_util cerv_qual tbscreen_qual ///
             tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
             pneum_qual rota_qual  trauma_util icu_util kmcn_qual sam_util /// 
			 newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num icu_mort_num trauma_mort_num ///
			 flag_poutlier_anc1_util flag_poutlier_totaldel flag_poutlier_cs_util ///
			 flag_poutlier_pnc_util flag_poutlier_diarr_util flag_poutlier_pneum_util ///
			 flag_poutlier_art_util flag_poutlier_opd_util flag_poutlier_ipd_util flag_poutlier_road_util /// 
			 flag_poutlier_diab_util flag_poutlier_cerv_qual flag_poutlier_tbscreen_qual ///
             flag_poutlier_tbdetect_qual flag_poutlier_tbtreat_qual flag_poutlier_vacc_qual /// 
			 flag_poutlier_bcg_qual flag_poutlier_pent_qual flag_poutlier_measles_qual ///
             flag_poutlier_pneum_qual flag_poutlier_rota_qual  flag_poutlier_trauma_util ///
			 flag_poutlier_icu_util flag_poutlier_kmcn_qual flag_poutlier_sam_util ///
			 flag_poutlier_newborn_mort_num flag_poutlier_sb_mort_num flag_poutlier_mat_mort_num ///
			 flag_poutlier_ipd_mort_num flag_poutlier_icu_mort_num flag_poutlier_trauma_mort_num /// 		 
			 flag_noutlier_anc1_util flag_noutlier_totaldel flag_noutlier_cs_util ///
			 flag_noutlier_pnc_util flag_noutlier_diarr_util flag_noutlier_pneum_util ///
			 flag_noutlier_art_util flag_noutlier_opd_util flag_noutlier_ipd_util flag_noutlier_road_util /// 
			 flag_noutlier_diab_util flag_noutlier_cerv_qual flag_noutlier_tbscreen_qual ///
             flag_noutlier_tbdetect_qual flag_noutlier_tbtreat_qual flag_noutlier_vacc_qual /// 
			 flag_noutlier_bcg_qual flag_noutlier_pent_qual flag_noutlier_measles_qual ///
             flag_noutlier_pneum_qual flag_noutlier_rota_qual  flag_noutlier_trauma_util ///
			 flag_noutlier_icu_util flag_noutlier_kmcn_qual flag_noutlier_sam_util ///
			 flag_noutlier_newborn_mort_num flag_noutlier_sb_mort_num flag_noutlier_mat_mort_num ///
			 flag_noutlier_ipd_mort_num flag_noutlier_icu_mort_num flag_noutlier_trauma_mort_num, /// 			 
			 i(Province dist subdist Facility) j(month)	
*Month and year
gen year = 2019
replace year= 2020 if month>=13	
replace month=month-12 if month>=13
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIER TABLE 
preserve

	collapse (count) anc1_util-trauma_util (sum) flag_poutlier* flag_noutlier*  , by (year month preCovid)
	foreach x of global all {
		gen pct_pout`x' = flag_poutlier_`x' / `x'
		gen pct_nout`x' = flag_noutlier_`x' / `x'		
		rename `x' c_`x'
	}
	collapse (mean) c_* pct_pout* pct_nout*, by(preCovid)
	reshape long c_ pct_pout pct_nout, i(preCovid) j(service) string
	reshape wide c_ pct_pout pct_nout, i(service) j(preCovid)
	rename (c_0 pct_pout0 pct_nout0 c_1 pct_pout1 pct_nout1) (Pre_Count Pre_PosOutlier Pre_NegOutlier Post_count post_PosOutlier post_NegOutlier) 
	export excel using "$analysis/Results/ResultsMar29.xlsx", sheet(KZN_outliers) firstrow(variable) sheetreplace  

restore 

* COMPLETENESS GRAPH 
preserve
collapse (count) anc1_util-trauma_util , by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	cap replace complete`x' = complete`x'*100
	*cap drop max`x'
	}			
	gen rmonth = month if year==2019
	replace rmonth= month+12 if year==2020
	
	twoway (line completeopd_util rmonth, lcolor(blue)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("Completeness in reporting of outpatient visits South Africa", size(msmall) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
restore

* COMPLETENESS TABLE
preserve 
	collapse (count) anc1_util-trauma_util , by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	*cap drop max`x'
	}	
	export excel year month preCovid complete* using "$user/$analysis/Results/completeness_table.xlsx", sheet(SouthAfrica_completeness) firstrow(variable) sheetreplace
	collapse (mean) complete* max*, by(preCovid)
	reshape long complete max, i(preCovid) j(service) string
	reshape wide complete max, i(service) j(preCovid) 
	**Calculate pvalue of two proportion t test:
	gen diff = complete0-complete1
	gen z = diff/(sqrt(complete1*(1-complete1)/max1))
	gen pval = 2*(1-normal(abs(z)))
	rename (complete0 complete1 max0) (postCovid preCovid Nfac) 
	drop z max1
	order service Nfac preCovid postCovid diff pval	
	export excel using "$analysis/Results/ResultsMar10.xlsx", sheet(KZN_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* Use dataset before cleaning
* Nepal
clear
u "$user/HMIS Data for Health System Performance Covid (all countries)/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_dq.dta", clear

global all fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
                bcg_qual pent_qual measles_qual opv3_qual pneum_qual opd_util er_util ///
                ipd_util  diab_util hyper_util tbdetect_qual hivtest_qual sam_util hivdiag_qual ///
				ipd_mort_num neo_mort_num sb_mort_num mat_mort_num

keep org* fp_sa_util* anc_util* del_util* cs_util* pnc_util* diarr_util* pneum_util* ///
                bcg_qual* pent_qual* measles_qual* opv3_qual* pneum_qual* opd_util* er_util* ///
                ipd_util*  diab_util* hyper_util* tbdetect_qual* hivtest_qual* sam_util* hivdiag_qual* ///
				ipd_mort_num* neo_mort_num* sb_mort_num* mat_mort_num*
			

*Treating mortality as it was in first paper: if the service is provided, replace to missing. If it is not provided, keep missing.
egen total_del = rowtotal(del_util*)
foreach var in mat_mort_num neo_mort_num sb_mort_num {
egen total`var' = rowtotal(`var'*)
forval i=1/12 {
	replace `var'`i'_19=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_19=. if total_del==0 & total`var'==0
	replace `var'`i'_20=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_20=. if total_del==0 & total`var'==0	
}
}
egen total_ipd = rowtotal(ipd_util*)
egen total_ipdmort = rowtotal(ipd_mort_num*)
forval i=1/12 {
replace ipd_mort_num`i'_19 = 0 if total_ipd>0 & total_ipd<. & total_ipdmort==0
replace ipd_mort_num`i'_19 = . if total_ipd==0 & total_ipdmort==0
replace ipd_mort_num`i'_20 = 0 if total_ipd>0 & total_ipd<. & total_ipdmort==0
replace ipd_mort_num`i'_20 = . if total_ipd==0 & total_ipdmort==0
}
*Facilities that don't do csections inconsistently report 0 or ., switch all to . if none reported
egen totalcs = rowtotal(cs_util*)
forval i=1/12 {
	replace cs_util`i'_19=. if totalcs==0
	replace cs_util`i'_20=. if totalcs==0	
}
drop totalcs
				
* For Outlier assessment 
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	gen neg_out`x' = rowmean`x'-(3.5*(rowsd`x'))	
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_poutlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		gen flag_noutlier_`x'`v'= 1 if `x'`v'<neg_out`x' & `x'`v'<. 
		replace flag_poutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 		
		replace flag_noutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x'
}

* Reshape from wide to long 
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
                bcg_qual pent_qual measles_qual opv3_qual pneum_qual opd_util er_util ///
                ipd_util  diab_util hyper_util tbdetect_qual hivtest_qual sam_util hivdiag_qual ///
				ipd_mort_num neo_mort_num sb_mort_num mat_mort_num ///
				flag_poutlier_fp_sa_util flag_poutlier_anc_util flag_poutlier_del_util /// 
				flag_poutlier_cs_util flag_poutlier_pnc_util flag_poutlier_diarr_util ///
				flag_poutlier_pneum_util flag_poutlier_bcg_qual flag_poutlier_pent_qual /// 
				flag_poutlier_measles_qual flag_poutlier_opv3_qual flag_poutlier_pneum_qual /// 
				flag_poutlier_opd_util flag_poutlier_er_util flag_poutlier_ipd_util /// 
				flag_poutlier_diab_util flag_poutlier_hyper_util flag_poutlier_tbdetect_qual /// 
				flag_poutlier_hivtest_qual flag_poutlier_sam_util flag_poutlier_hivdiag_qual ///
				flag_poutlier_ipd_mort_num flag_poutlier_neo_mort_num flag_poutlier_sb_mort_num flag_poutlier_mat_mort_num ///			
				flag_noutlier_fp_sa_util flag_noutlier_anc_util flag_noutlier_del_util /// 
				flag_noutlier_cs_util flag_noutlier_pnc_util flag_noutlier_diarr_util ///
				flag_noutlier_pneum_util flag_noutlier_bcg_qual flag_noutlier_pent_qual /// 
				flag_noutlier_measles_qual flag_noutlier_opv3_qual flag_noutlier_pneum_qual /// 
				flag_noutlier_opd_util flag_noutlier_er_util flag_noutlier_ipd_util /// 
				flag_noutlier_diab_util flag_noutlier_hyper_util flag_noutlier_tbdetect_qual /// 
				flag_noutlier_hivtest_qual flag_noutlier_sam_util flag_noutlier_hivdiag_qual ///
				flag_noutlier_ipd_mort_num flag_noutlier_neo_mort_num flag_noutlier_sb_mort_num flag_noutlier_mat_mort_num, ///
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
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIER TABLE 
preserve 

	collapse (count) hyper_util-fp_sa_util (sum) flag_poutlier* flag_noutlier* , by (year month preCovid)
	foreach x of global all {
		gen pct_pout`x' = flag_poutlier_`x' / `x'
		gen pct_nout`x' = flag_noutlier_`x' / `x'
		rename `x' c_`x'
	}
	collapse (mean) c_* pct_pout* pct_nout*, by(preCovid)
	reshape long c_ pct_pout pct_nout, i(preCovid) j(service) string
	reshape wide c_ pct_pout pct_nout, i(service) j(preCovid)
	rename (c_0 pct_pout0 pct_nout0 c_1 pct_pout1 pct_nout1) (Pre_Count Pre_PosOutlier Pre_NegOutlier Post_count post_PosOutlier post_NegOutlier) 
	export excel using "$analysis/Results/ResultsMar29.xlsx", sheet(Nep_outliers) firstrow(variable) sheetreplace  

restore 
* COMPLETENESS GRAPHS
preserve
	collapse (count) hyper_util-fp_sa_util, by (year month preCovid)		  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	cap replace complete`x' = complete`x'*100
	*cap drop max`x'
	}			
	gen rmonth = month if year==2019
	replace rmonth= month+12 if year==2020
	
	twoway (line completeopd_util rmonth, lcolor(blue)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("Completeness in reporting of outpatient visits Nepal", size(msmall) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
restore
	
* COMPLETENESS TABLE 

preserve
	collapse (count) hyper_util-fp_sa_util, by (year month preCovid)		  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	*cap drop max`x'
	}	
	export excel year month preCovid complete* using "$user/$analysis/Results/completeness_table.xlsx", sheet(Nepal_completeness) firstrow(variable) sheetreplace
	collapse (mean) complete* max*, by(preCovid)
	reshape long complete max, i(preCovid) j(service) string
	reshape wide complete max, i(service) j(preCovid) 
	**Calculate pvalue of two proportion t test:
	gen diff = complete0-complete1
	gen z = diff/(sqrt(complete1*(1-complete1)/max1))
	gen pval = 2*(1-normal(abs(z)))
	rename (complete0 complete1 max0) (postCovid preCovid Nfac) 
	drop z max1
	order service Nfac preCovid postCovid diff pval
	export excel using "$analysis/Results/ResultsMar10.xlsx", sheet(Nep_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* Use dataset before cleaning
* Lao
clear
u "$user/HMIS Data for Health System Performance Covid (all countries)/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_Jan19-Dec20_WIDE_dq.dta", clear

global all opd_util ipd_util fp_sa_util anc_util del_util cs_util pnc_util ///
                bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util /// 
				road_util measles_qual mat_mort_num sb_mort_num neo_mort_num
keep org* opd_util* ipd_util* fp_sa_util* anc_util* del_util* cs_util* pnc_util* ///
                bcg_qual* pent_qual* opv3_qual* pneum_qual* diab_util* hyper_util* /// 
				road_util* measles_qual* mat_mort_num* sb_mort_num* neo_mort_num*

*Treating mortality as it was in first paper: if the service is provided, replace to missing. If it is not provided, keep missing.
egen total_del = rowtotal(del_util*)
foreach var in mat_mort_num neo_mort_num sb_mort_num {
egen total`var' = rowtotal(`var'*)
forval i=1/12 {
	replace `var'`i'_19=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_19=. if total_del==0 & total`var'==0
	replace `var'`i'_20=0 if total_del>0 & total_del<. & total`var'==0
	replace `var'`i'_20=. if total_del==0 & total`var'==0	
}
}				


* For Outlier assessment 
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	gen neg_out`x' = rowmean`x'-(3.5*(rowsd`x'))	
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_poutlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		gen flag_noutlier_`x'`v'= 1 if `x'`v'<neg_out`x' & `x'`v'<. 
		replace flag_poutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 		
		replace flag_noutlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' neg_out`x'
}

* Reshaping from wide to long 
reshape long opd_util ipd_util fp_sa_util anc_util del_util cs_util pnc_util ///
                 bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util /// 
				 road_util  measles_qual mat_mort_num sb_mort_num neo_mort_num /// 
				 flag_poutlier_opd_util flag_poutlier_ipd_util flag_poutlier_fp_sa_util ///
				 flag_poutlier_anc_util flag_poutlier_pnc_util flag_poutlier_del_util /// 
				 flag_poutlier_cs_util flag_poutlier_bcg_qual flag_poutlier_measles_qual ///
				 flag_poutlier_pent_qual flag_poutlier_opv3_qual flag_poutlier_pneum_qual /// 
				 flag_poutlier_diab_util flag_poutlier_hyper_util flag_poutlier_road_util ///
				 flag_poutlier_mat_mort_num flag_poutlier_sb_mort_num flag_poutlier_neo_mort_num ///
				 flag_noutlier_opd_util flag_noutlier_ipd_util flag_noutlier_fp_sa_util ///
				 flag_noutlier_anc_util flag_noutlier_pnc_util flag_noutlier_del_util /// 
				 flag_noutlier_cs_util flag_noutlier_bcg_qual flag_noutlier_measles_qual ///
				 flag_noutlier_pent_qual flag_noutlier_opv3_qual flag_noutlier_pneum_qual /// 
				 flag_noutlier_diab_util flag_noutlier_hyper_util flag_noutlier_road_util ///
				 flag_noutlier_mat_mort_num flag_noutlier_sb_mort_num flag_noutlier_neo_mort_num, ///				 
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
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIER TABLE 
preserve 

	collapse (count) mat_mort_num-fp_sa_util (sum) flag_poutlier* flag_noutlier* , by (year month  preCovid)
	foreach x of global all {
		gen pct_pout`x' = flag_poutlier_`x' / `x'
		gen pct_nout`x' = flag_noutlier_`x' / `x'
		rename `x' c_`x'
	}
	collapse (mean) c_* pct_pout* pct_nout*, by(preCovid)
	reshape long c_ pct_pout pct_nout, i(preCovid) j(service) string
	reshape wide c_ pct_pout pct_nout, i(service) j(preCovid)
	rename (c_0 pct_pout0 pct_nout0 c_1 pct_pout1 pct_nout1) (Pre_Count Pre_PosOutlier Pre_NegOutlier Post_count post_PosOutlier post_NegOutlier) 
	export excel using "$analysis/Results/ResultsMar29.xlsx", sheet(Lao_outliers) firstrow(variable) sheetreplace  

restore 
* COMPLETENESS GRAPH
preserve 
	collapse (count) mat_mort_num-fp_sa_util, by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	cap replace complete`x' = complete`x'*100
	*cap drop max`x'
	}			
	gen rmonth = month if year==2019
	replace rmonth= month+12 if year==2020
	
	twoway (line completeopd_util rmonth, lcolor(blue)) , ///
	ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
	xtitle("", size(small)) legend(off) ytitle("Percentage", size(small)) legend(off) ///
	graphregion(color(white)) title("Completeness in reporting of outpatient visits Lao PDR", size(msmall) color(black))  ///
	xlabel(1(1)24) xlabel(,  labsize(small)) ylabel(0(10)100, labsize(small))
restore
* COMPLETENESS TABLE 
preserve 
	collapse (count) mat_mort_num-fp_sa_util, by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen complete`x'= `x'/max`x'
	*cap drop max`x'
	}	
	export excel year month preCovid complete* using "$user/$analysis/Results/completeness_table.xlsx", sheet(Laos_completeness) firstrow(variable) sheetreplace
	collapse (mean) complete* max*, by(preCovid)
	reshape long complete max, i(preCovid) j(service) string
	reshape wide complete max, i(service) j(preCovid) 
	**Calculate pvalue of two proportion t test:
	gen diff = complete0-complete1
	gen z = diff/(sqrt(complete1*(1-complete1)/max1))
	gen pval = 2*(1-normal(abs(z)))
	rename (complete0 complete1 max0) (postCovid preCovid Nfac) 
	drop z max1
	order service Nfac preCovid postCovid diff pval
	export excel using "$analysis/Results/ResultsMar10.xlsx", sheet(Lao_completeness) firstrow(variable) sheetreplace  
restore 
