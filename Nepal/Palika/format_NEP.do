* HS performance during Covid
* November 11 2020
* Nepal, January 2019 - Nov 2020, analyses at Palika LEVEL 
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
*****************************************************************
 
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD

*****************************************************************/
use "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE_CCA_DB.dta", clear
	rename orgunitlevel2 province
	order province  org* 
	collapse (sum) fp_perm_util1_19-neo_mort_num11_20 , by(province)
	encode province, gen(prv)
	drop province
	order prv
	set obs 8
foreach x of var _all    {
	egen `x'tot= total(`x'), m
	replace `x'= `x'tot in 8
	drop `x'tot
}
decode prv, gen(province)
replace province="National" if province==""
drop prv
order province

* Reshaping for data visualisations / dashboard
reshape long  fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			  pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util tbdetect_qual hivdiag_qual ///
			  pent_qual bcg_qual measles_qual opv3_qual pneum_qual  ///
			  totaldel sb_mort_num mat_mort_num ipd_mort_num neo_mort_num, ///
			  i(province) j(month) string
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
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
rename mo month
sort province year month
 

* Reshaping for data visualisations
preserve
	keep if year == 2020
	foreach v of global all {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/temp.dta", replace
restore
keep if year==2019
foreach v of global all {
	rename(`v')(`v'19)
	}
drop year
merge m:m province month using "$user/$data/temp.dta"
drop _merge


rm "$user/$data/temp.dta"
export delimited using "$user/$data/Nepal_palika_Jan19-Nov20_fordashboard.csv", replace








/* 


* Recoding months to match Nepali calendar
* January 2019 is Magh 20175 (Jan 15 to Feb 15 2019) 
* January 2020 is Magh 2076 (Jan 15 to Feb 15 2020)
* to identify the last day on the month on the dashboard, we move months forward
gen month2 = month+1
replace year = 2020 if year ==2019 & month2==13
recode month2 (13=1)
drop month 
rename month2 month
order province year  month


















