* HS performance during Covid
* Sept 17, 2020 
* Ethiopia, January - June 2020
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

*Import raw data
import delimited using "$user/$data/Raw/2020/Ethiopia_Health system performance during Covid_data extraction_2020_January to June_14_09_2020_GC - Final/Ethiopia_2020_January to June_by worda level & zonal Level_14_09_2020/Ethiopia_2020_January to June_ by woreda csv.csv", clear
* Recode variables
* VOLUMES 
* FP
rename (totalnewandrepeatacceptorsdisagg-v11) ///
( 	fp_util1_20		fp_util2_20		fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	)
* STI
rename (totalnumberofsticasesbysexjanuar-totalnumberofsticasesbysexjune20) ///
(	sti_util1_20	sti_util2_20	sti_util3_20	sti_util4_20	sti_util5_20	sti_util6_20 )
* ANC
rename (numberofpregnantwomenthatreceive-v23) ///
	(anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20 )
* Deliveries
rename (totalnumberofbirthsattendedbyski-v29) ///
(	del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20 )
*Csections
rename (numberofwomenhavinggivenbirthbyc-v35) ///
(	cs_util1_20		cs_util2_20		cs_util3_20		cs_util4_20		cs_util5_20		cs_util6_20 )
* PNC
rename (numberofpostnatalvisitswithin7da-v41) ///
(	pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20 )
* ORS
rename (numberofchildrentreatedfordiarrh-v47) ///
(	diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20 )
* Pneumonia
rename ( numberofunder5childrentreatedfor-v53) ///
(	pneum_util1_20	pneum_util2_20	pneum_util3_20	pneum_util4_20	pneum_util5_20	pneum_util6_20 )
* Screened malnutrition
rename (totalnumberofchildren5yrsscreene-v59) ///
(	sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20)
* ART
rename (numberofadultsandchildrenwhoarec-v65) ///
(		art_util1_20	art_util2_20	art_util3_20	art_util4_20	art_util5_20	art_util6_20 )	
* OPD 
rename (numberofoutpatientvisitsjanuary2-numberofoutpatientvisitsjune2020) ///
(		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20) 
* IPD
rename (numberofinpatientadmissionsjanua-numberofinpatientadmissionsjune2) ///
(		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20 )
* ER 
rename (totalnumberofemergencyunitattend-v83) ///
(		er_util1_20		er_util2_20		er_util3_20		er_util4_20		er_util5_20		er_util6_20	)
* Road traffic
rename (numberofroadtrafficinjurycasesdi-v89) ///
(		road_util1_20	road_util2_20	road_util3_20	road_util4_20	road_util5_20	road_util6_20 )
* Diabetes
rename (totalnumberofdiabeticpatientsenr-v95 ) ///
(		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20 ) 
* Hypertension 
rename (totalnumberofhypertensivepatient-v101) ///
(	hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20 ) 
drop totalnumberofindividualsscreened-v113 // screened for diabetes or hypertension, not needed
* QUALITY 
* KMC %
rename (proportionoflowbirthweightandorp-v119) ///
(	kmc_qual1_20	kmc_qual2_20	kmc_qual3_20	kmc_qual4_20	kmc_qual5_20	kmc_qual6_20 )
	forval i = 1/6 { // data available until june for now
		replace kmc_qual`i'_20 = kmc_qual`i'_20 / 100
	}
* Newborn resuscitation %
rename (proportionofasphyxiatedneonatesw-v125) ///
(	resus_qual1_20	resus_qual2_20	resus_qual3_20	resus_qual4_20	resus_qual5_20	resus_qual6_20 ) 
	forval i = 1/6 { // data available until june for now
		replace resus_qual`i'_20 = resus_qual`i'_20 / 100
	}
* Cervical cancer screening # 
rename (numberofwomenaged3049screenedwit-v131) ///
(	cerv_qual1_20	cerv_qual2_20	cerv_qual3_20	cerv_qual4_20	cerv_qual5_20	cerv_qual6_20 )
* VL supression #
rename (numberofadultandpediatricpatient-v137) ///
(	hivsupp_qual_num1_20	hivsupp_qual_num2_20	hivsupp_qual_num3_20	hivsupp_qual_num4_20 ///
	hivsupp_qual_num5_20	hivsupp_qual_num6_20	)
* Controlled diabetes #
rename (v138-v143 ) ///
(	diab_qual_num1_20	diab_qual_num2_20	diab_qual_num3_20	diab_qual_num4_20	diab_qual_num5_20 ///
	diab_qual_num6_20	)
