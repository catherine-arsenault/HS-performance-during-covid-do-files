clear all 
set more off
use "$user/$data/Data for analysis/Ethiopia_Jan19-Aug20_WIDE_CCA_DB.dta", clear
/****************************************************************
  CREATE FACILITY TYPES AND REGION TYPES
*****************************************************************/
gen factype = 1 if regexm(organ, "[Hh]ospital") | regexm(organ, "HOSPITAL") 
replace factype =2 if factype==.
lab def factype 1"Hospitals" 2"Non-Hospitals"
lab val factype factype

gen regtype = 1 if region=="Addis Ababa" | region=="Dire Dawa" | region=="Harari"
replace regtype = 2 if region == "Amhara" | | region=="Oromiya" ///
                              | region== "SNNP" | region=="Tigray"
replace regtype = 3 if region == "Afar" | region=="Ben Gum" ///
                              | region=="Gambella" | region=="Somali" 
lab def regtype 1"Urban" 2"Agrarian" 3"Pastoral"
lab val regtype regtype
/****************************************************************
  COLLAPSE  AND RESHAPE FOR DASHBOARD
*****************************************************************/
preserve
	collapse (sum) fp_util1_19-totalipd_mort8_20 , by(factype)
	save "$user/$data/Data for analysis/tmpfactype.dta", replace
restore
	collapse (sum) fp_util1_19-totalipd_mort8_20 , by(region)
	encode region, gen(reg)
	drop region
	reg
	set obs 17 // number of regions 11 + National + Urban + Agraria + Pastoral

foreach x of var _all    {
	egen `x'tot= total(`x'), m
	replace `x'= `x'tot in 12
	drop `x'tot
}
decode reg, gen(region)
replace region="National" if region==""
drop reg
order region

reshape long  diab_util hyper_util diab_qual_num hyper_qual_num fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util  cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num totaldel ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
			  totalipd_mort, i(region ) j(month) string
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
sort region year month
order region year month 

* Reshaping for data visualisations / dashboard
preserve
	keep if year == 2020
	global varlist fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
	sam_util opd_util ipd_util er_util road_util  cerv_qual art_util ///
	hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
	newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num totaldel totalipd_mort ///
	diab_util hyper_util diab_qual_num hyper_qual_num kmc_qual_num kmc_qual_denom ///
	resus_qual_num resus_qual_denom
	
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/Data for analysis/temp.dta", replace
restore
keep if year==2019
foreach v of global varlist {
	rename(`v')(`v'19)
	}
drop year
merge m:m region month using "$user/$data/Data for analysis/temp.dta"
drop _merge

rm "$user/$data/Data for analysis/temp.dta"

********************************************************************************
* THIS IS THE CSV FILE FOR GOOGLE DATA STUDIO
export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Aug20_fordashboard.csv", replace



/* Code to identify clinics (private) 
replace factype =2 if regexm(organ, "[Cc]linic") | regexm(organ, "CLINIC") | ///
                           regexm(organ, "CLINIK")  |  regexm(organ, "[Cc]linik") | ///
						   regexm(organ, "[Nn]GO") | regexm(organ, "[Cc]linc") | ///
						   regexm(organ, "[Cc]LINC") | regexm(organ, "[Cc]ilinik") | ///
						   regexm(organ, "[Kk]linik") | regexm(organ, "[Kk]ilinik") | ///
						   regexm(organ, "[Cc]ilinic") | regexm(organ, " [Nn]go") | ///
						   regexm(organ, "[Cc]LIINC") | regexm(organ, "[Cc]lnic") 





