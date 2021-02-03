clear all 
set more off
use "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE_CCA_DB.dta", clear

/****************************************************************
 COLLAPSE  BY FACILITY TYPES, REGION TYPES AND AT NATIONAL LEVEL
*****************************************************************/
* Region names
drop orgunitlevel1 orgunitlevel4  
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

* Totals by facility types
	gen factype = "Facility type: Hospitals" if regexm(organ, "[Hh]ospital") | regexm(organ, "HOSPITAL") 
	replace factype ="Facility type: Non-Hospitals" if factype==""
	
preserve
	collapse (sum) fp_util1_19-totalipd_mort10_20 , by(factype)
	rename factype region
	save "$user/$data/Data for analysis/tmpfactype.dta", replace
restore

* Totals by region type
	collapse (sum) fp_util1_19-totalipd_mort10_20 , by(region)	
	gen regtype = "Region type: Urban" if region=="Addis Ababa" ///
	                          | region=="Dire Dawa" | region=="Harari"
	replace regtype = "Region type: Agrarian" if region == "Amhara" | region=="Oromiya" ///
                              | region== "SNNP" | region=="Tigray"
	replace regtype = "Region type: Pastoral" if region == "Afar" | region=="Ben Gum" ///
                              | region=="Gambella" | region=="Somali" 
preserve
	collapse (sum) fp_util1_19-totalipd_mort10_20 , by(regtype)	
	rename regtype region
	save "$user/$data/Data for analysis/tmpregtype.dta", replace
restore
* Totals at national level 
	encode region, gen(reg)
	drop region regtype
	order reg 
	set obs 12 // number of regions  + National 
	foreach x of var _all    {
		egen `x'tot= total(`x'), m
		replace `x'= `x'tot in 12
		drop `x'tot
}
	decode reg, gen(region)
	replace region="National" if region==""
	drop reg
	order region

append using "$user/$data/Data for analysis/tmpfactype.dta"
append using "$user/$data/Data for analysis/tmpregtype.dta"


/****************************************************************
 RESHAPE FOR DASHBAORD
*****************************************************************/
reshape long  diab_util hyper_util diab_qual_num hyper_qual_num fp_util sti_util anc_util ///
			  del_util cs_util pnc_util diarr_util pneum_util sam_util opd_util ipd_util ///
			  er_util road_util  cerv_qual art_util hivsupp_qual_num  ///
			  vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual ///
			  newborn_mort_num sb_mort_num mat_mort_num er_mort_num  totaldel ///
			  kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom /// 
        tbnum_qual tbdenom_qual tbdetect_qual totalipd_mort diab_detec hyper_detec ///
        , i(region ) j(month) string

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
	newborn_mort_num sb_mort_num mat_mort_num er_mort_num totaldel totalipd_mort ///
	diab_util hyper_util diab_qual_num hyper_qual_num kmc_qual_num kmc_qual_denom ///
  tbnum_qual tbdenom_qual tbdetect_qual resus_qual_num resus_qual_denom diab_detec hyper_detec
  
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
drop _merge //34 not merging becuase they are November and December months which are missing in 2020 data

rm "$user/$data/Data for analysis/temp.dta"
rm "$user/$data/Data for analysis/tmpfactype.dta"
rm "$user/$data/Data for analysis/tmpregtype.dta"
********************************************************************************
* THIS IS THE CSV FILE FOR GOOGLE DATA STUDIO
export delimited using "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Ethiopia_Jan19-Oct20_fordashboard.csv", replace

/* Code to identify clinics (private) 
replace factype =2 if regexm(organ, "[Cc]linic") | regexm(organ, "CLINIC") | ///
                           regexm(organ, "CLINIK")  |  regexm(organ, "[Cc]linik") | ///
						   regexm(organ, "[Nn]GO") | regexm(organ, "[Cc]linc") | ///
						   regexm(organ, "[Cc]LINC") | regexm(organ, "[Cc]ilinik") | ///
						   regexm(organ, "[Kk]linik") | regexm(organ, "[Kk]ilinik") | ///
						   regexm(organ, "[Cc]ilinic") | regexm(organ, " [Nn]go") | ///
						   regexm(organ, "[Cc]LIINC") | regexm(organ, "[Cc]lnic") 





