* Health system resilience during Covid-19 
* Associations between COVID-19 lockdowns and health service disruptions in 10 countries 

global user "/Users/acatherine/Dropbox (Harvard University)"
global dofiles "/Users/acatherine/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 4"

global user "/Users/nek096/Dropbox (Harvard University)"
global dofiles "/Users/nek096/Documents/GitHub/HS-performance-during-covid-do-files/Multi-country/Paper 4 Factors Associated"

global analysis "SPH-Kruk Team/QuEST Network/Core Research/HS performance Covid (internal)/Multi-country papers/Paper 4 Factors associated"
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

global CHLall del_util cs_util ipd_util road_util surg_util pnc_util fp_util ///
	   er_util mental_util anc_util hyper_util diab_util measles_qual pent_qual ///
	   bcg_qual pneum_qual breast_util pneum_util

global ETHall fp_util anc_util del_util cs_util pnc_util  diarr_util pneum_util ///
	   malnu_util vacc_qual bcg_qual pent_qual measles_qual opv3_qual pneum_qual ///
	   rota_qual art_util opd_util er_util ipd_util  road_util 

global GHAall fp_util anc_util del_util cs_util pnc_util diarr_util ///
       pneum_util vacc_qual bcg_qual pent_qual ///
	   measles_qual opv3_qual pneum_qual rota_qual opd_util ipd_util road_util ///
	   diab_util hyper_util malaria_util tbdetect_qual 
 
global HTIall opd_util fp_util anc_util del_util pnc_util vacc_qual diab_util ///
	   hyper_util 
			  
global KZNall anc_util del_util cs_util pnc_util diarr_util pneum_util  ///
	   art_util opd_util ipd_util road_util diab_util cerv_qual	tbscreen_qual ///
	   tbdetect_qual tbtreat_qual vacc_qual bcg_qual pent_qual measles_qual ///
	   pneum_qual rota_qual  trauma_util  
		 		  
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
  
