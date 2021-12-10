* HS performance during Covid
* Created Jan 29 2021
* Data extracted Jan 29 2021
* Ethiopia, Jan19 - November 2020 data

* FACILITY LEVEL DATA

********************************************************************************
*Public hospitals (N=347)
import delimited "$user/$data/Raw/By levels/Received Jan292021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_29_01 _2021_GC/Facility Type/Ethiopia_2020_January to December_ by Public Hospital_29_01_2021.csv", clear

*RMNCH 
*Contraceptive users 
rename (totalnewandrepeatacceptorsdisagg - v34) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)

*Antenatal care visits 
rename (numberofpregnantwomenthatreceive - v82) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
		
* Deliveries
rename (totalnumberofbirthsattendedbyski-v106) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename (numberofwomenhavinggivenbirthbyc-v130) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)

*Child diarrhea visits 
rename (numberofchildrentreatedfordiarrh - v178) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
*Child pneumonia visits
rename (numberofunder5childrentreatedfor - v202) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)

*Child malnutrition visits 
rename (totalnumberofchildren5yrsscreene - v226)	///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)
	
*Postnatal care visits 
rename (numberofpostnatalvisitswithin7da - v154) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20) 

*VACCINES
*Fully vaccinated children 
rename (numberofchildrenreceivedallvacci - v610) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20 vacc_qual11_20 vacc_qual12_20)

*BCG vaccines 
rename (v635 - v658) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20) 

*Penta3 vaccine 
rename (numberofchildrenunderoneyearofag - v634) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)

*Measles vaccine 
rename (v659 - v682) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 ///
	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
*OPV3 vaccine 
rename (v683 - v706) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

*Pneumoccocal vaccines 
rename (v707 - v730) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

*Rotavirus 2nd dose only 
rename (v755 - v778) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

*OTHER SERVICES
*Adult & Children on ART 
rename (numberofadultsandchildrenwhoarec - v250) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20)

*Outpatient visits 
rename (numberofoutpatientvisitstir2011 - v274) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
*ER visit attendances
rename (totalnumberofemergencyunitattend - v322) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)	

*Inpatient admissions 
rename (numberofinpatientadmissionstir20 - v298) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)	

		
*INSTITUTIONAL MORTALITY 
*Newborn mortality 
rename (numberofneonataldeathsinthefirst- v802) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20) 
		
*Maternal mortality 
rename (numberofmaternaldeathsinhealthfa - v826) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20) 

*ER mortality 
rename (totaldeathintheemergencyunittir2 - v874)	///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)
	
*Inpatient mortality 
rename (numberofinpatientdeathsintherepo - v850) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)	

*ICU mortality 
rename (totaldeathinicuinthereportingper-v898) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 ///
	icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
		
drop *12_20 // December likely incomplete		
keep org* *_19 *_20 
gen factype="Public Hospital"				
save "$user/$data/Data for analysis/Ethiopia_Facility_Public_Hosp_Jan19-Nov20_WIDE.dta", replace	

********************************************************************************
*Private hospitals (N=60)
import delimited "$user/$data/Raw/By levels/Received Jan292021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_29_01 _2021_GC/Facility Type/Ethiopia_2020_January to December_ by Private Hospital_29_01_2021.csv", clear

*RMNCH 
*Contraceptive users 
rename (totalnewandrepeatacceptorsdisagg - v33) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)

*Antenatal care visits 
rename (numberofpregnantwomenthatreceive - v81) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
		
* Deliveries
rename (totalnumberofbirthsattendedbyski - v105) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename (numberofwomenhavinggivenbirthbyc - v129) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)

*Child diarrhea visits 
rename (numberofchildrentreatedfordiarrh - v177) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
*Child pneumonia visits
rename (numberofunder5childrentreatedfor - v201) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)

*Child malnutrition visits 
rename (totalnumberofchildren5yrsscreene - v225)	///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)
	
*Postnatal care visits 
rename (numberofpostnatalvisitswithin7da - v153) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20) 

*VACCINES
*Fully vaccinated children 
rename (numberofchildrenreceivedallvacci - v609) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20 vacc_qual11_20 vacc_qual12_20)

*BCG vaccines 
rename (v634 - v657) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20) 

*Penta3 vaccine 
rename (numberofchildrenunderoneyearofag - v633) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)

