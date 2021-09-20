* HS performance during Covid
* March 10, 2021 
* Nepal, Nov 2020 - Dec 2020
* Palika level data analysis 

clear all
set more off

********************************************************************************
********************************************************************************
*Import raw data: VOLUMES OF SERVICES

*Family Planning 
*1) Permanent method (fp_perm)
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_fp_util.csv", clear
	drop organisationunitdescription
	rename (familyplanningprogrampermanentfp) (v9)
	egen fp_perm_util11_20 = rowtotal(v9 v11 v13 v15 v17), m 
	egen fp_perm_util12_20 = rowtotal(v10 v12 v14 v16 v18), m 
		
*2) Short acting method (fp_sa)
	rename (familyplanningprogramtemporaryfp ) (v19 )
	egen fp_sa_util11_20 = rowtotal(v19 v21 v23 v25 v27 v29 v31 v33 v61 v63), m
	egen fp_sa_util12_20 = rowtotal(v20 v22 v24 v26 v28 v30 v32 v34 v62 v64), m

*3) Long acting method (fp_la)
	rename (familyplanningprogrampostpartumf safemotherhoodprogramsafeabortio) (v35 v57)
	egen fp_la_util11_20 = rowtotal(v35 v37 v39 v41 v43 v45 v47 v49 v51 v53 v55 v57 v59), m
	egen fp_la_util12_20 = rowtotal(v36 v38 v40 v42 v44 v46 v48 v50 v52 v54 v56 v58 v60), m
	
	keep org* fp* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(fp*), m
	
*Amit review needed: 3 municipalities names did not match the previous data. But the code matches. Did they change Names?
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"

	drop if tag==1 & total==. //no observation 
	drop tag total
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace
		
*ANC visits 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_anc_del_cs_pnc_diarr_pneum_sam_util.csv", clear
	drop organisationunitdescription
	rename safemotherhoodprogramantenatalch v9 
	egen anc_util11_20 = rowtotal(v9 v11), m
	egen anc_util12_20 = rowtotal(v10 v12), m

*Facility deliveries 
	rename (safemotherhoodprogramdeliveryser v14) ///
	(del_util11_20 del_util12_20) 
	
*C-section 
	egen cs_util11_20 = rowtotal(safemotherhoodprogramtypeofdeliv v17 v19), m
	egen cs_util12_20 = rowtotal(v16 v18 v20), m
	
*Postnatal care visits 
	rename (safemotherhoodprogram3pncvisitsa v22) ///
	(pnc_util11_20 pnc_util12_20)
	
*Diarrhea 
	egen diarr_util11_20 = rowtotal(cbimci259monthsclassificationdia v25 v27 v29 v31), m
	egen diarr_util12_20 = rowtotal(v24 v26 v28 v30 v32), m
	
*Pneumonia 
	egen pneum_util11_20 = rowtotal(cbimci259monthsclassificationari cbimci259monthsorcclassification), m
	egen pneum_util12_20 = rowtotal(v34 v36), m

*Malnutrition 
	rename (cbimci259monthsclassificationsev v38) ///
	(sam_util11_20 sam_util12_20) 
	
