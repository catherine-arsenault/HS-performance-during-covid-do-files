* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault

global user "/Users/acatherine/Dropbox (Harvard University)"
global analysis "/Users/acatherine/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 1 Service utilization"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 1 Service utilization"

global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"
global analysis "/Users/annagage/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 1 Service utilization"

********************************************************************************
* File paths data 
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
* Variables available in each country
global sentinel opd_util del_util pnc_util art_util diab_util 

global CHLall fp_util anc_util pnc_util er_util surg_util road_util mental_util 

global ETHall fp_util anc_util del_util cs_util pnc_util  diarr_util pneum_util ///
	   malnu_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
	   rota_qual art_util opd_util er_util ipd_util  road_util 

global GHAall fp_util anc_util del_util cs_util pnc_util diarr_util ///
       pneum_util malnu_util vacc_qual bcg_qual pent_qual ///
	   measles_qual opv3_qual pneum_qual rota_qual opd_util ipd_util road_util ///
	   diab_util hyper_util malaria_util tbdetect_qual 
 
global HTIall opd_util fp_util anc_util del_util pnc_util vacc_qual diab_util ///
	   hyper_util cerv_qual
			  
global KZNall anc_util del_util cs_util pnc_util diarr_util pneum_util malnu_util ///
	   art_util opd_util ipd_util road_util diab_util cerv_qual	tbscreen_qual ///
	   tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
	   pneum_qual rota_qual  trauma_util  icu_util
		 		  
global LAOall opd_util ipd_util fp_util anc_util del_util cs_util pnc_util ///
	   bcg_qual pent_qual opv3_qual pneum_qual diab_util hyper_util road_util
	   
global MEXall fp_util anc_util del_util cs_util diarr_util pneum_util malnu_util ///
	   bcg_qual pent_qual measles_qual opd_util opv3_qual pneum_qual ///
	   rota_qual diab_util hyper_util  art_util mental_util  ///
	   er_util ipd_util cerv_qual breast_util	
		   
global NEPall fp_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
	   bcg_qual pent_qual measles_qual opv3_qual pneum_qual opd_util er_util ///
	   ipd_util  diab_util hyper_util tbdetect_qual hivtest_qual 
   
global KORall anc_util del_util cs_util diarr_util pneum_util diab_util hyper_util ///
	   art_util mental_util opd_util er_util ipd_util 

global THAall del_util hyper_util diab_util opd_util ipd_util road_util	malaria_util  		
  
******************************************************************************** 
* Creates datasets for paper 1 analyses
do "$dofiles/cr_su_01.do"

********************************************************************************
* Regression analyses 
do "$dofiles/an_su_02.do"

********************************************************************************
* Creates multi country graphs
do "$dofiles/cr_su_02.do"

********************************************************************************
* Country-specific graphs
run "$dofiles/graphs_Chile.do"
run "$dofiles/graphs_Ethiopia.do"





