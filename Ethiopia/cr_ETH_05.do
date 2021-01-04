* HS performance during Covid
* Created Dec 7, 2020 
* Ethiopia, Jan19 - October 2020 data

*Imported raw data from January 2019 to Oct 2020 
import delimited "$user/$data/Raw/By levels/Ethiopia_Health system performance during Covid_data extraction_2020_January to October_06_12 _2020_GC/Ethiopia_2020_January to October_ by Woredas_06_12_2020.csv", clear

* Recode variables
* VOLUMES 
* FP
rename (totalnewandrepeatacceptorsdisagg-v27) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20)
	
* STI
rename (totalnumberofsticasesbysextir201-v49) ///
(	sti_util1_19	sti_util2_19	sti_util3_19	sti_util4_19	sti_util5_19	sti_util6_19 ///	
	sti_util7_19	sti_util8_19	sti_util9_19	sti_util10_19	sti_util11_19	sti_util12_19 ///
	sti_util1_20	sti_util2_20	sti_util3_20	sti_util4_20	sti_util5_20	sti_util6_20 ///
	sti_util7_20    sti_util8_20    sti_util9_20    sti_util10_20)
	
* ANC 
rename (numberofpregnantwomenthatreceive-v71) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20)
	
* Deliveries
rename (totalnumberofbirthsattendedbyski-v93 ) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20)   

*Csections
rename ( numberofwomenhavinggivenbirthbyc-v115) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20)
	
* PNC
rename (numberofpostnatalvisitswithin7da-v137) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20)
	
* ORS
rename (numberofchildrentreatedfordiarrh-v159) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20)
	
* Pneumonia
rename ( numberofunder5childrentreatedfor-v181) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20)
	
* Screened malnutrition
rename (totalnumberofchildren5yrsscreene-v203) ///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20)

* ART
rename (numberofadultsandchildrenwhoarec-v225) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20)
		
* OPD 
rename (numberofoutpatientvisitstir2011-v247) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20)
		
* IPD
rename (numberofinpatientadmissionstir20-v269) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20)
		
* ER 
rename (totalnumberofemergencyunitattend-v291) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20)

* Road traffic
rename (numberofroadtrafficinjurycasesdi-v313) ///
(		road_util1_19	road_util2_19	road_util3_19	road_util4_19	road_util5_19	road_util6_19 ///
		road_util7_19	road_util8_19	road_util9_19	road_util10_19	road_util11_19	road_util12_19 ///
		road_util1_20	road_util2_20	road_util3_20	road_util4_20	road_util5_20	road_util6_20 ///
		road_util7_20   road_util8_20   road_util9_20   road_util10_20)
		
* Diabetes visits 
rename (totalnumberofdiabeticpatientsenr-v335) ///
(		diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19 ///
	    diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19  diab_util11_19	diab_util12_19 ///
		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20 ///
		diab_util7_20   diab_util8_20   diab_util9_20   diab_util10_20)
		
* Hypertension screen 
rename (totalnumberofhypertensivepatient-v357) ///
(	hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	///
	hyper_util7_19 	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 ///
	hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20 ///
	hyper_util7_20  hyper_util8_20  hyper_util9_20  hyper_util10_20)
	
drop totalnumberofindividualsscreened-v401 // screened for diabetes or hypertension, not needed

* QUALITY 
* KMC %
* Separate denominator and numerator variables are available 
drop proportionoflowbirthweightandorp-v423

* Newborn resuscitation %
* Separate denominator and numerator variables are available 
drop proportionofasphyxiatedneonatesw-v445


* Cervical cancer screening # 
rename (numberofwomenaged3049screenedwit-v467) ///
(	cerv_qual1_19	cerv_qual2_19	cerv_qual3_19	cerv_qual4_19	cerv_qual5_19	cerv_qual6_19 ///
	cerv_qual7_19	cerv_qual8_19	cerv_qual9_19	cerv_qual10_19	cerv_qual11_19	cerv_qual12_19 ///
	cerv_qual1_20	cerv_qual2_20	cerv_qual3_20	cerv_qual4_20	cerv_qual5_20	cerv_qual6_20 ///
	cerv_qual7_20   cerv_qual8_20   cerv_qual9_20   cerv_qual10_20)
	
* VL supression #
rename (numberofadultandpediatricpatient-v489) ///
(	hivsupp_qual_num1_19	hivsupp_qual_num2_19	hivsupp_qual_num3_19	hivsupp_qual_num4_19 ///
	hivsupp_qual_num5_19	hivsupp_qual_num6_19	hivsupp_qual_num7_19	hivsupp_qual_num8_19 ///
	hivsupp_qual_num9_19	hivsupp_qual_num10_19	hivsupp_qual_num11_19	hivsupp_qual_num12_19 ///
	hivsupp_qual_num1_20	hivsupp_qual_num2_20	hivsupp_qual_num3_20	hivsupp_qual_num4_20 ///
	hivsupp_qual_num5_20	hivsupp_qual_num6_20	hivsupp_qual_num7_20    hivsupp_qual_num8_20 ///
	hivsupp_qual_num9_20    hivsupp_qual_num10_20)
	