*Measles vaccine 
rename (v658 - v681) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 ///
	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
*OPV3 vaccine 
rename (v682 - v705) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

*Pneumoccocal vaccines 
rename (v706 - v729) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

*Rotavirus 2nd dose only 
rename (v754 - v777) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

*OTHER SERVICES
*Adult & Children on ART 
rename (numberofadultsandchildrenwhoarec - v249) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20)

*Outpatient visits 
rename (numberofoutpatientvisitstir2011 - v273) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
*ER visit attendances
rename (totalnumberofemergencyunitattend - v321) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)	

*Inpatient admissions 
rename (numberofinpatientadmissionstir20 - v297) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)	

		
*INSTITUTIONAL MORTALITY 
*Newborn mortality 
rename (numberofneonataldeathsinthefirst - v801) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20) 
		
*Maternal mortality 
rename (numberofmaternaldeathsinhealthfa - v825) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20) 

*ER mortality 
rename (totaldeathintheemergencyunittir2 - v873)	///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)
	
*Inpatient mortality 
rename (numberofinpatientdeathsintherepo - v849) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)	

*ICU mortality 
rename (totaldeathinicuinthereportingper- v897) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 ///
	icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
		
drop *12_20 // December likely incomplete	

keep org* *_19 *_20 
gen factype="Private hospitals"
*append with previous data
append using "$user/$data/Data for analysis/Ethiopia_Facility_Public_Hosp_Jan19-Nov20_WIDE.dta", force
save "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", replace

********************************************************************************
*Health centers (N=3721)
import delimited "$user/$data/Raw/By levels/Received Jan292021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_29_01 _2021_GC/Facility Type/Ethiopia_2020_January to December_ by Health Center_29_01_2021.csv", clear

*RMNCH 
*Contraceptive users 
rename (totalnewandrepeatacceptorsdisagg - v35) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)

*Antenatal care visits 
rename (numberofpregnantwomenthatreceive - v83) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
		
* Deliveries
rename (totalnumberofbirthsattendedbyski - v107) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename (numberofwomenhavinggivenbirthbyc - v131) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)

*Child diarrhea visits 
rename (numberofchildrentreatedfordiarrh - v179) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
*Child pneumonia visits
rename (numberofunder5childrentreatedfor - v203) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)

*Child malnutrition visits 
rename (totalnumberofchildren5yrsscreene - v227)	///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)
	
*Postnatal care visits 
rename (numberofpostnatalvisitswithin7da - v155) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20) 


*VACCINES
*Fully vaccinated children 
rename (numberofchildrenreceivedallvacci - v611) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20 vacc_qual11_20 vacc_qual12_20)

*BCG vaccines 
rename (v636 - v659) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20) 

*Penta3 vaccine 
rename (numberofchildrenunderoneyearofag - v635) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)

*Measles vaccine 
rename (v660 - v683) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 ///
	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
*OPV3 vaccine 
rename (v684 - v707) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

*Pneumoccocal vaccines 
rename (v708 - v731) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

*Rotavirus 2nd dose only 
rename (v756 - v779) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

*OTHER SERVICES
*Adult & Children on ART 
rename (numberofadultsandchildrenwhoarec - v251) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20)

*Outpatient visits 
rename (numberofoutpatientvisitstir2011 - v275) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
*ER visit attendances
rename (totalnumberofemergencyunitattend - v323) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)	

*Inpatient admissions 
rename (numberofinpatientadmissionstir20 - v299) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)	

	
*INSTITUTIONAL MORTALITY 
*Newborn mortality 
rename (numberofneonataldeathsinthefirst - v803) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20) 
		
*Maternal mortality 
rename (numberofmaternaldeathsinhealthfa - v827) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20) 

*ER mortality 
rename (totaldeathintheemergencyunittir2 - v875)	///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)
	
*Inpatient mortality 
rename (numberofinpatientdeathsintherepo - v851) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)	

*ICU mortality 
rename (totaldeathinicuinthereportingper - v899) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 ///
	icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
	
drop *12_20 // December likely incomplete	

keep org* *_19 *_20 
gen factype="Health centers"
*append with previous data
append using "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", force

save "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", replace
********************************************************************************
*Clinics N=7041
import delimited "$user/$data/Raw/By levels/Received Jan292021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_29_01 _2021_GC/Facility Type/Ethiopia_2020_January to December_ by clinics_29_01_2021.csv", clear

