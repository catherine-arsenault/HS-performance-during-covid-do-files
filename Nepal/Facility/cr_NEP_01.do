* HS performance during Covid
* Nepal, January 2019 - June 2020
* Facility-level data analysis
* Created by Byron Cohen & MK Kim 

* HS performance during Covid
* Sep 10, 2020 
* Nepal, January 2019 - June 2020
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
*global user "/Users/byroncohen/Cohen Dropbox/Byron Cohen/Dropbox (HSPH)"
global data "/HMIS Data for Health System Performance Covid (Nepal)"

********************************************************************************
*Import raw data: VOLUMES OF RMNCH SERVICES
********************************************************************************
	*Family planning 2019 
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_fp_util.csv", clear
	*drop organisationunitdescription
	rename (familyplanningprogrampermanentfp familyplanningprogrampostpartumf familyplanningprogramtemporaryfp) (v11 v71 v107)  
	//24 indicators 
	* Magh 2075	Falgun 2075	Chaitra 2075 Baisakh 2076 Jestha 2076 Asadh 2076	
	* Shrawan2076	Bhadra 2076	Ashwin 2076	Kartik 2076	Mangshir 2076	Poush 2076
	egen fp_util1_19 = rowtotal(v11 v23 v35 v47 v59 v71 v83 v95 v107 v119 v131 v143 v155 v167 v179 v191 v203 v215 v227 v239 v251 v263 v275 v287), m
	egen fp_util2_19 = rowtotal(v12 v24 v36 v48 v60 v72 v84 v96 v108 v120 v132 v144 v156 v168 v180 v192 v204 v216 v228 v240 v252 v264 v276 v288), m
	egen fp_util3_19 = rowtotal(v13 v25 v37 v49 v61 v73 v85 v97 v109 v121 v133 v145 v157 v169 v181 v193 v205 v217 v229 v241 v253 v265 v277 v289), m
	egen fp_util4_19 = rowtotal(v14 v26 v38 v50 v62 v74 v86 v98 v110 v122 v134 v146 v158 v170 v182 v194 v206 v218 v230 v242 v254 v266 v278 v290), m
	egen fp_util5_19 = rowtotal(v15 v27 v39 v51 v63 v75 v87 v99 v111 v123 v135 v147 v159 v171 v183 v195 v207 v219 v231 v243 v255 v267 v279 v291), m
	egen fp_util6_19 = rowtotal(v16 v28 v40 v52 v64 v76 v88 v100 v112 v124 v136 v148 v160 v172 v184 v196 v208 v220 v232 v244 v256 v268 v280 v292), m
	egen fp_util7_19 = rowtotal(v17 v29 v41 v53 v65 v77 v89 v101 v113 v125 v137 v149 v161 v173 v185 v197 v209 v221 v233 v245 v257 v269 v281 v293), m
	egen fp_util8_19 = rowtotal(v18 v30 v42 v54 v66 v78 v90 v102 v114 v126 v138 v150 v162 v174 v186 v198 v210 v222 v234 v246 v258 v270 v282 v294), m
	egen fp_util9_19 = rowtotal(v19 v31 v43 v55 v67 v79 v91 v103 v115 v127 v139 v151 v163 v175 v187 v199 v211 v223 v235 v247 v259 v271 v283 v295), m
	egen fp_util10_19 = rowtotal(v20 v32 v44 v56 v68 v80 v92 v104 v116 v128 v140 v152 v164 v176 v188 v200 v212 v224 v236 v248 v260 v272 v284 v296), m
	egen fp_util11_19 = rowtotal(v21 v33 v45 v57 v69 v81 v93 v105 v117 v129 v141 v153 v165 v177 v189 v201 v213 v225 v237 v249 v261 v273 v285 v297), m
	egen fp_util12_19 = rowtotal(v22 v34 v46 v58 v70 v82 v94 v106 v118 v130 v142 v154 v166 v178 v190 v202 v214 v226 v238 v250 v262 v274 v286 v298), m
	keep org* fp* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(fp*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*Family planning 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_fp_util.csv", clear
	*drop organisationunitdescription
	rename (familyplanningprogrampermanentfp familyplanningprogrampostpartumf familyplanningprogramtemporaryfp) (v11 v41 v59)
	egen fp_util1_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125 v131 v137 v143 v149), m
	egen fp_util2_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v102 v108 v114 v120 v126 v132 v138 v144 v150), m
	egen fp_util3_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v103 v109 v115 v121 v127 v133 v139 v145 v151), m
	egen fp_util4_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v104 v110 v116 v122 v128 v134 v140 v146 v152), m
	egen fp_util5_20 = rowtotal(v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93 v99 v105 v111 v117 v123 v129 v135 v141 v147 v153), m
	egen fp_util6_20 = rowtotal(v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 v82 v88 v94 v100 v106 v112 v118 v124 v130 v136 v142 v148 v154), m
	keep org* fp* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(fp*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	* ANC 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_anc_util", encoding(UTF-8) clear 
	egen anc_util1_19  =rowtotal(safemotherhoodprogramantenatalch v23), m
	egen anc_util2_19  =rowtotal(v12  v24), m
	egen anc_util3_19	=rowtotal(v13 v25), m
	egen anc_util4_19	=rowtotal(v14 v26), m
	egen anc_util5_19	=rowtotal(v15 v27), m
	egen anc_util6_19	=rowtotal(v16 v28), m
	egen anc_util7_19	=rowtotal(v17 v29 ), m
	egen anc_util8_19=	rowtotal(v18  v30), m
	egen anc_util9_19=	rowtotal(v19  v31), m
	egen anc_util10_19	=rowtotal(v20 v32 ), m
	egen anc_util11_19	=rowtotal(v21 v33 ), m
	egen anc_util12_19 =rowtotal(v22  v34), m
	keep org* anc* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(anc*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* ANC 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan_June_facility_anc_util.csv", encoding(UTF-8) clear 
	egen anc_util1_20 = rowtotal(safemotherhoodprogramantenatalch v17), m
	egen anc_util2_20 =	rowtotal(v12 v18 ), m
	egen anc_util3_20	=rowtotal(v13 v19), m
	egen anc_util4_20	=rowtotal(v14  v20 ), m
	egen anc_util5_20	=rowtotal(v15 v21), m
	egen anc_util6_20=	rowtotal(v16 v22 ), m
	keep org* anc* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(anc*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* Facility Deliveries 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_del_util", encoding(UTF-8) clear 
	*drop organisationunitdescription organisationunitid organisationunitcode
	rename (safemotherhoodprogramdeliveryser-v22) ///
	(del_util1_19 del_util2_19	del_util3_19	del_util4_19	del_util5_19  del_util6_19 ///
	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19 del_util12_19)
	keep org* del* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(del*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* Facility Deliveries 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_del_util", encoding(UTF-8) clear 
	*drop organisationunitdescription organisationunitid organisationunitcode
	rename (safemotherhoodprogramdeliveryser-v16) (del_util1_20 del_util2_20 del_util3_20 del_util4_20 ///
	del_util5_20 del_util6_20)
	keep org* del* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(del*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* Live births 2019 
	import delimited "$user/$data/Raw data/Nepal_2019_Jan_Dec_facility_live_births", encoding(UTF-8) clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	egen live_births1_19 = rowtotal(magh2075safemotherhoodprogramdel v12 v13), m 
	egen live_births2_19 = rowtotal(falgun2075safemotherhoodprogramd v15 v16 ), m 
	egen live_births3_19 = rowtotal(chaitra2075safemotherhoodprogram v18 v19 ), m 
	egen live_births4_19 = rowtotal(baishak2076safemotherhoodprogram v21 v22 ), m 
	egen live_births5_19 = rowtotal(jestha2076safemotherhoodprogramd v24 v25 ), m 
	egen live_births6_19 = rowtotal(asar2076safemotherhoodprogramdel v27 v28 ), m 
	egen live_births7_19 = rowtotal(shrawan2076safemotherhoodprogram v30 v31 ), m 
	egen live_births8_19 = rowtotal(bhadra2076safemotherhoodprogramd v33 v34 ), m 
	egen live_births9_19 = rowtotal(ashwin2076safemotherhoodprogramd v36 v37 ), m 
	egen live_births10_19 = rowtotal(kartik2076safemotherhoodprogramd v39 v40 ), m 
	egen live_births11_19 = rowtotal(mangsir2076safemotherhoodprogram v42 v43 ), m 
	egen live_births12_19 = rowtotal(poush2076safemotherhoodprogramde v45 v46 ), m 	
	keep org* live* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(live_*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* Live births 2020 Jan-Jun
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_live_births", clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	egen live_births1_20 = rowtotal(magh2076safemotherhoodprogramdel v12 v13 ), m
	egen live_births2_20 = rowtotal(falgun2076safemotherhoodprogramd v15 v16 ), m
	egen live_births3_20 = rowtotal(chaitra2076safemotherhoodprogram v18 v19 ), m
	egen live_births4_20 = rowtotal(baishak2077safemotherhoodprogram v21 v22 ), m
	egen live_births5_20 = rowtotal(jestha2077safemotherhoodprogramd v24 v25 ), m
	egen live_births6_20 = rowtotal(asar2077safemotherhoodprogramdel v27 v28 ), m
	keep org* live* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(live_*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* C-sections 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_cs_util.csv", encoding(UTF-8) clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename safemotherhoodprogramtypeofdeliv v11 
	egen cs_util1_19 =  rowtotal(v11 v23 v35), m
	egen cs_util2_19 =	rowtotal( v12 v24 v36 ), m
	egen cs_util3_19 =	rowtotal(v13 v25 v37 ), m
	egen cs_util4_19 =	rowtotal(v14 v26 v38), m
	egen cs_util5_19=	rowtotal(v15 v27 v39), m
	egen cs_util6_19=	rowtotal(v16 v28 v40), m
	egen cs_util7_19=	rowtotal(v17 v29 v41 ), m
	egen cs_util8_19=	rowtotal(v18 v30 v42 ), m
	egen cs_util10_19=	rowtotal(v19 v31 v43), m
	egen cs_util9_19=	rowtotal(v20 v32 v44  ), m
	egen cs_util11_19=	rowtotal(v21 v33 v45 ), m
	egen cs_util12_19=	rowtotal(v22 v34 v46 ), m
	keep org* cs*
	duplicates tag org* , gen(tag)
	egen total= rowtotal(cs_*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* C-sections 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_cs_util", encoding(UTF-8) clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	egen cs_util1_20 = rowtotal(safemotherhoodprogramtypeofdeliv v17 v23), m
	egen cs_util2_20 =	rowtotal(v12 v18 v24 ), m
	egen cs_util3_20	=rowtotal(v13 v19 v25), m
	egen cs_util4_20	=rowtotal(v14 v20 v26 ), m
	egen cs_util5_20	=rowtotal(v15 v21 v27), m
	egen cs_util6_20=	rowtotal(v16 v22 v28  ), m
	keep org* cs* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(cs*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
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
	
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
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
	
save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	* PNC 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_pnc_util.csv", encoding(UTF-8) clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename magh2075safemotherhoodprogram3pn pnc_util1_19
	rename falgun2075safemotherhoodprogram3 pnc_util2_19 
	rename chaitra2075safemotherhoodprogram pnc_util3_19 
	rename baishak2076safemotherhoodprogram pnc_util4_19 
	rename jestha2076safemotherhoodprogram3 pnc_util5_19 
	rename asar2076safemotherhoodprogram3pn pnc_util6_19 
	rename shrawan2076safemotherhoodprogram pnc_util7_19 
	rename bhadra2076safemotherhoodprogram3 pnc_util8_19 
	rename ashwin2076safemotherhoodprogram3 pnc_util9_19 
	rename kartik2076safemotherhoodprogram3 pnc_util10_19 
	rename mangsir2076safemotherhoodprogram pnc_util11_19 
	rename poush2076safemotherhoodprogram3p pnc_util12_19 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pnc*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* PNC 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_pnc_util", encoding(UTF-8) clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename(magh2076safemotherhoodprogram3pn-asar2077safemotherhoodprogram3pn) (pnc_util1_20 pnc_util2_20 ///
			pnc_util3_20 pnc_util4_20 pnc_util5_20 pnc_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pnc*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace 
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Child Diarrhea 2019 
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_diarr_util.csv", clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename cbimci259monthsclassificationdia v11
	egen diarr_util1_19 = rowtotal( v11 v23 v35 v47 v59), m
	egen diarr_util2_19 = rowtotal( v12 v24 v36 v48 v60), m
	egen diarr_util3_19 = rowtotal( v13 v25 v37 v49 v61), m
	egen diarr_util4_19 = rowtotal( v14 v26 v38 v50 v62), m
	egen diarr_util5_19 = rowtotal( v15 v27 v39 v51 v63), m
	egen diarr_util6_19 = rowtotal( v16 v28 v40 v52 v64), m
	egen diarr_util7_19 = rowtotal( v17 v29 v41 v53 v65), m
	egen diarr_util8_19 = rowtotal( v18 v30 v42 v54 v66), m
	egen diarr_util9_19 = rowtotal( v19 v31 v43 v55 v67), m
	egen diarr_util10_19 = rowtotal( v20 v32 v44 v56 v68), m
	egen diarr_util11_19 = rowtotal( v21 v33 v45 v57 v69), m
	egen diarr_util12_19 = rowtotal( v22 v34 v46 v58 v70), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==. //no observation
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace 
	
	* Child diarrhea 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_diarr_util",  clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename cbimci259monthsclassificationdia v11
	egen diarr_util1_20 = rowtotal(v11 v17 v23 v29 v35), m 
	egen diarr_util2_20 = rowtotal(v12 v18 v24 v30 v36), m 
	egen diarr_util3_20	= rowtotal(v13 v19 v25 v31 v37), m 
	egen diarr_util4_20	= rowtotal(v14 v20 v26 v32 v38), m 
	egen diarr_util5_20	= rowtotal(v15 v21 v27 v33 v39), m 
	egen diarr_util6_20=  rowtotal(v16 v22 v28 v34 v40), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace 
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Child Pneumonia 2019 
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_pneum_util.csv", clear
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename cbimci259monthsclassificationari v11
	egen pneum_util1_19 = rowtotal(v11 v23)
	egen pneum_util2_19 = rowtotal(v12 v24)
	egen pneum_util3_19 = rowtotal(v13 v25)
	egen pneum_util4_19 = rowtotal(v14 v26)
	egen pneum_util5_19 = rowtotal(v15 v27)
	egen pneum_util6_19 = rowtotal(v16 v28)
	egen pneum_util7_19 = rowtotal(v17 v29)
	egen pneum_util8_19 = rowtotal(v18 v30)
	egen pneum_util9_19 = rowtotal(v19 v31)
	egen pneum_util10_19 = rowtotal(v20 v32)
	egen pneum_util11_19 = rowtotal(v21 v33)
	egen pneum_util12_19 = rowtotal(v22 v34)
	keep org* pneum* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace 
	
	*Child Pneumonia 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_pneum_util.csv", clear
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename cbimci259monthsclassificationari v11
	egen pneum_util1_20 = rowtotal(v11 v17)
	egen pneum_util2_20 = rowtotal(v12 v18)
	egen pneum_util3_20 = rowtotal(v13 v19)
	egen pneum_util4_20 = rowtotal(v14 v20)
	egen pneum_util5_20 = rowtotal(v15 v21)
	egen pneum_util6_20 = rowtotal(v16 v22)
	keep org* pneum* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Child malnutrition 2019 
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_sam_util.csv", clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename (cbimci259monthsclassificationsev-v22) (sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19 ///
	sam_util5_19 sam_util6_19 sam_util7_19	sam_util8_19 sam_util9_19 sam_util10_19	sam_util11_19 sam_util12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*Child malnutrition 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_sam_util", clear 
	*drop  organisationunitdescription organisationunitid organisationunitcode
	rename (cbimci259monthsclassificationsev-v16 ) (sam_util1_20 sam_util2_20 sam_util3_20	sam_util4_20 ///
	sam_util5_20 sam_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
		
********************************************************************************
*Import raw data: VACCINES
********************************************************************************
	* BCG 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_bcg_qual.csv", encoding(UTF-8) clear 
	egen bcg_qual1_19 = rowtotal(immunizationprogramvaccinetypech), m
	egen bcg_qual2_19 =	rowtotal(v12), m
	egen bcg_qual3_19 = rowtotal(v13), m
	egen bcg_qual4_19 = rowtotal(v14), m
	egen bcg_qual5_19 = rowtotal(v15), m
	egen bcg_qual6_19 = rowtotal(v16), m
	egen bcg_qual7_19 = rowtotal(v17 ), m
	egen bcg_qual8_19 = rowtotal(v18), m
	egen bcg_qual9_19 = rowtotal(v19), m
	egen bcg_qual10_19 = rowtotal(v20 ), m
	egen bcg_qual11_19 = rowtotal(v21 ), m
	egen bcg_qual12_19 = rowtotal(v22), m
	keep org* bcg* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no bcg data 
	egen total= rowtotal(bcg*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	* BCG 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_bcg_qual.csv", encoding(UTF-8) clear 
	egen bcg_qual1_20 = rowtotal(immunizationprogramvaccinetypech), m
	egen bcg_qual2_20 =	rowtotal(v12 ), m
	egen bcg_qual3_20	=rowtotal(v13), m
	egen bcg_qual4_20	=rowtotal(v14), m
	egen bcg_qual5_20	=rowtotal(v15), m
	egen bcg_qual6_20=	rowtotal(v16 ), m
	keep org* bcg* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(bcg*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	* Penta3 Vaccines 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_pent_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo - v34 
	rename (v35-v46) ///
	(pent_qual1_19 	pent_qual2_19 	pent_qual3_19	pent_qual4_19	pent_qual5_19 ///
	 pent_qual6_19	pent_qual7_19	pent_qual8_19 	 pent_qual9_19 	pent_qual10_19 ///
	 pent_qual11_19 pent_qual12_19)
	keep org* pent* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no bcg data 
	egen total= rowtotal(pent*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*Penta3 Vaccines 2020		
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_pent_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v22
	rename (v23-v28) (pent_qual1_20 pent_qual2_20  pent_qual3_20 pent_qual4_20 ///
	pent_qual5_20 pent_qual6_20)
	keep org* pent* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pent*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Measles Vaccines 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_measles_qual.csv", encoding(UTF-8) clear 
	egen measles_qual1_19 = rowtotal( immunizationprogramchildrenimmun v23), m
	egen measles_qual2_19 =	rowtotal( v12 v24 ), m
	egen measles_qual3_19 = rowtotal( v13 v25 ), m
	egen measles_qual4_19 = rowtotal( v14 v26 ), m
	egen measles_qual5_19 = rowtotal(v15 v27 ), m
	egen measles_qual6_19 = rowtotal(v16 v28 ), m
	egen measles_qual7_19 = rowtotal( v17 v29  ), m
	egen measles_qual8_19 = rowtotal(v18 v30 ), m
	egen measles_qual9_19 = rowtotal(v19 v31 ), m
	egen measles_qual10_19 = rowtotal(v20 v32 ), m
	egen measles_qual11_19 = rowtotal(v21 v33  ), m
	egen measles_qual12_19 = rowtotal(v22 v34 ), m
	keep org* measles* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no measles data 
	egen total= rowtotal(measles*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*Measles Vaccines 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_measles_qual.csv", encoding(UTF-8) clear 
	egen measles_qual1_20 = rowtotal(immunizationprogramchildrenimmun v17 ), m
	egen measles_qual2_20 = rowtotal(v12 v18 ), m
	egen measles_qual3_20 = rowtotal(v13 v19 ), m
	egen measles_qual4_20 = rowtotal(v14 v20 ), m
	egen measles_qual5_20 = rowtotal(v15 v21 ), m
	egen measles_qual6_20 = rowtotal(v16 v22 ), m
	keep org* measles* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(measles*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*OPV3 Vaccines 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_opv3_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v22 v35-v46
	rename (v23-v34) ///
	(opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	///
	 opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	///
	 opv3_qual11_19	opv3_qual12_19) 
	duplicates tag org*, gen(tag)
	keep org* opv3* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no opv3 data 
	egen total= rowtotal(opv3*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*OPV3 Vaccines 2020 Jan-Jun
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_opv3_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v16 v23-v28
	rename(v17-v22) (opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20 ///
	opv3_qual5_20 opv3_qual6_20)
	keep org* opv3* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(opv3*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Pneumococcal Vaccines 2019
import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_pneum_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v34
	rename (v35-v46) ///
	(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19 ///
	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	///
	pneum_qual11_19	pneum_qual12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*Pneumococcal Vaccines Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_pneum_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v22
	rename (v23-v28) (pneum_qual1_20 pneum_qual2_20	pneum_qual3_20 pneum_qual4_20 ///
	pneum_qual5_20 pneum_qual6_20)
	keep org* pneum* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(pneum*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
********************************************************************************
*Import raw data: VOLUME OF OTHER SERVICES
********************************************************************************
	
	*Outpatient Visits 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_opd_util.csv", encoding(UTF-8) clear 
	*drop organisationunitdescription
	egen opd_util1_19 = rowtotal(disaggregationbysexcasteethnicit ), m
	egen opd_util2_19 = rowtotal(v12), m
	egen opd_util3_19 = rowtotal(v13), m
	egen opd_util4_19 = rowtotal(v14), m
	egen opd_util5_19 = rowtotal(v15), m
	egen opd_util6_19 = rowtotal(v16), m
	egen opd_util7_19 = rowtotal(v17), m
	egen opd_util8_19 = rowtotal(v18), m
	egen opd_util9_19 = rowtotal(v19), m
	egen opd_util10_19 = rowtotal(v20), m
	egen opd_util11_19 = rowtotal(v21), m
	egen opd_util12_19 = rowtotal(v22), m
	keep org* opd* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(opd*), m
	drop if tag==1 & total==.  //0 observation was dropped
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*Outpatient Visits Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_opd_util.csv", encoding(UTF-8) clear 
	*drop organisationunitdescription
	rename disaggregationbysexcasteethnicit v11
	egen opd_util1_20 = rowtotal(v11 ), m
	egen opd_util2_20 = rowtotal(v12), m
	egen opd_util3_20 = rowtotal(v13 ), m
	egen opd_util4_20 = rowtotal(v14 ), m
	egen opd_util5_20 = rowtotal(v15 ), m
	egen opd_util6_20 = rowtotal(v16 ), m
	keep org* opd* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(opd*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*ER Visits 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_er_util.csv", encoding(UTF-8) clear 
	rename clientsreceivedemergencyservices v11
	egen er_util1_19 = rowtotal( v11 v23 v35 v47), m
	egen er_util2_19 = rowtotal( v12 v24 v36 v48), m
	egen er_util3_19 = rowtotal( v13 v25 v37 v49), m
	egen er_util4_19 = rowtotal( v14 v26 v38 v50), m
	egen er_util5_19 = rowtotal(v15 v27 v39 v51), m
	egen er_util6_19 = rowtotal(v16 v28 v40 v52), m
	egen er_util7_19 = rowtotal( v17 v29  v41 v53), m
	egen er_util8_19 = rowtotal(v18 v30 v42 v54), m
	egen er_util9_19 = rowtotal(v19 v31 v43 v55), m
	egen er_util10_19 = rowtotal(v20 v32 v44 v56), m
	egen er_util11_19 = rowtotal(v21 v33  v45 v57), m
	egen er_util12_19 = rowtotal(v22 v34 v46 v58), m
	keep org* er* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no er data 
	egen total= rowtotal(er*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*ER Visits Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_er_util.csv", encoding(UTF-8) clear 
	*drop organisationunitdescription
	rename clientsreceivedemergencyservices v11
	egen er_util1_20 = rowtotal(v11 v17 v23 v29 ), m
	egen er_util2_20 = rowtotal(v12 v18 v24 v30), m
	egen er_util3_20 = rowtotal(v13 v19 v25 v31 ), m
	egen er_util4_20 = rowtotal(v14 v20 v26 v32 ), m
	egen er_util5_20 = rowtotal(v15 v21 v27 v33 ), m
	egen er_util6_20 = rowtotal(v16 v22 v28 v34 ), m
	keep org* er* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(er*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Inpatient Admissions 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_ipd_util.csv", encoding(UTF-8) clear 
	*drop organisationunitdescription
	egen ipd_util1_19 = rowtotal( disaggregationbysexcasteethnicit), m
	egen ipd_util2_19 = rowtotal(v12), m
	egen ipd_util3_19 = rowtotal(v13), m
	egen ipd_util4_19 = rowtotal(v14), m
	egen ipd_util5_19 = rowtotal(v15), m
	egen ipd_util6_19 = rowtotal(v16), m
	egen ipd_util7_19 = rowtotal(v17), m
	egen ipd_util8_19 = rowtotal(v18), m
	egen ipd_util9_19 = rowtotal(v19), m
	egen ipd_util10_19 = rowtotal(v20), m
	egen ipd_util11_19 = rowtotal(v21), m
	egen ipd_util12_19 = rowtotal(v22), m
	keep org* ipd* 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*Inpatient Admissions Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_ipd_util.csv", encoding(UTF-8) clear 
	*drop organisationunitdescription
	egen ipd_util1_20 = rowtotal(disaggregationbysexcasteethnicit ), m
	egen ipd_util2_20 = rowtotal(v12), m
	egen ipd_util3_20 = rowtotal(v13 ), m
	egen ipd_util4_20 = rowtotal(v14 ), m
	egen ipd_util5_20 = rowtotal(v15 ), m
	egen ipd_util6_20 = rowtotal(v16 ), m
	keep org* ipd* 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

********************************************************************************
*Import raw data: QUALITY OF SERVICES
********************************************************************************
	*TB cases detected 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_tbdetect_qual.csv", encoding(UTF-8) clear 
	rename disaggregationbysexcasteethnicit v11
	egen tbdetect_qual1_19 = rowtotal( v11), m
	egen tbdetect_qual2_19 = rowtotal( v12), m
	egen tbdetect_qual3_19 = rowtotal( v13), m
	egen tbdetect_qual4_19 = rowtotal( v14), m
	egen tbdetect_qual5_19 = rowtotal(v15), m
	egen tbdetect_qual6_19 = rowtotal(v16), m
	egen tbdetect_qual7_19 = rowtotal( v17), m
	egen tbdetect_qual8_19 = rowtotal(v18), m
	egen tbdetect_qual9_19 = rowtotal(v19), m
	egen tbdetect_qual10_19 = rowtotal(v20), m
	egen tbdetect_qual11_19 = rowtotal(v21), m
	egen tbdetect_qual12_19 = rowtotal(v22), m
	keep org* tbdetect* 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*TB cases detected Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_tbdetect_qual.csv", encoding(UTF-8) clear 
	rename disaggregationbysexcasteethnicit v11
	egen tbdetect_qual1_20 = rowtotal(v11 ), m
	egen tbdetect_qual2_20 = rowtotal(v12), m
	egen tbdetect_qual3_20 = rowtotal(v13 ), m
	egen tbdetect_qual4_20 = rowtotal(v14 ), m
	egen tbdetect_qual5_20 = rowtotal(v15 ), m
	egen tbdetect_qual6_20 = rowtotal(v16 ), m
	keep org* tbdetect* 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*HIV cases diagnosed 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_hivdiag_qual.csv", encoding(UTF-8) clear 
	rename disaggregationbysexcasteethnicit v11
	egen hivdiag_qual1_19 = rowtotal( v11 v23), m
	egen hivdiag_qual2_19 = rowtotal( v12 v24), m
	egen hivdiag_qual3_19 = rowtotal( v13 v25), m
	egen hivdiag_qual4_19 = rowtotal( v14 v26), m
	egen hivdiag_qual5_19 = rowtotal(v15 v27), m
	egen hivdiag_qual6_19 = rowtotal(v16 v28), m
	egen hivdiag_qual7_19 = rowtotal( v17 v29), m
	egen hivdiag_qual8_19 = rowtotal(v18 v30), m
	egen hivdiag_qual9_19 = rowtotal(v19 v31), m
	egen hivdiag_qual10_19 = rowtotal(v20 v32), m
	egen hivdiag_qual11_19 = rowtotal(v21 v33), m
	egen hivdiag_qual12_19 = rowtotal(v22 v34), m
	keep org* hivdiag* 
	duplicates tag org* , gen(tag) 
	egen total= rowtotal(hivdiag*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*HIV cases diagnosed Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_hivdiag_qual.csv", encoding(UTF-8) clear
	rename disaggregationbysexcasteethnicit v11
	egen hivdiag_qual1_20 = rowtotal(v11 v17), m
	egen hivdiag_qual2_20 = rowtotal(v12 v18), m
	egen hivdiag_qual3_20 = rowtotal(v13 v19), m
	egen hivdiag_qual4_20 = rowtotal(v14 v20), m
	egen hivdiag_qual5_20 = rowtotal(v15 v21), m
	egen hivdiag_qual6_20 = rowtotal(v16 v22), m
	keep org* hivdiag* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(hivdiag*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
********************************************************************************
*Import raw data: INSTITUTIONAL MORTALITY
********************************************************************************
	* Maternal mortality 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_mat_mort.csv", encoding(UTF-8)clear
	egen mat_mort_num1_19 = rowtotal( magh2075safemotherhoodprogrammat v12 v13 ), m
	egen mat_mort_num2_19 = rowtotal(falgun2075safemotherhoodprogramm v15 v16), m
	egen mat_mort_num3_19	= rowtotal(chaitra2075safemotherhoodprogram v18 v19), m
	egen mat_mort_num4_19	= rowtotal(baishak2076safemotherhoodprogram v21 v22), m
	egen mat_mort_num5_19	= rowtotal(jestha2076safemotherhoodprogramm v24 v25), m
	egen mat_mort_num6_19 = rowtotal(asar2076safemotherhoodprogrammat v27 v28  ), m
	egen mat_mort_num7_19	= rowtotal(shrawan2076safemotherhoodprogram v30 v31 ), m
	egen mat_mort_num8_19 = rowtotal(bhadra2076safemotherhoodprogramm v33 v34 ), m
	egen mat_mort_num9_19 = rowtotal( ashwin2076safemotherhoodprogramm v36 v37), m
	egen mat_mort_num10_19 = rowtotal(kartik2076safemotherhoodprogramm v39 v40), m
	egen mat_mort_num11_19 = rowtotal(mangsir2076safemotherhoodprogram v42 v43), m
	egen mat_mort_num12_19 = rowtotal( poush2076safemotherhoodprogramma v45 v46 ), m
	keep org* mat* 
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* Maternal mortality 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_mat_mort", encoding(UTF-8) clear 
	*drop organisationunitdescription
	egen mat_mort_num1_20 = rowtotal(magh2076safemotherhoodprogrammat v12 v13), m // magh
	egen mat_mort_num2_20 = rowtotal(falgun2076safemotherhoodprogramm v15 v16), m // falgun
	egen mat_mort_num3_20 = rowtotal(chaitra2076safemotherhoodprogram v18 v19 ), m // chaitra
	egen mat_mort_num4_20 = rowtotal( baishak2077safemotherhoodprogram v21 v22), m // baisakh
	egen mat_mort_num5_20 = rowtotal(jestha2077safemotherhoodprogramm v24 v25), m // jestha
	egen mat_mort_num6_20 = rowtotal(asar2077safemotherhoodprogrammat v27 v28), m // asar
	keep org* mat* 
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname, gen(tag)
	egen total= rowtotal(mat*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Stillbirths 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_sb_mort.csv", encoding(UTF-8)clear
	*drop organisationunitdescription
	drop fchvprogramsmhfphomedeliverytota-v22
	egen sb_mort_num1_19 = rowtotal(safemotherhoodprogramnumberofsti v35), m
	egen sb_mort_num2_19 = rowtotal(v24 v36), m
	egen sb_mort_num3_19	= rowtotal(v25 v37  ), m
	egen sb_mort_num4_19	= rowtotal(v26 v38 ), m
	egen sb_mort_num5_19	= rowtotal(v27 v39 ), m
	egen sb_mort_num6_19 	= rowtotal(v28 v40  ), m
	egen sb_mort_num7_19	= rowtotal(v29 v41 ), m
	egen sb_mort_num8_19 = rowtotal(v30 v42 ), m
	egen sb_mort_num10_19 = rowtotal(v31 v43 ), m
	egen sb_mort_num9_19 = rowtotal(v32 v44 ), m
	egen sb_mort_num11_19 = rowtotal(v33 v45 ), m
	egen sb_mort_num12_19 = rowtotal( v34 v46 ), m
	keep org* sb* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sb*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*Stillbirths 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_sb_mort", encoding(UTF-8) clear 
	*drop organisationunitdescription
	drop fchvprogramsmhfphomedeliverytota-v16
	egen sb_mort_num1_20 = rowtotal( safemotherhoodprogramnumberofsti v23), m
	egen sb_mort_num2_20 = rowtotal(v18 v24), m
	egen sb_mort_num3_20	= rowtotal(v19 v25 ), m
	egen sb_mort_num4_20	= rowtotal(v20 v26 ), m
	egen sb_mort_num5_20	= rowtotal(v21 v27 ), m
	egen sb_mort_num6_20 	= rowtotal(v22 v28 ), m
	keep org* sb* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sb*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	*Inpatient deaths 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_ipd_mort.csv", clear
	*drop organisationunitdescription
	rename inpatientdeathsin48hoursofadmiss v11 
	rename inpatientdeathsinâ48hoursofadmis v131
	egen ipd_mort_num1_19 = rowtotal(v11 v23 v35 v47 v59 v71 v83 v95 v107 v119 v131 v143 v155 v167 v179 v191 v203 v215 v227 v239 ), m
	egen ipd_mort_num2_19 = rowtotal(v12 v24 v36 v48 v60 v72 v84 v96 v108 v120 v132 v144 v156 v168 v180 v192 v204 v216 v228 v240 ), m
	egen ipd_mort_num3_19 = rowtotal(v13 v25 v37 v49 v61 v73 v85 v97 v109 v121 v133 v145 v157 v169 v181 v193 v205 v217 v229 v241 ), m
	egen ipd_mort_num4_19 = rowtotal(v14 v26 v38 v50 v62 v74 v86 v98 v110 v122 v134 v146 v158 v170 v182 v194 v206 v218 v230 v242 ), m
	egen ipd_mort_num5_19 = rowtotal(v15 v27 v39 v51 v63 v75 v87 v99 v111 v123 v135 v147 v159 v171 v183 v195 v207 v219 v231 v243 ), m
	egen ipd_mort_num6_19 = rowtotal(v16 v28 v40 v52 v64 v76 v88 v100 v112 v124 v136 v148 v160 v172 v184 v196 v208 v220 v232 v244 ), m
	egen ipd_mort_num7_19 = rowtotal(v17 v29 v41 v53 v65 v77 v89 v101 v113 v125 v137 v149 v161 v173 v185 v197 v209 v221 v233 v245 ), m
	egen ipd_mort_num8_19 = rowtotal(v18 v30 v42 v54 v66 v78 v90 v102 v114 v126 v138 v150 v162 v174 v186 v198 v210 v222 v234 v246 ), m
	egen ipd_mort_num9_19 = rowtotal(v19 v31 v43 v55 v67 v79 v91 v103 v115 v127 v139 v151 v163 v175 v187 v199 v211 v223 v235 v247 ), m
	egen ipd_mort_num10_19 = rowtotal(v20 v32 v44 v56 v68 v80 v92 v104 v116 v128 v140 v152 v164 v176 v188 v200 v212 v224 v236 v248), m
	egen ipd_mort_num11_19 = rowtotal(v21 v33 v45 v57 v69 v81 v93 v105 v117 v129 v141 v153 v165 v177 v189 v201 v213 v225 v237 v249 ), m
	egen ipd_mort_num12_19 = rowtotal(v22 v34 v46 v58 v70 v82 v94 v106 v118 v130 v142 v154 v166 v178 v190 v202 v214 v226 v238 v250 ), m
	keep org* ipd* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	*Inpatient deaths 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_ipd_mort.csv", clear
	*drop organisationunitdescription
	rename (inpatientdeathsin48hoursofadmiss inpatientdeathsinâ48hoursofadmis) (v11 v71)
	egen ipd_mort_num1_20 = rowtotal(v11 v17 v23 v29 v35 v41 v47 v53 v59 v65 v71 v77 v83 v89 v95 v101 v107 v113 v119 v125 ), m
	egen ipd_mort_num2_20 = rowtotal(v12 v18 v24 v30 v36 v42 v48 v54 v60 v66 v72 v78 v84 v90 v96 v102 v108 v114 v120 v126 ), m
	egen ipd_mort_num3_20 = rowtotal(v13 v19 v25 v31 v37 v43 v49 v55 v61 v67 v73 v79 v85 v91 v97 v103 v109 v115 v121 v127 ), m
	egen ipd_mort_num4_20 = rowtotal(v14 v20 v26 v32 v38 v44 v50 v56 v62 v68 v74 v80 v86 v92 v98 v104 v110 v116 v122 v128 ), m
	egen ipd_mort_num5_20 = rowtotal(v15 v21 v27 v33 v39 v45 v51 v57 v63 v69 v75 v81 v87 v93 v99 v105 v111 v117 v123 v129 ), m
	egen ipd_mort_num6_20 = rowtotal(v16 v22 v28 v34 v40 v46 v52 v58 v64 v70 v76 v82 v88 v94 v100 v106 v112 v118 v124 v130 ), m
	keep org* ipd* 
	duplicates tag org*, gen(tag)
	egen total= rowtotal(ipd*), m
	drop if tag==1 & total==. //no observation 
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace


******************************************************************
* Fix issue with Province 1 
	order org* 
	encode organisationunitdescription, gen(orgdescr)
	drop organisationunitdescription
	replace orgunitlevel4= orgunitlevel3 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"

	duplicates tag org*, gen(tag)
	drop if tag 
	// 2 duplicate facilities, reported no data
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
/********************************************************************************
*END	
********************************************************************************	
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	*Rotavirus Vaccines 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_rota_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v22
	rename (v23-v34) ///
	(rota_qual1_19	rota_qual2_19	rota_qual3_19	rota_qual4_19	rota_qual5_19 ///
	rota_qual6_19	rota_qual7_19	rota_qual8_19	rota_qual9_19	rota_qual10_19 ///
	rota_qual11_19	rota_qual12_19)
	keep org* rota* 
	duplicates tag org* , gen(tag) // there are X duplicate facilities, drop those with no rota data 
	egen total= rowtotal(rota*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace

	*Rotavirus Vaccines Jan-Jun 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_rota_qual.csv", encoding(UTF-8) clear 
	drop immunizationprogramvaccinetypedo-v16
	rename(v17-v22) ///
	(rota_qual1_20	rota_qual2_20	rota_qual3_20	rota_qual4_20	rota_qual5_20 ///
	rota_qual6_20)
	keep org* rota* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(rota*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 orgunitlevel6 organisationunitid organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace









	
	
	
	
	/* WRONG INDICATORS DOWNLOADED
	* Child diarrhea 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_diarr_util.csv", encoding(UTF-8)clear 
	egen diarr_util1_19 = rowtotal( cbimci259monthsclassificationdia v20 v32 v44), m
	egen diarr_util2_19 = rowtotal( v9 v21 v33 v45), m
	egen diarr_util3_19	= rowtotal(v10 v22 v34 v46), m
	egen diarr_util4_19	= rowtotal(v11 v23 v35 v47), m
	egen diarr_util5_19	= rowtotal(v12 v24 v36 v48 ), m
	egen diarr_util6_19 = rowtotal(v13 v25 v37 v49 ), m
	egen diarr_util7_19	= rowtotal(v14 v26 v38 v50 ), m
	egen diarr_util8_19 = rowtotal(v15 v27 v39 v51 ), m
	egen diarr_util10_19 = rowtotal(v16 v28 v40 v52 ), m
	egen diarr_util9_19 = rowtotal(v17 v29 v41 v53), m
	egen diarr_util11_19 = rowtotal(v18 v30 v42 v54), m
	egen diarr_util12_19 = rowtotal(v19 v31 v43 v55 ), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	* Child diarrhea 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_diarr_util", encoding(UTF-8) clear 
	egen diarr_util1_20 = rowtotal( cbimci259monthsclassificationdia v14 v20 v26), m // Magh
	egen diarr_util2_20 = rowtotal(v10 v16 v22 v28), m // Falgun
	egen diarr_util3_20	= rowtotal( v9 v15 v21 v27), m  // Chaitra
	egen diarr_util4_20	= rowtotal(v11 v17 v23 v29 ), m // Baisak
	egen diarr_util5_20	= rowtotal(v12 v18 v24 v30 ), m 
	egen diarr_util6_20=  rowtotal(v13 v19 v25 v31 ), m
	keep org* diarr* 
	duplicates tag org* , gen(tag)
	egen total= rowtotal(diarr*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	* Child malnutrition 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_sam_util.csv", encoding(UTF-8)clear 
	rename (cbimci259monthsclassificationsev-v19) (sam_util1_19	sam_util2_19	sam_util3_19	sam_util4_19 ///
	sam_util5_19 sam_util6_19 sam_util7_19	sam_util8_19 sam_util9_19 sam_util10_19	sam_util11_19 sam_util12_19)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	* Child malnutrition 2020 
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_sam_util", encoding(UTF-8) clear 
	rename (cbimci259monthsclassificationsev-v13 ) (sam_util1_20	sam_util2_20 sam_util3_20	sam_util4_20 ///
	sam_util5_20 sam_util6_20)
	duplicates tag org*, gen(tag)
	egen total= rowtotal(sam*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	
	* Newborn mortality 2019
	import delimited "$user/$data/Raw data/Nepal_2019_Jan-Dec_facility_new_mort.csv", encoding(UTF-8)clear
	rename (fchvprogramdeath28daysmagh2075-fchvprogramdeath28daysbhadra2076 ///
	fchvprogramdeath28dayskartik2076 fchvprogramdeath28daysashwin2076 fchvprogramdeath28daysmangsir207 ///
	fchvprogramdeath28dayspoush2076) (newborn_mort1_19	newborn_mort2_19 newborn_mort3_19 ///
	newborn_mort4_19 newborn_mort5_19	newborn_mort6_19 newborn_mort7_19 newborn_mort8_19 ///
	newborn_mort10_19 newborn_mort9_19 newborn_mort11_19 newborn_mort12_19  )
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname, gen(tag)
	egen total= rowtotal(newb*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
	* Newborn mortality 2020
	import delimited "$user/$data/Raw data/Nepal_2020_Jan-June_facility_new_mort", encoding(UTF-8) clear 
	rename(fchvprogramdeath28daysmagh2076-fchvprogramdeath28daysasar2077) (newborn_mort1_20	 ///
	newborn_mort2_20	newborn_mort3_20	newborn_mort4_20	newborn_mort5_20	newborn_mort6_20)
	duplicates tag orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname, gen(tag)
	egen total= rowtotal(newb*), m
	drop if tag==1 & total==.
	drop tag total
	merge 1:1 orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 orgunitlevel5 ///
	orgunitlevel6 organisationunitname using "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_Jan19-Jun20_WIDE.dta", replace
