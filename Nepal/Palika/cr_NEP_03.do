* HS performance during Covid
* Jan 11, 2021 
* Nepal, January 2020 - Nov 2020
* Palika level data analysis 

clear all
set more off

********************************************************************************
********************************************************************************
*Import raw data: VOLUMES OF SERVICES

*Family Planning 
*1) Permanent method (fp_perm)
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_fp_util.csv", clear
	drop organisationunitdescription
	rename (familyplanningprogrampermanentfp) (v9)
	egen fp_perm_util1_20 = rowtotal(v9  v20 v31 v42 v53), m
	egen fp_perm_util2_20 = rowtotal(v10 v21 v32 v43 v54), m
	egen fp_perm_util3_20 = rowtotal(v11 v22 v33 v44 v55), m 
	egen fp_perm_util4_20 = rowtotal(v12 v23 v34 v45 v56), m 
	egen fp_perm_util5_20 = rowtotal(v13 v24 v35 v46 v57), m 
	egen fp_perm_util6_20 = rowtotal(v14 v25 v36 v47 v58), m 
	egen fp_perm_util7_20 = rowtotal(v15 v26 v37 v48 v59), m 
	egen fp_perm_util8_20 = rowtotal(v16 v27 v38 v49 v60), m 
	egen fp_perm_util9_20 = rowtotal(v17 v28 v39 v50 v61), m 
	egen fp_perm_util10_20 = rowtotal(v18 v29 v40 v51 v62), m 
	egen fp_perm_util11_20 = rowtotal(v19 v30 v41 v52 v63), m 
	
*2) Short acting method (fp_sa)
	rename (familyplanningprogramtemporaryfp ) (v64 )
	egen fp_sa_util1_20 = rowtotal(v64 v75 v86 v97 v108 v119 v130 v141 v295 v306), m
	egen fp_sa_util2_20 = rowtotal(v65 v76 v87 v98 v109 v120 v131 v142 v296 v307), m
	egen fp_sa_util3_20 = rowtotal(v66 v77 v88 v99 v110 v121 v132 v143 v297 v308), m
	egen fp_sa_util4_20 = rowtotal(v67 v78 v89 v100 v111 v122 v133 v144 v298 v309), m
	egen fp_sa_util5_20 = rowtotal(v68 v79 v90 v101 v112 v123 v134 v145 v299 v310), m
	egen fp_sa_util6_20 = rowtotal(v69 v80 v91 v102 v113 v124 v135 v146 v300 v311), m
	egen fp_sa_util7_20 = rowtotal(v70 v81 v92 v103 v114 v125 v136 v147 v301 v312), m
	egen fp_sa_util8_20 = rowtotal(v71 v82 v93 v104 v115 v126 v137 v148 v302 v313), m
	egen fp_sa_util9_20 = rowtotal(v72 v83 v94 v105 v116 v127 v138 v149 v303 v314), m
	egen fp_sa_util10_20 = rowtotal(v73 v84 v95 v106 v117 v128 v139 v150 v304 v315), m
	egen fp_sa_util11_20 = rowtotal(v74 v85 v96 v107 v118 v129 v140 v151 v305 v316), m

