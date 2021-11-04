* HS Performance during COVID - Data quality analysis
* Created July 27, 2021 
* Ethiopia, Haiti, KZN, Lao, Nepal
* Completeness

clear all
set more off	
********************************************************************************
* ETHIOPIA
* Use dataset before cleaning
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_Jan19-Dec20_WIDE_dq.dta", clear

* All indicators 
global all fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
           sam_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
           rota_qual art_util opd_util er_util ipd_util  road_util hivsupp_qual_num /// 
		   diab_util hyper_util diab_detec hyper_detec cerv_qual kmc_qual_num /// 
		   kmc_qual_denom resus_qual_num resus_qual_denom

drop sti_util* totaldel* diab_qual_num* hyper_qual_num* sb_mort_num* newborn_mort_num* mat_mort_num* ipd_mort_num* er_mort_num* icu_mort_num*	 
		   
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

* For outlier assessment 
foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1_19 2_19 3_19 4_19 5_19 6_19 7_19 8_19 9_19 10_19 11_19 12_19 ///
				 1_20 2_20 3_20 4_20 5_20 6_20 7_20 8_20 9_20 10_20 11_20 12_20 { 
		gen flag_out_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
		replace flag_out_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	}
	drop rowmean`x' rowsd`x' pos_out`x' 
}

* Reshaping from wide to long 
reshape long fp_util anc_util del_util cs_util pnc_util  diarr_util ///
	        pneum_util sam_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual ///
			pneum_qual rota_qual art_util opd_util er_util ipd_util  road_util /// 
			hivsupp_qual_num diab_util hyper_util diab_detec hyper_detec /// 
			cerv_qual kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
			flag_out_fp_util flag_out_anc_util ///
			flag_out_del_util flag_out_cs_util flag_out_pnc_util /// 
			flag_out_diarr_util flag_out_pneum_util flag_out_sam_util flag_out_vacc_qual /// 
			flag_out_bcg_qual flag_out_pent_qual flag_out_measles_qual flag_out_opv3_qual /// 
			flag_out_pneum_qual flag_out_rota_qual flag_out_art_util flag_out_opd_util /// 
			flag_out_er_util flag_out_ipd_util  flag_out_road_util /// 
			flag_out_hivsupp_qual_num flag_out_diab_util flag_out_hyper_util /// 
			flag_out_diab_detec flag_out_hyper_detec flag_out_cerv_qual flag_out_kmc_qual_num ///
			flag_out_kmc_qual_denom flag_out_resus_qual_num flag_out_resus_qual_denom, /// 
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
	collapse (count) resus_qual_denom-rota_qual (sum) flag_out* , by (year month preCovid)
	foreach x of global all {
		gen `x'pct_out = flag_out_`x' / `x'
	}
	collapse (mean) *pct_out, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Eth_outliers) firstrow(variable) sheetreplace  
restore 

* Note: The few missing for pct_out is because there were 0 in the count for some diab and hyper indicators 

* COMPLETENESS TABLE 
preserve
	collapse (count) resus_qual_denom-rota_qual , by (year month preCovid)
			  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
	}		
	collapse (mean) completeness_*, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Eth_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* HAITI
* Use dataset before cleaning
clear
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear

global all opd_util fp_util anc_util cerv_qual del_util pnc_util vacc_qual diab_util ///
           hyper_util
keep orgunitlevel1-orgunitlevel3 ID Number opd_util* fp_util* anc_util* cerv_qual* del_util* /// 
	 pnc_util* vacc_qual* diab_util* hyper_util* 
			
