* HS performance during Covid
* Feb 22, 2021
* Lao, January 2020 - December 2020
* Facility level analysis 
* Created by MK Kim 

clear all
set more off
********************************************************************************
********************************************************************************
*Import raw data: VOLUMES OF SERVICES 
* 1269 facilities
*Family planning 
	 import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_1 Modern contraceptive use.csv", clear
	 rename ïorgunitlevel1 country 
	*1) permanent method 
	egen fp_perm_util1_20 = rowtotal(january2020femalesterilizationne january2020femalesterilizationco january2020malesterilizationnewu january2020malesterilizationcont), mi 
	egen fp_perm_util2_20 = rowtotal(february2020femalesterilizationn february2020femalesterilizationc february2020malesterilizationnew february2020malesterilizationcon), mi 
	egen fp_perm_util3_20 = rowtotal(march2020femalesterilizationnewu march2020femalesterilizationcont march2020malesterilizationnewuse march2020malesterilizationcontin), mi 
	egen fp_perm_util4_20 = rowtotal(april2020femalesterilizationnewu april2020femalesterilizationcont april2020malesterilizationnewuse april2020malesterilizationcontin), mi 
	egen fp_perm_util5_20 = rowtotal(may2020femalesterilizationnewuse may2020femalesterilizationcontin may2020malesterilizationnewusers may2020malesterilizationcontinue), mi 
	egen fp_perm_util6_20 = rowtotal(june2020femalesterilizationnewus june2020femalesterilizationconti june2020malesterilizationnewuser june2020malesterilizationcontinu), mi 
	egen fp_perm_util7_20 = rowtotal(july2020femalesterilizationnewus july2020femalesterilizationconti july2020malesterilizationnewuser july2020malesterilizationcontinu), mi 
	egen fp_perm_util8_20 = rowtotal(august2020femalesterilizationnew august2020femalesterilizationcon august2020malesterilizationnewus august2020malesterilizationconti), mi 
	egen fp_perm_util9_20 = rowtotal(september2020femalesterilization v159 september2020malesterilizationne september2020malesterilizationco), mi 
	egen fp_perm_util10_20 = rowtotal(october2020femalesterilizationne october2020femalesterilizationco october2020malesterilizationnewu october2020malesterilizationcont), mi 
	egen fp_perm_util11_20 = rowtotal(november2020femalesterilizationn november2020femalesterilizationc november2020malesterilizationnew november2020malesterilizationcon), mi 
		egen fp_perm_util12_20 = rowtotal(december2020femalesterilizationn december2020femalesterilizationc december2020malesterilizationnew december2020malesterilizationcon), mi 
	
	*2) short acting method 
	egen fp_sa_util1_20 = rowtotal(january2020combinedpillnewuser january2020combinedpillcontinueu january2020emergencypillnewuser january2020emergencypillcontinue january2020singlepillnewusers january2020singlepillcontinueuse january2020deposeinjectablenewus january2020deposeinjectableconti january2020condomsnewusers january2020condomscontinueusers), mi 
	
	egen fp_sa_util2_20 = rowtotal(february2020combinedpillnewuser february2020combinedpillcontinue february2020condomsnewusers february2020condomscontinueusers february2020deposeinjectablenewu february2020deposeinjectablecont february2020emergencypillnewuser february2020emergencypillcontinu february2020singlepillnewusers february2020singlepillcontinueus), mi 
	
	egen fp_sa_util3_20 = rowtotal(march2020combinedpillnewuser march2020combinedpillcontinueuse march2020condomsnewusers march2020condomscontinueusers march2020deposeinjectablenewuser march2020deposeinjectablecontinu march2020emergencypillnewuser march2020emergencypillcontinueus march2020singlepillnewusers march2020singlepillcontinueusers), mi 
	
	egen fp_sa_util4_20 = rowtotal(april2020combinedpillnewuser april2020combinedpillcontinueuse april2020condomsnewusers april2020condomscontinueusers april2020deposeinjectablenewuser april2020deposeinjectablecontinu april2020emergencypillnewuser april2020emergencypillcontinueus april2020singlepillnewusers april2020singlepillcontinueusers), mi 
	
	egen fp_sa_util5_20 = rowtotal(may2020combinedpillnewuser may2020combinedpillcontinueuser may2020condomsnewusers may2020condomscontinueusers may2020deposeinjectablenewusers may2020deposeinjectablecontinueu may2020emergencypillnewuser may2020emergencypillcontinueuser may2020singlepillnewusers may2020singlepillcontinueusers), mi 
	
	egen fp_sa_util6_20 = rowtotal(june2020combinedpillnewuser june2020combinedpillcontinueuser june2020condomsnewusers june2020condomscontinueusers june2020deposeinjectablenewusers june2020deposeinjectablecontinue june2020emergencypillnewuser june2020emergencypillcontinueuse june2020singlepillnewusers june2020singlepillcontinueusers), mi 
	
	egen fp_sa_util7_20 = rowtotal(july2020combinedpillnewuser july2020combinedpillcontinueuser july2020condomsnewusers july2020condomscontinueusers july2020deposeinjectablenewusers july2020deposeinjectablecontinue july2020emergencypillnewuser july2020emergencypillcontinueuse july2020singlepillnewusers july2020singlepillcontinueusers), mi 
	
	egen fp_sa_util8_20 = rowtotal(august2020combinedpillnewuser august2020combinedpillcontinueus august2020condomsnewusers august2020condomscontinueusers august2020deposeinjectablenewuse august2020deposeinjectablecontin august2020emergencypillnewuser august2020emergencypillcontinueu august2020singlepillnewusers august2020singlepillcontinueuser), mi 
	
	egen fp_sa_util9_20 = rowtotal(september2020combinedpillnewuser september2020combinedpillcontinu september2020condomsnewusers september2020condomscontinueuser september2020deposeinjectablenew september2020deposeinjectablecon september2020emergencypillnewuse september2020emergencypillcontin september2020singlepillnewusers september2020singlepillcontinueu), mi 
	
	egen fp_sa_util10_20 = rowtotal(october2020combinedpillnewuser october2020combinedpillcontinueu october2020condomsnewusers october2020condomscontinueusers october2020deposeinjectablenewus october2020deposeinjectableconti october2020emergencypillnewuser october2020emergencypillcontinue october2020singlepillnewusers october2020singlepillcontinueuse), mi 
	
	egen fp_sa_util11_20 = rowtotal(november2020combinedpillnewuser november2020combinedpillcontinue november2020emergencypillnewuser november2020emergencypillcontinu november2020singlepillnewusers november2020singlepillcontinueus november2020deposeinjectablenewu november2020deposeinjectablecont november2020condomsnewusers november2020condomscontinueusers), mi 
		
		egen fp_sa_util12_20 = rowtotal(december2020combinedpillnewuser december2020combinedpillcontinue december2020emergencypillnewuser december2020emergencypillcontinu december2020singlepillnewusers december2020singlepillcontinueus december2020deposeinjectablenewu december2020deposeinjectablecont december2020condomsnewusers december2020condomscontinueusers), mi 
	
	 *3) long acting 
	 egen fp_la_util1_20 = rowtotal(january2020iudnewusers january2020iudcontinueusers january2020implantnewusers january2020implantcontinueusers), mi 
	 
	 egen fp_la_util2_20 = rowtotal(february2020iudnewusers february2020iudcontinueusers february2020implantnewusers february2020implantcontinueusers), mi 
	 
	 egen fp_la_util3_20 = rowtotal(march2020iudnewusers march2020iudcontinueusers march2020implantnewusers march2020implantcontinueusers), mi 
	 
	 egen fp_la_util4_20 = rowtotal(april2020iudnewusers april2020iudcontinueusers april2020implantnewusers april2020implantcontinueusers), mi 
	 
	 egen fp_la_util5_20 = rowtotal(may2020iudnewusers may2020iudcontinueusers may2020implantnewusers may2020implantcontinueusers), mi 
	 
	 egen fp_la_util6_20 = rowtotal(june2020iudnewusers june2020iudcontinueusers june2020implantnewusers june2020implantcontinueusers), mi 
	 
	 egen fp_la_util7_20 = rowtotal(july2020iudnewusers july2020iudcontinueusers july2020implantnewusers july2020implantcontinueusers), mi 
	 
	 egen fp_la_util8_20 = rowtotal(august2020iudnewusers august2020iudcontinueusers august2020implantnewusers august2020implantcontinueusers), mi 
	 
	 egen fp_la_util9_20 = rowtotal(september2020iudnewusers september2020iudcontinueusers september2020implantnewusers september2020implantcontinueuser), mi 
	 
	 egen fp_la_util10_20 = rowtotal(october2020iudnewusers october2020iudcontinueusers october2020implantnewusers october2020implantcontinueusers), mi 
	 
	 egen fp_la_util11_20 = rowtotal(november2020implantnewusers november2020implantcontinueusers november2020iudnewusers november2020iudcontinueusers ), mi 
		 
	egen fp_la_util12_20 = rowtotal(december2020implantnewusers december2020implantcontinueusers december2020iudnewusers december2020iudcontinueusers), mi 
	
	keep org* fp* 
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace


