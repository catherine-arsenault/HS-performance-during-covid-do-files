* HS performance during Covid
* April 20, 2021
* Haiti, January 2019 - March 2021
* Data recoding, Min Kyung Kim 

clear all 
set more off 

********************************************************************************
*MCH-related data 
import excel "$user/$data//Raw data/Jan19-March21/MCH_dataset_DI.xlsx", sheet("MCH") firstrow clear 

* Total deliveries
rename (AccouchementsInstitutionnelsJa - AE) ///
(totaldel1_19	totaldel2_19	totaldel3_19	///
totaldel4_19	totaldel5_19	totaldel6_19	totaldel7_19	totaldel8_19	///
totaldel9_19	totaldel10_19	totaldel11_19	totaldel12_19 	totaldel1_20	///
totaldel2_20	totaldel3_20	totaldel4_20	totaldel5_20	totaldel6_20	///
totaldel7_20	totaldel8_20	totaldel9_20	totaldel10_20	totaldel11_20 ///
totaldel12_20	totaldel1_21	totaldel2_21	totaldel3_21	)

* PNC visits for mother 
rename (ConsultationspostnatalesJanvie - BF) ///
(pncm_util1_19	pncm_util2_19	pncm_util3_19	///
pncm_util4_19	pncm_util5_19	pncm_util6_19	pncm_util7_19	pncm_util8_19	///
pncm_util9_19	pncm_util10_19	pncm_util11_19	pncm_util12_19 pncm_util1_20	///
pncm_util2_20	pncm_util3_20	pncm_util4_20	pncm_util5_20	pncm_util6_20	///
pncm_util7_20	pncm_util8_20	pncm_util9_20	pncm_util10_20	pncm_util11_20 ///
pncm_util12_20	pncm_util1_21	pncm_util2_21	pncm_util3_21	)

* Prenatal visits 
rename (VisiteConsultationsprenatales - CG) ///
(prenatal_util1_19	prenatal_util2_19	prenatal_util3_19	prenatal_util4_19 ///
prenatal_util5_19	prenatal_util6_19	prenatal_util7_19	prenatal_util8_19 ///
prenatal_util9_19	prenatal_util10_19	prenatal_util11_19	prenatal_util12_19 ///
prenatal_util1_20	prenatal_util2_20	prenatal_util3_20	prenatal_util4_20 ///
prenatal_util5_20	prenatal_util6_20	prenatal_util7_20	prenatal_util8_20 ///
prenatal_util9_20	prenatal_util10_20	prenatal_util11_20	prenatal_util12_20 ///
prenatal_util1_21	prenatal_util2_21	prenatal_util3_21)

* Maternal deaths - no data
rename (NombredeDecesmaternelsJanvie - DH) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19 ///
mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19 ///
mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 ///
mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20 ///
mat_mort_num5_20	mat_mort_num6_20	mat_mort_num7_20	mat_mort_num8_20 ///
mat_mort_num9_20	mat_mort_num10_20	mat_mort_num11_20	mat_mort_num12_20 ///
mat_mort_num1_21	mat_mort_num2_21	mat_mort_num3_21)

* Fully vaccinated 
egen vacc_qual1_19 = rowtotal(CompletementVaccinesInstitutio ///
CompletementVaccinesCommunauta), m 
egen vacc_qual2_19 = rowtotal(DJ EK), m 
egen vacc_qual3_19 = rowtotal(DK EL), m 
egen vacc_qual4_19 = rowtotal(DL EM), m 
egen vacc_qual5_19 = rowtotal(DM EN), m 
egen vacc_qual6_19 = rowtotal(DN EO), m 
egen vacc_qual7_19 = rowtotal(DO EP), m 
egen vacc_qual8_19 = rowtotal(DP EQ), m 
egen vacc_qual9_19 = rowtotal(DQ ER), m 
egen vacc_qual10_19 = rowtotal(DR ES), m 
egen vacc_qual11_19 = rowtotal(DS ET), m 
egen vacc_qual12_19 = rowtotal(DT EU), m 
egen vacc_qual1_20 = rowtotal(DU EV), m
egen vacc_qual2_20 = rowtotal(DV EW), m
egen vacc_qual3_20 = rowtotal(DW EX), m
egen vacc_qual4_20 = rowtotal(DX EY), m
egen vacc_qual5_20 = rowtotal(DY EZ), m 
egen vacc_qual6_20 = rowtotal(DZ FA), m 
egen vacc_qual7_20 = rowtotal(EA FB), m
egen vacc_qual8_20 = rowtotal(EB FC), m 
egen vacc_qual9_20 = rowtotal(EC FD), m 
egen vacc_qual10_20 = rowtotal(ED FE), m 
egen vacc_qual11_20 = rowtotal(EE FF), m 
egen vacc_qual12_20 = rowtotal(EF FG), m 
egen vacc_qual1_21 = rowtotal(EG FH), m 
egen vacc_qual2_21 = rowtotal(EH FI), m 
egen vacc_qual3_21 = rowtotal(EI FJ), m 

drop CompletementVaccinesInstitutio - FJ