* Controlled hypertension #
rename (v144-v149 ) ///
(	hyper_qual_num1_20	hyper_qual_num2_20	hyper_qual_num3_20	hyper_qual_num4_20	hyper_qual_num5_20 ///
	hyper_qual_num6_20	)
* Full vaccination
rename (numberofchildrenreceivedallvacci-v155) ///
(	vacc_qual1_20	vacc_qual2_20	vacc_qual3_20	vacc_qual4_20	vacc_qual5_20	vacc_qual6_20 ) 
* Penta3
rename(numberofchildrenunderoneyearofag-v161) ///
(	pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 )
* BCG
rename (v162-v167) ///
(	bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20)
* Measles
rename (v168-v173) ///
(	measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	)
* Polio3
rename (v174-v179) ///
(	opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20 )
* Pneumococcal 
rename (v180-v185) ///
(	pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 )
* Rotavirus 2nd dose
drop v186-v191 // dropping 1st dose only
rename (v192-v197) ///
(	rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20	rota_qual6_20 )
* MORTALITY 
* Newborn deaths # numerator
rename(numberofneonataldeathsinthefirst-v203) ///
(	newborn_mort_num1_20	newborn_mort_num2_20	newborn_mort_num3_20	newborn_mort_num4_20 ///
	newborn_mort_num5_20	newborn_mort_num6_20)
* Stillbirths # numerator
rename (numberofstillbirthsjanuary2020-numberofstillbirthsjune2020) ///
(	sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20		sb_mort_num5_20		sb_mort_num6_20 )
* Maternal deaths # numerator
rename (numberofmaternaldeathsinhealthfa-v215) ///
(	mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20 ///
	mat_mort_num6_20 )
*Inpatient deaths # numerator
rename (numberofinpatientdeathsintherepo-v221) ///
(	ipd_mort_num1_20	ipd_mort_num2_20	ipd_mort_num3_20	ipd_mort_num4_20	ipd_mort_num5_20 ///
	ipd_mort_num6_20	)
* ICU deaths # numerator
rename (totaldeathinicuinthereportingper-v233) ///
(	icu_mort_num1_20	icu_mort_num2_20	icu_mort_num3_20	icu_mort_num4_20	icu_mort_num5_20 ///
	icu_mort_num6_20	)
* ER mortality  numerator
rename (totaldeathintheemergencyunitjanu-totaldeathintheemergencyunitjune) ///
(	er_mort_num1_20	er_mort_num2_20	er_mort_num3_20	er_mort_num4_20		er_mort_num5_20		er_mort_num6_20 )
* Create unique facility id
drop orgunitlevel1 orgunitlevel4  
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
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"

egen unit_id = concat(region zone organisationunitname)
order region zone organisationunitname unit_id


merge 1:1  region zone organisationunitname using "$user/$data/Ethiopia_Jan19-Dec19_WIDE.dta"
/*    Result                           # of obs.
    -----------------------------------------
    not matched                           344
        from master                       245  (_merge==1)
        from using                         99  (_merge==2)

    matched                             3,366  (_merge==3)
    ----------------------------------------- */
drop _merge

save "$user/$data/Ethiopia_Jan19-June20_WIDE.dta", replace

/* By woreda, new TB cases, unable to read labels, waiting for Solomon to confirm
import excel using "$user/$data/Raw/Ethiopia_Health system performance during Covid_data extraction_2019_January to December_03_08_2020_GC/Ethiopia_2019_January to December_all death & quarterly data_03_08_2020/Ethiopia_TB_Quarterly_2019_January to December_ by woreda.xlsx", firstrow clear
drop Numberofbacteriologicallyconf G H I V W X Y Z AA AB AC AD
rename (Totalnumberofnewbacteriologi K L M N O P Q R S T U) (tbdetect_qual1_20	tbdetect_qual2_20	tbdetect_qual3_20	tbdetect_qual4_20	tbdetect_qual5_20	tbdetect_qual6_20	tbdetect_qual7_20	tbdetect_qual8_20	tbdetect_qual9_20	tbdetect_qual10_20	tbdetect_qual11_20	tbdetect_qual12_20)


/* Totals by region (Ethiopian Calendar)
import excel using "$user/$data/Raw/Ethiopia_Health system performance during Covid_data extraction_2019_January to December_03_08_2020_GC/Ethiopia_2019_January to December_ by region_03_08_2020/Ethiopia_2019_January to December_ by Region_03_08_2020.xlsx", firstrow clear



