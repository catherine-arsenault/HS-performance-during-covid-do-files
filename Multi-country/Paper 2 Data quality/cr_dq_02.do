* HS Performance during COVID - Data quality analysis
* Created October 28th, 2021
* Ethiopia, Haiti, KZN, Lao, Nepal
* Internal and External consistency 

clear all
set more off	
********************************************************************************

**** Internal consistency: ANC, Deliveries, BCG, Pent and Pneum vaccines ****
********************************************************************************

*Ethiopia 
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
keep month year anc_util del_util bcg_qual pent_qual pneum_qual
gen preCovid= year==2019 | year==2020 & month <4
collapse (sum) anc_util-pneum_qual, by (preCovid)
gen country = "Ethiopia"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(preCovid) 
order country anc*1 anc*0 del*1 del*0 bcg*1 bcg*0 pent*1 pent*0 pneum*1 pneum*0
save "$user/$analysis/Results/inttmpEthiopia.dta", replace

* Nepal
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_su_24months_for_analyses.dta", clear
keep month year anc_util del_util bcg_qual pent_qual pneum_qual
gen preCovid= year==2019 | year==2020 & month <4
collapse (sum) anc_util-pneum_qual, by (preCovid)
gen country = "Nepal"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(preCovid) 
order country anc*1 anc*0 del*1 del*0 bcg*1 bcg*0 pent*1 pent*0 pneum*1 pneum*0
save "$user/$analysis/Results/inttmpNepal.dta", replace

*Haiti 
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_su_24months_for_analyses.dta", clear
keep month year anc_util del_util vacc_qual orgunitlevel1
gen preCovid= year==2019 | year==2020 & month <4
collapse (sum) anc_util del_util vacc_qual, by (preCovid orgunitlevel1)
rename orgunitlevel1 country
reshape wide anc_util del_util vacc_qual, i(country) j(preCovid) 
order country anc*1 anc*0 del*1 del*0 vacc*1 vacc*0
save "$user/$analysis/Results/inttmpHaiti.dta", replace

* KZN 
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/KZN_su_24months_for_analyses.dta", clear
keep month year anc_util del_util bcg_qual pent_qual pneum_qual
gen preCovid= year==2019 | year==2020 & month <4
collapse (sum) anc_util-pneum_qual, by (preCovid)
gen country = "KZN"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(preCovid) 
order country anc*1 anc*0 del*1 del*0 bcg*1 bcg*0 pent*1 pent*0 pneum*1 pneum*0
save "$user/$analysis/Results/inttmpKZN.dta", replace

*Lao
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_su_24months_for_analyses.dta", clear 
keep month year anc_util del_util bcg_qual pent_qual pneum_qual 
gen preCovid= year==2019 | year==2020 & month <4
collapse (sum) anc_util-pneum_qual, by (preCovid)
gen country = "Lao"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(preCovid) 
order country anc*1 anc*0 del*1 del*0 bcg*1 bcg*0 pent*1 pent*0 pneum*1 pneum*0
save "$user/$analysis/Results/inttmpLao.dta", replace

* Creating overall table of totals for volumes  
clear
append using "$user/$analysis/Results/inttmpEthiopia.dta" "$user/$analysis/Results/inttmpHaiti.dta" /// 
			 "$user/$analysis/Results/inttmpKZN.dta" "$user/$analysis/Results/inttmpLao.dta" /// 
			 "$user/$analysis/Results/inttmpNepal.dta"
export excel using "$user/$analysis/Results/Results_internal_external.xlsx", sheet(Internal_consistency) firstrow(variable) sheetreplace  


********************************************************************************

**** External consistency: ANC, Deliveries, BCG, Pent and Pneum vaccines ****
********************************************************************************

*Ethiopia 
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
keep month year del_util cs_util
collapse (sum) del_util cs_util, by (year)
gen country = "Ethiopia"
reshape wide del_util cs_util, i(country) j(year) 
order country del* cs*
save "$user/$analysis/Results/exttmpEthiopia.dta", replace

* Nepal
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_su_24months_for_analyses.dta", clear
keep month year del_util cs_util
collapse (sum) del_util cs_util, by (year)
gen country = "Nepal"
reshape wide del_util cs_util, i(country) j(year) 
order country del* cs*
save "$user/$analysis/Results/exttmpNepal.dta", replace

