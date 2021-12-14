* HS performance during Covid
* Dec 3, 2021


/******************************************************************************
		CREATES FINAL DATASET FOR ANALYSES
*******************************************************************************/
use "$user/$data/Data for analysis/Nepal_palika_2021_WIDE_CCA.dta", clear
gen unique_id = _n

reshape long fp_sa_util anc_util del_util cs_util pnc_util diarr_util ///
			   pneum_util  opd_util ipd_util er_util ////
			   tbdetect_qual hivtest_qual hyper_util diab_util pent_qual bcg_qual ///
			   measles_qual pneum_qual , ///
			  i(org* unique_id) j(month) string
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year =2021 if month=="1_21" | month=="2_21" | month=="3_21" | month=="4_21" | month=="5_21" ///
				| month=="6_21" 
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20" | month =="1_21"
replace mo = 2 if month =="2_19" | month =="2_20" | month =="2_21"
replace mo = 3 if month =="3_19" | month =="3_20" | month =="3_21"
replace mo = 4 if month =="4_19" | month =="4_20" | month =="4_21"
replace mo = 5 if month =="5_19" | month =="5_20" | month =="5_21"
replace mo = 6 if month =="6_19" | month =="6_20" | month =="6_21"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort org* year month
order org*  year month 

save "$user/$data/Data for analysis/Nepal_su_30months.dta", replace