*********************************************************************************************
*********************************************************************************************
*Antenatal care
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_3 Antenatal care.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020anc1stvisitbyhealthfa-december2020anc1stvisitbyhealthf) ///
	(anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20	anc_util7_20	anc_util8_20	anc_util9_20	anc_util10_20 anc_util11_20 anc_util12_20)	
	keep org* anc*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
*********************************************************************************************
*Facility delivery 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_4 Facility deliveries.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020deliveryathf-december2020deliveryathf) ///
	(del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20	del_util7_20	del_util8_20	del_util9_20	del_util10_20 del_util11_20 del_util12_20)
	
	keep org* del*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
********************************************************************************************
*C-sections 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_5 Caesarean sections.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020caesareandelivery-december2020caesareandelivery) ///
	(cs_util1_20	cs_util2_20	cs_util3_20	cs_util4_20	cs_util5_20	cs_util6_20	cs_util7_20	cs_util8_20	cs_util9_20	cs_util10_20 cs_util11_20 cs_util12_20)
	
	keep org* cs*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
*Postnatal care 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_6 Postnatal care.csv", clear
	rename ïorgunitlevel1 country 
	egen pnc_util1_20 = rowtotal(january2020pncwithin2days january2020pnc342days), mi 
	egen pnc_util2_20 = rowtotal(february2020pncwithin2days february2020pnc342days), mi 
	egen pnc_util3_20 = rowtotal(march2020pncwithin2days march2020pnc342days), mi 
	egen pnc_util4_20 = rowtotal(april2020pncwithin2days april2020pnc342days), mi 
	egen pnc_util5_20 = rowtotal(may2020pncwithin2days may2020pnc342days), mi 
	egen pnc_util6_20 = rowtotal(june2020pncwithin2days june2020pnc342days), mi 
	egen pnc_util7_20 = rowtotal(july2020pncwithin2days july2020pnc342days), mi 
	egen pnc_util8_20 = rowtotal(august2020pncwithin2days august2020pnc342days), mi 
	egen pnc_util9_20 = rowtotal(september2020pncwithin2days september2020pnc342days), mi 
	egen pnc_util10_20 = rowtotal(october2020pncwithin2days october2020pnc342days), mi 
	egen pnc_util11_20 = rowtotal(november2020pncwithin2days november2020pnc342days), mi 
	egen pnc_util12_20 = rowtotal(december2020pncwithin2days december2020pnc342days), mi 
	
	keep org* pnc*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
