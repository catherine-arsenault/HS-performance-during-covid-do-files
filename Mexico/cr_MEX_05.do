* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update with August data

clear all
set more off	

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
drop Indic11* 

*IPD
rename In12_egrecc_ago20 ipd_util8_20
drop In12_*

* Diabetes and hypertension visits among all (adult and children)
rename (In15_DM_jul20 In15_DM_ago20 In15_DM_sept20 In16_HTA_jul20 ///
In16_HTA_ago20 In16_HTA_sept20) ( diab_util7_20 diab_util8_20 ///
diab_util9_20 hyper_util7_20  hyper_util8_20  hyper_util9_20 )
 
rename Indic17_sui_ago20 mental_util8_20 

rename Indic21cacu_aug2020 cerv_util8_20 

rename ( Indic24_dmctrl_ago20 Indic25_htactrl_ago20) (diab_qual_num8_20 hyper_qual_num8_20 )

* Error in delivery data - Edited Nov 10 2020 
drop del_util*_20 cs_util*_20 totaldel*_20
save "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta", replace

import excel using "$user/$data/Raw/Punto 3_Partos atendidios  2020 enero - agosto.xlsx", sheet(Sheet1) firstrow clear
drop Año
rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México Ote"
replace Delegation = "México Poniente" if Delegation== "México Pte"
replace Delegation = "D.F. Norte" if Delegation== "CDMX Norte"
replace Delegation = "D.F. Sur" if Delegation== "CDMX Sur"
replace Delegation = "Veracruz Norte" if Delegation== "Veracruz Nte"

rename (Enero Febrero Marzo Abril Mayo Junio Julio Agosto) ///
(del_util1_20 del_util2_20 del_util3_20 del_util4_20 del_util5_20 del_util6_20 ///
del_util7_20 del_util8_20 )
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta", replace

* Error in caesarean data - Edited Nov 10 2020 
import excel using "$user/$data/Raw/Punto 4_Césareas  2020 enero -agosto.xlsx", sheet(Sheet1) firstrow clear
drop Año
rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México Ote"
replace Delegation = "México Poniente" if Delegation== "México Pte"
replace Delegation = "D.F. Norte" if Delegation== "CDMX Norte"
replace Delegation = "D.F. Sur" if Delegation== "CDMX Sur"
replace Delegation = "Veracruz Norte" if Delegation== "Veracruz Nte"
rename (Enero Febrero Marzo Abril Mayo Junio Julio Agosto) ///
(cs_util1_20 cs_util2_20 cs_util3_20 cs_util4_20 cs_util5_20 cs_util6_20 ///
cs_util7_20 cs_util8_20 )
merge 1:1 Delegation using "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta"
drop _merge 

* Total deliveries
egen totaldel1_20= rowtotal(del_util1_20 cs_util1_20), m
egen totaldel2_20= rowtotal(del_util2_20 cs_util2_20), m
egen totaldel3_20= rowtotal(del_util3_20 cs_util3_20), m
egen totaldel4_20= rowtotal(del_util4_20 cs_util4_20), m
egen totaldel5_20= rowtotal(del_util5_20 cs_util5_20), m
egen totaldel6_20= rowtotal(del_util6_20 cs_util6_20), m
egen totaldel7_20= rowtotal(del_util7_20 cs_util7_20), m
egen totaldel8_20= rowtotal(del_util8_20 cs_util8_20), m

save "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta", replace

********************************************************************************
* MERGE TO DATA FROM FIRST AND SECOND ROUNDS (Jan19-Jul20)
********************************************************************************
merge 1:1 Delegation using  "$user/$data/Data for analysis/IMSS_Jan19-Jul20_WIDE.dta"
drop _merge
order Deleg sti_util*  del_util*  cs_util*  diarr_util*  pneum_util*  malnu_util* ///
	art_util*  er_util*  ipd_util*  dental_util* diab_util*   hyper_util*  mental_util* ///
	opv3_qual*  pneum_qual*  rota_qual*  fp_util*  anc_util*  opd_util*  cerv_util*  ///
	diab_qual_num*  hyper_qual_num*  pent_qual* bcg_qual* bcgu_qual* measles_qual* ///
	newborn_mort_num*  sb_mort_num* mat_mort_num*  er_mort_num* ///
	ipd_mort_num* death_covid*  hospit_covid* death_negative* hospit_negative* ///
	death_pending* hospit_pending* totaldel*
save "$user/$data/Data for analysis/IMSS_Jan19-Aug20_WIDE.dta", replace