* For Outlier assessment 
foreach x of global all {
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


reshape long opd_util fp_util anc_util cerv_qual del_util pnc_util vacc_qual diab_util ///
				 hyper_util flag_outlier_opd_util flag_outlier_fp_util flag_outlier_anc_util  /// 
				 flag_outlier_cerv_qual flag_outlier_del_util flag_outlier_pnc_util /// 
				 flag_outlier_vacc_qual flag_outlier_diab_util flag_outlier_hyper_util, ///
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
	collapse (count) fp_util-vacc_qual (sum) flag_outlier* , by (year month preCovid)
	foreach x of global all {
		gen `x'pct_outlier = flag_outlier_`x' / `x'
	} 
	collapse (mean) *pct_outlier, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Hat_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS TABLE 

preserve
	collapse (count) fp_util-vacc_qual , by (year month preCovid)	  
	foreach x of global all {
		cap egen max`x'=max(`x')
		cap gen completeness_`x'= `x'/max`x'
		cap drop max`x'
	}		
	collapse (mean) completeness_*, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Hat_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* KWAZULU NATAL, SOUTH AFRICA
* Use dataset before cleaning
clear
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide.dta", clear

global all anc1_util del_util cs_util pnc_util diarr_util pneum_util  ///
           art_util opd_util ipd_util road_util diab_util cerv_qual tbscreen_qual ///
           tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
           pneum_qual rota_qual  trauma_util icu_util kmcn_qual sam_util
keep Province dist subdist Facility factype anc1_util* del_util* cs_util* pnc_util* diarr_util* pneum_util*  ///
     art_util* opd_util* ipd_util* road_util* diab_util* cerv_qual* tbscreen_qual* ///
     tbdetect_qual* tbtreat_qual* vacc_qual* bcg_qual* pent_qual* measles_qual* ///
     pneum_qual* rota_qual*  trauma_util* icu_util* kmcn_qual* sam_util*
	   
* Outpatient visits are missing in 2019 and then 0 in 2020
* set all to missing as these facilities do not report that indicator (it's a hospital-level indicator only)
egen totalopd=rowtotal(opd_util*)
forval i=1/24 {
	replace opd_util`i'=. if totalopd==0
}
drop totalopd

* For Outlier assessment  
foreach x of global all {
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

* Reshaping from wide to long 
reshape long anc1_util del_util cs_util pnc_util diarr_util pneum_util  ///
             art_util opd_util ipd_util road_util diab_util cerv_qual tbscreen_qual ///
             tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
             pneum_qual rota_qual  trauma_util icu_util kmcn_qual sam_util /// 
			 flag_outlier_anc1_util flag_outlier_del_util flag_outlier_cs_util ///
			 flag_outlier_pnc_util flag_outlier_diarr_util flag_outlier_pneum_util ///
			 flag_outlier_art_util flag_outlier_opd_util flag_outlier_ipd_util flag_outlier_road_util /// 
			 flag_outlier_diab_util flag_outlier_cerv_qual flag_outlier_tbscreen_qual ///
             flag_outlier_tbdetect_qual flag_outlier_tbtreat_qual flag_outlier_vacc_qual /// 
			 flag_outlier_bcg_qual flag_outlier_pent_qual flag_outlier_measles_qual ///
             flag_outlier_pneum_qual flag_outlier_rota_qual  flag_outlier_trauma_util ///
			 flag_outlier_icu_util flag_outlier_kmcn_qual flag_outlier_sam_util, /// 
			 i(Province dist subdist Facility) j(month)	
*Month and year
gen year = 2019
replace year= 2020 if month>=13	
replace month=month-12 if month>=13
gen preCovid= year==2019 | year==2020 & month <4

* OUTLIER TABLE 
preserve
	collapse (count) anc1_util-trauma_util (sum) flag_outlier* , by (year month preCovid)
	foreach x of global all {
		gen `x'pct_outlier = flag_outlier_`x' / `x'
	}
	collapse (mean) *pct_outlier, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(KZN_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS TABLE 

preserve 
	collapse (count) anc1_util-trauma_util , by (year month preCovid)	  
	foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
	}
	collapse (mean) completeness_*, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid		
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(KZN_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* Use dataset before cleaning
* Lao
clear
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_Jan19-Dec20_WIDE_dq.dta", clear

global all opd_util ipd_util fp_sa_util anc_util del_util cs_util pnc_util ///
                bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util /// 
				road_util measles_qual
keep org* opd_util* ipd_util* fp_sa_util* anc_util* del_util* cs_util* pnc_util* ///
                bcg_qual* pent_qual* opv3_qual* pneum_qual* diab_util* hyper_util* /// 
				road_util* measles_qual*

* For Outlier assessment 
foreach x of global all {
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

* Reshaping from wide to long 
reshape long opd_util ipd_util fp_sa_util anc_util del_util cs_util pnc_util ///
                 bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util /// 
				 road_util  measles_qual /// 
				 flag_outlier_opd_util flag_outlier_ipd_util flag_outlier_fp_sa_util ///
				 flag_outlier_anc_util flag_outlier_pnc_util flag_outlier_del_util /// 
				 flag_outlier_cs_util flag_outlier_bcg_qual flag_outlier_measles_qual ///
				 flag_outlier_pent_qual flag_outlier_opv3_qual flag_outlier_pneum_qual /// 
				 flag_outlier_diab_util flag_outlier_hyper_util flag_outlier_road_util, ///
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
	collapse (count) road_util-fp_sa_util (sum) flag_outlier* , by (year month preCovid)
	foreach x of global all {
		gen `x'pct_outlier = flag_outlier_`x' / `x'
	}
	collapse (mean) *pct_outlier, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid		
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Lao_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS TABLE 
preserve 
	collapse (count) road_util-fp_sa_util, by (year month preCovid)	  
	foreach x of global all {
		cap egen max`x'=max(`x')
		cap gen completeness_`x'= `x'/max`x'
		cap drop max`x'
	}		
	collapse (mean) completeness_*, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Lao_completeness) firstrow(variable) sheetreplace  
restore 

********************************************************************************
* Use dataset before cleaning
* Nepal
clear
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_dq.dta", clear

global all fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
                bcg_qual pent_qual measles_qual opv3_qual pneum_qual opd_util er_util ///
                ipd_util  diab_util hyper_util tbdetect_qual hivtest_qual sam_util hivdiag_qual 

keep org* fp_sa_util* anc_util* del_util* cs_util* pnc_util* diarr_util* pneum_util* ///
                bcg_qual* pent_qual* measles_qual* opv3_qual* pneum_qual* opd_util* er_util* ///
                ipd_util*  diab_util* hyper_util* tbdetect_qual* hivtest_qual* sam_util* hivdiag_qual*
			
* For Outlier assessment 
foreach x of global all {
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

* Reshape from wide to long 
reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
                bcg_qual pent_qual measles_qual opv3_qual pneum_qual opd_util er_util ///
                ipd_util  diab_util hyper_util tbdetect_qual hivtest_qual sam_util hivdiag_qual ///
				flag_outlier_fp_sa_util flag_outlier_anc_util flag_outlier_del_util /// 
				flag_outlier_cs_util flag_outlier_pnc_util flag_outlier_diarr_util ///
				flag_outlier_pneum_util flag_outlier_bcg_qual flag_outlier_pent_qual /// 
				flag_outlier_measles_qual flag_outlier_opv3_qual flag_outlier_pneum_qual /// 
				flag_outlier_opd_util flag_outlier_er_util flag_outlier_ipd_util /// 
				flag_outlier_diab_util flag_outlier_hyper_util flag_outlier_tbdetect_qual /// 
				flag_outlier_hivtest_qual flag_outlier_sam_util flag_outlier_hivdiag_qual, ///
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
	collapse (count) hyper_util-fp_sa_util (sum) flag_outlier* , by (year month preCovid)
	foreach x of global all {
		gen `x'pct_outlier = flag_outlier_`x' / `x'
	}
	collapse (mean) *pct_outlier, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid	
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Nep_outliers) firstrow(variable) sheetreplace  
restore 

* COMPLETENESS TABLE 

preserve
	collapse (count) hyper_util-fp_sa_util, by (year month preCovid)
			  
	foreach x of global all {
		cap egen max`x'=max(`x')
		cap gen completeness_`x'= `x'/max`x'
		cap drop max`x'
	}		
	collapse (mean) completeness_*, by(preCovid)
	xpose, varname clear
	rename (v1 v2) (postCovid preCovid) 
	drop in 1
	order _varname preCovid postCovid	
	export excel using "$user/$analysis/Results/ResultsNOV4.xlsx", sheet(Nep_completeness) firstrow(variable) sheetreplace  
restore 