* Diabetes enrolled 
rename (v490-v511 ) ///
(diab_qual_num1_19	diab_qual_num2_19	diab_qual_num3_19	diab_qual_num4_19	diab_qual_num5_19	diab_qual_num6_19	diab_qual_num7_19	diab_qual_num8_19	diab_qual_num9_19	diab_qual_num10_19	diab_qual_num11_19	diab_qual_num12_19  diab_qual_num1_20	diab_qual_num2_20	diab_qual_num3_20	diab_qual_num4_20	diab_qual_num5_20   diab_qual_num6_20	diab_qual_num7_20   diab_qual_num8_20 ///
diab_qual_num9_20   diab_qual_num10_20)


* Hypertension enrolled 
rename (v512-v533 ) ///
(hyper_qual_num1_19	hyper_qual_num2_19	hyper_qual_num3_19	hyper_qual_num4_19	hyper_qual_num5_19	hyper_qual_num6_19	hyper_qual_num7_19	hyper_qual_num8_19	hyper_qual_num9_19	hyper_qual_num10_19	hyper_qual_num11_19	hyper_qual_num12_19 hyper_qual_num1_20	hyper_qual_num2_20	hyper_qual_num3_20	hyper_qual_num4_20	hyper_qual_num5_20 ///
	hyper_qual_num6_20	hyper_qual_num7_20 hyper_qual_num8_20 hyper_qual_num9_20 hyper_qual_num10_20)
	
* Full vaccination
rename (numberofchildrenreceivedallvacci-v555) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20)

* Penta3
rename(numberofchildrenunderoneyearofag-v577) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20)
	
* BCG
rename (v578-v599) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20)

* Measles
rename (v600-v621) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 measles_qual10_20)
	
* Polio3
rename (v622-v643) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20)

* Pneumococcal 
rename (v644-v665) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20)

* Rotavirus 2nd dose
drop v666-v687 // dropping 1st dose only
rename (v688-v709) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20)

* MORTALITY 
* Newborn deaths # numerator
rename(numberofneonataldeathsinthefirst-v731) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20)
	
* Stillbirths # numerator
rename (numberofstillbirthstir2011-numberofstillbirthstikemet2013) ///
(sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19 sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20		sb_mort_num5_20		sb_mort_num6_20 sb_mort_num7_20 sb_mort_num8_20 sb_mort_num9_20 sb_mort_num10_20)

* Maternal deaths # numerator
rename (numberofmaternaldeathsinhealthfa-v775) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
	mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20)
	
*Inpatient deaths # numerator
rename (numberofinpatientdeathsintherepo-v797) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
	ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ipd_mort_num10_20)
	
* ER mortality  numerator
rename (totaldeathintheemergencyunittir2-v819) ///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20)

* ICU deaths # numerator
rename (totaldeathinicuinthereportingper-v841) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 icu_mort_num10_20)
	
*Total number of neonates resuscitated 
rename (totalnumberofneonatesresuscitate-v863) ///
(resus_qual_denom1_19	resus_qual_denom2_19	resus_qual_denom3_19	resus_qual_denom4_19	resus_qual_denom5_19	resus_qual_denom6_19	resus_qual_denom7_19	resus_qual_denom8_19	resus_qual_denom9_19	resus_qual_denom10_19	resus_qual_denom11_19	resus_qual_denom12_19 resus_qual_denom1_20	resus_qual_denom2_20	resus_qual_denom3_20	resus_qual_denom4_20	resus_qual_denom5_20	resus_qual_denom6_20	resus_qual_denom7_20	resus_qual_denom8_20 ///
resus_qual_denom9_20    resus_qual_denom10_20)

*Total number of neonates resuscitated and survived 
rename (v864-v885) (resus_qual_num1_19	resus_qual_num2_19	resus_qual_num3_19	resus_qual_num4_19	resus_qual_num5_19	resus_qual_num6_19	resus_qual_num7_19	resus_qual_num8_19	resus_qual_num9_19	resus_qual_num10_19	resus_qual_num11_19	resus_qual_num12_19 resus_qual_num1_20	resus_qual_num2_20	resus_qual_num3_20	resus_qual_num4_20	resus_qual_num5_20	resus_qual_num6_20	resus_qual_num7_20	resus_qual_num8_20 resus_qual_num9_20 resus_qual_num10_20)


