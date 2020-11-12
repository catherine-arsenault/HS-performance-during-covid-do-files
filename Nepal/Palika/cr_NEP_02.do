* HS performance during Covid
* Sep 10, 2020 
* Nepal, January 2019 - June 2020
* Palika level data analysis 
clear all
set more off
********************************************************************************
********************************************************************************
*Import raw data: VOLUMES OF SERVICES
	*Family planning 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_fp_util.csv", clear
	drop organisationunitdescription
	rename (familyplanningprogrampermanentfp familyplanningprogrampostpartumf ///
			familyplanningprogramtemporaryfp) (v9 v69 v105)  
	//24 indicators 
	egen fp_util1_19 = rowtotal(v9 v21 v33 v45 v57 v69 v81 v93 v105 v117 v129 v141 v153 v165 v177 v189 v201 v213 ///
	  							v225 v237 v249 v261 v273 v285), m
	egen fp_util2_19 = rowtotal(v10 v22 v34 v46 v58 v70 v82 v94 v106 v118 v130 v142 v154 v166 v178 v190 v202 v214 	///
								v226 v238 v250 v262 v274 v286), m
	egen fp_util3_19 = rowtotal(v11 v23 v35 v47 v59 v71 v83 v95 v107 v119 v131 v143 v155 v167 v179 v191 v203 v215 ///
							    v227 v239 v251 v263 v275 v287), m
	egen fp_util4_19 = rowtotal(v12 v24 v36 v48 v60 v72 v84 v96 v108 v120 v132 v144 v156 v168 v180 v192 v204 v216 	///
								 v228 v240 v252 v264 v276 v288), m
	egen fp_util5_19 = rowtotal(v13 v25 v37 v49 v61 v73 v85 v97 v109 v121 v133 v145 v157 v169 v181 v193 v205 v217 	///
								 v229 v241 v253 v265 v277 v289), m
	egen fp_util6_19 = rowtotal(v14 v26 v38 v50 v62 v74 v86 v98 v110 v122 v134 v146 v158 v170 v182 v194 v206 v218 	///
								 v230 v242 v254 v266 v278 v290), m
	egen fp_util7_19 = rowtotal(v15 v27 v39 v51 v63 v75 v87 v99 v111 v123 v135 v147 v159 v171 v183 v195 v207 v219 	///
								v231 v243 v255 v267 v279 v291), m
	egen fp_util8_19 = rowtotal(v16 v28 v40 v52 v64 v76 v88 v100 v112 v124 v136 v148 v160 v172 v184 v196 v208 v220 ///
								v232 v244 v256 v268 v280 v292), m
	egen fp_util9_19 = rowtotal(v17 v29 v41 v53 v65 v77 v89 v101 v113 v125 v137 v149 v161 v173 v185 v197 v209 v221 	///
								v233 v245 v257 v269 v281 v293), m
	egen fp_util10_19 = rowtotal(v18 v30 v42 v54 v66 v78 v90 v102 v114 v126 v138 v150 v162 v174 v186 v198 v210 v222 ///
									v234 v246 v258 v270 v282 v294), m
	egen fp_util11_19 = rowtotal(v19 v31 v43 v55 v67 v79 v91 v103 v115 v127 v139 v151 v163 v175 v187 v199 v211 v223 ///
								v235 v247 v259 v271 v283 v295), m
	egen fp_util12_19 = rowtotal(v20 v32 v44 v56 v68 v80 v92 v104 v116 v128 v140 v152 v164 v176 v188 v200 v212 v224 ///
								v236 v248 v260 v272 v284 v296), m
	keep org* fp* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(fp*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*Family planning 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_fp_util.csv", clear
	drop organisationunitdescription
	rename (familyplanningprogrampermanentfp familyplanningprogrampostpartumf familyplanningprogramtemporaryfp) (v9 			v39 v57)
	egen fp_util1_20 = rowtotal(v9 v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93 v99 v105 v111 v117 v123 									v129 v135 v141 v147), m
	egen fp_util2_20 = rowtotal(v10 v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 v82 v88 v94 v100 v106 v112 v118 v124 									v130 v136 v142 v148), m
	egen fp_util3_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125 									v131 v137 v143 v149), m
	egen fp_util4_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v107 v108 v114 v120 v126 									v132 v138 v144 v150), m
	egen fp_util5_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v108 v109 v115 v121 v127 									v133 v139 v145 v151), m
	egen fp_util6_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v109 v110 v116 v122 v128 									v134 v140 v146 v152), m
	keep org* fp* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(fp*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* ANC 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_anc_util.csv", clear
	drop organisationunitdescription
	egen anc_util1_19 = rowtotal(safemotherhoodprogramantenatalch v21), m
	egen anc_util2_19 =	rowtotal( v10 v22), m
	egen anc_util3_19	=rowtotal( v11 v23), m
	egen anc_util4_19	=rowtotal( v12 v24), m
	egen anc_util5_19	=rowtotal(v13 v25), m
	egen anc_util6_19=	rowtotal(v14  v26), m
	egen anc_util7_19	=rowtotal( v15 v27 ), m
	egen anc_util8_19=	rowtotal(v16  v28), m
	egen anc_util9_19=	rowtotal(v17 v29), m
	egen anc_util10_19	=rowtotal(v18 v30 ), m
	egen anc_util11_19	=rowtotal(v19 v31 ), m
	egen anc_util12_19 =rowtotal(v20  v32), m
	keep org* anc* 
	duplicates tag org* , gen(tag) //no duplicates
	egen total= rowtotal(anc*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1  org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* Deliveries 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_del_util.csv", clear 
	drop organisationunitdescription
	rename (safemotherhoodprogramdeliveryser-v20) ///
	(del_util1_19 del_util2_19	del_util3_19	del_util4_19	del_util5_19  del_util6_19 ///
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19 del_util12_19)
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid ///
	organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(del*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1  orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid ///
				organisationunitname organisationunitcode using ///
				"$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
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

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* Live births 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_live_births",  clear 
	drop organisationunitdescription
	egen live_births1_19 = rowtotal(safemotherhoodprogramdeliveryout v21 v33), m 
	egen live_births2_19 = rowtotal(v10 v22 v34 ), m 
	egen live_births3_19 = rowtotal(v11 v23 v35), m 
	egen live_births4_19 = rowtotal(v12 v24 v36 ), m 
	egen live_births5_19 = rowtotal(v13 v25 v37 ), m 
	egen live_births6_19 = rowtotal(v14 v26 v38 ), m 
	egen live_births7_19 = rowtotal(v15 v27 v39 ), m 
	egen live_births8_19 = rowtotal(v16 v28 v40 ), m 
	egen live_births9_19 = rowtotal(v17 v29 v41 ), m 
	egen live_births10_19 = rowtotal(v18 v30 v42 ), m 
	egen live_births11_19 = rowtotal(v19 v31 v43 ), m 
	egen live_births12_19 = rowtotal(v20 v32 v44 ), m 	
	keep org* live* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(live_*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace

	* Live births 2019
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* C-sections 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_cs_util.csv", clear 
	drop organisationunitdescription
	egen cs_util1_19 =  rowtotal(safemotherhoodprogramtypeofdeliv v21 v33 ), m
	egen cs_util2_19 =	rowtotal(v10 v22 v34), m
	egen cs_util3_19 =	rowtotal(v11 v23 v35), m
	egen cs_util4_19 =	rowtotal(v12 v24 v36), m
	egen cs_util5_19=	rowtotal(v13 v25 v37), m
	egen cs_util6_19=	rowtotal(v14 v26 v38), m
	egen cs_util7_19=	rowtotal(v15 v27 v39), m
	egen cs_util8_19=	rowtotal(v16 v28 v40), m
	egen cs_util9_19=	rowtotal(v17 v29 v41), m 
	egen cs_util10_19=	rowtotal(v18 v30 v42), m
	egen cs_util11_19=	rowtotal(v19 v31 v43 ), m
	egen cs_util12_19=	rowtotal(v20 v32 v44 ), m
	keep org* cs*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(cs_*), m
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
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
* 	Perinatal mortality
gen peri_mort_num1_19 = totaldel1_19 - live_births1_19
gen peri_mort_num2_19 = totaldel2_19 -live_births2_19 
gen peri_mort_num3_19 = totaldel3_19 -live_births3_19 
gen peri_mort_num4_19 = totaldel4_19 -live_births4_19 
gen peri_mort_num5_19 = totaldel5_19 -live_births5_19 
gen peri_mort_num6_19 = totaldel6_19 -live_births6_19 
gen peri_mort_num7_19 = totaldel7_19 -live_births7_19 
gen peri_mort_num8_19 = totaldel8_19 -live_births8_19 
gen peri_mort_num9_19 = totaldel9_19 -live_births9_19 
gen peri_mort_num10_19 = totaldel10_19 -live_births10_19 
gen peri_mort_num11_19 = totaldel11_19 -live_births11_19 
gen peri_mort_num12_19 = totaldel12_19 -live_births12_19  
gen peri_mort_num1_20 = totaldel1_20 - live_births1_20
gen peri_mort_num2_20 = totaldel2_20 -live_births2_20 
gen peri_mort_num3_20 = totaldel3_20 -live_births3_20 
gen peri_mort_num4_20 = totaldel4_20 -live_births4_20 
gen peri_mort_num5_20 = totaldel5_20 -live_births5_20 
gen peri_mort_num6_20 = totaldel6_20 -live_births6_20
forval i =1/12 {
	replace peri_mort_num`i'_19 = 0 if peri_mort_num`i'_19 <0 & peri_mort_num`i'_19!=.
}	
forval i =1/6 {
	replace peri_mort_num`i'_20 = 0 if peri_mort_num`i'_20 <0 & peri_mort_num`i'_20!=.
}
drop live_births*  
save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* PNC 2019
import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_pnc_util.csv", clear 
	drop organisationunitdescription
	rename (safemotherhoodprogram3pncvisitsa-v20) (pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19 ///
	pnc_util5_19 pnc_util6_19 pnc_util7_19 pnc_util8_19	pnc_util9_19 pnc_util10_19	pnc_util11_19 pnc_util12_19)
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pnc*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* Child diarrhea 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_diarr_util.csv", clear 
	drop organisationunitdescription
	rename cbimci259monthsclassificationdia v9
	egen diarr_util1_19 = rowtotal(v9 v21 v33 v45 v57), m
	egen diarr_util2_19 = rowtotal(v10 v22 v34 v46 v58), m
	egen diarr_util3_19	= rowtotal(v11 v23 v35 v47 v59), m
	egen diarr_util4_19	= rowtotal(v12 v24 v36 v48 v60), m
	egen diarr_util5_19	= rowtotal(v13 v25 v37 v49 v61), m
	egen diarr_util6_19 = rowtotal(v14 v26 v38 v50 v62), m
	egen diarr_util7_19	= rowtotal(v15 v27 v39 v51 v63), m
	egen diarr_util8_19 = rowtotal(v16 v28 v40 v52 v64), m
	egen diarr_util9_19 = rowtotal(v17 v29 v41 v53 v65), m
	egen diarr_util10_19 = rowtotal(v18 v30 v42 v54 v66), m
	egen diarr_util11_19 = rowtotal(v19 v31 v43 v55 v67), m
	egen diarr_util12_19 = rowtotal(v20 v32 v44 v56 v68), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==. //no observation
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
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


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Child pneumonia 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_pneum_util.csv", clear
	drop organisationunitdescription
	rename cbimci259monthsclassificationari v9
	egen pneum_util1_19 = rowtotal(v9 v21)
	egen pneum_util2_19 = rowtotal(v10 v22)
	egen pneum_util3_19 = rowtotal(v11 v23)
	egen pneum_util4_19 = rowtotal(v12 v24)
	egen pneum_util5_19 = rowtotal(v13 v25)
	egen pneum_util6_19 = rowtotal(v14 v26)
	egen pneum_util7_19 = rowtotal(v15 v27)
	egen pneum_util8_19 = rowtotal(v16 v28)
	egen pneum_util9_19 = rowtotal(v17 v29)
	egen pneum_util10_19 = rowtotal(v18 v30)
	egen pneum_util11_19 = rowtotal(v19 v31)
	egen pneum_util12_19 = rowtotal(v20 v32)
	keep org* pneum* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* Child malnutrition 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_sam_util.csv", clear 
	drop organisationunitdescription
	rename (cbimci259monthsclassificationsev-v20) (sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19 ///
	sam_util5_19 sam_util6_19 sam_util7_19	sam_util8_19 sam_util9_19 sam_util10_19	sam_util11_19 sam_util12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Outpatient visit 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_opd_util.csv", clear 
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v20) (opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19 ///
	opd_util5_19 opd_util6_19 opd_util7_19	opd_util8_19 opd_util9_19 opd_util10_19	opd_util11_19 opd_util12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(opd*), m
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

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Inpatient admissions 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_ipd_util.csv", clear 
	drop organisationunitdescription
	rename (disaggregationbysexcasteethnicit-v20) (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19 ///
	ipd_util5_19 ipd_util6_19 ipd_util7_19	ipd_util8_19 ipd_util9_19 ipd_util10_19	ipd_util11_19 ipd_util12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
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

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Emergency room visits 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_er_util.csv", clear 
	drop organisationunitdescription
	rename clientsreceivedemergencyservices v9 
	egen er_util1_19 	= rowtotal( v9 v21 v33 v45), m
	egen er_util2_19 	= rowtotal(v10 v22 v34 v46), m
	egen er_util3_19	= rowtotal(v11 v23 v35 v47), m
	egen er_util4_19	= rowtotal(v12 v24 v36 v48), m
	egen er_util5_19	= rowtotal(v13 v25 v37 v49), m
	egen er_util6_19	= rowtotal(v14 v26 v38 v50), m
	egen er_util7_19	= rowtotal(v15 v27 v39 v51), m
	egen er_util8_19 	= rowtotal(v16 v28 v40 v52), m
	egen er_util9_19 	= rowtotal(v17 v29 v41 v53), m
	egen er_util10_19 	= rowtotal(v18 v30 v42 v54), m
	egen er_util11_19 	= rowtotal(v19 v31 v43 v55), m
	egen er_util12_19 	= rowtotal(v20 v32 v44 v56), m
	keep org* er* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(er*), m
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

	
********************************************************************************	
********************************************************************************	
*Import raw data: QUALITY
	*TB cases detected 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_tbdetect_qual.csv", clear 
	drop organisationunitdescription
	rename  (disaggregationbysexcasteethnicit-v20) ///
	(tbdetect_qual1_19 	tbdetect_qual2_19 tbdetect_qual3_19 tbdetect_qual4_19 tbdetect_qual5_19 ///
	tbdetect_qual6_19 tbdetect_qual7_19 tbdetect_qual8_19 tbdetect_qual9_19 tbdetect_qual10_19 ///
	tbdetect_qual11_19 tbdetect_qual12_19 )
	duplicates tag org*, gen(tag)
	egen total= rowtotal(tb*), m
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


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*HIV cases diagnosed 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_hivdiag_qual.csv", clear 
	drop organisationunitdescription
	egen hivdiag_qual1_19 	= rowtotal( disaggregationbysexcasteethnicit v21), m
	egen hivdiag_qual2_19 	= rowtotal(v10 v22 ), m
	egen hivdiag_qual3_19	= rowtotal(v11 v23 ), m
	egen hivdiag_qual4_19	= rowtotal(v12 v24 ), m
	egen hivdiag_qual5_19	= rowtotal(v13 v25 ), m
	egen hivdiag_qual6_19	= rowtotal(v14 v26 ), m
	egen hivdiag_qual7_19	= rowtotal(v15 v27 ), m
	egen hivdiag_qual8_19 	= rowtotal(v16 v28 ), m
	egen hivdiag_qual9_19 	= rowtotal(v17 v29 ), m
	egen hivdiag_qual10_19 	= rowtotal(v18 v30 ), m
	egen hivdiag_qual11_19 	= rowtotal(v19 v31 ), m
	egen hivdiag_qual12_19 	= rowtotal(v20 v32 ), m
	keep org* hiv* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(hiv*), m
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

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Pentavalent 3rd dose 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_pent_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v32
	rename (v33-v44) ///
	(pent_qual1_19 	pent_qual2_19 	pent_qual3_19	pent_qual4_19	pent_qual5_19 ///
	 pent_qual6_19	pent_qual7_19	pent_qual8_19 	 pent_qual9_19 	pent_qual10_19 ///
	 pent_qual11_19 pent_qual12_19)
	keep org* pent* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pent*), m
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*BCG vaccine 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_bcg_qual.csv", clear 
	drop organisationunitdescription
	rename  (immunizationprogramvaccinetypech v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20) ///
	(bcg_qual1_19 bcg_qual2_19 bcg_qual3_19 bcg_qual4_19 bcg_qual5_19 bcg_qual6_19 bcg_qual7_19 bcg_qual8_19 bcg_qual9_19 				bcg_qual10_19 bcg_qual11_19 bcg_qual12_19 )
	duplicates tag org*, gen(tag)
	egen total= rowtotal(bcg*), m
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
	
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Measles vaccine 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_measles_qual.csv", clear 
	drop organisationunitdescription
	egen measles_qual1_19 	= rowtotal( immunizationprogramchildrenimmun v21), m
	egen measles_qual2_19 	= rowtotal(v10 v22 ), m
	egen measles_qual3_19	= rowtotal(v11 v23 ), m
	egen measles_qual4_19	= rowtotal(v12 v24 ), m
	egen measles_qual5_19	= rowtotal(v13 v25 ), m
	egen measles_qual6_19	= rowtotal(v14 v26 ), m
	egen measles_qual7_19	= rowtotal(v15 v27 ), m
	egen measles_qual8_19 	= rowtotal(v16 v28 ), m
	egen measles_qual9_19 	= rowtotal(v17 v29 ), m
	egen measles_qual10_19 	= rowtotal(v18 v30 ), m
	egen measles_qual11_19 	= rowtotal(v19 v31 ), m
	egen measles_qual12_19 	= rowtotal(v20 v32 ), m
	keep org* measles* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(measles*), m
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*OPV3 vaccine 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_opv3_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v20 v33-v44
	rename (v21-v32) ///
	(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	///
	 opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	///
	 opv3_qual11_19	opv3_qual12_19) 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(opv3*), m
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Pneumococcal vaccine 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_pneum_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v20 v21-v32
	rename (v33-v44) ///
	(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19 ///
	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	///
	pneum_qual11_19	pneum_qual12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pneum*), m
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

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Rotavirus 2019 
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_rota_qual.csv", clear 
	drop organisationunitdescription immunizationprogramvaccinetypedo-v20
	rename (v21-v32) ///
	(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19 ///
	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19 ///
	rota_qual11_19	rota_qual12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(rota*), m
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
	
********************************************************************************	
********************************************************************************	
*Import raw data: DEATHS
	* Maternal mortality 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_mat_mort.csv", clear
	replace orgunitlevel2= "5 Province 5" if orgunitlevel2=="5 Lumbini Province"
	drop organisationunitdescription
	egen mat_mort_num1_19 = rowtotal( safemotherhoodprogrammaternaldea v21 v33 ), m
	egen mat_mort_num2_19 	= rowtotal(v10 v22 v34), m
	egen mat_mort_num3_19	= rowtotal(v11 v23 v35), m
	egen mat_mort_num4_19	= rowtotal(v12 v24 v36), m
	egen mat_mort_num5_19	= rowtotal(v13 v25 v37), m
	egen mat_mort_num6_19	= rowtotal(v14 v26 v38), m
	egen mat_mort_num7_19	= rowtotal(v15 v27 v39), m
	egen mat_mort_num8_19 	= rowtotal(v16 v28 v40), m
	egen mat_mort_num9_19 	= rowtotal(v17 v29 v41), m
	egen mat_mort_num10_19 	= rowtotal(v18 v30 v42), m
	egen mat_mort_num11_19 	= rowtotal(v19 v31 v43), m
	egen mat_mort_num12_19 	= rowtotal(v20 v32 v44 ), m
	keep org* mat* 
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 					organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(mat*), m
	drop if tag==1 & total==. 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 				organisationunitname organisationunitcode using ///
	"$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	* Maternal mortality 2020 
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_mat_mort", clear
	replace orgunitlevel2= "5 Province 5" if orgunitlevel2=="5 Lumbini Province"
	drop organisationunitdescription
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Stillbirths 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_sb_mort.csv", clear
	drop organisationunitdescription
	drop fchvprogramsmhfphomedeliverytota-v20 //home delivery was dropped 
	egen sb_mort_num1_19 = rowtotal(safemotherhoodprogramnumberofsti v33), m
	egen sb_mort_num2_19 = rowtotal(v22 v34), m
	egen sb_mort_num3_19 = rowtotal(v23 v35), m
	egen sb_mort_num4_19 = rowtotal(v24 v36), m
	egen sb_mort_num5_19 = rowtotal(v25 v37), m
	egen sb_mort_num6_19 = rowtotal(v26 v38), m
	egen sb_mort_num7_19 = rowtotal(v27 v39), m
	egen sb_mort_num8_19 = rowtotal(v28 v40), m
	egen sb_mort_num9_19 = rowtotal(v29 v41), m  
	egen sb_mort_num10_19 = rowtotal(v30 v42), m
	egen sb_mort_num11_19 = rowtotal(v31 v43), m
	egen sb_mort_num12_19 = rowtotal(v32 v44), m
	keep org* sb* 
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 					organisationunitname organisationunitcode, gen(tag)
	egen total= rowtotal(sb*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitid 				organisationunitname organisationunitcode using ///
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
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Inpatient deaths 2019
	import delimited "$user/$data/Raw data/Palika/Nepal_2019_Jan-Dec_palika_ipd_mort.csv", clear
	drop organisationunitdescription
	rename (inpatientdeathsin48hoursofadmiss inpatientdeathsinâ48hoursofadmis) (v9 v129)  
	//20 indicators 
	egen ipd_mort_num1_19 = rowtotal(v9 v21 v33 v45 v57 v69 v81 v93 v105 v117 v129 v141 v153 v165 v177 v189 v201 v213 								v225 v237 ), m
	egen ipd_mort_num2_19 = rowtotal(v10 v22 v34 v46 v58 v70 v82 v94 v106 v118 v130 v142 v154 v166 v178 v190 v202 v214 								 v226 v238 ), m
	egen ipd_mort_num3_19 = rowtotal(v11 v23 v35 v47 v59 v71 v83 v95 v107 v119 v131 v143 v155 v167 v179 v191 v203 v215 								 v227 v239 ), m
	egen ipd_mort_num4_19 = rowtotal(v12 v24 v36 v48 v60 v72 v84 v96 v108 v120 v132 v144 v156 v168 v180 v192 v204 v216 								 v228 v240 ), m
	egen ipd_mort_num5_19 = rowtotal(v13 v25 v37 v49 v61 v73 v85 v97 v109 v121 v133 v145 v157 v169 v181 v193 v205 v217 								 v229 v241 ), m
	egen ipd_mort_num6_19 = rowtotal(v14 v26 v38 v50 v62 v74 v86 v98 v110 v122 v134 v146 v158 v170 v182 v194 v206 v218 								 v230 v242 ), m
	egen ipd_mort_num7_19 = rowtotal(v15 v27 v39 v51 v63 v75 v87 v99 v111 v123 v135 v147 v159 v171 v183 v195 v207 v219 								 v231 v243 ), m
	egen ipd_mort_num8_19 = rowtotal(v16 v28 v40 v52 v64 v76 v88 v100 v112 v124 v136 v148 v160 v172 v184 v196 v208 v220 								 v232 v244 ), m
	egen ipd_mort_num9_19 = rowtotal(v17 v29 v41 v53 v65 v77 v89 v101 v113 v125 v137 v149 v161 v173 v185 v197 v209 v221 								 v233 v245 ), m
	egen ipd_mort_num10_19 = rowtotal(v18 v30 v42 v54 v66 v78 v90 v102 v114 v126 v138 v150 v162 v174 v186 v198 v210 v222 								v234 v246 ), m
	egen ipd_mort_num11_19 = rowtotal(v19 v31 v43 v55 v67 v79 v91 v103 v115 v127 v139 v151 v163 v175 v187 v199 v211 v223 								v235 v247 ), m
	egen ipd_mort_num12_19 = rowtotal(v20 v32 v44 v56 v68 v80 v92 v104 v116 v128 v140 v152 v164 v176 v188 v200 v212 v224 								v236 v248 ), m
	keep org* ipd* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_WIDE.dta", replace
	
	*Inpatient deaths 2020
	import delimited "$user/$data/Raw data/Palika/Nepal_2020_Jan-June_palika_ipd_mort.csv", clear
	drop organisationunitdescription
	rename (inpatientdeathsin48hoursofadmiss inpatientdeathsinâ48hoursofadmis) (v9 v69)
	egen ipd_mort_num1_20 = rowtotal(v9 v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93 v99 v105 v111 v117 v123), m
	egen ipd_mort_num2_20 = rowtotal(v10 v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 ///
								 v82 v88 v94 v100 v106 v112 v118 v124) , m
	egen ipd_mort_num3_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125), m
	egen ipd_mort_num4_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v107 v108 v114 v120 v126), m
	egen ipd_mort_num5_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v108 v109 v115 v121 v127), m
	egen ipd_mort_num6_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v109 v110 v116 v122 v128), m
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
	
********************************************************************************
*END	
********************************************************************************	
	