*Haiti 
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_su_24months_for_analyses.dta", clear
keep month year del_util orgunitlevel1
collapse (sum) del_util, by (year orgunitlevel1)
rename orgunitlevel1 country
reshape wide del_util, i(country) j(year) 
order country del*
save "$user/$analysis/Results/exttmpHaiti.dta", replace

* KZN 
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/KZN_su_24months_for_analyses.dta", clear
keep month year del_util cs_util
collapse (sum) del_util cs_util, by (year)
gen country = "KZN"
reshape wide del_util cs_util, i(country) j(year) 
order country del* cs*
save "$user/$analysis/Results/exttmpKZN.dta", replace

*Lao
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_su_24months_for_analyses.dta", clear 
keep month year del_util cs_util
collapse (sum) del_util cs_util, by (year)
gen country = "Lao"
reshape wide del_util cs_util, i(country) j(year) 
order country del* cs*
save "$user/$analysis/Results/exttmpLao.dta", replace

* Creating overall table of totals for volumes  
clear
append using "$user/$analysis/Results/exttmpEthiopia.dta" "$user/$analysis/Results/exttmpHaiti.dta" /// 
			 "$user/$analysis/Results/exttmpKZN.dta" "$user/$analysis/Results/exttmpLao.dta" /// 
			 "$user/$analysis/Results/exttmpNepal.dta"
export excel using "$user/$analysis/Results/Results_internal_external.xlsx", sheet(External_consistency) firstrow(variable) sheetreplace  


* Remove temp files 
global country Ethiopia Haiti KZN Lao Nepal 
foreach x of global country {
		rm "$user/$analysis/Results/inttmp`x'.dta"
		rm "$user/$analysis/Results/exttmp`x'.dta"
	}


