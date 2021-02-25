* HS performance during Covid
* Sep 10, 2020 
* Nepal, January 2020 - June 2020
* Palika level data analysis 
clear all
set more off

*Family planning 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_fp_util.csv", clear
	drop organisationunitdescription
	rename (familyplanningprogrampermanentfp familyplanningprogrampostpartumf familyplanningprogramtemporaryfp) (v9 v39 v57)
	egen fp_util1_20 = rowtotal(v9  v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93  v99 v105 v111 v117 v123 v129 v135 v141 v147), m
	egen fp_util2_20 = rowtotal(v10 v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 v82 v88 v94 v100 v106 v112 v118 v124 v130 v136 v142 v148), m
	egen fp_util3_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125 v131 v137 v143 v149), m
	egen fp_util4_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v102 v108 v114 v120 v126 v132 v138 v144 v150), m
	egen fp_util5_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v103 v109 v115 v121 v127 v133 v139 v145 v151), m
	egen fp_util6_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v104 v110 v116 v122 v128 v134 v140 v146 v152), m
	keep org* fp* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(fp*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	* ANC 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_anc_util.csv", clear
	drop organisationunitdescription
	egen anc_util1_20 = rowtotal(safemotherhoodprogramantenatalch v15), m
	egen anc_util2_20 =	rowtotal(v10 v16 ), m
	egen anc_util3_20	=rowtotal(v11 v17), m
	egen anc_util4_20	=rowtotal(v12  v18 ), m
	egen anc_util5_20	=rowtotal(v13 v19), m
	egen anc_util6_20=	rowtotal(v14 v20 ), m
	keep org* anc* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(anc*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	* Deliveries 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_del_util.csv", clear 
	drop organisationunitdescription
	rename (safemotherhoodprogramdeliveryser-v14) (del_util1_20 del_util2_20 del_util3_20 del_util4_20 ///
	del_util5_20 del_util6_20)
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid  		   		organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(del*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid  		   	  	organisationunitname organisationunitcode using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

	
* Live births 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_live_births", clear 
	drop organisationunitdescription
	egen live_births1_20 = rowtotal(safemotherhoodprogramdeliveryout v15 v21 ), m
	egen live_births2_20 = rowtotal(v10 v16 v22 ), m
	egen live_births3_20 = rowtotal(v11 v17 v23 ), m
	egen live_births4_20 = rowtotal(v12 v18 v24 ), m
	egen live_births5_20 = rowtotal(v13 v19 v25 ), m
	egen live_births6_20 = rowtotal(v14 v20 v26 ), m
	keep org* live* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(live_*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	
* C-sections 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_cs_util.csv", clear 
	drop organisationunitdescription
	egen cs_util1_20 =rowtotal(safemotherhoodprogramtypeofdeliv v15 v21 ), m
	egen cs_util2_20 =rowtotal(v10 v16 v22), m
	egen cs_util3_20 =rowtotal(v11 v17 v23), m
	egen cs_util4_20 =rowtotal(v12 v18 v24), m
	egen cs_util5_20 =rowtotal(v13 v19 v25), m
	egen cs_util6_20 =rowtotal(v14 v20 v26), m
	keep org* cs* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(cs*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
* Total deliveries
	
	egen totaldel1_20 =  rowtotal(del_util1_20  cs_util1_20), m
	egen totaldel2_20 =	rowtotal(del_util2_20 cs_util2_20), m
	egen totaldel3_20 =	rowtotal(del_util3_20 cs_util3_20), m
	egen totaldel4_20 =	rowtotal(del_util4_20 cs_util4_20), m
	egen totaldel5_20=	rowtotal(del_util5_20 cs_util5_20), m
	egen totaldel6_20=	rowtotal(del_util6_20 cs_util6_20), m
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
* 	Perinatal mortality
gen peri_mort_num1_20 = totaldel1_20 - live_births1_20
gen peri_mort_num2_20 = totaldel2_20 -live_births2_20 
gen peri_mort_num3_20 = totaldel3_20 -live_births3_20 
gen peri_mort_num4_20 = totaldel4_20 -live_births4_20 
gen peri_mort_num5_20 = totaldel5_20 -live_births5_20 
gen peri_mort_num6_20 = totaldel6_20 -live_births6_20	
forval i =1/6 {
	replace peri_mort_num`i'_20 = 0 if peri_mort_num`i'_20 <0 & peri_mort_num`i'_20!=.
}

drop live_births*  
save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

	* PNC 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_pnc_util.csv", clear 
	drop organisationunitdescription
	rename(outreachcliniccommunityhealthpro-v14) (pnc_util1_20 pnc_util2_20 ///
			pnc_util3_20 pnc_util4_20 pnc_util5_20 pnc_util6_20)
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid ///
	organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(pnc*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 	///
	organisationunitname organisationunitcode using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace 
	
	* Child diarrhea 2020 - redownloaded due to wrong order 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_diarr_util",  clear 
	drop organisationunitdescription
	rename cbimci259monthsclassificationdia v9
	egen diarr_util1_20 = rowtotal(v9 v15 v21 v27 v33), m 
	egen diarr_util2_20 = rowtotal(v10 v16 v22 v28 v34), m 
	egen diarr_util3_20	= rowtotal(v11 v17 v23 v29 v35), m 
	egen diarr_util4_20	= rowtotal(v12 v18 v24 v30 v36), m 
	egen diarr_util5_20	= rowtotal(v13 v19 v25 v31 v37), m 
	egen diarr_util6_20=  rowtotal(v14 v20 v26 v32 v38), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

*Child pneumonia 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_pneum_util.csv", clear
	drop organisationunitdescription
	rename cbimci259monthsclassificationari v9
	egen pneum_util1_20 = rowtotal(v9 v15)
	egen pneum_util2_20 = rowtotal(v10 v16)
	egen pneum_util3_20 = rowtotal(v11 v17)
	egen pneum_util4_20 = rowtotal(v12 v18)
	egen pneum_util5_20 = rowtotal(v13 v19)
	egen pneum_util6_20 = rowtotal(v14 v20)
	keep org* pneum* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

* Child malnutrition 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_sam_util", clear 
	drop organisationunitdescription
	rename (cbimci259monthsclassificationsev-v14 ) (sam_util1_20 sam_util2_20 sam_util3_20	sam_util4_20 ///
	sam_util5_20 sam_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace	
	
	
	*Outpatient visit 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_opd_util.csv", clear 
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v14) (opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20 ///
	opd_util5_20 opd_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(opd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

	*Inpatient admissions 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_ipd_util.csv", clear 
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v14) (ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20 ///
	ipd_util5_20 ipd_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

*Emergency room visits 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_er_util.csv", clear 
	drop organisationunitdescription
	rename clientsreceivedemergencyservices v9 
	egen er_util1_20 	= rowtotal( v9 v15 v21 v27), m
	egen er_util2_20 	= rowtotal(v10 v16 v22 v28), m
	egen er_util3_20	= rowtotal(v11 v17 v23 v29), m
	egen er_util4_20	= rowtotal(v12 v18 v24 v30), m
	egen er_util5_20	= rowtotal(v13 v19 v25 v31), m
	egen er_util6_20	= rowtotal(v14 v20 v26 v32), m
	keep org* er* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(er*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

*TB cases detected 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_tbdetect_qual.csv", clear 
	drop organisationunitdescription
	rename  (disaggregationbysexcasteethnicit-v14) (tbdetect_qual1_20 tbdetect_qual2_20 ///
	tbdetect_qual3_20 tbdetect_qual4_20 tbdetect_qual5_20 tbdetect_qual6_20)	
	duplicates tag org*, gen(tag)
	egen total= rowtotal(tb*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
*HIV cases diagnosed 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_hivdiag_qual.csv", clear 
	drop organisationunitdescription
	egen hivdiag_qual1_20 	= rowtotal(disaggregationbysexcasteethnicit v15), m
	egen hivdiag_qual2_20 	= rowtotal(v10 v16 ), m
	egen hivdiag_qual3_20	= rowtotal(v11 v17 ), m
	egen hivdiag_qual4_20	= rowtotal(v12 v18 ), m
	egen hivdiag_qual5_20	= rowtotal(v13 v19 ), m
	egen hivdiag_qual6_20	= rowtotal(v14 v20 ), m
	keep org* hiv* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(hiv*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*Pentavalent 3rd dose 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_pent_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v20
	rename (v21-v26) (pent_qual1_20 pent_qual2_20  pent_qual3_20 pent_qual4_20 ///
	pent_qual5_20 pent_qual6_20)	
	keep org* pent* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pent*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*BCG vaccine 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_bcg_qual.csv", clear 
	drop organisationunitdescription
	rename  (immunizationprogramvaccinetypech v10 v11 v12 v13 v14) (bcg_qual1_20 bcg_qual2_20 bcg_qual3_20 				bcg_qual4_20 bcg_qual5_20 bcg_qual6_20  )
	duplicates tag org*, gen(tag)
	egen total= rowtotal(bcg*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*Measles vaccine 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_measles_qual.csv", clear 
	drop organisationunitdescription
	egen measles_qual1_20 	= rowtotal(immunizationprogramchildrenimmun v15), m
	egen measles_qual2_20 	= rowtotal(v10 v16 ), m
	egen measles_qual3_20	= rowtotal(v11 v17 ), m
	egen measles_qual4_20	= rowtotal(v12 v18 ), m
	egen measles_qual5_20	= rowtotal(v13 v19 ), m
	egen measles_qual6_20	= rowtotal(v14 v20 ), m
	keep org* measles* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(measles*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
		*OPV3 vaccine 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_opv3_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v14 ///
	v21-v26
	rename(v15-v20) (opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20 ///
	opv3_qual5_20 opv3_qual6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(opv3*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

	*Pneumococcal vaccine 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_pneum_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v20
	rename (v21-v26) (pneum_qual1_20 pneum_qual2_20	pneum_qual3_20 pneum_qual4_20 ///
	pneum_qual5_20 pneum_qual6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*Rotavirus 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_rota_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v14
	rename(v15-v20) ///
	(rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20 ///
	rota_qual6_20)
	keep org* rota* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(rota*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	* Maternal mortality 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_mat_mort", clear
	drop organisationunitdescription
	replace orgunitlevel2= "5 Province 5" if orgunitlevel2=="5 Lumbini Province"
	egen mat_mort_num1_20 = rowtotal(safemotherhoodprogrammaternaldea v15 v21), m // magh
	egen mat_mort_num2_20 = rowtotal(v10 v16 v22), m // falgun
	egen mat_mort_num3_20 = rowtotal(v11 v17 v23), m // chaitra
	egen mat_mort_num4_20 = rowtotal(v12 v18 v24), m // baisakh
	egen mat_mort_num5_20 = rowtotal(v13 v19 v25), m // jestha
	egen mat_mort_num6_20 = rowtotal(v14 v20 v26), m // asar
	keep org* mat* 
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 					organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(mat*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 					organisationunitname organisationunitcode using ///
	"$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	
	*Stillbirths 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_sb_mort", clear 
	drop organisationunitdescription
	drop fchvprogramsmhfphomedeliverytota-v14 //home delivery was dropped 
	egen sb_mort_num1_20 = rowtotal(safemotherhoodprogramnumberofsti v21), m
	egen sb_mort_num2_20 = rowtotal(v16 v22), m
	egen sb_mort_num3_20 = rowtotal(v17 v23), m
	egen sb_mort_num4_20 = rowtotal(v18 v24), m
	egen sb_mort_num5_20 = rowtotal(v19 v25), m
	egen sb_mort_num6_20 = rowtotal(v20 v26), m
	keep org* sb* 
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 					organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(sb*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 				organisationunitname organisationunitcode using ///
	"$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
		*Inpatient deaths 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_ipd_mort.csv", clear
	drop organisationunitdescription
	rename (inpatientdeathsin48hoursofadmiss inpatientdeathsinâ48hoursofadmis) (v9 v69)
	egen ipd_mort_num1_20 = rowtotal(v9  v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93 v99  v105 v111 v117 v123), m
	egen ipd_mort_num2_20 = rowtotal(v10 v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 v82 v88 v94 v100 v106 v112 v118 v124), m
	egen ipd_mort_num3_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125), m
	egen ipd_mort_num4_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v102 v108 v114 v120 v126), m
	egen ipd_mort_num5_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v103 v109 v115 v121 v127), m
	egen ipd_mort_num6_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v104 v110 v116 v122 v128), m
	keep org* ipd* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	
		
drop rota* 

* Fix issue with Province 1 
	order org*
	drop  organisationunitid organisationunitcode orgunitlevel4			 
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				

	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
