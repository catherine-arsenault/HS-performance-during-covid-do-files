
/* Health system performance during Covid-19. Created by Catherine Arsenault
   May 24, 2021
   Paper title: Effect of Covid-19 on health service utilization in 10 countries
   This do file describes health service distributions in each country at region,
   province levels */
   
* Chile 17 regions
use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear 
global CHLall anc_util del_util cs_util pnc_util
collapse (sum) $CHLall, by (region year month )
foreach x of  global CHLall {
histogram `x', percent title("Chile `x'") graphregion(color(white)) normal
graph export "$analysis/Results/Graphs/Distributions/CHL_`x'.pdf", replace
}
* Ethiopia 10 regions
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta",  clear
global ETHall opd_util er_util ipd_util fp_util sti_util anc_util del_util ///
cs_util pnc_util diarr_util pneum_util malnu_util vacc_qual bcg_qual pent_qual ///
measles_qual opv3_qual pneum_qual rota_qual  art_util ///
hivsupp_qual_num road_util
collapse (sum) $ETHall, by (region year month)
foreach x of  global ETHall {
histogram `x', percent title("Ethiopia `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/ETH_`x'.pdf", replace
}
* Ghana 16 regions
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear
global GHAall opd_util ipd_util fp_util sti_util anc_util del_util cs_util ///
pnc_util diarr_util pneum_util malnu_util vacc_qual bcg_qual pent_qual ///
measles_qual opv3_qual pneum_qual rota_qual malaria_util tbdetect_qual ///
diab_util hyper_util road_util
foreach x of  global GHAall {
histogram `x', percent title(" Ghana `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/GHA_`x'.pdf", replace
}
* Haiti 10 departments
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear
global HTIall opd_util fp_util anc_util del_util pnc_util vacc_qual diab_util ///
				hyper_util cerv_qual
collapse (sum) $HTIall, by (orgunitlevel2 year month)
foreach x of  global HTIall {
histogram `x', percent title("Haiti `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/HTI_`x'.pdf", replace
}
* South Korea 17 regions
u "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", clear 
global KORall opd_util er_util ipd_util sti_util anc_util del_util cs_util ///
		kmc_qual diarr_util pneum_util art_util diab_util hyper_util
foreach x of  global KORall {
histogram `x', percent title("Korea `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/KOR_`x'.pdf", replace
}
* KZN 11 districts
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta",  clear
global KZNall opd_util ipd_util anc_util del_util cs_util kmc_qual pnc_util ///
		diarr_util pneum_util malnu_util vacc_qual bcg_qual pent_qual measles_qual ///
		pneum_qual rota_qual tbscreen_qual tbdetect_qual art_util diab_util ///
		road_util cerv_qual
collapse (sum) $KZNall, by (dist year month)
foreach x of global  KZNall {
histogram `x', percent title("KZN `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/KZN_`x'.pdf", replace
}
* Laos 18 Provinces
global LAOall opd_util ipd_util fp_util anc_util del_util cs_util pnc_util ///
		bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util road_util
use "$user/$LAOdata/Data for analysis/LAO_su_24months_for_analyses.dta",  clear
collapse (sum) $LAOall, by (orgunitlevel2 year month)
foreach x of global  LAOall {
histogram `x', percent title("Laos `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/LAO_`x'.pdf", replace
}
* Mexico 35 delegations
global MEXall opd_util er_util ipd_util fp_util sti_util anc_util del_util ///
		cs_util diarr_util pneum_util malnu_util bcg_qual pent_qual measles_qual ///
		opv3_qual pneum_qual rota_qual art_util diab_util hyper_util cerv_qual ///
		breast_util
u "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear
foreach x of  global MEXall {
histogram `x', percent title("Mexico `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/MEX_`x'.pdf", replace
}
* Nepal 77 districts
global NEPall opd_util er_util ipd_util fp_util anc_util del_util cs_util pnc_util ///
		diarr_util pneum_util bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
		tbdetect_qual hivtest_qual diab_util hyper_util

use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta",  clear
rename orgunitlevel3 District
collapse (sum) $NEPall, by (District year month)
foreach x of  global NEPall {
histogram `x', percent title("Nepal `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/NEP_`x'.pdf", replace
}
* Thailand 77 provinces
global THAall opd_util ipd_util del_util malaria_util ///
	diab_util hyper_util road_util
u "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear
foreach x of  global THAall {
histogram `x', percent title("Thailand `x'") graphregion(color(white)) normal 
graph export "$analysis/Results/Graphs/Distributions/THA_`x'.pdf", replace
}















