* HS performance during Covid
* July 24, 2020 , Edits to DM and HTN control on August 26th 
* Catherine Arsenault
* Mexico - IMSS, January 2019 - February 2020
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import spss using "$user/$data/Raw/Indicators_IMSS_Jan_Dec2019_Jan_Febr2020.sav", clear
drop if num_del==.

* 35 delegations, data in wide form
* Indicators
* FP
egen fp_util1_19 = rowtotal(Indic1_PF1vez_jan2019 Indic1_PFSub_jan2019), m
egen fp_util2_19 = rowtotal(Indic1_*feb2019 ), m
egen fp_util3_19 = rowtotal(Indic1_*mar2019 ), m
egen fp_util4_19 = rowtotal(Indic1_PF1vez_apr2019  Indic1_PFSub_abr2019), m
egen fp_util5_19 = rowtotal(Indic1_*may_2019), m
egen fp_util6_19 = rowtotal(Indic1_*jun2019), m
egen fp_util7_19 = rowtotal(Indic1_*jul2019), m
egen fp_util8_19 = rowtotal(Indic1_*ago2019), m
egen fp_util9_19 = rowtotal(Indic1_*sept2019), m
egen fp_util10_19 = rowtotal(Indic1_*oct2019), m
egen fp_util11_19 = rowtotal(Indic1_*nov2019), m
egen fp_util12_19 = rowtotal(Indic1_*dic2019), m
egen fp_util1_20 = rowtotal(Indic1_*ene2020 ), m
egen fp_util2_20 = rowtotal(Indic1_PF1vez_feb2020 Indic1_PFSub_feb_2020), m
drop Indic1_*  
* STI
rename (Indic2_ETS_jan2019 Indic2_ETS_feb2019 Indic2_ETS_mar2019 Indic2_ETS_abr2019 Indic2_ETS_may2019 Indic2_ETS_jun2019 Indic2_ETS_jul2019 Indic2_ETS_ago2019 Indic2_ETS_sept2019 Indic2_ETS_oct2019 Indic2_ETS_nov2019 Indic2_ETS_dic2019 Indic2_ETS_ene2020 Indic2_ETS_feb2020) ( sti_util1_19	sti_util2_19	sti_util3_19	sti_util4_19	sti_util5_19	sti_util6_19	sti_util7_19	sti_util8_19	sti_util9_19	sti_util10_19	sti_util11_19	sti_util12_19 sti_util1_20 sti_util2_20)
* ANC
egen anc_util1_19 = rowtotal(Indic3_*ene2019), m
egen anc_util2_19 = rowtotal(Indic3_*feb2019 ), m
egen anc_util3_19 = rowtotal(Indic3_*mar2019), m
egen anc_util4_19 = rowtotal(Indic3_*abr2019), m
egen anc_util5_19 = rowtotal(Indic3_AC1ravez_may2019  Indic3_ACSub_may2019), m
egen anc_util6_19 = rowtotal(Indic3_AC1ravez_jun2019  Indic3_ACSub_jun2019), m
egen anc_util7_19 = rowtotal(Indic3_AC1ravez_jul2019 Indic3_ACSub_jul2019), m
egen anc_util8_19 = rowtotal(Indic3_AC1ravez_ago2019   Indic3_ACSub_ago2019), m
egen anc_util9_19 = rowtotal(Indic3_AC1ravez_sept2019 Indic3_ACSub_sept2019), m
egen anc_util10_19 = rowtotal(Indic3_AC1ravez_oct2019 Indic3_ACSub_oct2019), m
egen anc_util11_19 = rowtotal(Indic3_AC1ravez_nov2019  Indic3_ACSub_nov2019 ), m
egen anc_util12_19 = rowtotal(Indic3_AC1ravez_dic_2019  Indic3_ACSub_dic2019), m
egen anc_util1_20 = rowtotal(Indic3_AC1ravez_ene2020   Indic3_ACSubsec_ene2020), m
egen anc_util2_20 = rowtotal(Indic3_AC1ravez_feb2020_A  Indic3_ACSubsec_feb2020), m
drop Indic3_*
* Deliveries
rename (Indic4_FD_ene2019 Indic4_FD_feb2019 Indic4_FD_mar2019 Indic4_FD_abr2019 Indic4_FD_may2019 Indic4_FD_jun2019 Indic4_FD_jul2019 Indic4_FD_ago2019 Indic4_FD_sept2019 Indic4_FD_oct2019 Indic4_FD_nov2019 Indic4_FD_dic2019 Indic4_FD_ene2020 Indic4_FD_feb2020) ( del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 del_util1_20 del_util2_20)
*Caesareans
rename (Indic5_Cesa_ene2019 Indic5_Cesa_feb2019 Indic5_Cesa_mar2019 Indic5_Cesa_abr2019 Indic5_Cesa_may2019 Indic5_Cesa_jun2019 Indic5_Cesa_jul2019 Indic5_Cesa_ago2019 Indic5_Cesa_sept2019 Indic5_Cesa_oct2019 Indic5_Cesa_nov2019 Indic5_Cesa_dic2019 Indic5_Cesa_ene2020 Indic5_Cesa_feb2020) (cs_util1_19	cs_util2_19	cs_util3_19	cs_util4_19	cs_util5_19	cs_util6_19	cs_util7_19	cs_util8_19	cs_util9_19	cs_util10_19	cs_util11_19	cs_util12_19 cs_util1_20 cs_util2_20)
* Create total deliveries =  deliveries + C-sections to calculate rates later on
egen totaldel1_19 = rowtotal( del_util1_19 cs_util1_19), m
egen totaldel2_19 = rowtotal( del_util2_19 cs_util2_19), m
egen totaldel3_19 = rowtotal( del_util3_19 cs_util3_19), m
egen totaldel4_19 = rowtotal( del_util4_19 cs_util4_19), m
egen totaldel5_19 = rowtotal( del_util5_19 cs_util5_19), m
egen totaldel6_19 = rowtotal( del_util6_19 cs_util6_19), m
egen totaldel7_19 = rowtotal( del_util7_19 cs_util7_19), m
egen totaldel8_19 = rowtotal( del_util8_19 cs_util8_19), m
egen totaldel9_19 = rowtotal( del_util9_19 cs_util9_19), m
egen totaldel10_19 = rowtotal( del_util10_19 cs_util10_19), m
egen totaldel11_19 = rowtotal( del_util11_19 cs_util11_19), m
egen totaldel12_19 = rowtotal( del_util12_19 cs_util12_19), m
egen totaldel1_20 = rowtotal( del_util1_20 cs_util1_20), m
egen totaldel2_20 = rowtotal( del_util2_20 cs_util2_20), m

