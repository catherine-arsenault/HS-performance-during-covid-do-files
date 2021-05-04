* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault


global user "/Users/acatherine/Dropbox (Harvard University)"
global analysis "/Users/acatherine/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 1 Service utilization"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 1 Service utilization"

global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"
global analysis "/Users/annagage/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 1 Service utilization"

********************************************************************************
global CHLdata "/HMIS Data for Health System Performance Covid (Chile)"
global ETHdata "/HMIS Data for Health System Performance Covid (Ethiopia)"
global GHAdata "/HMIS Data for Health System Performance Covid (Ghana)"
global HTIdata "/HMIS Data for Health System Performance Covid (Haiti)"
global KORdata "/HMIS Data for Health System Performance Covid (South Korea)"
global KZNdata "/HMIS Data for Health System Performance Covid (South Africa)"
global LAOdata "/HMIS Data for Health System Performance Covid (Lao PDR)"
global MEXdata "/HMIS Data for Health System Performance Covid (Mexico)"
global NEPdata "/HMIS Data for Health System Performance Covid (Nepal)"
global THAdata "/HMIS Data for Health System Performance Covid (Thailand)"
********************************************************************************

global all opd_util er_util road_util ipd_util fp_util sti_util anc_util ///
		   del_util cs_util kmc_qual pnc_util diarr_util pneum_util malnu_util ///
		   vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
		   rota_qual malaria_util tbscreen_qual hivtest_qual tbdetect_qual ///
		   art_util  diab_util hyper_util cerv_qual breast_util
		
********************************************************************************
* Creates datasets for paper 1 analyses
do "$dofiles/cr_su_01.do"

********************************************************************************
* Creates multi country graphs
do "$dofiles/cr_su_02.do"

********************************************************************************
* Regression analyses by country 
do "$dofiles/an_su_Chile"
do "$dofiles/an_su_Ethiopia"
do "$dofiles/an_su_Ghana"
do "$dofiles/an_su_Haiti"
do "$dofiles/an_su_Korea"
do "$dofiles/an_su_KZN"
do "$dofiles/an_su_Lao"
do "$dofiles/an_su_Mexico"
do "$dofiles/an_su_Nepal"
do "$dofiles/an_su_Thailand"







