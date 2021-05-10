* HS performance during Covid
* April 8, 2021
* Ghana, January 2019 - December 2020
* MK Kim 
* Data cleaning - Remove outliers at regional level

clear all
set more off	

u "$user/$data/Data for analysis/GHA_Jan19-Dec20_WIDE.dta", clear

*Reshape to wide format 
encode period, gen(month)
drop period 
order region month 

reshape wide  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util  ///
			  pneum_util  malnu_util tt_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual opd_util ipd_util ///
			  road_util diab_util hyper_util malaria_util tbdetect_qual ///
			  surg_util ipd_mort_num newborn_mort_num sb_mort_num ///
			  mat_mort_num totaldel, i(region) j(month)  
			  
order region fp_util* sti_util* anc_util* del_util* cs_util* pnc_util* diarr_util*  ///
			  pneum_util*  malnu_util* tt_qual* vacc_qual* pent_qual* bcg_qual* ///
			  measles_qual* opv3_qual* pneum_qual* rota_qual* opd_util* ipd_util* ///
			  road_util* diab_util* hyper_util* malaria_util* tbdetect_qual* ///
			  surg_util* ipd_mort_num* newborn_mort_num* sb_mort_num* ///
			  mat_mort_num* totaldel*

export excel using "$user/$data/Cleaning/Raw data recoded.xlsx", firstrow(variables) replace
			  
*Removes positive outliers - 3.5 standard deviation higher than mean 
global volume fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
			  malnu_util
global vaccine tt_qual vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual 
global other opd_util ipd_util road_util diab_util hyper_util malaria_util ///
			 tbdetect_qual surg_util
global mortality ipd_mort_num newborn_mort_num sb_mort_num mat_mort_num totaldel
global all $volume $vaccine $other $mortality 


foreach x of global all {
	egen rowmean`x'= rowmean(`x'*)
	egen rowsd`x'= rowsd(`x'*)
	gen pos_out`x' = rowmean`x'+(3.5*(rowsd`x')) // + threshold
	foreach v in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 {
	gen flag_outlier_`x'`v'= 1 if `x'`v'>pos_out`x' & `x'`v'<. 
	replace flag_outlier_`x'`v'= . if rowmean`x'<= 1 // replaces flag to missing if the series mean is 1 or less 
	replace `x'`v'=. if flag_outlier_`x'`v'==1 // replaces value to missing if flag is = 1
	}
	drop rowmean`x' rowsd`x' pos_out`x'  flag_outlier_`x'*
}

*30 outliers were identified and replaced as missing 
*12 of them seem susupicious - emailed CA 

*Reshape to long format 
reshape long  fp_util sti_util anc_util del_util cs_util pnc_util diarr_util  ///
			  pneum_util  malnu_util tt_qual vacc_qual pent_qual bcg_qual ///
			  measles_qual opv3_qual pneum_qual rota_qual opd_util ipd_util ///
			  road_util diab_util hyper_util malaria_util tbdetect_qual ///
			  surg_util ipd_mort_num newborn_mort_num sb_mort_num ///
			  mat_mort_num totaldel, i(region) j(month, string)  

gen year = 2020 if month=="13" |	month=="14" |	month=="15" |	month=="16" |	///
		month=="17" |	month=="18"  | month=="19" |	month=="20" |	///
		month=="21" |	month=="22" | month=="23" |	month=="24"
replace year = 2019 if year==.
gen mo = 1 if month =="1" | month =="13"
replace mo = 2 if month =="2" | month =="14"
replace mo = 3 if month =="3" | month =="15"
replace mo = 4 if month =="4" | month =="16"
replace mo = 5 if month =="5" | month =="17"
replace mo = 6 if month =="6" | month =="18"
replace mo = 7 if month =="7" | month =="19"
replace mo = 8 if month =="8" | month =="20"
replace mo = 9 if month =="9" | month =="21"
replace mo = 10 if month =="10" | month =="22"
replace mo = 11 if month =="11" | month =="23"
replace mo = 12 if month =="12" | month =="24"
drop month
sort region year mo 
rename mo month

save "$user/$data/Data for analysis/GHA_Jan19-Dec20_WIDE_final.dta", replace 
			  

			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
			  
