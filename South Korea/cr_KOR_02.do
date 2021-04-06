* HS performance during Covid
* Created on Feb 4th 2021
* South Korea, Jan19 - Sep 2020 data

* Call in dataset
import delimited "/$user/$data/Raw data/SouthKorea_03302021.csv", numericcols(3/400) clear

rename (ïorgunitlevel1 orgunitlevel2) (country region)

* Drop national total 
drop if region=="total" | region ==""

* Drop Empty variables 
drop v24 v25 v47 v48 v70 v71 v93 v94 v116 v117 v139 v140 v162 v163 v185 v186 v208 v209 v231 v232 v254 v255 v277 v278 v300 v301 v323 v324 v346 v347 v369 v370 v392 v393 v415 v416

**********************************************************************************
* Recode variables 
**********************************************************************************
* RMNCH
* STI visits 
rename (numberofconsultationsforsticarej - v23) ///
		(sti_util1_19	sti_util2_19	sti_util3_19	sti_util4_19	///
		sti_util5_19	sti_util6_19	sti_util7_19	sti_util8_19	///
		sti_util9_19	sti_util10_19	sti_util11_19	sti_util12_19 ///
		sti_util1_20	sti_util2_20	sti_util3_20	sti_util4_20	///
		sti_util5_20	sti_util6_20	sti_util7_20	sti_util8_20 ///
		sti_util9_20 )

* Antental care visits 
rename (numberofantenatalcarevisitsjanua - v46) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19 ///
	 anc_util6_19 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19 ///
	 anc_util11_19	anc_util12_19 anc_util1_20	anc_util2_20	anc_util3_20 ///
	 anc_util4_20	anc_util5_20	anc_util6_20 anc_util7_20   anc_util8_20 ///
	 anc_util9_20 )

* Facility deliveries - includes C-sections 
rename (numberoffacilitydeliveriesjanuar - v69) ///
	(totaldel1_19	totaldel2_19	totaldel3_19	totaldel4_19	totaldel5_19 ///
	totaldel6_19	totaldel7_19	totaldel8_19	totaldel9_19	totaldel10_19 ///
	totaldel11_19	totaldel12_19 totaldel1_20	totaldel2_20	totaldel3_20 ///
	totaldel4_20	totaldel5_20	totaldel6_20	totaldel7_20	totaldel8_20 ///
	totaldel9_20 )  

* C-sections 
rename (numberofcaesareansectionsjanuary - v92) ///
		(cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19	 ///
		cs_util5_19 cs_util6_19 cs_util7_19		cs_util8_19		///
		cs_util9_19		cs_util10_19 ///
		cs_util11_19	cs_util12_19 cs_util1_20		cs_util2_20		cs_util3_20 ///
		cs_util4_20		cs_util5_20		cs_util6_20 cs_util7_20     cs_util8_20 ///
		cs_util9_20 )	

* Sick child care diarrhea
rename (numberofconsultationsforsickchil - v115) ///
		(diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	///
		 diarr_util5_19	diarr_util6_19	diarr_util7_19	diarr_util8_19	///
		 diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 ///
		 diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	///
		 diarr_util5_20	diarr_util6_20	diarr_util7_20	diarr_util8_20 ///
		 diarr_util9_20 )

* Sick child care pneumonia 
rename (v118 - v138) ///
		(pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	///
		pneum_util5_19	pneum_util6_19	pneum_util7_19	pneum_util8_19	///
		pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19 ///
		pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	///
		pneum_util5_20	pneum_util6_20	pneum_util7_20	pneum_util8_20 ///
		pneum_util9_20 )


**********************************************************************************
* OTHER SERVICES
* ART 
rename (numberofadultandchildrenreceivin - v161) ///
		(art_util1_19	art_util2_19	art_util3_19	art_util4_19	///
		 art_util5_19	art_util6_19	art_util7_19	art_util8_19	///
		 art_util9_19	art_util10_19	art_util11_19	art_util12_19 ///
		 art_util1_20	art_util2_20	art_util3_20	art_util4_20	///
		 art_util5_20	art_util6_20	art_util7_20	art_util8_20 ///
		 art_util9_20 ) 

* Outpatient visits 
rename (numberofoutpatientvisitsjanuary2 - v184) ///
		(opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	///
		opd_util5_19	opd_util6_19	opd_util7_19	opd_util8_19	///
		opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	///
		opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20 ///
		opd_util9_20 )