*3) Long acting method (fp_la)
	rename (familyplanningprogrampostpartumf safemotherhoodprogramsafeabortio) (v152 v273)
	egen fp_la_util1_20 = rowtotal(v152 v163 v174 v185 v196 v207 v218 v229 v240 v251 v262 v273 v284), m
	egen fp_la_util2_20 = rowtotal(v153 v164 v175 v186 v197 v208 v219 v230 v241 v252 v263 v274 v285), m
	egen fp_la_util3_20 = rowtotal(v154 v165 v176 v187 v198 v209 v220 v231 v242 v253 v264 v275 v286), m
	egen fp_la_util4_20 = rowtotal(v155 v166 v177 v188 v199 v210 v221 v232 v243 v254 v265 v276 v287), m
	egen fp_la_util5_20 = rowtotal(v156 v167 v178 v189 v200 v211 v222 v233 v244 v255 v266 v277 v288), m
	egen fp_la_util6_20 = rowtotal(v157 v168 v179 v190 v201 v212 v223 v234 v245 v256 v267 v278 v289), m
	egen fp_la_util7_20 = rowtotal(v158 v169 v180 v191 v202 v213 v224 v235 v246 v257 v268 v279 v290), m
	egen fp_la_util8_20 = rowtotal(v159 v170 v181 v192 v203 v214 v225 v236 v247 v258 v269 v280 v291), m
	egen fp_la_util9_20 = rowtotal(v160 v171 v182 v193 v204 v215 v226 v237 v248 v259 v270 v281 v292), m
	egen fp_la_util10_20 = rowtotal(v161 v172 v183 v194 v205 v216 v227 v238 v249 v260 v271 v282 v293), m
	egen fp_la_util11_20 = rowtotal(v162 v173 v184 v195 v206 v217 v228 v239 v250 v261 v272 v283 v294), m
	
	keep org* fp* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(fp*), m
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	drop if tag==1 & total==. //no observation 
	drop tag total
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace
	
	
*ANC visits 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_anc_del_cs_pnc_diarr_pneum_sam_util.csv", clear
	drop organisationunitdescription
	rename safemotherhoodprogramantenatalch v9 
	egen anc_util1_20 = rowtotal(v9  v20), m
	egen anc_util2_20 = rowtotal(v10 v21), m
	egen anc_util3_20 = rowtotal(v11 v22), m
	egen anc_util4_20 = rowtotal(v12 v23), m
	egen anc_util5_20 = rowtotal(v13 v24), m
	egen anc_util6_20 = rowtotal(v14 v25), m
	egen anc_util7_20 = rowtotal(v15 v26), m
	egen anc_util8_20 = rowtotal(v16 v27), m
	egen anc_util9_20 = rowtotal(v17 v28), m
	egen anc_util10_20 = rowtotal(v18 v29), m
	egen anc_util11_20 = rowtotal(v19 v30), m

*Facility deliveries 
	rename (safemotherhoodprogramdeliveryser-v41) (del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20	del_util7_20	del_util8_20	del_util9_20	del_util10_20	del_util11_20)
	
*C-section 
	rename safemotherhoodprogramtypeofdeliv v42
	egen cs_util1_20 = rowtotal(v42 v53 v64), m
	egen cs_util2_20 = rowtotal(v43 v54 v65), m
	egen cs_util3_20 = rowtotal(v44 v55 v66), m
	egen cs_util4_20 = rowtotal(v45 v56 v67), m
	egen cs_util5_20 = rowtotal(v46 v57 v68), m
	egen cs_util6_20 = rowtotal(v47 v58 v69), m
	egen cs_util7_20 = rowtotal(v48 v59 v70), m
	egen cs_util8_20 = rowtotal(v49 v60 v71), m
	egen cs_util9_20 = rowtotal(v50 v61 v72), m
	egen cs_util10_20 = rowtotal(v51 v62 v73), m
	egen cs_util11_20 = rowtotal(v52 v63 v74), m
	
*Postnatal care visits 
	rename (safemotherhoodprogram3pncvisitsa-v85) (pnc_util1_20	pnc_util2_20	pnc_util3_20	pnc_util4_20	pnc_util5_20	pnc_util6_20	pnc_util7_20	pnc_util8_20	pnc_util9_20	pnc_util10_20	pnc_util11_20)
	
*Diarrhea 
	rename cbimci259monthsclassificationdia v86
	egen diarr_util1_20 = rowtotal(v86 v97 v108 v119 v130), m
	egen diarr_util2_20 = rowtotal(v87 v98 v109 v120 v131), m
	egen diarr_util3_20 = rowtotal(v88 v99 v110 v121 v132), m
	egen diarr_util4_20 = rowtotal(v89 v100 v111 v122 v133), m
	egen diarr_util5_20 = rowtotal(v90 v101 v112 v123 v134), m
	egen diarr_util6_20 = rowtotal(v91 v102 v113 v124 v135), m
	egen diarr_util7_20 = rowtotal(v92 v103 v114 v125 v136), m
	egen diarr_util8_20 = rowtotal(v93 v104 v115 v126 v137), m
	egen diarr_util9_20 = rowtotal(v94 v105 v116 v127 v138), m
	egen diarr_util10_20 = rowtotal(v95 v106 v117 v128 v139), m
	egen diarr_util11_20 = rowtotal(v96 v107 v118 v129 v140), m
	
*Pneumonia 
	rename (cbimci259monthsclassificationari cbimci259monthsorcclassification) (v141 v152)
	egen pneum_util1_20 = rowtotal(v141 v152), m
	egen pneum_util2_20 = rowtotal(v142 v153), m
	egen pneum_util3_20 = rowtotal(v143 v154), m
	egen pneum_util4_20 = rowtotal(v144 v155), m
	egen pneum_util5_20 = rowtotal(v145 v156), m
	egen pneum_util6_20 = rowtotal(v146 v157), m
	egen pneum_util7_20 = rowtotal(v147 v158), m
	egen pneum_util8_20 = rowtotal(v148 v159), m
	egen pneum_util9_20 = rowtotal(v149 v160), m
	egen pneum_util10_20 = rowtotal(v150 v161), m
	egen pneum_util11_20 = rowtotal(v151 v162), m