*RMNCH 
*Contraceptive users 
rename (totalnewandrepeatacceptorsdisagg - v34) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)

*Antenatal care visits 
rename (numberofpregnantwomenthatreceive - v82) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
		
* Deliveries
rename (totalnumberofbirthsattendedbyski - v106) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename (numberofwomenhavinggivenbirthbyc - v130) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)

*Child diarrhea visits 
rename (numberofchildrentreatedfordiarrh - v178) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
*Child pneumonia visits
rename (numberofunder5childrentreatedfor - v202) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)

*Child malnutrition visits 
rename (totalnumberofchildren5yrsscreene - v226)	///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)
	
*Postnatal care visits 
rename (numberofpostnatalvisitswithin7da - v154) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20) 

*VACCINES
*Fully vaccinated children 
rename (numberofchildrenreceivedallvacci - v610) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20 vacc_qual11_20 vacc_qual12_20)

*BCG vaccines 
rename (v635 - v658) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20) 

*Penta3 vaccine 
rename (numberofchildrenunderoneyearofag - v634) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)

*Measles vaccine 
rename (v659 - v682) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 ///
	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
*OPV3 vaccine 
rename (v683 - v706) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

*Pneumoccocal vaccines 
rename (v707 - v730) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

*Rotavirus 2nd dose only 
rename (v755 - v778) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

*OTHER SERVICES
*Adult & Children on ART 
rename (numberofadultsandchildrenwhoarec - v250) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20)

*Outpatient visits 
rename (numberofoutpatientvisitstir2011 - v274) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
*ER visit attendances
rename (totalnumberofemergencyunitattend - v322) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)	

*Inpatient admissions 
rename (numberofinpatientadmissionstir20 - v298) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)	

	
*INSTITUTIONAL MORTALITY 
*Newborn mortality 
rename (numberofneonataldeathsinthefirst - v802) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20) 
		
*Maternal mortality 
rename (numberofmaternaldeathsinhealthfa - v826) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20) 

*ER mortality 
rename (totaldeathintheemergencyunittir2 - v874)	///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)
	
*Inpatient mortality 
rename (numberofinpatientdeathsintherepo - v850) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)	

*ICU mortality 
rename (totaldeathinicuinthereportingper - v898) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 ///
	icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
		
drop *12_20 // December likely incomplete	
keep org* *_19 *_20 
gen factype="Clinics"
*append with previously saved data
append using "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", force

save "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", replace

********************************************************************************
*Health posts N=17697
import delimited "$user/$data/Raw/By levels/Received Jan292021/Ethiopia_Health system performance during Covid_data extraction_2020_January to December_29_01 _2021_GC/Facility Type/Ethiopia_2020_January to December_ by Health Posts_29_01_2021.csv", clear

*RMNCH 
*Contraceptive users 
rename (totalnewandrepeatacceptorsdisagg - v35) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	///
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19 ///
	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
	fp_util7_20     fp_util8_20     fp_util9_20     fp_util10_20 fp_util11_20 fp_util12_20)

*Antenatal care visits 
rename (numberofpregnantwomenthatreceive - v83) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19 ///		
	 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
	 anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 ///
	 anc_util7_20   anc_util8_20    anc_util9_20    anc_util10_20 anc_util11_20 anc_util12_20)
		
* Deliveries
rename (totalnumberofbirthsattendedbyski - v107) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19 ///		
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19 ///
	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 ///
	del_util7_20    del_util8_20    del_util9_20    del_util10_20 del_util11_20 del_util12_20)   

*Csections
rename (numberofwomenhavinggivenbirthbyc - v131) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19 ///		
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19 ///
	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 ///
	cs_util7_20     cs_util8_20     cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)

*Child diarrhea visits 
rename (numberofchildrentreatedfordiarrh - v179) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///		
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 ///
	diarr_util7_20  diarr_util8_20  diarr_util9_20  diarr_util10_20 diarr_util11_20 diarr_util12_20)
	
*Child pneumonia visits
rename (numberofunder5childrentreatedfor - v203) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19 ///	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 ///
	pneum_util7_20  pneum_util8_20  pneum_util9_20  pneum_util10_20 pneum_util11_20 pneum_util12_20)