/* Mortality code 
**************** Totals table for mortality ****************
************************************************************
*Ethiopia 
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_Jan19-Dec20_WIDE_dq.dta", clear
keep mat_mort* newborn_mort*
gen country = "Ethiopia"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
egen newborn_mort2019 = rowtotal(newborn_mort_num1_19 newborn_mort_num2_19 newborn_mort_num3_19 newborn_mort_num4_19 /// 
								 newborn_mort_num5_19 newborn_mort_num6_19 newborn_mort_num7_19 newborn_mort_num8_19 /// 
								 newborn_mort_num9_19 newborn_mort_num10_19 newborn_mort_num11_19 newborn_mort_num12_19)
egen newborn_mort2020 = rowtotal(newborn_mort_num1_20 newborn_mort_num2_20 newborn_mort_num3_20 newborn_mort_num4_20 ///
								 newborn_mort_num5_20 newborn_mort_num6_20 newborn_mort_num7_20 newborn_mort_num8_20 /// 
								 newborn_mort_num9_20 newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020 newborn_mort2019 newborn_mort2020, by(country)
*merge 1:1 country using "$user/$analysis/Results/totaltmpEthiopia.dta"
*drop _merge
save "$user/$analysis/Results/totalmorttmpEthiopia.dta", replace

*Haiti
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear
keep mat_mort* 
gen country = "Haiti"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020, by(country)
*merge 1:1 country using "$user/$analysis/Results/totaltmpHaiti.dta"
*drop _merge
save "$user/$analysis/Results/totalmorttmpHaiti.dta", replace

*KZN
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide.dta", clear
keep mat_mort* newborn_mort*
gen country = "KZN"
egen mat_mort2019 = rowtotal(mat_mort_num1 mat_mort_num2 mat_mort_num3 mat_mort_num4 mat_mort_num5 mat_mort_num6  /// 
             mat_mort_num7 mat_mort_num8 mat_mort_num9 mat_mort_num10 mat_mort_num11 mat_mort_num12)
egen mat_mort2020 = rowtotal(mat_mort_num13 mat_mort_num14 mat_mort_num15 mat_mort_num16 mat_mort_num17 mat_mort_num18 /// 
             mat_mort_num19 mat_mort_num20 mat_mort_num21 mat_mort_num22 mat_mort_num23 mat_mort_num24)
egen newborn_mort2019 = rowtotal(newborn_mort_num1 newborn_mort_num2 newborn_mort_num3 newborn_mort_num4 newborn_mort_num5 newborn_mort_num6  /// 
             newborn_mort_num7 newborn_mort_num8 newborn_mort_num9 newborn_mort_num10 newborn_mort_num11 newborn_mort_num12)
egen newborn_mort2020 = rowtotal(newborn_mort_num13 newborn_mort_num14 newborn_mort_num15 newborn_mort_num16 newborn_mort_num17 newborn_mort_num18 /// 
             newborn_mort_num19 newborn_mort_num20 newborn_mort_num21 newborn_mort_num22 newborn_mort_num23 newborn_mort_num24)
collapse (sum) mat_mort2019 mat_mort2020 newborn_mort2019 newborn_mort2020, by(country)
*merge 1:1 country using "$user/$analysis/Results/totaltmpKZN.dta"
*drop _merge
save "$user/$analysis/Results/totalmorttmpKZN.dta", replace

*Lao
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_Jan19-Dec20_WIDE.dta", clear
keep mat_mort* neo_mort_num*
gen country = "Lao"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
egen newborn_mort2019 = rowtotal(neo_mort_num1_19 neo_mort_num2_19 neo_mort_num3_19 neo_mort_num4_19 neo_mort_num5_19 neo_mort_num6_19  /// 
             neo_mort_num7_19 neo_mort_num8_19 neo_mort_num9_19 neo_mort_num10_19 neo_mort_num11_19 neo_mort_num12_19)
egen newborn_mort2020 = rowtotal(neo_mort_num1_20 neo_mort_num2_20 neo_mort_num3_20 neo_mort_num4_20 neo_mort_num5_20 neo_mort_num6_20 /// 
             neo_mort_num7_20 neo_mort_num8_20 neo_mort_num9_20 neo_mort_num10_20 neo_mort_num11_20 neo_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020 newborn_mort2019 newborn_mort2020, by(country)
*merge 1:1 country using "$user/$analysis/Results/totaltmpLao.dta"
*drop _merge
save "$user/$analysis/Results/totalmorttmpLao.dta", replace

* Nepal
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", clear
keep mat_mort* neo_mort_num*
gen country = "Nepal"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
egen newborn_mort2019 = rowtotal(neo_mort_num1_19 neo_mort_num2_19 neo_mort_num3_19 neo_mort_num4_19 neo_mort_num5_19 neo_mort_num6_19  /// 
             neo_mort_num7_19 neo_mort_num8_19 neo_mort_num9_19 neo_mort_num10_19 neo_mort_num11_19 neo_mort_num12_19)
egen newborn_mort2020 = rowtotal(neo_mort_num1_20 neo_mort_num2_20 neo_mort_num3_20 neo_mort_num4_20 neo_mort_num5_20 neo_mort_num6_20 /// 
             neo_mort_num7_20 neo_mort_num8_20 neo_mort_num9_20 neo_mort_num10_20 neo_mort_num11_20 neo_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020 newborn_mort2019 newborn_mort2020, by(country)
*merge 1:1 country using "$user/$analysis/Results/totaltmpNepal.dta"
*drop _merge
save "$user/$analysis/Results/totalmorttmpNepal.dta", replace

* Creating overall table of totals for mortality 
clear
append using "$user/$analysis/Results/totalmorttmpEthiopia.dta" "$user/$analysis/Results/totalmorttmpHaiti.dta" /// 
			 "$user/$analysis/Results/totalmorttmpKZN.dta" "$user/$analysis/Results/totalmorttmpLao.dta" /// 
			 "$user/$analysis/Results/totalmorttmpNepal.dta"
*keep country del* cs* mat_mort* newborn_mort*
*order country del* cs* mat_mort* newborn_mort*
export excel using "$user/$analysis/Results/Results_totals.xlsx", sheet(Total_mort) firstrow(variable) sheetreplace  

* Remove temp files 
global country Ethiopia Haiti KZN Lao Nepal 
foreach x of global country {
		rm "$user/$analysis/Results/totalmorttmp`x'.dta"
		rm "$user/$analysis/Results/totaltmp`x'.dta"
	}
