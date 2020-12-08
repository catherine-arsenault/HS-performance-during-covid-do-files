* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, formatting dataset for the dashboard

use "$user/$data/Data for analysis/IMSS_Jan19-Oct20_clean.dta", clear


********************************************************************************
* CREATE NATIONAL TOTALS
********************************************************************************
foreach v in cerv_denom2019 cerv_denom2020 sti_util del_util cs_util diarr_util ///
pneum_util malnu_util art_util er_util dental_util ///
ipd_util diab_util hyper_util mental_util cerv_util diab_qual_num hyper_qual_num /// 
opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num mat_mort_num er_mort_num /// 
fp_util anc_util totaldel opd_util pent_qual bcg_qual measles_qual ipd_mort_num ///
death_covid hospit_covid death_negative hospit_negative death_pending hospit_pending {
	by year month, sort: egen `v'tot= total(`v'), m
	replace `v'= `v'tot if Delegation=="National"
	drop `v'tot
}

save "$user/$data/Data for analysis/IMSS_Jan19-Oct20_clean.dta", replace 

********************************************************************************
* RESHAPE FOR DASHBOARD
********************************************************************************
preserve
	keep if year == 2020
	global varlist cerv_denom2019 cerv_denom2020 ///
	sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util ///
	dental_util ipd_util diab_util hyper_util mental_util cerv_util diab_qual_num ///
	hyper_qual_num opv3_qual pneum_qual rota_qual newborn_mort_num sb_mort_num ///
	mat_mort_num er_mort_num fp_util anc_util totaldel opd_util pent_qual bcg_qual ///
	measles_qual ipd_mort_num death_covid hospit_covid death_negative hospit_negative ///
	death_pending hospit_pending
				   
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year cerv_denom2019
	save "$user/$data/temp.dta", replace
restore

keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
}
drop year cerv_denom2020
merge m:m  Delegation month using "$user/$data/temp.dta"
drop  _merge 

export delimited using "$user/$data/IMSS_Jan19-Oct20_fordashboard.csv", replace

rm "$user/$data/temp.dta"











	
