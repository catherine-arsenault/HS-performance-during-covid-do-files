* HS performance during Covid
* Created March 24th, 2020 
* Ethiopia, Jan19 - October 2020 data

*Imported raw data from January 2019 to Dec 2020 (n=3943)
import delimited "$user/$data/Raw/2020/Rcvd 23MAR2021/Ethiopia_Health system performance during Covid_data extraction_2021_January to December_21_03 _2021_GC/Ethiopia_2021_January to December_ by Woreda Level_21_03_2021.csv", clear

* Recode variables
* VOLUMES 
* FP
rename (totalnewandrepeatacceptorsdisagg - v29) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)
	
* STI
rename (totalnumberofsticasesbysextir201- v53) ///
(	sti_util1_19	sti_util2_19	sti_util3_19	sti_util4_19	sti_util5_19	sti_util6_19 ///	
	sti_util7_19	sti_util8_19	sti_util9_19	sti_util10_19	sti_util11_19	sti_util12_19 ///
	sti_util1_20	sti_util2_20	sti_util3_20	sti_util4_20	sti_util5_20	sti_util6_20 ///
	sti_util7_20    sti_util8_20    sti_util9_20    sti_util10_20 sti_util11_20 sti_util12_20)
	
* ANC 
rename (numberofpregnantwomenthatreceive- v77) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
	
* Deliveries
rename (totalnumberofbirthsattendedbyski-v101) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename ( numberofwomenhavinggivenbirthbyc- v125) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20) 
	
* PNC
rename (numberofpostnatalvisitswithin7da- v149) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20)
	
* ORS
rename (numberofchildrentreatedfordiarrh- v173) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
* Pneumonia
rename ( numberofunder5childrentreatedfor - v197) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)
	
* Screened malnutrition
rename (totalnumberofchildren5yrsscreene- v221) ///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)

* ART
rename (numberofadultsandchildrenwhoarec - v245) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20) 
		
* OPD 
rename (numberofoutpatientvisitstir2011 - v269) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
* IPD
rename (numberofinpatientadmissionstir20- v293) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)
		
* ER 
rename (totalnumberofemergencyunitattend - v317) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)

* Road traffic
rename (numberofroadtrafficinjurycasesdi- v341) ///
(		road_util1_19	road_util2_19	road_util3_19	road_util4_19	road_util5_19	road_util6_19 ///
		road_util7_19	road_util8_19	road_util9_19	road_util10_19	road_util11_19	road_util12_19 ///
		road_util1_20	road_util2_20	road_util3_20	road_util4_20	road_util5_20	road_util6_20 ///
		road_util7_20   road_util8_20   road_util9_20   road_util10_20 road_util11_20 road_util12_20)
		
* Diabetes patients enrolled in care 6 months prior to report
rename (totalnumberofdiabeticpatientsenr - v365) ///
(		diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19 ///
	    diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19  diab_util11_19	diab_util12_19 ///
		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20 ///
		diab_util7_20   diab_util8_20   diab_util9_20   diab_util10_20  diab_util11_20  diab_util12_20)
		
* Hypertension patients enrolled in care 6 months prior to report
rename (totalnumberofhypertensivepatient - v389) ///
(	hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	///
	hyper_util7_19 	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 ///
	hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20 ///
	hyper_util7_20  hyper_util8_20  hyper_util9_20  hyper_util10_20 hyper_util11_20 hyper_util12_20)

* Diabetes screen	
rename (totalnumberofindividualsscreened - v413) ///
(		diab_detec1_19	diab_detec2_19	diab_detec3_19	diab_detec4_19	diab_detec5_19	diab_detec6_19 ///
	    diab_detec7_19	diab_detec8_19	diab_detec9_19	diab_detec10_19  diab_detec11_19	diab_detec12_19 ///
		diab_detec1_20	diab_detec2_20	diab_detec3_20	diab_detec4_20	diab_detec5_20	diab_detec6_20 ///
		diab_detec7_20   diab_detec8_20   diab_detec9_20   diab_detec10_20 diab_detec11_20 diab_detec12_20)

* Hypertension screen 
rename ( v414 - v437)	///
(	hyper_detec1_19	hyper_detec2_19	hyper_detec3_19	hyper_detec4_19	hyper_detec5_19	hyper_detec6_19	///
	hyper_detec7_19 	hyper_detec8_19	hyper_detec9_19	hyper_detec10_19	hyper_detec11_19	hyper_detec12_19 ///
	hyper_detec1_20	hyper_detec2_20	hyper_detec3_20	hyper_detec4_20	hyper_detec5_20	hyper_detec6_20 ///
	hyper_detec7_20  hyper_detec8_20  hyper_detec9_20  hyper_detec10_20 hyper_detec11_20 hyper_detec12_20)
	
