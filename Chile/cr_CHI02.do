* HS performance during Covid
* Created on June 14 2021
* Chile, Jan19 - Dec 2020 data
* Recode variables

**********************************************************************************
*ER visits - 584 obs 
import delimited "/$user/$data/Raw data/061421/CL - ER visits.csv", clear
rename (_01-v29) ///
(er_util1_19	er_util2_19	er_util3_19	er_util4_19	er_util5_19	er_util6_19	er_util7_19	er_util8_19	er_util9_19	er_util10_19	er_util11_19	er_util12_19 er_util1_20	er_util2_20	er_util3_20	er_util4_20	er_util5_20	er_util6_20	er_util7_20	er_util8_20	er_util9_20	er_util10_20	er_util11_20	er_util12_20)

duplicates tag id, gen(dup_id)
drop if dup_id==1 
*10 observations were dropped
drop dup_id

save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

**********************************************************************************
*Modern contraceptive Use - 2070 obs
import delimited "/$user/$data/Raw data/061421/CL - Modern Contraceptive Use.csv", clear 
rename (_01-v29 ) ///
(fp_util1_19	fp_util2_19	fp_util3_19	fp_util4_19	fp_util5_19	fp_util6_19	fp_util7_19	fp_util8_19	fp_util9_19	fp_util10_19	fp_util11_19	fp_util12_19 fp_util1_20	fp_util2_20	fp_util3_20	fp_util4_20	fp_util5_20	fp_util6_20	fp_util7_20	fp_util8_20	fp_util9_20	fp_util10_20	fp_util11_20	fp_util12_20)  
	
duplicates tag id, gen(dup_id)
drop if dup_id==1 
*no observations were dropped
drop dup_id

	merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
	drop _merge // 2406 out 2525 were not merged 
	save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

*******************************************************************************
*Postnatal care visits - 1722 obs 
import delimited "/$user/$data/Raw data/061421/CL - Postnatal_Care.csv", clear
rename (_01-v29) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19 ///
	pnc_util6_19 pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19 ///
	pnc_util11_19	pnc_util12_19 pnc_util1_20	pnc_util2_20	pnc_util3_20 ///
	pnc_util4_20	pnc_util5_20	pnc_util6_20 pnc_util7_20    pnc_util8_20 ///
	pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20)

duplicates tag id, gen(dup_id)
drop if dup_id==1 
*no observations were dropped
drop dup_id
	
	merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
	drop _merge // 803 out of 2525 not merged
	save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

******************************************************************************
*Surgery performed - 240 obs
import delimited "/$user/$data/Raw data/061421/CL - Surgeries Performed.csv", clear
rename (_01-v29) ///
(surg_util1_19	surg_util2_19	surg_util3_19	surg_util4_19	  ///
surg_util5_19	surg_util6_19	surg_util7_19	surg_util8_19 ///
surg_util9_19	surg_util10_19	surg_util11_19	surg_util12_19 ///
surg_util1_20	surg_util2_20	surg_util3_20	surg_util4_20 ///
surg_util5_20	surg_util6_20	surg_util7_20	surg_util8_20 ///
surg_util9_20	surg_util10_20	surg_util11_20	surg_util12_20)

duplicates tag id, gen(dup_id)
drop if dup_id==1 
*no observations were dropped
drop dup_id

	merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
	drop _merge // 2317 out of 2654 not matched
	save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace
	
******************************************************************************
*Traffic injuries - 584 obs
import delimited "/$user/$data/Raw data/061421/CL - Traffic Injuries.csv", clear
rename (_01-v29) ///
(road_util1_19	road_util2_19	road_util3_19	road_util4_19 ///
road_util5_19	road_util6_19	road_util7_19	road_util8_19 ///
road_util9_19	road_util10_19	road_util11_19	road_util12_19 ///
road_util1_20	road_util2_20	road_util3_20	road_util4_20 ///
road_util5_20	road_util6_20	road_util7_20	road_util8_20 ///
road_util9_20	road_util10_20	road_util11_20	road_util12_20)

duplicates tag id, gen(dup_id)
drop if dup_id==1 
*10 observations were dropped 
drop dup_id

	merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
	drop _merge // 1967 out of 2541 not matched
	save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace
	*n= 2541 observations 
	
*******************************************************************************
*END
*******************************************************************************
/* duplicates list id - traffic injuries
+------------------------+
  | group:   obs:       id |
  |------------------------|
  |      1    238   107828 |
  |      1    239   107828 |
  |      2    266   113832 |
  |      2    267   113832 |
  |      3    290   117824 |
  |------------------------|
  |      3    583   117824 |
  |      4    371   129803 |
  |      4    372   129803 |
  |      5    348   200581 |
  |      5    413   200581 |
  +------------------------+

	
duplicates list id - ER visits 
	
	 +------------------------+
  | group:   obs:       id |
  |------------------------|
  |      1    238   107828 |
  |      1    239   107828 |
  |      2    266   113832 |
  |      2    267   113832 |
  |      3    290   117824 |
  |------------------------|
  |      3    583   117824 |
  |      4    371   129803 |
  |      4    372   129803 |
  |      5    348   200581 |
  |      5    413   200581 |
  +------------------------+

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
