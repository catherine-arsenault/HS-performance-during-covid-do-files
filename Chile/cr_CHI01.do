* HS performance during Covid
* Created on Feb 1st 2021
* Chile, Jan19 - Oct 2020 data

* Recode variables

**********************************************************************************
*ANC visits - 1884 obs
import delimited "/$user/$data/Raw data/Chile_Antenatal_Care.csv", clear
rename (_01-v27) ///
	(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19 ///
	 anc_util6_19 anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19 ///
	 anc_util11_19	anc_util12_19 anc_util1_20	anc_util2_20	anc_util3_20 ///
	 anc_util4_20	anc_util5_20	anc_util6_20 anc_util7_20   anc_util8_20 ///
	 anc_util9_20    anc_util10_20)

save "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta", replace	

**********************************************************************************
*Facility deliveries - 159 obs (only tertiary hospitals)
import delimited "/$user/$data/Raw data/Chile_Facilities_Deliveries.csv", clear
rename (_01-v27 ) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19 ///
	del_util6_19 del_util7_19	del_util8_19	del_util9_19	del_util10_19 ///
	del_util11_19	del_util12_19 del_util1_20	del_util2_20	del_util3_20 ///
	del_util4_20	del_util5_20	del_util6_20 del_util7_20    del_util8_20 ///
	del_util9_20    del_util10_20)  
	
	merge 1:1 idfacility  using "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta"
	drop _merge // 1893 out of 1968 not matched
	save "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta", replace	

**********************************************************************************
*C-sections - 82 obs (only tertiary hospitals)
import delimited "/$user/$data/Raw data/Chile_Caesarian.csv", clear
rename ( _01-v27) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19 ///
	cs_util6_19 cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19 ///
	cs_util11_19	cs_util12_19 cs_util1_20		cs_util2_20		cs_util3_20 ///
	cs_util4_20		cs_util5_20		cs_util6_20 cs_util7_20     cs_util8_20 ///
    cs_util9_20     cs_util10_20)	
	
	merge 1:1 idfacility  using "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta"
	drop _merge // 1886 out of 1884 not matched
	save "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta", replace	

**********************************************************************************
*Postnatal care visits - 1709 obs 
import delimited "/$user/$data/Raw data/Chile_Postnatal_Care.csv", clear
rename (_01-v27) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19 ///
	pnc_util6_19 pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19 ///
	pnc_util11_19	pnc_util12_19 pnc_util1_20	pnc_util2_20	pnc_util3_20 ///
	pnc_util4_20	pnc_util5_20	pnc_util6_20 pnc_util7_20    pnc_util8_20 ///
	pnc_util9_20    pnc_util10_20)
	
	merge 1:1 idfacility using "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta"
	drop _merge // 369 out of 1884 not matched
	save "$user/$data/Data for analysis/Chile_Jan19-Oct20_WIDE.dta", replace	

**********************************************************************************
*END
**********************************************************************************
/* Descriptive 
Number of facilities by level: 
Primary 1853
Secondary: 4
Tertiary: 166
Total: 2023
*/

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
