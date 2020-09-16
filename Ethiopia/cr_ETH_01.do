* HS performance during Covid
* Aug 4, 2020 
* Ethiopia, January - December 2019
clear all
set more off	
global user "/Users/catherinearsenault/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Ethiopia)"

*Import raw data
import excel using "$user/$data/Raw/Ethiopia_Health system performance during Covid_data extraction_2019_January to December_03_08_2020_GC/Ethiopia_2019_January to December_by worda level & zonal Level_03_08_2020/Ethiopia_2019_January to December_ by woreda level.xlsx", firstrow clear
* Recode variables
* VOLUMES 
* FP
rename (Totalnewandrepeatacceptors G H I J K L M N O P Q) ///
( 	fp_util1_19		fp_util2_19		fp_util3_19		fp_util4_19		fp_util5_19		fp_util6_19	
	fp_util7_19		fp_util8_19		fp_util9_19		fp_util10_19	fp_util11_19	fp_util12_19)
* STI
rename (TotalnumberofSTIcasesbysex S T U V W X Y Z AA AB AC) ///
(	sti_util1_19	sti_util2_19	sti_util3_19	sti_util4_19	sti_util5_19	sti_util6_19	
	sti_util7_19	sti_util8_19	sti_util9_19	sti_util10_19	sti_util11_19	sti_util12_19)
* ANC
rename (Numberofpregnantwomenthatre AE AF AG AH AI AJ AK AL AM AN AO) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19	
	anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19)
* Deliveries
rename (Totalnumberofbirthsattended AQ AR AS AT AU AV AW AX AY AZ BA) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19	
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19)
*Csections
rename ( Numberofwomenhavinggivenbir BC BD BE BF BG BH BI BJ BK BL BM) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19		cs_util6_19	
	cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19	cs_util11_19	cs_util12_19)
* PNC
rename (NumberofPostnatalvisitswithi BO BP BQ BR BS BT BU BV BW BX BY) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19	pnc_util6_19	
	pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19	pnc_util11_19	pnc_util12_19)
* ORS
rename (Numberofchildrentreatedford CA CB CC CD CE CF CG CH CI CJ CK) ///
(	diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19	
	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19)
* Pneumonia
rename ( Numberofunder5childrentreat CM CN CO CP CQ CR CS CT CU CV CW) ///
(	pneum_util1_19	pneum_util2_19	pneum_util3_19	pneum_util4_19	pneum_util5_19	pneum_util6_19	
	pneum_util7_19	pneum_util8_19	pneum_util9_19	pneum_util10_19	pneum_util11_19	pneum_util12_19)
* Screened malnutrition
rename (Totalnumberofchildren5yrss CY CZ DA DB DC DD DE DF DG DH DI) ///
(	sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19	sam_util5_19	sam_util6_19	
	sam_util7_19	sam_util8_19	sam_util9_19	sam_util10_19	sam_util11_19	sam_util12_19)