*Total delivery = cs_util + del_util (denominator)
	egen totaldel11_20=	rowtotal(del_util11_20 cs_util11_20), m
	egen totaldel12_20=	rowtotal(del_util12_20 cs_util12_20), m

	keep org* anc* del* cs* diarr* pneum* totaldel* pnc* sam*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(anc* del* cs* diarr* pneum* totaldel* pnc* sam*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace


********************************************************************************
********************************************************************************
*Import raw data: VACCINES

*BCG vaccines 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_bcg_pent_measles_opv3_pneum_qual.csv", clear
	drop organisationunitdescription
	rename (immunizationprogramvaccinetypech v10) ///
	(bcg_qual11_20 bcg_qual12_20)
	
*Penta3 vaccine 
	rename (immunizationprogramvaccinetypedo v12) ///
	(pent_qual11_20 pent_qual12_20)
	
*Measles vaccine 
	egen measles_qual11_20 = rowtotal(immunizationprogramchildrenimmun v15), m 
	egen measles_qual12_20 = rowtotal(v14 v16), m 
	
*OPV3 vaccines
	rename (v17 v18) (opv3_qual11_20 opv3_qual12_20)
	
*Pneumococcal vaccines 
	rename (v19 v20) (pneum_qual11_20 pneum_qual12_20)
	
	keep org* bcg* pent* measles* opv3* pneum*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(bcg* pent* measles* opv3* pneum*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace

	
********************************************************************************
********************************************************************************
*Import raw data: OTHER SERVICES

*Outpatient visits 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_opd_er_ipd_util.csv", clear
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit v10) ///
	(opd_util11_20 opd_util12_20)
	

*ER visits 
	egen er_util11_20 = rowtotal(clientsreceivedemergencyservices v13 v15 v17), m 
	egen er_util12_20 = rowtotal(v12 v14 v16 v18), m 
	
*Inpatient admissions 
	rename (v19 v20) (ipd_util11_20 ipd_util12_20)
	
	keep org* opd* er* ipd* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(opd* er* ipd* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace
	
********************************************************************************
********************************************************************************
*Import raw data: QUALITY 

*TB cases detected 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_tbdetect_hivdiag_qual.csv", clear
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit v10) ///
	(tbdetect_qual11_20 tbdetect_qual12_20)

*HIV cases diagnosed 
	egen hivdiag_qual11_20 = rowtotal(v11 v13), m 
	egen hivdiag_qual12_20 = rowtotal(v12 v14), m 
	
	keep org* tbdetect* hivdiag*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(tbdetect* hivdiag* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace

********************************************************************************
********************************************************************************
*Import raw data: MORTALITY 

*Stillbirth rate
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_sb_mort_mat_mort_num.csv", clear
	drop organisationunitdescription
	egen sb_mort_num11_20 = rowtotal(safemotherhoodprogramnumberofsti v11), m 
	egen sb_mort_num12_20 = rowtotal(v10 v12), m 
	
*Maternal mortality 
	egen mat_mort_num11_20 = rowtotal(safemotherhoodprogrammaternaldea v15 v17), m 
	egen mat_mort_num12_20 = rowtotal(v14 v16 v18), m 
	
	keep org* sb_mort* mat_mort* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(sb_mort* mat_mort* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace

*Neonatal deaths 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_neonatal_mort_num.csv", clear
	drop organisationunitdescription
	egen neo_mort_num11_20 = rowtotal(totallateneonataldeathsinthehosp totalearlyneonataldeathsinthehos safemotherhoodprogrammaternaldea), m
	egen neo_mort_num12_20 = rowtotal(v10 v12 v14), m
		
	keep org* neo*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(neo* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace


*Inpatient mortality 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Nov-Dec_palika_ipd_mort_num.csv", clear
	drop organisationunitdescription
    egen ipd_mort_num11_20 = rowtotal(inpatientdeathsin48hoursofadmiss v11 v13 v15 v17 v19 v21 v23 v25 v27 inpatientdeathsinâ48hoursofadmis v31 v33 v35 v37 v39 v41 v43 v45 v47 ), m 
	 egen ipd_mort_num12_20 = rowtotal(v10 v12 v14 v16 v18 v20 v22 v24 v26 v28 v30 v32 v34 v36 v38 v40 v42 v44 v46 v48 ), m 
 
	keep org* ipd_mort_num*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(ipd_mort* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta"
	
	drop _merge 
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace
	
* Fix issue with Provinces
	order org*
	drop  organisationunitid organisationunitcode 		 
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"
	
	save "$user/$data/Data for analysis/Nepal_palika_Nov20-Dec20_WIDE.dta", replace	

********************************************************************************
* Merge with Jan19-Nov20 data, remove poorly reported indicators
********************************************************************************	
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 organisationunitname ///
	           using "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE.dta"
	drop _merge
	drop live_births* //no longer used 
	drop ipd_util* ipd_mort* // wrong data elements used
	drop sam_util* hivdiag_qual* // remove from analyses, poorly reported
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", replace

********************************************************************************
* Corrections to ipd_util and ipd_mort  
********************************************************************************		
import delimited "$user/$data/Raw data/Palika/Nepal_2019_2020_inpatient.csv", clear
* Replace facility identifiers so that new dataset match old dataset
	rename ïorgunitlevel1 orgunitlevel1
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
* IPD util
	rename  (inpatientmorbiditycasesmagh2075-inpatientmorbiditycasespoush2077) ///
	(ipd_util1_19 ipd_util2_19 ipd_util3_19 ipd_util4_19 ipd_util5_19 ///
	ipd_util6_19 ipd_util7_19	ipd_util8_19 ipd_util9_19 ipd_util10_19	///
	ipd_util11_19 ipd_util12_19 ipd_util1_20	ipd_util2_20	ipd_util3_20 ///
	ipd_util4_20 ipd_util5_20 ipd_util6_20 ipd_util7_20 ipd_util8_20 ipd_util9_20 ///
	ipd_util10_20	ipd_util11_20 ipd_util12_20)
* IPD deaths
	rename (inpatientmorbiditydeathsmagh2075-v53) (ipd_mort_num1_19 ///
	ipd_mort_num2_19 ipd_mort_num3_19 ipd_mort_num4_19 ipd_mort_num5_19 ///
	ipd_mort_num6_19 ipd_mort_num7_19 ipd_mort_num8_19 ipd_mort_num9_19 ///
	ipd_mort_num10_19 ipd_mort_num11_19 ipd_mort_num12_19 ipd_mort_num1_20 ///
	ipd_mort_num2_20 ipd_mort_num3_20 ipd_mort_num4_20 ipd_mort_num5_20 ///
	ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ipd_mort_num9_20 ///
	ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20)

	egen total= rowtotal(ipd_util1_19-ipd_mort_num12_20), m
	drop if total==. 
	drop total
	
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", replace
	
********************************************************************************
* New HIV indicator 
********************************************************************************			
import delimited "$user/$data/Raw data/Palika/Nepal_2019_2020_HIV_tests.csv", clear
* Replace facility identifiers so that new dataset match old dataset
	rename ïorgunitlevel1 orgunitlevel1
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	replace orgunitlevel3="206 RAUTAHAT" if orgunitlevel3=="206 RAUTAHAT "
* HIV testing
	rename (virologyhivtestconductedmagh2075-v29) (hivtest_qual1_19 hivtest_qual2_19 ///
	hivtest_qual3_19  hivtest_qual4_19 hivtest_qual5_19 hivtest_qual6_19 ///
	hivtest_qual7_19 hivtest_qual8_19 hivtest_qual9_19 hivtest_qual10_19 ///
	hivtest_qual11_19 hivtest_qual12_19 hivtest_qual1_20 hivtest_qual2_20 ///
	hivtest_qual3_20  hivtest_qual4_20 hivtest_qual5_20 hivtest_qual6_20 ///
	hivtest_qual7_20 hivtest_qual8_20 hivtest_qual9_20 hivtest_qual10_20 ///
	hivtest_qual11_20 hivtest_qual12_20)
	
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", replace	
	
********************************************************************************
* New Hypertension and Diabetes indicators (missed on first extraction)
********************************************************************************	
import delimited "$user/$data/Raw data/Palika/Nepal_2019_2020_Hyper_Diab.csv", clear
* Replace facility identifiers so that new dataset match old dataset
	rename ïorgunitlevel1 orgunitlevel1
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	replace orgunitlevel3="206 RAUTAHAT" if orgunitlevel3=="206 RAUTAHAT "
*Hypertension
rename (opdmorbiditycardiovascularrespir-v29) ///
    (hyper_util1_19 hyper_util2_19 ///
	hyper_util3_19  hyper_util4_19 hyper_util5_19 hyper_util6_19 ///
	hyper_util7_19 hyper_util8_19 hyper_util9_19 hyper_util10_19 ///
	hyper_util11_19 hyper_util12_19 hyper_util1_20 hyper_util2_20 ///
	hyper_util3_20  hyper_util4_20 hyper_util5_20 hyper_util6_20 ///
	hyper_util7_20 hyper_util8_20 hyper_util9_20 hyper_util10_20 ///
	hyper_util11_20 hyper_util12_20)
	
* Diabetes
rename (outpatientmorbiditynutritionalme-v53) ///
  (diab_util1_19 diab_util2_19 ///
	diab_util3_19  diab_util4_19 diab_util5_19 diab_util6_19 ///
	diab_util7_19 diab_util8_19 diab_util9_19 diab_util10_19 ///
	diab_util11_19 diab_util12_19 diab_util1_20 diab_util2_20 ///
	diab_util3_20  diab_util4_20 diab_util5_20 diab_util6_20 ///
	diab_util7_20 diab_util8_20 diab_util9_20 diab_util10_20 ///
	diab_util11_20 diab_util12_20)

merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE.dta", replace	


/*old codes - we have removed this indicator because we added a neonatal mortality indicator. 
*Perinatal mortality = totaldel-livebirth 	
	gen peri_mort_num1_20 = totaldel1_20 - live_births1_20
	gen peri_mort_num2_20 = totaldel2_20 -live_births2_20 
	gen peri_mort_num3_20 = totaldel3_20 -live_births3_20 
	gen peri_mort_num4_20 = totaldel4_20 -live_births4_20 
	gen peri_mort_num5_20 = totaldel5_20 -live_births5_20 
	gen peri_mort_num6_20 = totaldel6_20 -live_births6_20	
	gen peri_mort_num7_20 = totaldel7_20 -live_births7_20	
	gen peri_mort_num8_20 = totaldel8_20 -live_births8_20	
	gen peri_mort_num9_20 = totaldel9_20 -live_births9_20	
	gen peri_mort_num10_20 = totaldel10_20 -live_births10_20	
	gen peri_mort_num11_20 = totaldel11_20 -live_births11_20
	
forval i =1/11 {
	replace peri_mort_num`i'_20 = 0 if peri_mort_num`i'_20 <0 & peri_mort_num`i'_20!=.
}
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace

*/	
	
	
	
	
	






