* Inpatient admissions 
rename (numberofinpatientadmissionsjanua - v207) ///
	    (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	///
		ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	///
		ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	///
		ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20 ///
		ipd_util9_20 )
		
* Emergency room visits 
rename (numberofemergencyroomvisitsjanua - v230) ///
		(er_util1_19	er_util2_19	er_util3_19	er_util4_19	er_util5_19	///
		er_util6_19	er_util7_19	er_util8_19	er_util9_19	er_util10_19	///
		er_util11_19	er_util12_19 er_util1_20	er_util2_20	///
		er_util3_20	er_util4_20	er_util5_20	er_util6_20	er_util7_20	er_util8_20 ///
		er_util9_20 ) 

* Diabetic patients 
rename (numberofdiabeticpatientsvisitedf - v253) ///
		(diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19 ///
		diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19 ///
		diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19  ///
		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	///
		diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20 ///
		diab_util9_20 )

* Hypertensive patients 
rename (numberofhypertensivepatientsvisi - v276) ///
		(hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19 ///
		hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	///
		hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 ///
		hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	///
		hyper_util5_20	hyper_util6_20	hyper_util7_20	hyper_util8_20 ///
		hyper_util9_20 )

* Mental consultations 
rename (numberofmentalhealthconsultation - v299) ///
		(mental_util1_19	mental_util2_19	mental_util3_19	mental_util4_19	///
		mental_util5_19	mental_util6_19	mental_util7_19	mental_util8_19	///
		mental_util9_19	mental_util10_19	mental_util11_19	///
		mental_util12_19 mental_util1_20	mental_util2_20	mental_util3_20	///
		mental_util4_20	mental_util5_20	mental_util6_20	mental_util7_20	///
		mental_util8_20 mental_util9_20)

**********************************************************************************
* QUALITY 
* LBW babies initiated on KMC 
rename (numberoflbwbabiesinitiatedonkmcj - v322) ///
		(kmc_qual1_19	kmc_qual2_19	kmc_qual3_19	kmc_qual4_19 ///
		kmc_qual5_19	kmc_qual6_19	kmc_qual7_19	kmc_qual8_19	///
		kmc_qual9_19	kmc_qual10_19	kmc_qual11_19	kmc_qual12_19 ///
		kmc_qual1_20	kmc_qual2_20	kmc_qual3_20	kmc_qual4_20	///
		kmc_qual5_20	kmc_qual6_20	kmc_qual7_20	kmc_qual8_20 ///
		kmc_qual9_20 )

**********************************************************************************		
* MORTALITY 
* Insitutional newborn deaths 
rename (numberofinstitutionalnewborndeat - v345) ///
		(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19 ///
		newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19 ///
		newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19 ///
		newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19 ///
		newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20 ///
		newborn_mort_num4_20	newborn_mort_num5_20	newborn_mort_num6_20 ///
		newborn_mort_num7_20	newborn_mort_num8_20    newborn_mort_num9_20)

* Institutional stillbirths 
rename (numberofinstitutionalstillbirths - v368) ///
		(sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	///
		sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	///
		sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19 ///
		sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	///
		sb_mort_num5_20	sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20 ///
		sb_mort_num9_20)
		
* Maternal deaths 
rename (numberofmaternaldeathsjanuary201 - v391) ///
		(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	///
		 mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	///
		 mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	///
		 mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19 ///
		 mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20 ///
		 mat_mort_num4_20	mat_mort_num5_20	mat_mort_num6_20 ///
		 mat_mort_num7_20	mat_mort_num8_20    mat_mort_num9_20)

* Inpatient deaths 
rename (numberofinpatientdeathsjanuary20 - v414) ///
		(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19 ///
		ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	///
		ipd_mort_num7_19	ipd_mort_num8_19	ipd_mort_num9_19	///
		ipd_mort_num10_19	ipd_mort_num11_19	ipd_mort_num12_19 ///
		ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	///
		ipd_mort_num4_20	ipd_mort_num5_20	ipd_mort_num6_20	///
		ipd_mort_num7_20	ipd_mort_num8_20    ipd_mort_num9_20 )

* All cause deaths - dropped since there is no denominator 
drop numberofinstitutioanlallcausedea - v438
		
save "$user/$data/Data for analysis/Kor_Jan19-Sep20_WIDE.dta", replace	
**********************************************************************************
*END
**********************************************************************************


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