*Child malnutrition visits 
rename (totalnumberofchildren5yrsscreene - v227)	///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19  ///		
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19 ///
	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20 ///
	sam_util7_20    sam_util8_20    sam_util9_20    sam_util10_20 sam_util11_20 sam_util12_20)
	
*Postnatal care visits 
rename (numberofpostnatalvisitswithin7da - v155) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19 ///		
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19 ///
	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 ///
	pnc_util7_20    pnc_util8_20    pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20) 

*VACCINES
*Fully vaccinated children 
rename (numberofchildrenreceivedallvacci - v611) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19 ///
vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 vacc_qual7_20   vacc_qual8_20   vacc_qual9_20   vacc_qual10_20 vacc_qual11_20 vacc_qual12_20)

*BCG vaccines 
rename (v636 - v659) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20) 

*Penta3 vaccine 
rename (numberofchildrenunderoneyearofag - v635) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)

*Measles vaccine 
rename (v660 - v683) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 ///
	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	
*OPV3 vaccine 
rename (v684 - v707) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19 ///
opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 opv3_qual7_20   opv3_qual8_20   opv3_qual9_20   opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

*Pneumoccocal vaccines 
rename (v708 - v731) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

*Rotavirus 2nd dose only 
rename (v756 - v779) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19 ///
rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 rota_qual7_20   rota_qual8_20   rota_qual9_20   rota_qual10_20 rota_qual11_20 rota_qual12_20)

*OTHER SERVICES
*Adult & Children on ART 
rename (numberofadultsandchildrenwhoarec - v251) ///
(		art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19 ///	
		art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 ///
		art_util7_20    art_util8_20    art_util9_20    art_util10_20 art_util11_20 art_util12_20)

*Outpatient visits 
rename (numberofoutpatientvisitstir2011 - v275) ///
(		opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19 ///
		opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20 ///
		opd_util7_20    opd_util8_20    opd_util9_20    opd_util10_20 opd_util11_20 opd_util12_20)
		
*ER visit attendances
rename (totalnumberofemergencyunitattend - v323) ///
(		er_util1_19		er_util2_19		er_util3_19		er_util4_19		er_util5_19		er_util6_19	///
		er_util7_19	    er_util8_19	    er_util9_19	    er_util10_19	er_util11_19	er_util12_19 ///
		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	///
		er_util7_20     er_util8_20     er_util9_20     er_util10_20 er_util11_20 er_util12_20)	

*Inpatient admissions 
rename (numberofinpatientadmissionstir20 - v299) ///
(		ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19 ///
		ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 ///
		ipd_util7_20    ipd_util8_20    ipd_util9_20    ipd_util10_20 ipd_util11_20 ipd_util12_20)	

	
*INSTITUTIONAL MORTALITY 
*Newborn mortality 
rename (numberofneonataldeathsinthefirst - v803) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
newborn_mort_num5_20	newborn_mort_num6_20    newborn_mort_num7_20    newborn_mort_num8_20 ///
newborn_mort_num9_20    newborn_mort_num10_20 newborn_mort_num11_20 newborn_mort_num12_20) 
		
*Maternal mortality 
rename (numberofmaternaldeathsinhealthfa - v827) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
mat_mort_num6_20 mat_mort_num7_20 mat_mort_num8_20 mat_mort_num9_20 ///
mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20) 

*ER mortality 
rename (totaldeathintheemergencyunittir2 - v875)	///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	///
er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	///
er_mort_num11_19	er_mort_num12_19 er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 er_mort_num7_20 er_mort_num8_20 ///
er_mort_num9_20 er_mort_num10_20 er_mort_num11_20 er_mort_num12_20)
	
*Inpatient mortality 
rename (numberofinpatientdeathsintherepo - v851) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)	

*ICU mortality 
rename (totaldeathinicuinthereportingper-v899) ///
(icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19 icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	icu_mort_num7_20 icu_mort_num8_20 icu_mort_num9_20 ///
	icu_mort_num10_20 icu_mort_num11_20 icu_mort_num12_20)
	
		
drop *12_20 // December likely incomplete	

keep org* *_19 *_20 	
gen factype="Health posts"
*append with previously saved data
append using "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", force

save "$user/$data/Data for analysis/Ethiopia_Facility_Jan19-Nov20_WIDE.dta", replace	
*N=28,866

********************************************************************************
*END
********************************************************************************
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
