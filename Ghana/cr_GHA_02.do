* HS performance during Covid
* Created on April 7th 2021
* Ghana, Jan19 - Dec 2020 data

*******************************************************************************

* Call in dataset
import delimited "/$user/$data/Raw data/GHANA DATA-ROUTINE-UPDATED-JAN-DEC-2019-2020.csv", clear	
rename ïregions region 

*******************************************************************************
* Rename variables 
* RMNCH 
rename (numberofnewandcurrentusersofcont totalstis ancattendance ///
		numberofbirthsattendedbyskilledh caesareansectiondeliveries numberofmothersalldeliveries) ///
		(fp_util sti_util anc_util del_util cs_util totaldel)
egen pnc_util = rowtotal(stpnconday1or2 stpnconday37), m 

* Other services 
rename (diarrhoeadiseasesunder5years pneumoniacasesunder5years ///
		malnutritioncasesunder5years totalopdattendance totaladmissions ///
		transportinjuriesroadtrafficacci diabetesmellitus hypertension ///
		numberofopdmalariacases numberoftbcasesdetected majorminorsurgicaloperations) ///
		(diarr_util pneum_util malnu_util opd_util ipd_util road_util ///
		 diab_util hyper_util malaria_util tbdetect_qual surg_util)

* Vaccines 
egen vacc_qual = rowtotal(fullyimmunizedchildren011m ///
						  fullyimmunizedchildren1223months), m 
rename 	(pregnantwomengiventd2 numberofchildrenimmunizedbyage1p ///
         numberofchildrenimmunizedbyage1b opvpolio3childrenvaccinated ///
		 pcv3childrenvaccinated)	///
		(tt_qual pent_qual bcg_qual opv3_qual pneum_qual)
egen measles_qual = rowtotal(measlesrubella1childrenvaccinate ///
					measlesrubella2childrenvaccinate), m
egen rota_qual = rowtotal(rotavirus1childrenvaccinated rotavirus2childrenvaccinated), m 


* Mortality 
rename 	(totalnumberofdeaths earlyneonataldeaths07days totalstillbirth ///
		 totalmaternaldeaths  ) ///
		 (ipd_mort_num newborn_mort_num sb_mort_num mat_mort_num )

foreach x in ipd_mort_num newborn_mort_num sb_mort_num mat_mort_num {
	replace `x'= 0 if `x'==.
} 
*******************************************************************************
* Keep only coded variables 
keep period region fp_util sti_util anc_util del_util cs_util pnc_util diarr_util ///
	 pneum_util malnu_util opd_util ipd_util road_util diab_util hyper_util ///
	 tt_qual malaria_util tbdetect_qual vacc_qual pent_qual bcg_qual opv3_qual ///
	 pneum_qual measles_qual rota_qual ipd_mort_num newborn_mort_num ///
	 sb_mort_num mat_mort_num surg_util totaldel


order region fp_util* sti_util* anc_util* del_util* cs_util* pnc_util* diarr_util*  ///
			 pneum_util*  malnu_util* tt_qual* vacc_qual* pent_qual* bcg_qual* ///
			  measles_qual* opv3_qual* pneum_qual* rota_qual* opd_util* ipd_util* ///
			  road_util* diab_util* hyper_util* malaria_util* tbdetect_qual* ///
			  surg_util* ipd_mort_num* newborn_mort_num* sb_mort_num* ///
			  mat_mort_num* totaldel*
			  
drop surg_util* // values seem improbable

save "$user/$data/Data for analysis/GHA_Jan19-Dec20_WIDE.dta", replace	