* Cervical cancer screening 
rename (NombredeFemmesbenificiairesd - HL) ///
(cerv_qual1_19	cerv_qual2_19	cerv_qual3_19	cerv_qual4_19	cerv_qual5_19 ///
cerv_qual6_19	cerv_qual7_19	cerv_qual8_19	cerv_qual9_19	cerv_qual10_19 ///
cerv_qual11_19	cerv_qual12_19 cerv_qual1_20	cerv_qual2_20	cerv_qual3_20 ///
cerv_qual4_20	cerv_qual5_20	cerv_qual6_20	cerv_qual7_20	cerv_qual8_20 ///
cerv_qual9_20	cerv_qual10_20	cerv_qual11_20	cerv_qual12_20	cerv_qual1_21 ///
cerv_qual2_21	cerv_qual3_21	)

* Stillborn 
rename (NombredemortnesJanvier2019 - NombredemortnesMars2021) ///
(sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	///
sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	///
sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	///
sb_mort_num11_19	sb_mort_num12_19 sb_mort_num1_20	///
sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	sb_mort_num5_20	///
sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20	sb_mort_num9_20 ///
sb_mort_num10_20	sb_mort_num11_20	sb_mort_num12_20 sb_mort_num1_21 ///
sb_mort_num2_21 sb_mort_num3_21)


order Number, after(ID)

save "$user/$data/Data for analysis/Haiti_Jan19-March21_MCH.dta", replace

********************************************************************************
* NCD - related data 

import excel "$user/$data//Raw data/Jan19-March21/NCD_dataset_DI.xlsx", sheet("NCD") firstrow clear 

*Diabetes visits (only the old case available)
rename (AnciensCasDiabeteJanvier2019 - AnciensCasDiabeteMars2021) ///
(diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19 ///
diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19 ///
diab_util11_19	diab_util12_19  diab_util1_20	diab_util2_20	diab_util3_20 ///
diab_util4_20	diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20 ///
diab_util9_20	diab_util10_20	diab_util11_20	diab_util12_20 diab_util1_21 ///
diab_util2_21	diab_util3_21)			 										  		

* Hypertension visits 
egen hyper_util1_19= rowtotal (AnciensCasHTAJanvier2019 NouveauxCasHTAJanvier2019 ) , m 
egen hyper_util2_19= rowtotal (AnciensCasHTAFévrier2019 NouveauxCasHTAFévrier2019 ) , m 
egen hyper_util3_19= rowtotal (AnciensCasHTAMars2019 NouveauxCasHTAMars2019 ) , m 
egen hyper_util4_19= rowtotal (AnciensCasHTAAvril2019 NouveauxCasHTAAvril2019 ) , m 
egen hyper_util5_19= rowtotal (AnciensCasHTAMai2019 NouveauxCasHTAMai2019 ) , m 
egen hyper_util6_19= rowtotal (AnciensCasHTAJuin2019 NouveauxCasHTAJuin2019 ) , m 
egen hyper_util7_19= rowtotal (AnciensCasHTAJuillet2019 NouveauxCasHTAJuillet2019 ) , m 
egen hyper_util8_19= rowtotal (AnciensCasHTAAoût2019 NouveauxCasHTAAoût2019 ) , m 
egen hyper_util9_19= rowtotal (AnciensCasHTASeptembre2019 NouveauxCasHTASeptembre2019 ) , m 
egen hyper_util10_19= rowtotal (AnciensCasHTAOctobre2019 NouveauxCasHTAOctobre2019 ) , m 
egen hyper_util11_19= rowtotal (AnciensCasHTANovembre2019 NouveauxCasHTANovembre2019 ) , m 
egen hyper_util12_19= rowtotal (AnciensCasHTADécembre2019 NouveauxCasHTADécembre2019 ) , m 
egen hyper_util1_20= rowtotal (AnciensCasHTAJanvier2020 NouveauxCasHTAJanvier2020 ) , m 
egen hyper_util2_20= rowtotal (AnciensCasHTAFévrier2020 NouveauxCasHTAFévrier2020 ) , m 
egen hyper_util3_20= rowtotal (AnciensCasHTAMars2020 NouveauxCasHTAMars2020 ) , m 
egen hyper_util4_20= rowtotal (AnciensCasHTAAvril2020 NouveauxCasHTAAvril2020 ) , m 
egen hyper_util5_20= rowtotal (AnciensCasHTAMai2020 NouveauxCasHTAMai2020 ) , m 
egen hyper_util6_20= rowtotal (AnciensCasHTAJuin2020 NouveauxCasHTAJuin2020 ) , m 
egen hyper_util7_20= rowtotal (AnciensCasHTAJuillet2020 NouveauxCasHTAJuillet2020 ) , m 
egen hyper_util8_20= rowtotal (AnciensCasHTAAoût2020 NouveauxCasHTAAoût2020 ) , m 
egen hyper_util9_20= rowtotal (AnciensCasHTASeptembre2020 NouveauxCasHTASeptembre2020 ) , m 
egen hyper_util10_20= rowtotal (AnciensCasHTAOctobre2020 NouveauxCasHTAOctobre2020 ) , m 
egen hyper_util11_20= rowtotal (AnciensCasHTANovembre2020 NouveauxCasHTANovembre2020 ) , m 
egen hyper_util12_20= rowtotal (AnciensCasHTADécembre2020 NouveauxCasHTADécembre2020 ) , m 
egen hyper_util1_21= rowtotal (AnciensCasHTAJanvier2021 NouveauxCasHTAJanvier2021 ) , m 
egen hyper_util2_21= rowtotal (AnciensCasHTAFévrier2021 NouveauxCasHTAFévrier2021 ) , m 
egen hyper_util3_21= rowtotal (AnciensCasHTAMars2021 NouveauxCasHTAMars2021 ) , m 