*Malnutrition 
	rename (cbimci259monthsclassificationsev-v173) (sam_util1_20	sam_util2_20	sam_util3_20	sam_util4_20	sam_util5_20	sam_util6_20	sam_util7_20	sam_util8_20	sam_util9_20	sam_util10_20	sam_util11_20)
	
	*Total delivery = cs_util + del_util (denominator)
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
	

	keep org* anc* del* cs* diarr* pneum* totaldel* pnc* sam*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(anc* del* cs* diarr* pneum* totaldel*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace

	
	
********************************************************************************
********************************************************************************
*Import raw data: VACCINES

*BCG vaccines 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_bcg_pent_measles_opv3_pneum_qual.csv", clear
	drop organisationunitdescription
	rename (immunizationprogramvaccinetypech-v19) (bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20	bcg_qual7_20	bcg_qual8_20	bcg_qual9_20	bcg_qual10_20	bcg_qual11_20)
	
*Penta3 vaccine 
	rename (immunizationprogramvaccinetypedo-v30) (pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20	pent_qual7_20	pent_qual8_20	pent_qual9_20	pent_qual10_20	pent_qual11_20)
	
*Measles vaccine 
	rename immunizationprogramchildrenimmun v31
	egen measles_qual1_20 = rowtotal(v31 v42), m
	egen measles_qual2_20 = rowtotal(v32 v43), m 
	egen measles_qual3_20 = rowtotal(v33 v44), m 
	egen measles_qual4_20 = rowtotal(v34 v45), m 
	egen measles_qual5_20 = rowtotal(v35 v46), m 
	egen measles_qual6_20 = rowtotal(v36 v47), m 
	egen measles_qual7_20 = rowtotal(v37 v48), m 
	egen measles_qual8_20 = rowtotal(v38 v49), m 
	egen measles_qual9_20 = rowtotal(v39 v50), m 
	egen measles_qual10_20 = rowtotal(v40 v51), m 
	egen measles_qual11_20 = rowtotal(v41 v52), m 
	
*OPV3 vaccines
	rename (v53-v63) (opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20	opv3_qual7_20	opv3_qual8_20	opv3_qual9_20	opv3_qual10_20	opv3_qual11_20)
	
*Pneumococcal vaccines 
	rename (v64-v74) (pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20	pneum_qual11_20)
	
	keep org* bcg* pent* measles* opv3* pneum*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(bcg* pent* measles* opv3* pneum*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace

	
********************************************************************************
********************************************************************************
*Import raw data: OTHER SERVICES

*Outpatient visits 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_opd_er_ipd_util.csv", clear
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v19) (opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20	opd_util9_20	opd_util10_20	opd_util11_20)
	

*ER visits 
	rename clientsreceivedemergencyservices v20
	egen er_util1_20 = rowtotal(v20 v31 v42 v53), m 
	egen er_util2_20 = rowtotal(v21 v32 v43 v54), m 
	egen er_util3_20 = rowtotal(v22 v33 v44 v55), m 
	egen er_util4_20 = rowtotal(v23 v34 v45 v56), m 
	egen er_util5_20 = rowtotal(v24 v35 v46 v57), m 
	egen er_util6_20 = rowtotal(v25 v36 v47 v58), m 
	egen er_util7_20 = rowtotal(v26 v37 v48 v59), m 
	egen er_util8_20 = rowtotal(v27 v38 v49 v60), m 
	egen er_util9_20 = rowtotal(v28 v39 v50 v61), m 
	egen er_util10_20 = rowtotal(v29 v40 v51 v62), m 
	egen er_util11_20 = rowtotal(v30 v41 v52 v63), m 
	
*Inpatient admissions 
	rename (v64-v74) (ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	ipd_util10_20	ipd_util11_20)
	
	keep org* opd* er* ipd* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(opd* er* ipd* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace
	
********************************************************************************
********************************************************************************
*Import raw data: QUALITY 

*TB cases detected 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_tbdetect_hivdiag_qual.csv", clear
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v19) (tbdetect_qual1_20	tbdetect_qual2_20	tbdetect_qual3_20	tbdetect_qual4_20	tbdetect_qual5_20	tbdetect_qual6_20	tbdetect_qual7_20	tbdetect_qual8_20	tbdetect_qual9_20	tbdetect_qual10_20	tbdetect_qual11_20)

*HIV cases diagnosed 
	egen hivdiag_qual1_20 = rowtotal(v20 v31), m 
	egen hivdiag_qual2_20 = rowtotal(v21 v32), m 
	egen hivdiag_qual3_20 = rowtotal(v22 v33), m 
	egen hivdiag_qual4_20 = rowtotal(v23 v34), m 
	egen hivdiag_qual5_20 = rowtotal(v24 v35), m 
	egen hivdiag_qual6_20 = rowtotal(v25 v36), m 
	egen hivdiag_qual7_20 = rowtotal(v26 v37), m 
	egen hivdiag_qual8_20 = rowtotal(v27 v38), m 
	egen hivdiag_qual9_20 = rowtotal(v28 v39), m 
	egen hivdiag_qual10_20 = rowtotal(v29 v40), m 
	egen hivdiag_qual11_20 = rowtotal(v30 v41), m 
	
	keep org* tbdetect* hivdiag*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(tbdetect* hivdiag* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace

********************************************************************************
********************************************************************************
*Import raw data: MORTALITY 

*Stillbirth rate
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_sb_mort_mat_mort_peri_mort_num.csv", clear
	drop organisationunitdescription
	rename safemotherhoodprogramnumberofsti v9 
	egen sb_mort_num1_20 = rowtotal(v9 v20), m 
	egen sb_mort_num2_20 = rowtotal(v10 v21), m 
	egen sb_mort_num3_20 = rowtotal(v11 v22), m 
	egen sb_mort_num4_20 = rowtotal(v12 v23), m 
	egen sb_mort_num5_20 = rowtotal(v13 v24), m 
	egen sb_mort_num6_20 = rowtotal(v14 v25), m 
	egen sb_mort_num7_20 = rowtotal(v15 v26), m 
	egen sb_mort_num8_20 = rowtotal(v16 v27), m 
	egen sb_mort_num9_20 = rowtotal(v17 v28), m 
	egen sb_mort_num10_20 = rowtotal(v18 v29), m 
	egen sb_mort_num11_20 = rowtotal(v19 v30), m 
	
*Maternal mortality 
	rename safemotherhoodprogrammaternaldea v31 
	egen mat_mort_num1_20 = rowtotal(v31 v42 v53), m 
	egen mat_mort_num2_20 = rowtotal(v32 v43 v54), m 
	egen mat_mort_num3_20 = rowtotal(v33 v44 v55), m 
	egen mat_mort_num4_20 = rowtotal(v34 v45 v56), m 
	egen mat_mort_num5_20 = rowtotal(v35 v46 v57), m 
	egen mat_mort_num6_20 = rowtotal(v36 v47 v58), m 
	egen mat_mort_num7_20 = rowtotal(v37 v48 v59), m 
	egen mat_mort_num8_20 = rowtotal(v38 v49 v60), m 
	egen mat_mort_num9_20 = rowtotal(v39 v50 v61), m 
	egen mat_mort_num10_20 = rowtotal(v40 v51 v62), m 
	egen mat_mort_num11_20 = rowtotal(v41 v52 v63), m 
	
*Livebirths 
	rename safemotherhoodprogramdeliveryout v64
	egen live_births1_20 = rowtotal(v64 v75 v86), m 
	egen live_births2_20 = rowtotal(v65 v76 v87), m 
	egen live_births3_20 = rowtotal(v66 v77 v88), m 
	egen live_births4_20 = rowtotal(v67 v78 v89), m 
	egen live_births5_20 = rowtotal(v68 v79 v90), m 
	egen live_births6_20 = rowtotal(v69 v80 v91), m 
	egen live_births7_20 = rowtotal(v70 v81 v92), m 
	egen live_births8_20 = rowtotal(v71 v82 v93), m 
	egen live_births9_20 = rowtotal(v72 v83 v94), m 
	egen live_births10_20 = rowtotal(v73 v84 v95), m 
	egen live_births11_20 = rowtotal(v74 v85 v96), m 

	keep org* sb_mort* mat_mort* live_births*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(sb_mort* mat_mort* live_births* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	
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

*Neonatal deaths 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_neonatal_mort_num.csv", clear
	drop organisationunitdescription
	rename (totallateneonataldeathsinthehosp totalearlyneonataldeathsinthehos safemotherhoodprogrammaternaldea) (v9 v20 v31)
	egen neo_mort_num1_20 = rowtotal(v9  v20 v31)
	egen neo_mort_num2_20 = rowtotal(v10 v21 v32)
	egen neo_mort_num3_20 = rowtotal(v11 v22 v33)
	egen neo_mort_num4_20 = rowtotal(v12 v23 v34)
	egen neo_mort_num5_20 = rowtotal(v13 v24 v35)
	egen neo_mort_num6_20 = rowtotal(v14 v25 v36)
	egen neo_mort_num7_20 = rowtotal(v15 v26 v37)
	egen neo_mort_num8_20 = rowtotal(v16 v27 v38)
	egen neo_mort_num9_20 = rowtotal(v17 v28 v39)
	egen neo_mort_num10_20 = rowtotal(v18 v29 v40)
	egen neo_mort_num11_20 = rowtotal(v19 v30 v41)
	
	keep org* neo*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(neo* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace


*Inpatient mortality 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-Nov_palika_ipd_mort_num.csv", clear
	drop organisationunitdescription
	rename (inpatientdeathsin48hoursofadmiss inpatientdeathsinâ48hoursofadmis) (v9 v119)
	egen ipd_mort_num1_20 = rowtotal( v9 v20 v31 v42 v53 v64 v75 v86 v97 v108 v119 v130 v141 v152 v163 v174 v185 v196 v207 v218), m 
	egen ipd_mort_num2_20 = rowtotal(v10 v21 v32 v43 v54 v65 v76 v87 v98 v109 v120 v131	v142 v153 v164 v175 v186 v197 v208 v219), m 
	egen ipd_mort_num3_20 = rowtotal(v11 v22 v33 v44 v55 v66 v77 v88  v99 v110 v121 v132 v143 v154 v165 v176 v187 v198 v209 v220), m 
	egen ipd_mort_num4_20 = rowtotal(v12 v23 v34 v45 v56 v67 v78 v89 v100 v111 v122 v133 v144 v155 v166 v177 v188 v199 v210 v221), m 
	egen ipd_mort_num5_20 = rowtotal(v13 v24 v35 v46 v57 v68 v79 v90 v101 v112 v123 v134 v145 v156 v167 v178 v189 v200 v211 v222), m 
	egen ipd_mort_num6_20 = rowtotal(v14 v25 v36 v47 v58 v69 v80 v91 v102 v113 v124 v135 v146 v157 v168 v179 v190 v201 v212 v223), m 
	egen ipd_mort_num7_20 = rowtotal(v15 v26 v37 v48 v59 v70 v81 v92 v103 v114 v125 v136 v147 v158 v169 v180 v191 v202 v213 v224), m 
	egen ipd_mort_num8_20 = rowtotal(v16 v27 v38 v49 v60 v71 v82 v93 v104 v115 v126 v137 v148 v159 v170 v181 v192 v203 v214 v225), m 
	egen ipd_mort_num9_20 = rowtotal(v17 v28 v39 v50 v61 v72 v83 v94 v105 v116 v127 v138 v149 v160 v171 v182 v193 v204 v215 v226), m 
    egen ipd_mort_num10_20 = rowtotal(v18 v29 v40 v51 v62 v73 v84 v95 v106 v117 v128 v139 v150 v161 v172 v183 v194 v205 v216 v227), m 
    egen ipd_mort_num11_20 = rowtotal(v19 v30 v41 v52 v63 v74 v85 v96 v107 v118 v129 v140 v151 v162 v173 v184 v195 v206 v217 v228), m 
 
	keep org* ipd_mort_num*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(ipd_mort* ), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	replace orgunitlevel3 = "10507 Diprung Rural Municipality" if orgunitlevel3 =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace orgunitlevel4 = "60904 Dhorchaur Rural Municipality" if orgunitlevel4 =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace orgunitlevel4 = "20611 Boudhimai Municipality" if orgunitlevel4 =="20611 Baudhimai Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta"
	drop _merge orgunitlevel4	
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace
	
* Fix issue with Provinces
	order org*
	drop  organisationunitid organisationunitcode 		 
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"
	
	save "$user/$data/Data for analysis/Nepal_palika_Jan20-Nov20_WIDE.dta", replace	

********************************************************************************
*END OF coding for Jan20-Nov20 data 
********************************************************************************	

*Merge with Jan19-Dec19 data 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 organisationunitname using "$user/$data/Data for analysis/Nepal_palika_Jan19-Dec19_WIDE.dta"
	drop _merge

	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_WIDE.dta", replace



	
	
	
	
	
	






