* ART
rename (Numberofadultsandchildrenwh DK DL DM DN DO DP DQ DR DS DT DU) ///
(art_util1_19	art_util2_19	art_util3_19	art_util4_19	art_util5_19	art_util6_19	art_util7_19	art_util8_19	art_util9_19	art_util10_19	art_util11_19	art_util12_19)
* OPD 
rename (NumberofoutpatientvisitsJanu NumberofoutpatientvisitsFeb NumberofoutpatientvisitsMar NumberofoutpatientvisitsApri NumberofoutpatientvisitsMay NumberofoutpatientvisitsJun NumberofoutpatientvisitsJuly NumberofoutpatientvisitsAugu NumberofoutpatientvisitsSept NumberofoutpatientvisitsOcto NumberofoutpatientvisitsNov NumberofoutpatientvisitsDece) ///
(opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19	opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19)
* IPD
rename (NumberofinpatientadmissionsJ Numberofinpatientadmissions EJ NumberofinpatientadmissionsA NumberofinpatientadmissionsM EM EN EO NumberofinpatientadmissionsS NumberofinpatientadmissionsO ER NumberofinpatientadmissionsD) ///
(ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19) 
* ER 
rename (Totalnumberofemergencyunita EU EV EW EX EY EZ FA FB FC FD FE) ///
(er_util1_19	er_util2_19	er_util3_19	er_util4_19	er_util5_19	er_util6_19	er_util7_19	er_util8_19	er_util9_19	er_util10_19	er_util11_19	er_util12_19)
* Road traffic
rename (Numberofroadtrafficinjuryca FG FH FI FJ FK FL FM FN FO FP FQ) ///
(road_util1_19	road_util2_19	road_util3_19	road_util4_19	road_util5_19	road_util6_19	road_util7_19	road_util8_19	road_util9_19	road_util10_19	road_util11_19	road_util12_19)
* Diabetes
rename (Totalnumberofdiabeticpatient FS FT FU FV FW FX FY FZ GA GB GC ) ///
(diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19)
* Hypertension 
rename (Totalnumberofhypertensivepat GE GF GG GH GI GJ GK GL GM GN GO) ///
(hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19)
drop Totalnumberofindividualsscre GQ GR GS GT GU GV GW GX GY GZ HA HB HC HD HE HF HG HH HI HJ HK HL HM
* QUALITY 
* KMC %
rename (Proportionoflowbirthweighta HO HP HQ HR HS HT HU HV HW HX HY) ///
(kmc_qual1_19	kmc_qual2_19	kmc_qual3_19	kmc_qual4_19	kmc_qual5_19	kmc_qual6_19	kmc_qual7_19	kmc_qual8_19	kmc_qual9_19	kmc_qual10_19	kmc_qual11_19	kmc_qual12_19)
forval i = 1/12 {
	replace kmc_qual`i'_19 = kmc_qual`i'_19 / 100
}
* Newborn resuscitation %
rename (Proportionofasphyxiatedneonat IA IB IC ID IE IF IG IH II IJ IK) ///
(resus_qual1_19	resus_qual2_19	resus_qual3_19	resus_qual4_19	resus_qual5_19	resus_qual6_19	resus_qual7_19	resus_qual8_19	resus_qual9_19	resus_qual10_19	resus_qual11_19	resus_qual12_19)
forval i = 1/12 {
	replace resus_qual`i'_19 = resus_qual`i'_19 / 100
}
* Cervical cancer screening # 
rename (Numberofwomenaged3049scr IM IN IO IP IQ IR IS IT IU IV IW) ///
(cerv_qual1_19	cerv_qual2_19	cerv_qual3_19	cerv_qual4_19	cerv_qual5_19	cerv_qual6_19	cerv_qual7_19	cerv_qual8_19	cerv_qual9_19	cerv_qual10_19	cerv_qual11_19	cerv_qual12_19)
* VL supression #
rename (Numberofadultandpediatricpa IY IZ JA JB JC JD JE JF JG JH JI) ///
(hivsupp_qual_num1_19	hivsupp_qual_num2_19	hivsupp_qual_num3_19	hivsupp_qual_num4_19	hivsupp_qual_num5_19	hivsupp_qual_num6_19	hivsupp_qual_num7_19	hivsupp_qual_num8_19	hivsupp_qual_num9_19	hivsupp_qual_num10_19	hivsupp_qual_num11_19	hivsupp_qual_num12_19)
* Controlled diabetes #
rename (JJ JK JL JM JN JO JP JQ JR JS JT JU ) ///
(diab_qual_num1_19	diab_qual_num2_19	diab_qual_num3_19	diab_qual_num4_19	diab_qual_num5_19	diab_qual_num6_19	diab_qual_num7_19	diab_qual_num8_19	diab_qual_num9_19	diab_qual_num10_19	diab_qual_num11_19	diab_qual_num12_19)
* Controlled hypertension #
rename (JV JW JX JY JZ KA KB KC KD KE KF KG ) ///
(hyper_qual_num1_19	hyper_qual_num2_19	hyper_qual_num3_19	hyper_qual_num4_19	hyper_qual_num5_19	hyper_qual_num6_19	hyper_qual_num7_19	hyper_qual_num8_19	hyper_qual_num9_19	hyper_qual_num10_19	hyper_qual_num11_19	hyper_qual_num12_19)
* Full vaccination
rename (Numberofchildrenreceivedall KI KJ KK KL KM KN KO KP KQ KR KS) ///
(vacc_qual1_19	vacc_qual2_19	vacc_qual3_19	vacc_qual4_19	vacc_qual5_19	vacc_qual6_19	vacc_qual7_19	vacc_qual8_19	vacc_qual9_19	vacc_qual10_19	vacc_qual11_19	vacc_qual12_19)
* Penta3
rename(Numberofchildrenunderoneyea KU KV KW KX KY KZ LA LB LC LD LE) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19)
* BCG
rename (LF LG LH LI LJ LK LL LM LN LO LP LQ) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19)
* Measles
rename (LR LS LT LU LV LW LX LY LZ MA MB MC) ///
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19)
* Polio3
rename (MD ME MF MG MH MI MJ MK ML MM MN MO) ///
(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19)
* Pneumococcal 
rename (MP MQ MR MS MT MU MV MW MX MY MZ NA) ///
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19)
* Rotavirus 2nd dose
drop NB NC ND NE NF NG NH NI NJ NK NL NM // dropping 1st dose only
rename (NN NO NP NQ NR NS NT NU NV NW NX NY) ///
(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19	rota_qual11_19	rota_qual12_19)
* MORTALITY 
* Newborn deaths # numerator
rename(Numberofneonataldeathsinthe OA OB OC OD OE OF OG OH OI OJ OK) ///
(newborn_mort_num1_19	newborn_mort_num2_19	newborn_mort_num3_19	newborn_mort_num4_19	newborn_mort_num5_19	newborn_mort_num6_19	newborn_mort_num7_19	newborn_mort_num8_19	newborn_mort_num9_19	newborn_mort_num10_19	newborn_mort_num11_19	newborn_mort_num12_19)
* Stillbirths # numerator
rename (NumberofstillbirthsJanuary NumberofstillbirthsFebruar NumberofstillbirthsMarch2 NumberofstillbirthsApril20 NumberofstillbirthsMay2019 NumberofstillbirthsJune20 NumberofstillbirthsJuly201 NumberofstillbirthsAugust2 NumberofstillbirthsSeptembe NumberofstillbirthsOctober NumberofstillbirthsNovembe NumberofstillbirthsDecember) ///
(sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19)
* Maternal deaths # numerator
rename (Numberofmaternaldeathsinhea OY OZ PA PB PC PD PE PF PG PH PI) ///
(mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19)
*Inpatient deaths # numerator
rename (Numberofinpatientdeathsinth PK PL PM PN PO PP PQ PR PS PT PU) ///
(ipd_mort_num1_19	ipd_mort_num2_19	ipd_mort_num3_19	ipd_mort_num4_19	ipd_mort_num5_19	ipd_mort_num6_19	ipd_mort_num7_19	ipd_mort_num8_19 ipd_mort_num9_19	ipd_mort_num10_19	ipd_mort_num11_19 ipd_mort_num12_19)
* ICU deaths # numerator
rename (TotaldeathinICUinthereport QI QJ QK QL QM QN QO QP QQ QR QS) (icu_mort_num1_19	icu_mort_num2_19	icu_mort_num3_19	icu_mort_num4_19	icu_mort_num5_19	icu_mort_num6_19	icu_mort_num7_19	icu_mort_num8_19	icu_mort_num9_19	icu_mort_num10_19	icu_mort_num11_19	icu_mort_num12_19)
drop orgunitlevel1 orgunitlevel4  QT QU QV QW QX QY QZ RA RB RC RD RE RF RG RH RI
* ER mortality  numerator
rename (Totaldeathintheemergencyuni PW PX PY PZ QA QB QC QD QE QF QG) ///
(er_mort_num1_19	er_mort_num2_19	er_mort_num3_19	er_mort_num4_19	er_mort_num5_19	er_mort_num6_19	er_mort_num7_19	er_mort_num8_19	er_mort_num9_19	er_mort_num10_19	er_mort_num11_19	er_mort_num12_19)
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
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"