*Total number of newborns weighing <2000gm and/or premature 
rename (totalnumberofnewbornsweighing200-v907) (kmc_qual_denom1_19	kmc_qual_denom2_19	kmc_qual_denom3_19	kmc_qual_denom4_19	kmc_qual_denom5_19	kmc_qual_denom6_19	kmc_qual_denom7_19	kmc_qual_denom8_19	kmc_qual_denom9_19	kmc_qual_denom10_19	kmc_qual_denom11_19	kmc_qual_denom12_19 kmc_qual_denom1_20	kmc_qual_denom2_20	kmc_qual_denom3_20	kmc_qual_denom4_20	kmc_qual_denom5_20	kmc_qual_denom6_20	kmc_qual_denom7_20	kmc_qual_denom8_20 kmc_qual_denom9_20 kmc_qual_denom10_20)

*Total number of newborns weighing <2000gm and/or premature newborns for which KMC initiated 
rename (v908-v929) ///
(kmc_qual_num1_19	kmc_qual_num2_19	kmc_qual_num3_19	kmc_qual_num4_19	kmc_qual_num5_19	kmc_qual_num6_19	kmc_qual_num7_19	kmc_qual_num8_19	kmc_qual_num9_19	kmc_qual_num10_19	kmc_qual_num11_19	kmc_qual_num12_19 kmc_qual_num1_20	kmc_qual_num2_20	kmc_qual_num3_20	kmc_qual_num4_20	kmc_qual_num5_20	kmc_qual_num6_20	kmc_qual_num7_20	kmc_qual_num8_20 kmc_qual_num9_20  kmc_qual_num10_20)


* Total deliveries
	egen totaldel1_19 =  rowtotal(del_util1_19 cs_util1_19), m
	egen totaldel2_19 =	rowtotal(del_util2_19 cs_util2_19), m
	egen totaldel3_19 =	rowtotal(del_util3_19 cs_util3_19), m
	egen totaldel4_19 =	rowtotal(del_util4_19 cs_util4_19), m
	egen totaldel5_19=	rowtotal(del_util5_19 cs_util5_19), m
	egen totaldel6_19=	rowtotal(del_util6_19 cs_util6_19), m
	egen totaldel7_19=	rowtotal(del_util7_19 cs_util7_19), m
	egen totaldel8_19=	rowtotal(del_util8_19 cs_util8_19), m
	egen totaldel9_19=	rowtotal(del_util9_19 cs_util9_19), m 
	egen totaldel10_19=	rowtotal(del_util10_19 cs_util10_19), m
	egen totaldel11_19=	rowtotal(del_util11_19  cs_util11_19), m
	egen totaldel12_19=	rowtotal(del_util12_19  cs_util12_19), m
	egen totaldel1_20 =  rowtotal(del_util1_20  cs_util1_20), m
	egen totaldel2_20 =	rowtotal(del_util2_20 cs_util2_20), m
	egen totaldel3_20 =	rowtotal(del_util3_20 cs_util3_20), m
	egen totaldel4_20 =	rowtotal(del_util4_20 cs_util4_20), m
	egen totaldel5_20=	rowtotal(del_util5_20 cs_util5_20), m
	egen totaldel6_20=	rowtotal(del_util6_20 cs_util6_20), m
	egen totaldel7_20=	rowtotal(del_util7_20 cs_util7_20), m
	egen totaldel8_20=	rowtotal(del_util8_20 cs_util8_20), m
	egen totaldel9_20=	rowtotal(del_util9_20 cs_util9_20), m
	egen totaldel10_20=	rowtotal(del_util10_20 cs_util10_20), m


/*Remaining indicators: 
Infants 0-2 months treated for sepsis 
Infants 0-2 months treated for local bacterial infection 
Total discharges from ICU 
Number of inpatient discharges 
Total number of units of blood transfused
Total units of blood received from NBTs & regional blood banks 
Number of safe abortions performed 
Total number of pregnant women tested for syphilis 
Total number of pregnant women treated for Hepatitis 
Total number of teenage girls positive for pregnancy 
Total number of women tested positive pregnancy 
*/

drop numberofsickyounginfants02months-v1171
	
	
* Create unique facility id
rename (orgunitlevel3 orgunitlevel2) (zone region) 
replace region ="Addis Ababa" if region== "Addis Ababa Regional Health Bureau"
replace region ="Afar"  if region== "Afar Regional Health Bureau"
replace region ="Amhara"  if region== "Amhara Regional Health Bureau"
replace region ="Ben Gum" if region==  "Beneshangul Gumuz Regional Health Bureau"
replace region ="Dire Dawa" if region==  "Dire Dawa Regional Health Bureau"
replace region ="Gambella"  if region== "Gambella Regional Health Bureau"
replace region ="Harari"  if region== "Harari Regional Health Bureau"
replace region ="Oromiya"  if region== "Oromiya Regional Health Bureau"
replace region ="SNNP"  if region== "SNNP Regional Health Bureau"
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"

egen unit_id = concat(region zone organisationunitname)

save "$user/$data/Data for analysis/Ethiopia_Jan19-Oct20_WIDE.dta", replace	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