* QUALITY 
* KMC %
* Separate denominator and numerator variables are available 
drop proportionoflowbirthweightandorp - v461

* Newborn resuscitation %
* Separate denominator and numerator variables are available 
drop proportionofasphyxiatedneonatesw - v485

* Cervical cancer screening # 
rename (numberofwomenaged3049screenedwit- v509) ///
(	cerv_qual1_19	cerv_qual2_19	cerv_qual3_19	cerv_qual4_19	cerv_qual5_19	cerv_qual6_19 ///
	cerv_qual7_19	cerv_qual8_19	cerv_qual9_19	cerv_qual10_19	cerv_qual11_19	cerv_qual12_19 ///
	cerv_qual1_20	cerv_qual2_20	cerv_qual3_20	cerv_qual4_20	cerv_qual5_20	cerv_qual6_20 ///
	cerv_qual7_20   cerv_qual8_20   cerv_qual9_20   cerv_qual10_20 cerv_qual11_20 cerv_qual12_20)
	
* VL supression #
rename (numberofadultandpediatricpatient - v533) ///
(	hivsupp_qual_num1_19	hivsupp_qual_num2_19	hivsupp_qual_num3_19	hivsupp_qual_num4_19 ///
	hivsupp_qual_num5_19	hivsupp_qual_num6_19	hivsupp_qual_num7_19	hivsupp_qual_num8_19 ///
	hivsupp_qual_num9_19	hivsupp_qual_num10_19	hivsupp_qual_num11_19	hivsupp_qual_num12_19 ///
	hivsupp_qual_num1_20	hivsupp_qual_num2_20	hivsupp_qual_num3_20	hivsupp_qual_num4_20 ///
	hivsupp_qual_num5_20	hivsupp_qual_num6_20	hivsupp_qual_num7_20    hivsupp_qual_num8_20 ///
	hivsupp_qual_num9_20    hivsupp_qual_num10_20  hivsupp_qual_num11_20  hivsupp_qual_num12_20)
	
* Diabetes control 
rename (v534 - v557) ///
(diab_qual_num1_19	diab_qual_num2_19	diab_qual_num3_19	diab_qual_num4_19	diab_qual_num5_19	diab_qual_num6_19	diab_qual_num7_19	diab_qual_num8_19	diab_qual_num9_19	diab_qual_num10_19	diab_qual_num11_19	diab_qual_num12_19  diab_qual_num1_20	diab_qual_num2_20	diab_qual_num3_20	diab_qual_num4_20	diab_qual_num5_20   diab_qual_num6_20	diab_qual_num7_20   diab_qual_num8_20 ///
diab_qual_num9_20   diab_qual_num10_20  diab_qual_num11_20  diab_qual_num12_20)

* Hypertension control
rename (v558 - v581) ///
(hyper_qual_num1_19	hyper_qual_num2_19	hyper_qual_num3_19	hyper_qual_num4_19	hyper_qual_num5_19	hyper_qual_num6_19	hyper_qual_num7_19	hyper_qual_num8_19	hyper_qual_num9_19	hyper_qual_num10_19	hyper_qual_num11_19	hyper_qual_num12_19 hyper_qual_num1_20	hyper_qual_num2_20	hyper_qual_num3_20	hyper_qual_num4_20	hyper_qual_num5_20 ///
	hyper_qual_num6_20	hyper_qual_num7_20 hyper_qual_num8_20 hyper_qual_num9_20 hyper_qual_num10_20 hyper_qual_num11_20 hyper_qual_num12_20)
	
* Full vaccination
rename (numberofchildrenreceivedallvacci - v605) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20  vacc_qual11_20  vacc_qual12_20)

* Penta3
rename(numberofchildrenunderoneyearofag- v629) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)
	
* BCG
rename (v630 - v653) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20)

* Measles 1st dose
rename (v654 - v677) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
* Polio3
rename (v678 - v701) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

* Pneumococcal 
rename (v702 - v725) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

* Rotavirus 2nd dose
drop v726 - v749 // dropping 1st dose only
rename (v750 - v773) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

* MORTALITY 
* Newborn deaths # numerator
rename(numberofneonataldeathsinthefirst- v797) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20)

* Maternal deaths # numerator
rename (numberofmaternaldeathsinhealthfa - v821) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
	mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
	
*Inpatient deaths # numerator
rename (numberofinpatientdeathsintherepo - v845) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
	ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)
	
* ER mortality  numerator
rename (totaldeathintheemergencyunittir2 - v869) ///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)

* ICU deaths # numerator
rename (totaldeathinicuinthereportingper - v893) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
	
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
	egen totaldel11_20=	rowtotal(del_util11_20 cs_util11_20), m
	egen totaldel12_20=	rowtotal(del_util12_20 cs_util12_20), m
	
