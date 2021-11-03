* HS Performance during COVID - Data quality analysis
* Created October 28th, 2021
* Ethiopia, Haiti, KZN, Lao, Nepal
* Totals

clear all
set more off	
********************************************************************************

**** Totals table for ANC, Deliveries, BCG, Pent and Pneum vaccines ****
************************************************************************

* I tried to write it as a loop, but don't think it will work for Haiti (missing variables), KZN or Lao (folder names)			

global countries Ethiopia Nepal
foreach x of global countries { 
			 	u "$user/HMIS Data for Health System Performance Covid (`x')/Data for analysis/`x'_su_24months_for_analyses.dta", clear
				keep year anc_util del_util bcg_qual pent_qual pneum_qual cs_util
				collapse (sum) anc_util-pneum_qual, by (year)
				gen country = "`x'"
				reshape wide anc_util del_util bcg_qual pent_qual pneum_qual cs_util, 
				save "$user/$analysis/Results/totaltmp`x'.dta", replace
				}
				
*Haiti 
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_su_24months_for_analyses.dta", clear
keep year anc_util del_util orgunitlevel1
collapse (sum) anc_util del_util, by (year orgunitlevel1)
rename orgunitlevel1 country
reshape wide anc_util del_util, i(country) j(year) 
order country anc* del* 
save "$user/$analysis/Results/totaltmpHaiti.dta", replace

* KZN 
u "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/KZN_su_24months_for_analyses.dta", clear
keep year anc_util del_util bcg_qual pent_qual pneum_qual cs_util
collapse (sum) anc_util-pneum_qual, by (year)
gen country = "KZN"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual cs_util, i(country) j(year) 
order country anc* del* bcg* pent* pneum* cs*
save "$user/$analysis/Results/totaltmpKZN.dta", replace

*Lao
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_su_24months_for_analyses.dta", clear 
keep year anc_util del_util bcg_qual pent_qual pneum_qual cs_util
collapse (sum) anc_util-pneum_qual, by (year)
gen country = "Lao"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual cs_util, i(country) j(year) 
order country anc* del* bcg* pent* pneum* cs*
save "$user/$analysis/Results/totaltmpLao.dta", replace

* Creating overall table of totals for volumes  
clear
append using "$user/$analysis/Results/totaltmpEthiopia.dta" "$user/$analysis/Results/totaltmpHaiti.dta" /// 
			 "$user/$analysis/Results/totaltmpKZN.dta" "$user/$analysis/Results/totaltmpLao.dta" /// 
			 "$user/$analysis/Results/totaltmpNepal.dta"
drop cs*
export excel using "$user/$analysis/Results/ResultsNOV2.xlsx", sheet(Total_vol) firstrow(variable) sheetreplace  

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
merge 1:1 country using "$user/$analysis/Results/totaltmpEthiopia.dta"
drop _merge
save "$user/$analysis/Results/totalmorttmpEthiopia.dta"

*Haiti
u "$user/HMIS Data for Health System Performance Covid (Haiti)/Data for analysis/Haiti_Jan19-March21_WIDE.dta", clear
keep mat_mort* 
gen country = "Haiti"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020, by(country)
merge 1:1 country using "$user/$analysis/Results/totaltmpHaiti.dta"
drop _merge
save "$user/$analysis/Results/totalmorttmpHaiti.dta"

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
merge 1:1 country using "$user/$analysis/Results/totaltmpKZN.dta"
drop _merge
save "$user/$analysis/Results/totalmorttmpKZN.dta"

*Lao
u "$user/HMIS Data for Health System Performance Covid (Lao PDR)/Data for analysis/Lao_Jan19-Dec20_WIDE.dta", clear
keep mat_mort* 
gen country = "Lao"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020, by(country)
merge 1:1 country using "$user/$analysis/Results/totaltmpLao.dta"
drop _merge
save "$user/$analysis/Results/totalmorttmpLao.dta"


* Nepal
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", clear
keep mat_mort* 
gen country = "Nepal"
egen mat_mort2019 = rowtotal(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19  /// 
             mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
egen mat_mort2020 = rowtotal(mat_mort_num1_20 mat_mort_num2_20 mat_mort_num3_20 mat_mort_num4_20 mat_mort_num5_20 mat_mort_num6_20 /// 
             mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
collapse (sum) mat_mort2019 mat_mort2020, by(country)
merge 1:1 country using "$user/$analysis/Results/totaltmpNepal.dta"
drop _merge
save "$user/$analysis/Results/totalmorttmpNepal.dta"

* Creating overall table of totals for mortality & volumes
clear
append using "$user/$analysis/Results/totalmorttmpEthiopia.dta" "$user/$analysis/Results/totalmorttmpHaiti.dta" /// 
			 "$user/$analysis/Results/totalmorttmpKZN.dta" "$user/$analysis/Results/totalmorttmpLao.dta" /// 
			 "$user/$analysis/Results/totalmorttmpNepal.dta"
keep country del* cs* mat_mort* newborn_mort*
order country del* cs* mat_mort* newborn_mort*
export excel using "$user/$analysis/Results/ResultsNOV2.xlsx", sheet(Total_mort) firstrow(variable) sheetreplace  



/* In case we remove the loop above 

*Ethiopia 
u "$user/HMIS Data for Health System Performance Covid (Ethiopia)/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear
keep year anc_util del_util bcg_qual pent_qual pneum_qual
collapse (sum) anc_util-pneum_qual, by (year)
gen country = "Ethiopia"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(year) 
order country anc* del* bcg* pent* pneum*

* Nepal
u "$user/HMIS Data for Health System Performance Covid (Nepal)/Data for analysis/Nepal_su_24months_for_analyses.dta", clear
keep year anc_util del_util bcg_qual pent_qual pneum_qual
collapse (sum) anc_util-pneum_qual, by (year)
gen country = "Nepal"
reshape wide anc_util del_util bcg_qual pent_qual pneum_qual, i(country) j(year) 
order country anc* del* bcg* pent* pneum*