**********************************************************************************************VACCINE
*********************************************************************************************
*BCG 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_26 BCG vaccination.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020monthlybcg-december2020monthlybcg) (bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20	bcg_qual7_20	bcg_qual8_20	bcg_qual9_20	bcg_qual10_20 bcg_qual11_20 bcg_qual12_20)
	
	keep org* bcg*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	

*********************************************************************************************
*********************************************************************************************
*Penta3 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_25 Pentavalent vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypenta3-december2020monthlypenta3) ///
	(pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20	pent_qual7_20	pent_qual8_20	pent_qual9_20	pent_qual10_20 pent_qual11_20 pent_qual12_20)
	
	keep org* pent*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace

*********************************************************************************************
*********************************************************************************************
*Measles vaccine 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_27 Measles vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlymcv2-december2020monthlymcv2) ///
	(measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20	measles_qual6_20	measles_qual7_20	measles_qual8_20	measles_qual9_20	measles_qual10_20 measles_qual11_20 measles_qual12_20)
	 
	keep org* measles*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	

*********************************************************************************************
*********************************************************************************************
* OPV3 vaccine 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_28 Polio vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlychildrengotipv-december2020monthlychildrengotip) ///
	(opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20	opv3_qual7_20	opv3_qual8_20	opv3_qual9_20	opv3_qual10_20 opv3_qual11_20 opv3_qual12_20)

	keep org* opv3*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
*********************************************************************************************
* PCV3 vaccine 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_29 Pneumococcal vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypcv3-december2020monthlypcv3) (pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)

	keep org* pneum*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace


*********************************************************************************************
*********************************************************************************************
*VOLUME OF OTHER SERVICES 
* OPD diabetes 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_15 Care for diabetes.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opddiabetes-december2020opddiabetes) ///
	(diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20	diab_util9_20	diab_util10_20 diab_util11_20 diab_util12_20)

	keep org* diab*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace


*********************************************************************************************
*********************************************************************************************
* Hypertension visits 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_16 Care for hypertension.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdhypertension-december2020opdhypertension) (hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20	hyper_util7_20	hyper_util8_20	hyper_util9_20	hyper_util10_20 hyper_util11_20 hyper_util12_20)
	
	keep org* hyper*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace	

*********************************************************************************************
* Outpatient visits 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_11 Outpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdoutpatientvisits-december2020opdoutpatientvisits) ///
	(opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20	opd_util9_20	opd_util10_20 opd_util11_20 opd_util12_20) 
	
	keep org* opd*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace	

