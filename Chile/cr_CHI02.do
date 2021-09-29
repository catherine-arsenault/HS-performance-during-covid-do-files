* HS performance during Covid
* Created on June 14 2021
* Chile, Jan19 - Dec 2020 data
* Recode variables

**********************************************************************************
*ER visits - 584 obs 
import delimited "/$user/$data/Raw data/061421/CL - ER visits.csv", clear delim(";")
replace region ="Región De Los Ríos" if region=="Región De los Ríos" 
rename (_01-v29) ///
(er_util1_19	er_util2_19	er_util3_19	er_util4_19	er_util5_19	er_util6_19	er_util7_19	er_util8_19	er_util9_19	er_util10_19	er_util11_19	er_util12_19 er_util1_20	er_util2_20	er_util3_20	er_util4_20	er_util5_20	er_util6_20	er_util7_20	er_util8_20	er_util9_20	er_util10_20	er_util11_20	er_util12_20)

*duplicate id corrected 
replace id=113826 if facilityname=="SAPU Eduardo Frei Montalva" & municipality=="La Cisterna"
replace id=200105 if facilityname=="SAPU Juan Pablo II" & municipality=="La Serena"
replace id=200157 if facilityname=="SAPU Los Volcanes" & municipality=="Villarrica"
replace id=118808 if facilityname=="SAPU San Pedro de La Paz" & municipality=="San Pedro de la Paz"
replace id=200348 if facilityname=="SAR Alemania" & municipality=="Calama"

save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

*******************************************************************************
*Modern contraceptive Use - 2070 obs
import delimited "/$user/$data/Raw data/061421/CL - Modern Contraceptive Use.csv", clear delim(";")
replace region ="Región De Los Ríos" if region=="Región De los Ríos" 
rename (_01-v29 ) ///
(fp_util1_19	fp_util2_19	fp_util3_19	fp_util4_19	fp_util5_19	fp_util6_19	fp_util7_19	fp_util8_19	fp_util9_19	fp_util10_19	fp_util11_19	fp_util12_19 fp_util1_20	fp_util2_20	fp_util3_20	fp_util4_20	fp_util5_20	fp_util6_20	fp_util7_20	fp_util8_20	fp_util9_20	fp_util10_20	fp_util11_20	fp_util12_20)  

merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

*******************************************************************************
*Postnatal care visits - 1722 obs 
import delimited "/$user/$data/Raw data/061421/CL - Postnatal_Care.csv", clear delim(";")
replace region ="Región De Los Ríos" if region=="Región De los Ríos" 
rename (_01-v29) ///
(	pnc_util1_19	pnc_util2_19	pnc_util3_19	pnc_util4_19	pnc_util5_19 ///
	pnc_util6_19 pnc_util7_19	pnc_util8_19	pnc_util9_19	pnc_util10_19 ///
	pnc_util11_19	pnc_util12_19 pnc_util1_20	pnc_util2_20	pnc_util3_20 ///
	pnc_util4_20	pnc_util5_20	pnc_util6_20 pnc_util7_20    pnc_util8_20 ///
	pnc_util9_20    pnc_util10_20 pnc_util11_20 pnc_util12_20)
	
merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace	

******************************************************************************
*Surgery performed - 240 obs
import delimited "/$user/$data/Raw data/061421/CL - Surgeries Performed.csv", clear delim(";")
replace region ="Región De Los Ríos" if region=="Región De los Ríos" 
rename (_01-v29) ///
(surg_util1_19	surg_util2_19	surg_util3_19	surg_util4_19	  ///
surg_util5_19	surg_util6_19	surg_util7_19	surg_util8_19 ///
surg_util9_19	surg_util10_19	surg_util11_19	surg_util12_19 ///
surg_util1_20	surg_util2_20	surg_util3_20	surg_util4_20 ///
surg_util5_20	surg_util6_20	surg_util7_20	surg_util8_20 ///
surg_util9_20	surg_util10_20	surg_util11_20	surg_util12_20)

merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace
	
******************************************************************************
*Traffic injuries - 584 obs
import delimited "/$user/$data/Raw data/061421/CL - Traffic Injuries.csv", clear delim(";")
replace region ="Región De Los Ríos" if region=="Región De los Ríos" 
replace region = "Región De Coquimbo" if id==105822
replace municipality ="Ovalle" if id==105822
replace level = "Primary" if id==105822
rename (_01-v29) ///
(road_util1_19	road_util2_19	road_util3_19	road_util4_19 ///
road_util5_19	road_util6_19	road_util7_19	road_util8_19 ///
road_util9_19	road_util10_19	road_util11_19	road_util12_19 ///
road_util1_20	road_util2_20	road_util3_20	road_util4_20 ///
road_util5_20	road_util6_20	road_util7_20	road_util8_20 ///
road_util9_20	road_util10_20	road_util11_20	road_util12_20)

*duplicate id corrected 
replace id=118808 if facilityname=="SAPU San Pedro de La Paz" & municipality=="San Pedro de la Paz"

*drop missing observation 
egen total =rowtotal(road_util1_19 - road_util12_20)
drop if total==0 
drop total 

*6 observations with duplicate ids were dropped 
duplicates tag id, generate(dup_id)
drop if dup_id ==1 
drop dup_id 

merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace

* Data received June 2021
******************************************************************************
*Antenatal Care - 1,894 facilities 
import delimited "/$user/$data/Raw data/061421/CL - Antenatal_Care.csv", clear delim(";")
rename (_01 - v29) ///
(anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19 ///
anc_util5_19	anc_util6_19	anc_util7_19	anc_util8_19 ///
anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19 ///
anc_util1_20 anc_util2_20	anc_util3_20	anc_util4_20	///
anc_util5_20	anc_util6_20	anc_util7_20	anc_util8_20 ///
anc_util9_20	anc_util10_20	anc_util11_20	anc_util12_20)

merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace

******************************************************************************
*Mental consultations - 2,225
import delimited "/$user/$data/Raw data/061421/CL - Mental Health.csv", clear delim(";")
rename (_01 - v29) ///
(mental_util1_19	mental_util2_19	mental_util3_19	mental_util4_19 ///
mental_util5_19	mental_util6_19	mental_util7_19	mental_util8_19 ///
mental_util9_19	mental_util10_19	mental_util11_19	mental_util12_19 ///
mental_util1_20	mental_util2_20	mental_util3_20	mental_util4_20 ///
mental_util5_20	mental_util6_20	mental_util7_20	mental_util8_20 ///
mental_util9_20	mental_util10_20	mental_util11_20	mental_util12_20)

merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
gen str facname = facilityname
egen total =rowtotal(mental_util1_19-er_util12_20)
drop if total==0 
drop total 
duplicates tag region facname, gen(tag)

replace facname = "Centro de Salud Familiar Cardenal Silva Henríquez_Peñalolén" ///
		if facname=="Centro de Salud Familiar Cardenal Silva Henríquez" & municipality=="Peñalolén"
replace facname ="Posta de Salud Rural Cayumapu_Pangui" if facname=="Posta de Salud Rural Cayumapu" ///
	& municipality=="Panguipulli"		
replace facname="Posta de Salud Rural Idahue_Colta" if facname=="Posta de Salud Rural Idahue" & municipality=="Coltauco"
replace facname="SAPU Eduardo Frei Montalva_Cisterna" if facname=="SAPU Eduardo Frei Montalva" & municipality=="La Cisterna"
replace facname="SAPU Juan Pablo II_Serena" if facname=="SAPU Juan Pablo II" & municipality=="La Serena"
replace facname="SAR Alemania_Calama" if facname=="SAR Alemania" & municipality=="Calama"
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace
* Data received September 2021
******************************************************************************
* Deliveries - 340 public and private hospitals
import excel using "/$user/$data/Raw data/Hosp_O80_O84_PARTOS TOTALES.xlsx",  firstrow clear
drop _1-_12 // dropping 2018	
drop if GLOSA_ESTABLECIMIENTO_SALUD=="TOTAL"
rename (O - AL) ///
(	del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19 ///
	del_util6_19 del_util7_19	del_util8_19	del_util9_19	del_util10_19 ///
	del_util11_19	del_util12_19 del_util1_20	del_util2_20	del_util3_20 ///
	del_util4_20	del_util5_20	del_util6_20 del_util7_20    del_util8_20 ///
	del_util9_20    del_util10_20 del_util11_20 del_util12_20)  

save "$user/$data/Data for analysis/tmp.dta", replace
******************************************************************************
* C-sections - 340 public and private hospitals	
import excel using "/$user/$data/Raw data/Hosp_O82_O842_PARTOS CESAREAS.xlsx",  firstrow clear
drop _1-_12 // dropping 2018	
drop if GLOSA_ESTABLECIMIENTO_SALUD=="TOTAL"
rename (N-AK) ///
(	cs_util1_19		cs_util2_19		cs_util3_19		cs_util4_19		cs_util5_19 ///
	cs_util6_19 cs_util7_19		cs_util8_19		cs_util9_19		cs_util10_19 ///
	cs_util11_19	cs_util12_19 cs_util1_20		cs_util2_20		cs_util3_20 ///
	cs_util4_20		cs_util5_20		cs_util6_20 cs_util7_20     cs_util8_20 ///
    cs_util9_20     cs_util10_20 cs_util11_20 cs_util12_20)	

merge 1:1 GLOSA_ESTABLECIMIENTO_SALUD using "$user/$data/Data for analysis/tmp.dta"
drop _merge 
save "$user/$data/Data for analysis/tmp.dta", replace

******************************************************************************
* Inpatient admissions - 340 public and private hospitals	
import excel using "/$user/$data/Raw data/Hosp_total_EGRESOS TOTALES.xlsx",  firstrow clear
drop _1-_12 // dropping 2018	
drop if GLOSA_ESTABLECIMIENTO_SALUD=="TOTAL"
rename (N-AK) ///
(	ipd_util1_19		ipd_util2_19		ipd_util3_19		ipd_util4_19		ipd_util5_19 ///
	ipd_util6_19 ipd_util7_19		ipd_util8_19		ipd_util9_19		ipd_util10_19 ///
	ipd_util11_19	ipd_util12_19 ipd_util1_20		ipd_util2_20		ipd_util3_20 ///
	ipd_util4_20		ipd_util5_20		ipd_util6_20 ipd_util7_20     ipd_util8_20 ///
    ipd_util9_20     ipd_util10_20 ipd_util11_20 ipd_util12_20)	

merge 1:1 GLOSA_ESTABLECIMIENTO_SALUD using "$user/$data/Data for analysis/tmp.dta"
drop _merge 
rename GLOSA_ESTABLECIMIENTO_SALUD facname 

merge 1:1 region facname using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge tag
replace region="Región Del Bíobío" if region=="Región del Bío Bío"

save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace

rm "$user/$data/Data for analysis/tmp.dta"	
*******************************************************************************
*END
*******************************************************************************


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
