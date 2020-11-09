 HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update with August data

clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"




import spss using "$user/$data/Raw/7.Indicadores_IMSS_Agosto_2020_9Nov20.sav", clear

rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México  Oriente"
replace Delegation = "México Poniente" if Delegation== "México  Poniente"
* 35 delegations, data in wide form

*FP
egen fp_util7_20 = rowtotal( Indic1_PF1vez_jul2020 Indic1_PFSub_jul2020), m
egen fp_util8_20 = rowtotal( Indic1_PF1vez_ago2020 Indic1_PFSub_ago2020), m
drop Indic1_PF*

*STI care
rename (Indic2_ETS_jun2020-Indic2_ETS_ago2020) (sti_util6_20 sti_util7_20 ///
		sti_util8_20)
		
* ANC
egen anc_util3_20 = rowtotal(Indic3_mar_1raVez20 Indic3_mar_Subsec20), m
egen anc_util4_20 = rowtotal(Indic3_abr_1raVez20 Indic3_abr_Subsec20), m
egen anc_util5_20 = rowtotal(Indic3_may_1raVez20 Indic3_may_Subsec20), m
egen anc_util6_20 = rowtotal(Inidic3_jun_1raVez20 Indic3_jun_Subsec20), m 
egen anc_util7_20 = rowtotal(Indic3_jul_1raVez20 Indic3_jul_Subsec20), m 
egen anc_util8_20 = rowtotal( Indic3_ago_1raVez20 Indic3_ago_Subsec20), m 
drop Indic3_* Inidic3_jun_1raVez20

* Deliveries , csections, 
rename ( Indic4_FD_ago2020 Indic5_Cesa_ago2020) (del_util8_20 cs_util8_20)

* Total deliveries
egen totaldel8_20= rowtotal(del_util8_20 cs_util8_20), m

* Diarrhea, pneumonia, malnutrition
rename(Indic7_Gastro_ago2020 Indic8_Neumo_ago2020 Indic9_Desnu_ago2020) ///
		(diarr_util8_20 pneum_util8_20 malnu_util8_20)

* Outpatients
egen opd_util8_20= rowtotal(Indic11_vmf_Ago2020 Indic11_esp_Ago2020), m

*ER, dental 
rename (Indic11_urg_Ago2020 Indic11_dntl_Ago2020) (er_util8_20 dental_util8_20)	
		