*******************************************************************************************	
* Inpatient admissions 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_12 Inpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020ipdinpatientvisits-december2020ipdinpatientvisits)  ///
	(ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	ipd_util10_20 ipd_util11_20 ipd_util12_20)
	
	keep org* ipd*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
* Road traffic injuries 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_14 Road traffic injury.csv", clear
	rename ïorgunitlevel1 country
	egen road_util1_20 = rowtotal(january2020opdroadtrafficinjury january2020ipdroadtrafficinjury), mi 
	egen road_util2_20 = rowtotal(february2020opdroadtrafficinjury february2020ipdroadtrafficinjury), mi 
	egen road_util3_20 = rowtotal(march2020opdroadtrafficinjury march2020ipdroadtrafficinjury), mi 
	egen road_util4_20 = rowtotal(april2020opdroadtrafficinjury april2020ipdroadtrafficinjury), mi 
	egen road_util5_20 = rowtotal(may2020opdroadtrafficinjury may2020ipdroadtrafficinjury), mi 
	egen road_util6_20 = rowtotal(june2020opdroadtrafficinjury june2020ipdroadtrafficinjury), mi 
	egen road_util7_20 = rowtotal(july2020opdroadtrafficinjury july2020ipdroadtrafficinjury), mi 
	egen road_util8_20 = rowtotal(august2020opdroadtrafficinjury august2020ipdroadtrafficinjury), mi 
	egen road_util9_20 = rowtotal(september2020opdroadtrafficinjur september2020ipdroadtrafficinjur), mi 
	egen road_util10_20 = rowtotal(october2020opdroadtrafficinjury october2020ipdroadtrafficinjury), mi 
	egen road_util11_20 = rowtotal(november2020opdroadtrafficinjury november2020ipdroadtrafficinjury), mi 
	egen road_util12_20 = rowtotal(december2020opdroadtrafficinjury december2020ipdroadtrafficinjury), mi 
	
	keep org* road*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace

********************************************************************************************
* MORTALITY 	
* Neonatal deaths 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_31 Neonatal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020deathneonatal07days-december2020deathneonatal07days) (neo_mort_num1_20	neo_mort_num2_20	neo_mort_num3_20	neo_mort_num4_20	neo_mort_num5_20	neo_mort_num6_20	neo_mort_num7_20	neo_mort_num8_20	neo_mort_num9_20	neo_mort_num10_20 neo_mort_num11_20 neo_mort_num12_20)
	
	keep org* neo*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
* Stillbirths 2020
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_32 Stillbirth rate.csv", clear	
	rename ïorgunitlevel1 country
	rename (january2020stillbirth28weeks-december2020stillbirth28weeks) (sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	sb_mort_num5_20	sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20	sb_mort_num9_20	sb_mort_num10_20 sb_mort_num11_20 sb_mort_num12_20)
	
	keep org* sb*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace

*********************************************************************************************
* Maternal deaths 2020 
	import delimited "$user/$data/Raw data/2020/facility/Jan20-Dec20/Lao_2020_Jan to Dec_facility_33 Maternal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020maternaldeaths-december2020maternaldeaths) (mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20	mat_mort_num6_20	mat_mort_num7_20	mat_mort_num8_20	mat_mort_num9_20	mat_mort_num10_20 mat_mort_num11_20 mat_mort_num12_20)
	
	keep org* mat*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
	
*********************************************************************************************
*Total delivery 2020
	egen totaldel1_20 = rowtotal(del_util1_20 cs_util1_20), m
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

	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta"
	drop _merge
	
	egen total = rowtotal (mat_mort_num1_20-totaldel12_20), m
	drop if total==. 
	drop total 
	save "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta", replace
		
********************************************************************************
* Merge with 2019 data
********************************************************************************
import excel using "$user/$data/Analyses/name match.xlsx", firstrow clear
drop I J 

* Merge to 2020 data (81 matched by hand)
merge 1:1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname using "$user/$data/Data for analysis/Lao_Jan20-Dec20_WIDE.dta" 
drop _merge 
replace orgunitlevel2=orgunitlevel2_old if orgunitlevel2_old !=""
replace orgunitlevel3=orgunitlevel3_old if orgunitlevel3_old !=""
replace orgunitlevel4=orgunitlevel4_old if orgunitlevel4_old !=""
replace organisationunitname=organisationunitname_old if organisationunitname_old !=""

drop *_old 

* Merge to 2019 data with the old names
merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Dec19_WIDE.dta"
drop _merge 

*Save dataset for dq analysis 
save "$user/$data/Data for analysis/Lao_Jan19-Dec20_WIDE_dq.dta" , replace 

********************************************************************************
* Drop poorly reported indicators
********************************************************************************
drop measles* 

save "$user/$data/Data for analysis/Lao_Jan19-Dec20_WIDE.dta" , replace 



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
							