*8 woredas were duplicates and had completely missing data for all indicators
* Dropped them in order to merge with the other dataset 
duplicates tag org* , gen(dup)
drop if dup==1

save "$user/$data/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta", replace	
*n=3935

********************************************************************************	
*Imported raw data from January 2019 to Dec 2020 
* Missing indicators sent March 26 (n=3943)
import delimited "$user/$data/Raw/2020/Rcvd 26MAR2021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_26_03 _2021_GC/Ethiopia_2020_January to December_ by Woreda Level_26_03_2021.csv", clear
	
* Stillbirths # numerator
rename (numberofstillbirthstir2011 - numberofstillbirthstahesas2013) ///
(sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19 sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20		sb_mort_num5_20		sb_mort_num6_20 sb_mort_num7_20 sb_mort_num8_20 sb_mort_num9_20 sb_mort_num10_20 sb_mort_num11_20 sb_mort_num12_20)

	
*Total number of neonates resuscitated 
rename (totalnumberofneonatesresuscitate - v53) ///
(resus_qual_denom1_19	resus_qual_denom2_19	resus_qual_denom3_19	resus_qual_denom4_19	resus_qual_denom5_19	resus_qual_denom6_19	resus_qual_denom7_19	resus_qual_denom8_19	resus_qual_denom9_19	resus_qual_denom10_19	resus_qual_denom11_19	resus_qual_denom12_19 resus_qual_denom1_20	resus_qual_denom2_20	resus_qual_denom3_20	resus_qual_denom4_20	resus_qual_denom5_20	resus_qual_denom6_20	resus_qual_denom7_20	resus_qual_denom8_20 ///
resus_qual_denom9_20    resus_qual_denom10_20 resus_qual_denom11_20 resus_qual_denom12_20)

*Total number of neonates resuscitated and survived 
rename (v54 - v77) (resus_qual_num1_19	resus_qual_num2_19	resus_qual_num3_19	resus_qual_num4_19	resus_qual_num5_19	resus_qual_num6_19	resus_qual_num7_19	resus_qual_num8_19	resus_qual_num9_19	resus_qual_num10_19	resus_qual_num11_19	resus_qual_num12_19 resus_qual_num1_20	resus_qual_num2_20	resus_qual_num3_20	resus_qual_num4_20	resus_qual_num5_20	resus_qual_num6_20	resus_qual_num7_20	resus_qual_num8_20 resus_qual_num9_20 resus_qual_num10_20 resus_qual_num11_20 resus_qual_num12_20)

*Total number of newborns weighing <2000gm and/or premature 
rename (v102 - v125) (kmc_qual_denom1_19	kmc_qual_denom2_19	kmc_qual_denom3_19	kmc_qual_denom4_19	kmc_qual_denom5_19	kmc_qual_denom6_19	kmc_qual_denom7_19	kmc_qual_denom8_19	kmc_qual_denom9_19	kmc_qual_denom10_19	kmc_qual_denom11_19	kmc_qual_denom12_19 kmc_qual_denom1_20	kmc_qual_denom2_20	kmc_qual_denom3_20	kmc_qual_denom4_20	kmc_qual_denom5_20	kmc_qual_denom6_20	kmc_qual_denom7_20	kmc_qual_denom8_20 kmc_qual_denom9_20 kmc_qual_denom10_20 kmc_qual_denom11_20 kmc_qual_denom12_20)

*Total number of newborns weighing <2000gm and/or premature newborns for which KMC initiated 
rename (totalnumberofnewbornsweighing200 - v101) ///
(kmc_qual_num1_19	kmc_qual_num2_19	kmc_qual_num3_19	kmc_qual_num4_19	kmc_qual_num5_19	kmc_qual_num6_19	kmc_qual_num7_19	kmc_qual_num8_19	kmc_qual_num9_19	kmc_qual_num10_19	kmc_qual_num11_19	kmc_qual_num12_19 kmc_qual_num1_20	kmc_qual_num2_20	kmc_qual_num3_20	kmc_qual_num4_20	kmc_qual_num5_20	kmc_qual_num6_20	kmc_qual_num7_20	kmc_qual_num8_20 kmc_qual_num9_20  kmc_qual_num10_20 kmc_qual_num11_20 kmc_qual_num12_20)

*same 8 woreda from previous dataset were duplicates and had completely missing data so dropped them to merge with the other dataset 
duplicates tag, gen(dup)
drop if dup==1

*n=3935

*Merge with the Jan19-Dec20 dataset 
merge 1:1 org* using "$user/$data/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta"
drop _merge 
drop dup 
save "$user/$data/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta", replace	
*N=3935
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