*Diarrhea
rename (Indic7_Gastro_ene2019 Indic7_Gastro_feb2019 Indic7_Gastro_mar2019 Indic7_Gastro_abr2019 Indic7_Gastro_may2019 Indic7_Gastro_jun2019 Indic7_Gastro_jul2019 Indic7_Gastro_ago2019 Indic7_Gastro_sept2019 Indic7_Gastro_oct2019 Indic7_Gastro_nov2019 Indic7_Gastro_dic2019 Indic7_Gastro_ene2020 Indic7_Gastro_feb2020) (diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 diarr_util1_20 diarr_util2_20)
*Pneumonia
rename( Indic8_Neumo_ene2019 Indic8_Neumo_feb2019 Indic8_Neumo_mar2019 Indic8_Neumo_abr2019 Indic8_Neumo_may2019 Indic8_Neumo_jun2019 Indic8_Neumo_jul2019 Indic8_Neumo_ago2019 Indic8_Neumo_sept2019 Indic8_Neumo_oct2019 Indic8_Neumo_nov2019 Indic8_Neumo_dic2019 Indic8_Neumo_ene2020 Indic8_Neumo_feb2020) (pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 pneum_util1_20	pneum_util2_20 )
*Malnutrition
rename (Indic9_Desnu_ene2019 Indic9_Desnu_feb2019 Indic9_Desnu_mar2019 Indic9_Desnu_abr2019 Indic9_Desnu_may2019 Indic9_Desnu_jun2019 Indic9_Desnu_jul2019 Indic9_Desnu_ago2019 Indic9_Desnu_sept2019 Indic9_Desnu_oct2019 Indic9_Desnu_nov2019 Indic9_Desnu_dic2019 Indic9_Desnu_ene2020 Indic9_Desnu_feb2020) (malnu_util1_19	malnu_util2_19	malnu_util3_19	malnu_util4_19	malnu_util5_19	malnu_util6_19	malnu_util7_19	malnu_util8_19	malnu_util9_19	malnu_util10_19	malnu_util11_19	malnu_util12_19 malnu_util1_20	malnu_util2_20)
* ART
rename(Indic10_TAR_ene2019 Indic10_TAR_feb2019 Indic10_TAR_mar2019 Indic10_TAR_abr2019 Indic10_TAR_may2019 Indic10_TAR_jun2019 Indic10_TAR_jul2019 Indic10_TAR_ago2019 Indic10_TAR_sept2019 Indic10_TAR_oct2019 Indic10_TAR_nov2019 Indic10_TAR_dic2019) (art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19	art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19)
* Dental
rename (Indic11_dntl_ene2019 Indic11_dntl_feb2019 Indic11_dntl_mar2019 Indic11_dntl_abr2019 Indic11_dntl_may2019 Indic11_dntl_jun2019 Indic11_dntl_jul2019 Indic11_dntl_ago2019 Indic11_dntl_sept2019 Indic11_dntl_oct2019 Indic11_dntl_nov2019 Indic11_dntl_dic2019 Indic11_dntl_ene2020 Indic11_dntl_feb2020) (dental_util1_19	dental_util2_19	dental_util3_19	dental_util4_19	dental_util5_19	dental_util6_19	dental_util7_19	dental_util8_19	dental_util9_19	dental_util10_19	dental_util11_19	dental_util12_19 dental_util1_20	dental_util2_20)
* OPD = (# of visits to family medicine) + (# of outpatient specialty consultations) 
egen opd_util1_19=rowtotal( Indic11_vmf_ene2019 Indic11_esp_ene2019 ), m
egen opd_util2_19=rowtotal( Indic11_vmf_feb2019 Indic11_esp_feb2019 ), m
egen opd_util3_19=rowtotal( Indic11_vmf_mar2019  Indic11_esp_mar2019), m
egen opd_util4_19=rowtotal( Indic11_vmf_abr2019  Indic11_esp_abr2019), m
egen opd_util5_19=rowtotal(  Indic11_vmf_may2019  Indic11_esp_may2019), m
egen opd_util6_19=rowtotal(  Indic11_vmf_jun2019  Indic11_esp_jun2019), m
egen opd_util7_19=rowtotal( Indic11_vmf_jul2019  Indic11_esp_jul2019 ), m
egen opd_util8_19=rowtotal( Indic11_vmf_ago2019 Indic11_esp_ago2019 ), m
egen opd_util9_19=rowtotal(  Indic11_vmf_sept2019  Indic11_esp_sept2019), m
egen opd_util10_19=rowtotal( Indic11_vmf_oct2019 Indic11_esp_oct2019), m
egen opd_util11_19=rowtotal(Indic11_vmf_nov2019  Indic11_esp_nov2019  ), m
egen opd_util12_19=rowtotal( Indic11_vmf_dic2019   Indic11_esp_dic2019 ), m
egen opd_util1_20=rowtotal( Indic11_vmf_ene2020 Indic11_esp_ene2020), m
egen opd_util2_20= rowtotal(Indic11_vmf_feb2020 Indic11_esp_feb2020) , m
* ER 
rename (Indic11_urg_ene2019 Indic11_urg_feb2019 Indic11_urg_mar2019 Indic11_urg_abr2019 Indic11_urg_may2019 Indic11_urg_jun2019 Indic11_urg_jul2019 Indic11_urg_ago2019 Indic11_urg_sept2019 Indic11_urg_oct2019 Indic11_urg_nov2019 Indic11_urg_dic2019 Indic11_urg_ene2020 Indic11_urg_feb2020) ( er_util1_19	er_util2_19	er_util3_19	er_util4_19	er_util5_19	er_util6_19	er_util7_19	er_util8_19	er_util9_19	er_util10_19	er_util11_19	er_util12_19 er_util1_20	er_util2_20)
drop Indic11_*
* IPD 
rename (Indic12_egrecc_ene2019 Indic12_egrecc_feb2019 Indic12_egrecc_mar2019 Indic12_egrecc_abr2019 Indic12_egrecc_may2019 Indic12_egrecc_jun2019 Indic12_egrecc_jul2019 Indic12_egrecc_ago2019 Indic12_egrecc_sept2019 Indic12_egrecc_oct2019 Indic12_egrecc_nov2019 Indic12_egrecc_dic2019 Indic12_egrecc_ene2020 Indic12_egrecc_feb2020) (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ipd_util1_20	ipd_util2_20)
drop Indic12_egrecctip* Indic12_egrecctiu*
* DM (diabetic patients visits)
rename (Indic15_DM_ene19-Indic15_DM_feb20) ( diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19 diab_util1_20	diab_util2_20)
* HTN
rename (Indic16_HTA_ene19 Indic16_HTA_feb19 Indic16_HTA_mar19 Indic16_HTA_abr19 Indic16_HTA_may19 Indic16_HTA_jun19 Indic16_HTA_jul19 Indic16_HTA_ago19 Indic16_HTA_sept19 Indic16_HTA_oct19 Indic16_HTA_nov19 Indic16_HTA_dic19 Indic16_HTA_ene20 Indic16_HTA_feb20 ) (hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 hyper_util1_20	hyper_util2_20)
* Mental health, attempted suicide
rename (Indic17_sui_ene19 Indic17_sui_feb19 Indic17_sui_mar19 Indic17_sui_abr19 Indic17_sui_may19 Indic17_sui_jun19 Indic17_sui_jul19 Indic17_sui_ago19 Indic17_sui_sept19 Indic17_sui_oct19 Indic17_sui_nov19 Indic17_sui_dic19 Indic17_sui_ene20 Indic17_sui_feb20) (mental_util1_19	mental_util2_19	mental_util3_19	mental_util4_19	mental_util5_19	mental_util6_19	mental_util7_19	mental_util8_19	mental_util9_19	mental_util10_19	mental_util11_19	mental_util12_19 mental_util1_20	mental_util2_20)
* TB, HiV viral load, only annual values, will drop for now
drop Indic20_tuber_2019 Indic20_tuber_2020 Indic23vih_suppres2019
*QUALITY
* Cervical cancer screening %
rename Indic21_Enero1Den cerv_denom
rename (Indic21cacu_jan2019-Indic21cacu_dec2019) (cerv_qual1_19 cerv_qual2_19 cerv_qual3_19 cerv_qual4_19 cerv_qual5_19 ///
		cerv_qual6_19 cerv_qual7_19 cerv_qual8_19 cerv_qual9_19 cerv_qual10_19 cerv_qual11_19 cerv_qual12_19)
* Blood sugar control % Edits Aug 26, among 20+
save "$user/$data/Data for analysis/IMSS_Jan19-Feb20_WIDE.dta", replace	
import spss using "$user/$data/Raw/Number_DM& hypertensive patients visited primary care clinics_2019-20years and older.sav", clear
drop num_del 
rename Delegación Delegation 
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Feb20_WIDE.dta"
drop _merge
rename (Indic24_dmctrl_ene19-Indic24_dmctrl_dic19) (diab_qual_num1_19 diab_qual_num2_19  diab_qual_num3_19  diab_qual_num4_19  diab_qual_num5_19 ///
		 diab_qual_num6_19  diab_qual_num7_19  diab_qual_num8_19  diab_qual_num9_19  diab_qual_num10_19  diab_qual_num11_19  diab_qual_num12_19)
rename (numberDM_jan2019-numberDM_dic19) (diab_qual_denom1_19 diab_qual_denom2_19  diab_qual_denom3_19  diab_qual_denom4_19  diab_qual_denom5_19 ///
		 diab_qual_denom6_19  diab_qual_denom7_19  diab_qual_denom8_19  diab_qual_denom9_19  diab_qual_denom10_19  diab_qual_denom11_19  ///
		 diab_qual_denom12_19)
drop Indic24* 
* HTN controlled % Edited Aug 26, among 20+ 
rename (Indic25_htactrl_ene19- Indic25_htactrl_dic19) (hyper_qual_num1_19 hyper_qual_num2_19  hyper_qual_num3_19  hyper_qual_num4_19  hyper_qual_num5_19 ///
		 hyper_qual_num6_19  hyper_qual_num7_19  hyper_qual_num8_19  hyper_qual_num9_19  hyper_qual_num10_19  hyper_qual_num11_19  hyper_qual_num12_19)
rename	(numberHBP_ene2019-numberHBP_dic19) (hyper_qual_denom1_19 hyper_qual_denom2_19  hyper_qual_denom3_19  hyper_qual_denom4_19  hyper_qual_denom5_19 ///
		 hyper_qual_denom6_19  hyper_qual_denom7_19  hyper_qual_denom8_19  hyper_qual_denom9_19  hyper_qual_denom10_19  hyper_qual_denom11_19 ///
		 hyper_qual_denom12_19)
drop Indic25* 
* VACCINES
* Penta vaccine #
egen pent_qual1_19 =rowtotal ( Indic26*ene19 ) , m
egen pent_qual2_19 =rowtotal (Indic26*feb19 ) , m 
egen pent_qual3_19 =rowtotal ( Indic26*mar19  ) , m
egen pent_qual4_19 =rowtotal ( Indic26*abr19  ) , m
egen pent_qual5_19 =rowtotal (Indic26*may19) , m
egen pent_qual6_19 =rowtotal (  Indic26*jun19 ) , m
egen pent_qual7_19 =rowtotal ( Indic26*jul19 ) , m
egen pent_qual8_19 =rowtotal (  Indic26*ago19 ) , m
egen pent_qual9_19 =rowtotal ( Indic26*sept19 ) , m
egen pent_qual10_19 =rowtotal (  Indic26*oct19 ), m 
egen pent_qual11_19 =rowtotal (  Indic26*nov19  ) , m
egen pent_qual12_19 =rowtotal ( Indic26*dic19  ) , m
egen pent_qual1_20 =rowtotal ( Indic26*ene20  ) , m
egen pent_qual2_20 =rowtotal (  Indic26*feb20  ) , m 
egen pent_qual3_20 =rowtotal ( Indic26*mar20 ) , m
egen pent_qual4_20 =rowtotal (Indic26*abr20     ) , m
egen pent_qual5_20 =rowtotal (Indic26*may20) , m
drop Indic26_penta*
* BCG
egen bcg_qual1_19 =rowtotal ( Indic27*ene19) , m
egen bcg_qual2_19 =rowtotal (Indic27*feb19 ) , m
egen bcg_qual3_19 =rowtotal ( Indic27*mar19) , m
egen bcg_qual4_19 =rowtotal ( Indic27*abr19), m
egen bcg_qual5_19 =rowtotal (Indic27*may19 ) , m
egen bcg_qual6_19 =rowtotal ( Indic27*jun19) , m
egen bcg_qual7_19 =rowtotal ( Indic27*jul19) , m
egen bcg_qual8_19 =rowtotal ( Indic27*ago19) , m
egen bcg_qual9_19 =rowtotal ( Indic27*sept19) , m
egen bcg_qual10_19 =rowtotal (Indic27*oct9) , m
egen bcg_qual11_19 =rowtotal ( Indic27*nov19) , m
egen bcg_qual12_19 =rowtotal (Indic27*dic19 ) , m
egen bcg_qual1_20 =rowtotal ( Indic27*ene20) , m
egen bcg_qual2_20 =rowtotal (Indic27*feb20 ) , m
egen bcg_qual3_20 =rowtotal ( Indic27*mar20) , m
egen bcg_qual4_20 =rowtotal ( Indic27*abr20), m
egen bcg_qual5_20 =rowtotal (Indic27*may20 ) , m
drop Indic27*
* MCV
egen measles_qual1_19 =rowtotal (Indic28*ene19  ) , m
egen measles_qual2_19 =rowtotal (Indic28*feb19  ) , m
egen measles_qual3_19 =rowtotal ( Indic28*mar19 ) , m
egen measles_qual4_19 =rowtotal ( Indic28*abr19  ) , m
egen measles_qual5_19 =rowtotal (Indic28*may19   ) , m
egen measles_qual6_19 =rowtotal ( Indic28*jun19  ) , m
egen measles_qual7_19 =rowtotal ( Indic28*jul19 ) , m
egen measles_qual8_19 =rowtotal (Indic28*ago19  ) , m
egen measles_qual9_19 =rowtotal (  Indic28*sept19  ) , m
egen measles_qual10_19 =rowtotal (  Indic28*oct19 ) , m
egen measles_qual11_19 =rowtotal (Indic28*nov19   ) , m
egen measles_qual12_19 =rowtotal ( Indic28*dic19  ) , m
egen measles_qual1_20 =rowtotal ( Indic28*ene20   ) , m
egen measles_qual2_20 =rowtotal ( Indic28*feb20  ) , m
egen measles_qual3_20 =rowtotal (  Indic28*mar20  ) , m
egen measles_qual4_20 =rowtotal (  Indic28*abr20  ) , m
egen measles_qual5_20 =rowtotal (  Indic28*may20   ) , m
drop Indic28*
* OPV3
rename (Indic29_SABIN_T_ene19 Indic29_SABIN_T_feb19 Indic29_SABIN_T_mar19 Indic29_SABIN_T_abr19 Indic29_SABIN_T_may19 Indic29_SABIN_T_jun19 Indic29_SABIN_T_jul19 Indic29_SABIN_T_ago19 Indic29_SABIN_T_sept19 Indic29_SABIN_T_oct9 Indic29_SABIN_T_nov19 Indic29_SABIN_T_dic19 Indic29_SABIN_T_ene20 Indic29_SABIN_T_feb20 Indic29_SABIN_T_mar20 Indic29_SABIN_T_abr20 Indic29_SABIN_T_may20) (opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19  opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20)
drop Indic29_SABIN_U_* Indic29_SABIN_P_* Indic29_SABIN_S_* Indic29_SABIN_R_* Indic29_SABIN_A_*
* Pneumo vaccine
rename (Indic30_ANC_ene19 Indic30_ANC_feb19 Indic30_ANC_mar19 Indic30_ANC_abr19 Indic30_ANC_may19 Indic30_ANC_jun19 Indic30_ANC_jul19 Indic30_ANC_ago19 Indic30_ANC_sept19 Indic30_ANC_oct19 Indic30_ANC_nov19 Indic30_ANC_dic19 Indic30_ANC_ene20 Indic30_ANC_feb20 Indic30_ANC_mar20 Indic30_ANC_abr20 Indic30_ANC_may20) (pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20)
* Rota vaccine
rename (Indic31_RV_ene19 Indic31_RV_feb19 Indic31_RV_mar19 Indic31_RV_abr19 Indic31_RV_may19 Indic31_RV_jun19 Indic31_RV_jul19 Indic31_RV_ago19 Indic31_RV_sept19 Indic31_RV_oct19 Indic31_RV_nov19 Indic31_RV_dic19 Indic31_RV_ene20 Indic31_RV_feb20 Indic31_RV_mar20 Indic31_RV_abr20 Indic31_RV_may20) (rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20 )
* MORTALITY
* newborn mortality
rename (Indic32_NMN_ene19-Indic32_NMN_dic19) (newborn_mort_num1_19 newborn_mort_num2_19 newborn_mort_num3_19 newborn_mort_num4_19 ///
		newborn_mort_num5_19 newborn_mort_num6_19 newborn_mort_num7_19 newborn_mort_num8_19 newborn_mort_num9_19 newborn_mort_num10_19 ///
		newborn_mort_num11_19 newborn_mort_num12_19)
drop Indic32*
* Stillbirth mortality
foreach v in Indic33_NMF_ene19 Indic33_NMF_feb19 Indic33_NMF_mar19 Indic33_NMF_abr19 ///
			 Indic33_NMF_may19 Indic33_NMF_jun19 Indic33_NMF_jul19 Indic33_NMF_ago19 ///
			 Indic33_NMF_sept19 Indic33_NMF_oct19 Indic33_NMF_nov19 Indic33_NMF_dic19 {
	replace `v'= 0 if `v'==.
}
rename(Indic33_NMF_ene19-Indic33_NMF_dic19) (sb_mort_num1_19 sb_mort_num2_19 sb_mort_num3_19 sb_mort_num4_19 ///
		sb_mort_num5_19 sb_mort_num6_19 sb_mort_num7_19 sb_mort_num8_19 sb_mort_num9_19 sb_mort_num10_19 ///
		sb_mort_num11_19 sb_mort_num12_19)
drop Indic33*
* Maternal mortality	
foreach v in Indic34_NMM_ene19 Indic34_NMM_feb19 Indic34_NMM_mar19 Indic34_NMM_abr19 ///
			 Indic34_NMM_may19 Indic34_NMM_jun19 Indic34_NMM_jul19 Indic34_NMM_ago19 ///
			 Indic34_NMM_sept19 Indic34_NMM_oct19 Indic34_NMM_nov19 Indic34_NMM_dic19 {
	replace `v'= 0 if `v'==.
}
rename (Indic34_NMM_ene19-Indic34_NMM_dic19)(mat_mort_num1_19 mat_mort_num2_19 mat_mort_num3_19 mat_mort_num4_19 mat_mort_num5_19 mat_mort_num6_19 mat_mort_num7_19 mat_mort_num8_19 mat_mort_num9_19 mat_mort_num10_19 mat_mort_num11_19 mat_mort_num12_19)
drop Indic34*
* ER mortality
rename(Indic36_ene19-Indic36_feb_20)(er_mort_num1_19 er_mort_num2_19 er_mort_num3_19 er_mort_num4_19 er_mort_num5_19 er_mort_num6_19 er_mort_num7_19 er_mort_num8_19 er_mort_num9_19 er_mort_num10_19 er_mort_num11_19 er_mort_num12_19 er_mort_num1_20  er_mort_num2_20) 
drop Indic36*
* Inpatient mortality (ICU and inpatient deaths, not ER deaths)
egen ipd_mort_num1_19 =rowtotal (  Indic37_ene19 Indic38_ene19) , m
egen ipd_mort_num2_19 =rowtotal (Indic37_feb19  Indic38_feb19) , m
egen ipd_mort_num3_19 =rowtotal (  Indic37_mar19  Indic38_mar19 ) , m
egen ipd_mort_num4_19 =rowtotal (  Indic37_abr19 Indic38_abr19   ) , m
egen ipd_mort_num5_19 =rowtotal (  Indic37_may19  Indic38_may19 ) , m
egen ipd_mort_num6_19 =rowtotal (   Indic37_jun19  Indic38_jun19 ) , m
egen ipd_mort_num7_19 =rowtotal ( Indic37_jul19  Indic38_jul19  ) , m
egen ipd_mort_num8_19 =rowtotal (   Indic37_ago19  Indic38_ago19  ) , m
egen ipd_mort_num9_19 =rowtotal ( Indic37_sept19    Indic38_sept19) , m
egen ipd_mort_num10_19 =rowtotal (   Indic37_oct19   Indic38_oct19) , m
egen ipd_mort_num11_19 =rowtotal ( Indic37_nov19  Indic38_nov19) , m
egen ipd_mort_num12_19 =rowtotal (  Indic37_dic19  Indic38_dic19  ) , m
egen ipd_mort_num1_20 =rowtotal ( Indic37_ene20     Indic38_ene_20  ) , m
egen ipd_mort_num2_20 =rowtotal (  Indic37_feb20  Indic38_feb20 ) , m
drop Indic37* Indic38* 

forval i = 1/12 {
	replace newborn_mort`i'_19 = newborn_mort`i'_19 * 1000
	replace sb_mort`i'_19 = sb_mort`i'_19*1000
	replace mat_mort`i'_19 = mat_mort`i'_19*1000
	replace er_mort`i'_19 = er_mort`i'_19*1000
	replace ipd_mort`i'_19 = ipd_mort`i'_19*1000
	cap replace er_mort`i'_20 = er_mort`i'_20*1000
	cap replace ipd_mort`i'_20 = ipd_mort`i'_20*1000
}
 
save "$user/$data/Data for analysis/IMSS_Jan19-Feb20_WIDE.dta", replace	

/* Reshape to long form
	reshape long  sti_util  del_util  cs_util  diarr_util  pneum_util  malnu_util  art_util  er_util  ipd_util  dental_util diab_util  ///
				  hyper_util  mental_util  cs_qual opv3_qual  pneum_qual  rota_qual  fp_util  anc_util  opd_util  cerv_qual  diab_qual  ///
				  hyper_qual  pent_qual  bcg_qual  measles_qual  newborn_mort  sb_mort  mat_mort  er_mort  ipd_mort  , ///
				  i(num_del) j(month) string


* Labels (And dashboard format)
* Volume RMNCH services
	lab var fp_util "Number of new and current users of contraceptives"
	lab var sti_util "Number of consultations for STI care"
	lab var anc_util "Total number of antenatal care visits"
	lab var del_util "Number of facility deliveries"
	lab var cs_util "Number of caesarean sections "
	lab var diarr_util "Number of consultations for sick child care - diarrhea"
	lab var pneum_util "Number of consultations for sick child care - pneumonia"
	lab var malnu_util "Number of consultations for sick child care - malnutrition"
* Vaccines
	lab var bcg_qual "Nb children vaccinated with bcg vaccine"
	lab var pent_qual "Nb children vaccinated with 3rd dose pentavalent"
	lab var measles_qual "Nb children vaccinated with measles vaccine"
	lab var opv3_qual "Nb children vaccinated with 3rd dose oral polio vaccine"
	lab var pneum_qual "Nb children vaccinated with pneumococcal vaccine"
	lab var rota_qual "Nb children vaccinated with rotavirus vaccine"
* Volume other services	
	lab var dental_util "Number of dental visits"
	lab var diab_util "Number of diabetic patients visits PC clinics"
	lab var hyper_util "Number of hypertensive patients visits PC clinics"
	lab var art_util "Number of adult and children on ART "
	lab var mental_util "Number consultations for attempted suicides"
	lab var opd_util  "Nb outpatient (family medicine clinic  & opd specialty) visits"
	lab var er_util "Number of emergency room visits"
	lab var ipd_util "Number of inpatient admissions total"
* Quality 
	lab var cerv_qual "% women 25-64 screened with VIA for cervical cancer"
	lab var diab_qual "% diabetic patients with controlled blood sugar"
	lab var hyper_qual "% hypertisive patients with controlled blood pressure" 
	lab var cs_qual "Caesarean section rate"
* Institutional mortality 
	lab var newborn_mort "Institutional newborn mortality %"
	lab var sb_mort "Institutional stillbirth rate %"
	lab var mat_mort "Institutional maternal mortality rate %"
	lab var er_mort "Emergency room mortality  %"
	lab var ipd_mort "ICU and inpatient deaths (not ED) / inpatient admissions  %"
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" 
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
order num_del Delegation year mo fp_util anc_util sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util ///
	  opd_util ipd_util diab_util hyper_util dental mental_util cs_qual cerv_qual diab_qual hyper_qual pent_qual measles_qual ///
	  bcg_qual opv3_qual pneum_qual rota_qual *_mort

sort num_del year mo 
rename mo month

save "$user/$data/Data for analysis/IMSS_Jan19-Feb20_clean.dta", replace

* Reshaping for data visualisations
preserve
	keep if year == 2020
	global varlist fp_util anc_util sti_util del_util cs_util diarr_util pneum_util malnu_util art_util er_util opd_util ipd_util ///
				   diab_util hyper_util dental_util mental_util cs_qual cerv_qual diab_qual hyper_qual pent_qual measles_qual bcg_qual ///
				   opv3_qual pneum_qual rota_qual newborn_mort sb_mort mat_mort er_mort ipd_mort
				   
	foreach v of global varlist {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/temp.dta", replace
restore

keep if year==2019

foreach v of global varlist {
	rename(`v')(`v'19)
	}
drop year
merge m:m num_del Delegation month using "$user/$data/temp.dta"
drop HF_tot - population2020 _merge

export delimited using "$user/$data/IMSS_Jan19-Feb20_fordashboard.csv", replace

rm "$user/$data/temp.dta"






