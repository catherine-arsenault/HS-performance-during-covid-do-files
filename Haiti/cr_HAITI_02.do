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
(del_util1_19	del_util2_19	del_util3_19	///
del_util4_19	del_util5_19	del_util6_19	del_util7_19	del_util8_19	///
del_util9_19	del_util10_19	del_util11_19	del_util12_19 	del_util1_20	///
del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20	///
del_util7_20	del_util8_20	del_util9_20	del_util10_20	del_util11_20 ///
del_util12_20	del_util1_21	del_util2_21	del_util3_21	)

* PNC visits for mother 
rename (ConsultationspostnatalesJanvie - BF) ///
(pnc_util1_19	pnc_util2_19	pnc_util3_19	///
pnc_util4_19	pnc_util5_19	pnc_util6_19	pnc_util7_19	pnc_util8_19	///
pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 pnc_util1_20	///
pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20	///
pnc_util7_20	pnc_util8_20	pnc_util9_20	pnc_util10_20	pnc_util11_20 ///
pnc_util12_20	pnc_util1_21	pnc_util2_21	pnc_util3_21	)

* Prenatal visits - variables are empty
drop  VisiteConsultationsprenatales - CG

* Maternal deaths - no data
drop  NombredeDecesmaternelsJanvie - DH

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

*Diabetes visits 										  		
egen diab_util1_19= rowtotal (AnciensCasDiabeteJanvier2019 NouveauxCasDiabeteJanvier201), m
egen diab_util2_19= rowtotal (AnciensCasDiabeteFévrier2019 NouveauxCasDiabeteFévrier201), m
egen diab_util3_19= rowtotal (AnciensCasDiabeteMars2019 NouveauxCasDiabeteMars2019), m
egen diab_util4_19= rowtotal (AnciensCasDiabeteAvril2019 NouveauxCasDiabeteAvril2019), m
egen diab_util5_19= rowtotal (AnciensCasDiabeteMai2019 NouveauxCasDiabeteMai2019), m
egen diab_util6_19= rowtotal (AnciensCasDiabeteJuin2019 NouveauxCasDiabeteJuin2019), m
egen diab_util7_19= rowtotal (AnciensCasDiabeteJuillet2019 NouveauxCasDiabeteJuillet201), m
egen diab_util8_19= rowtotal (AnciensCasDiabeteAoût2019 NouveauxCasDiabeteAoût2019), m
egen diab_util9_19= rowtotal (AnciensCasDiabeteSeptembre20 NouveauxCasDiabeteSeptembre2), m
egen diab_util10_19= rowtotal (AnciensCasDiabeteOctobre2019 NouveauxCasDiabeteOctobre201), m
egen diab_util11_19= rowtotal (AnciensCasDiabeteNovembre201 NouveauxCasDiabeteNovembre20), m
egen diab_util12_19= rowtotal (AnciensCasDiabeteDécembre201 NouveauxCasDiabeteDécembre20), m
egen diab_util1_20= rowtotal (AnciensCasDiabeteJanvier2020 NouveauxCasDiabeteJanvier202), m
egen diab_util2_20= rowtotal (AnciensCasDiabeteFévrier2020 NouveauxCasDiabeteFévrier202), m
egen diab_util3_20= rowtotal (AnciensCasDiabeteMars2020 NouveauxCasDiabeteMars2020), m
egen diab_util4_20= rowtotal (AnciensCasDiabeteAvril2020 NouveauxCasDiabeteAvril2020), m
egen diab_util5_20= rowtotal (AnciensCasDiabeteMai2020 NouveauxCasDiabeteMai2020), m
egen diab_util6_20= rowtotal (AnciensCasDiabeteJuin2020 NouveauxCasDiabeteJuin2020), m
egen diab_util7_20= rowtotal (AnciensCasDiabeteJuillet2020 NouveauxCasDiabeteJuillet202), m
egen diab_util8_20= rowtotal (AnciensCasDiabeteAoût2020 NouveauxCasDiabeteAoût2020), m
egen diab_util9_20= rowtotal (Y DB), m
egen diab_util10_20= rowtotal (AnciensCasDiabeteOctobre2020 NouveauxCasDiabeteOctobre202), m
egen diab_util11_20= rowtotal (AnciensCasDiabeteNovembre202 DD), m 
egen diab_util12_20= rowtotal (AnciensCasDiabeteDécembre202 DE), m
egen diab_util1_21= rowtotal (AnciensCasDiabeteJanvier2021 DF), m
egen diab_util2_21= rowtotal (AnciensCasDiabeteFévrier2021 DG), m
egen diab_util3_21= rowtotal (AnciensCasDiabeteMars2021 NouveauxCasDiabeteMars2021), m 

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

drop AnciensCasDiabeteJanvier2019-NouveauxCasDiabeteMars2021

order Number, after(ID)

merge 1:1 Number using "$user/$data/Data for analysis/Haiti_Jan19-March21_MCH.dta" 
drop _merge

save "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta", replace

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

* Family planning
rename (VisitesdesClientesPFRepart-BF) ///
(fp_util1_19	fp_util2_19	fp_util3_19	///
fp_util4_19	 fp_util5_19  fp_util6_19	fp_util7_19 fp_util8_19	///
fp_util9_19	 fp_util10_19 fp_util11_19	fp_util12_19 fp_util1_20 ///
fp_util2_20	 fp_util3_20  fp_util4_20	fp_util5_20	fp_util6_20	///
fp_util7_20 fp_util8_20	fp_util9_20	fp_util10_20	fp_util11_20 ///
fp_util12_20 fp_util1_21 fp_util2_21 fp_util3_21)

* ANC 
rename (VisitesdesFemmesEnceintesR-GK) ///
(anc_util1_19	anc_util2_19	anc_util3_19	///
anc_util4_19	 anc_util5_19  anc_util6_19	anc_util7_19 anc_util8_19	///
anc_util9_19	 anc_util10_19 anc_util11_19	anc_util12_19 anc_util1_20 ///
anc_util2_20	 anc_util3_20  anc_util4_20	anc_util5_20	anc_util6_20	///
anc_util7_20 anc_util8_20	anc_util9_20	anc_util10_20	anc_util11_20 ///
anc_util12_20 anc_util1_21 anc_util2_21 anc_util3_21)

drop VisitesdesEnfants14ans-FJ VisitesdesJeunesadultes15-HL

order Number, after(ID)

merge 1:1 Number using "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta" 
drop _merge

save "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta", replace

********************************************************************************
* Maternal mortality 
import excel "$user/$data//Raw data/Jan19-March21/Maternal_mortality_DI.xlsx", sheet("Sheet 1") firstrow clear 

rename E Number 

//no data 
drop DecesmaternelsJanvier2020 - DecesmaternelsDécembre2019

rename (NombredeDecesmaternelsparAc - AC) ///
(mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20 ///
mat_mort_num5_20	mat_mort_num6_20	mat_mort_num7_20	mat_mort_num8_20 ///
mat_mort_num9_20	mat_mort_num10_20	mat_mort_num11_20	mat_mort_num12_20  ///
mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19 ///
mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19 ///
mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 )

order org* ID Number *_19 *_20

merge 1:1 Number using "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta" 
drop _merge

save "$user/$data/Data for analysis/Haiti_Jan19-March21_WIDE.dta", replace

rm  "$user/$data/Data for analysis/Haiti_Jan19-March21_MCH.dta"
 
********************************************************************************
*END

																							
																							
																							
																							
																							
																							
																							
																							
																							
																							
																							