egen unit_id = concat(region zone organisationunitname)
order region zone organisationunitname unit_id

save "$user/$data/Ethiopia_Jan19-Dec19_WIDE.dta", replace




/* By woreda, new TB cases, unable to read labels, waiting for Solomon to confirm
import excel using "$user/$data/Raw/Ethiopia_Health system performance during Covid_data extraction_2019_January to December_03_08_2020_GC/Ethiopia_2019_January to December_all death & quarterly data_03_08_2020/Ethiopia_TB_Quarterly_2019_January to December_ by woreda.xlsx", firstrow clear
drop Numberofbacteriologicallyconf G H I V W X Y Z AA AB AC AD
rename (Totalnumberofnewbacteriologi K L M N O P Q R S T U) (tbdetect_qual1_19	tbdetect_qual2_19	tbdetect_qual3_19	tbdetect_qual4_19	tbdetect_qual5_19	tbdetect_qual6_19	tbdetect_qual7_19	tbdetect_qual8_19	tbdetect_qual9_19	tbdetect_qual10_19	tbdetect_qual11_19	tbdetect_qual12_19)


/* Totals by region (Ethiopian Calendar)
import excel using "$user/$data/Raw/Ethiopia_Health system performance during Covid_data extraction_2019_January to December_03_08_2020_GC/Ethiopia_2019_January to December_ by region_03_08_2020/Ethiopia_2019_January to December_ by Region_03_08_2020.xlsx", firstrow clear