drop AnciensCasHTAJanvier2019 - NouveauxCasDiabeteMars2021

order Number, after(ID)

merge 1:1 Number using "$user/$data/Data for analysis/Haiti_Jan19-March21_MCH.dta" 
drop _merge

save "$user/$data/Data for analysis/Haiti_Jan19-March21_NCD_MCH.dta", replace

********************************************************************************
* OPC - related data 

import excel "$user/$data//Raw data/Jan19-March21/OPC_dataset_DI.xlsx", sheet("OPC") firstrow clear 

* Dental visits 
rename (NombreClientsensoinsbuccode - AE) ///
(dental_util1_19	dental_util2_19	dental_util3_19	///
dental_util4_19	 dental_util5_19  dental_util6_19	dental_util7_19 dental_util8_19	///
dental_util9_19	 dental_util10_19 dental_util11_19	dental_util12_19 dental_util1_20 ///
dental_util2_20	 dental_util3_20  dental_util4_20	dental_util5_20	dental_util6_20	///
dental_util7_20 dental_util8_20	dental_util9_20	dental_util10_20	dental_util11_20 ///
dental_util12_20 dental_util1_21 dental_util2_21 dental_util3_21)

* Outpatient visits 
egen opd_util1_19 = rowtotal (VisitesdesClientesPFRepart VisitesdesEnfants14ans VisitesdesEnfants1014ans VisitesdesEnfants59ans VisitesdesEnfants1anRep VisitesdesFemmesEnceintesR VisitesdesJeunesadultes15 ) , m 
egen opd_util2_19 = rowtotal (AG BH CI DJ EK FL GM) , m 
egen opd_util3_19 = rowtotal (AH BI CJ DK EL FM GN) , m 
egen opd_util4_19 = rowtotal (AI BJ CK DL EM FN GO) , m 
egen opd_util5_19 = rowtotal (AJ BK CL DM EN FO GP) , m 
egen opd_util6_19 = rowtotal (AK BL CM DN EO FP GQ ) , m 
egen opd_util7_19 = rowtotal (AL BM CN DO EP FQ GR ) , m 
egen opd_util8_19 = rowtotal (AM BN CO DP EQ FR GS ) , m 
egen opd_util9_19 = rowtotal (AN BO CP DQ ER FS GT ) , m 
egen opd_util10_19 = rowtotal (AO BP CQ DR ES FT GF GU ) , m 
egen opd_util11_19 = rowtotal (AP BQ CR DS ET FU GV ) , m 
egen opd_util12_19 = rowtotal (AQ BR CS DT EU FV GW ) , m 
egen opd_util1_20 = rowtotal (AR BS CT DU EV FW GX ) , m 
egen opd_util2_20 = rowtotal (AS BT CU DV EW FX GY ) , m 
egen opd_util3_20 = rowtotal (AT BU CV DW EX FY GZ ) , m 
egen opd_util4_20 = rowtotal (AU BV CW DX EY FZ HA ) , m 
egen opd_util5_20 = rowtotal (AV BW CX DY EZ GA HB ) , m 
egen opd_util6_20 = rowtotal (AW BX CY DZ FA GB HC) , m 
egen opd_util7_20 = rowtotal (AX BY CZ EA FB GC HD) , m 
egen opd_util8_20 = rowtotal (AY BZ DA EB FC GD HE) , m 
egen opd_util9_20 = rowtotal (AZ CA DB EC FD GE HF) , m 
egen opd_util10_20 = rowtotal (BA CB DC ED FE GF HG) , m 
egen opd_util11_20 = rowtotal (BB CC DD EE FF GG HH) , m 
egen opd_util12_20 = rowtotal (BC CD DE EF FG GH HI) , m 
egen opd_util1_21 = rowtotal (BD CE DF EG FH GI HJ) , m 
egen opd_util2_21 = rowtotal (BE CF DG EH FI GJ HK) , m 
egen opd_util3_21 = rowtotal (BF CG DH EI FJ GK HL) , m 

drop VisitesdesClientesPFRepart  - HL

order Number, after(ID)

merge 1:1 Number using "$user/$data/Data for analysis/Haiti_Jan19-March21_NCD_MCH.dta" 
drop _merge

save "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta", replace

*END 


																							
																							
																							
																							
																							
																							
																							
																							
																							
																							
																							


