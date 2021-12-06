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
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace

* Data received September 2021
******************************************************************************
* Diabetes - 1,863 facilities 
import delimited "/$user/$data/Raw data/CL - Care Diabetes.csv", clear delim(";")
rename (_0enero-v29) ///
(		diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19 ///
	    diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19  diab_util11_19	diab_util12_19 ///
		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20 ///
		diab_util7_20   diab_util8_20   diab_util9_20   diab_util10_20 diab_util11_20 diab_util12_20)
rename (establecimiento comuna nivelatencion) (facilityname municipality levelofattention)
merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 
save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace
******************************************************************************
* Hypertension - 1914 facilities
import delimited "/$user/$data/Raw data/CL - Care Hypertension.csv", clear delim(";")
rename (_0enero-v29) ///
(	hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	///
	hyper_util7_19 	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 ///
	hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20 ///
	hyper_util7_20  hyper_util8_20  hyper_util9_20  hyper_util10_20 hyper_util11_20 hyper_util12_20)
rename (establecimiento comuna nivelatencion) (facilityname municipality levelofattention)
merge 1:1 id using "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta"
drop _merge 

replace region="Biobío" if region=="Región del Bío Bío" | region=="Región Del Bíobío"
replace region="Antofagasta" if region=="Región De Antofagasta"
replace region="Arica y Parinacota" if region=="Región De Arica Parinacota"
replace region="Atacama" if region=="Región De Atacama"
replace region="Aysén del General Carlos Ibáñez del Campo" if region=="Región De Aysén del General Carlos Ibañez del Campo"
replace region="Coquimbo" if region=="Región De Coquimbo"
replace region="La Araucanía" if region=="Región De La Araucanía"
replace region="Los Lagos" if region=="Región De Los Lagos"
replace region="Los Ríos" if region=="Región De Los Ríos"
replace region="Magallanes y de la Antártica Chilena" if region=="Región De Magallanes y de la Antártica Chilena"
replace region="Tarapacá" if region=="Región De Tarapacá"
replace region="Valparaíso" if region=="Región De Valparaíso"
replace region="Ñuble" if region=="Región De Ñuble"
replace region="Libertador General Bernardo O'Higgins" if region=="Región Del Libertador Gral. B. O'Higgins"
replace region="Maule" if region=="Región Del Maule"
replace region="Metropolitana de Santiago" if region=="Región Metropolitana de Santiago"

save "$user/$data/Data for analysis/Chile_Jan19-Dec20_WIDE.dta", replace

******************************************************************************
* HOSPITAL LEVEL DATA (PUBLIC AND PRIVATE)
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

save "$user/$data/Data for analysis/tmpH.dta", replace
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

merge 1:1 GLOSA_ESTABLECIMIENTO_SALUD using "$user/$data/Data for analysis/tmpH.dta"
drop _merge 
save "$user/$data/Data for analysis/tmpH.dta", replace

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
merge 1:1 GLOSA_ESTABLECIMIENTO_SALUD using "$user/$data/Data for analysis/tmpH.dta"
drop _merge 
rename GLOSA_ESTABLECIMIENTO_SALUD facilityname 

replace region="Biobío" if region=="Región del Bío Bío" | region=="Región Del Bíobío"
replace region="Antofagasta" if region=="Región De Antofagasta"
replace region="Arica y Parinacota" if region=="Región De Arica Parinacota"
replace region="Atacama" if region=="Región De Atacama"
replace region="Aysén del General Carlos Ibáñez del Campo" if region=="Región De Aysén del General Carlos Ibañez del Campo"
replace region="Coquimbo" if region=="Región De Coquimbo"
replace region="La Araucanía" if region=="Región De La Araucanía"
replace region="Los Lagos" if region=="Región De Los Lagos"
replace region="Los Ríos" if region=="Región De Los Ríos"
replace region="Magallanes y de la Antártica Chilena" if region=="Región De Magallanes y de la Antártica Chilena"
replace region="Tarapacá" if region=="Región De Tarapacá"
replace region="Valparaíso" if region=="Región De Valparaíso"
replace region="Ñuble" if region=="Región De Ñuble"
replace region="Libertador General Bernardo O'Higgins" if region=="Región Del Libertador Gral. B. O'Higgins"
replace region="Maule" if region=="Región Del Maule"
replace region="Metropolitana de Santiago" if region=="Región Metropolitana de Santiago"

save "$user/$data/Data for analysis/tmpH.dta", replace

******************************************************************************
* COMUNA LEVEL DATA 
******************************************************************************
* Vaccines - 345 communities
* Hexavalent
import excel using "/$user/$data/Raw data/Hexavalente.xlsx",  firstrow clear
rename (_Enero-Z) ///
(pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19 ///
pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20 pent_qual7_20   pent_qual8_20   pent_qual9_20   pent_qual10_20 pent_qual11_20 pent_qual12_20)
save "$user/$data/Data for analysis/tmpC.dta", replace
	
* BCG 
import excel using "/$user/$data/Raw data/BCG.xlsx",  firstrow clear
rename (_Enero-Z) ///
(bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19 ///
bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20 bcg_qual7_20    bcg_qual8_20    bcg_qual9_20    bcg_qual10_20 bcg_qual11_20 bcg_qual12_20)

merge 1:1 Comuna REGION using  "$user/$data/Data for analysis/tmpC.dta"
drop _merge 
save "$user/$data/Data for analysis/tmpC.dta", replace

*PCV
import excel using "/$user/$data/Raw data/Neumococica.xlsx",  firstrow clear
rename (_Enero-Z) /// 
(pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 ///
pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20 pneum_qual7_20  pneum_qual8_20  pneum_qual9_20  pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)
merge 1:1 Comuna REGION using  "$user/$data/Data for analysis/tmpC.dta"
drop _merge 
save "$user/$data/Data for analysis/tmpC.dta", replace

*MMR
import excel using "/$user/$data/Raw data/Tresvirica.xlsx",  firstrow clear
rename (_Enero-Z) /// 
(measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19 measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20 ///
	measles_qual6_20	measles_qual7_20 measles_qual8_20 measles_qual9_20 measles_qual10_20 measles_qual11_20 measles_qual12_20)
merge 1:1 Comuna REGION using  "$user/$data/Data for analysis/tmpC.dta"
drop _merge 
save "$user/$data/Data for analysis/tmpC.dta", replace

/****************************************************************
 ADDING DATA AT THE REGIONAL LEVEL
*****************************************************************/		
* Breast cancer screening
import excel using "/$user/$data/Raw data/CL - Brest Cancer.xlsx", firstrow clear
rename (_1-Y) ///
(breast_util1_19	breast_util2_19	breast_util3_19	breast_util4_19 ///
breast_util5_19	breast_util6_19	breast_util7_19	breast_util8_19	///
breast_util9_19	breast_util10_19	breast_util11_19	breast_util12_19 ///
breast_util1_20	breast_util2_20	breast_util3_20	breast_util4_20	breast_util5_20	///
breast_util6_20 breast_util7_20   breast_util8_20   breast_util9_20 ///
  breast_util10_20 breast_util11_20 breast_util12_20)
save "$user/$data/Data for analysis/tmpR.dta", replace		

* Child pneumonia
import excel using "/$user/$data/Raw data/Hosp_J09_J18_5a.xlsx", firstrow clear
foreach var of varlist _all {
	rename (`var') (p`var')
}
rename pregion region
drop if region==""
save "$user/$data/Data for analysis/tmp.dta", replace
import excel using "/$user/$data/Raw data/Hosp_J12_J18_5a.xlsx", firstrow clear
merge 1:1 region using "$user/$data/Data for analysis/tmp.dta"
drop _merge _1-_12 p_1-p_12
drop if region=="TOTAL" | region=="99" | region=="Extra"
egen pneum_util1_19 = rowtotal(N pN), m
egen pneum_util2_19 = rowtotal(O pO), m
egen pneum_util3_19 = rowtotal(P pP), m
egen pneum_util4_19 = rowtotal(Q pQ), m
egen pneum_util5_19 = rowtotal( R pR), m
egen pneum_util6_19 = rowtotal( S pS), m
egen pneum_util7_19 = rowtotal( T  pT), m
egen pneum_util8_19 = rowtotal( U pU), m
egen pneum_util9_19 = rowtotal( V pV), m
egen pneum_util10_19 = rowtotal( W pW), m
egen pneum_util11_19 = rowtotal( X pX), m
egen pneum_util12_19 = rowtotal( Y pY), m
egen pneum_util1_20 = rowtotal( Z pZ), m
egen pneum_util2_20 = rowtotal(AA  pAA), m
egen pneum_util3_20 = rowtotal( AB pAB), m
egen pneum_util4_20 = rowtotal( AC pAC), m
egen pneum_util5_20 = rowtotal( AD pAD), m
egen pneum_util6_20 = rowtotal( AE pAE), m
egen pneum_util7_20 = rowtotal( AF pAF), m
egen pneum_util8_20 = rowtotal( AG pAG), m
egen pneum_util9_20 = rowtotal( AH pAH), m
egen pneum_util10_20 = rowtotal( AI pAI), m
egen pneum_util11_20 = rowtotal( AJ pAJ), m
egen pneum_util12_20 = rowtotal( AK pAK), m
keep region pneum* 
merge 1:1 region using "$user/$data/Data for analysis/tmpR.dta"	
drop _merge
save  "$user/$data/Data for analysis/tmpR.dta", replace		

* Neonatal deaths
import excel using  "/$user/$data/Raw data/Mort_Neonatal.xlsx", firstrow clear
drop if region==""
rename (_1-Y) (neo_mort_num1_19 neo_mort_num2_19 neo_mort_num3_19 neo_mort_num4_19 ///
			neo_mort_num5_19 neo_mort_num6_19 neo_mort_num7_19 neo_mort_num8_19 ///
			neo_mort_num9_19 neo_mort_num10_19 neo_mort_num11_19 neo_mort_num12_19 ///
			neo_mort_num1_20 neo_mort_num2_20 neo_mort_num3_20 neo_mort_num4_20 ///
			neo_mort_num5_20 neo_mort_num6_20 neo_mort_num7_20 neo_mort_num8_20 ///
			neo_mort_num9_20 neo_mort_num10_20 neo_mort_num11_20 neo_mort_num12_20 )
merge 1:1 region using  "$user/$data/Data for analysis/tmpR.dta"
drop _merge 
save  "$user/$data/Data for analysis/tmpR.dta", replace			
	
* Inpatient deaths
import excel using  "/$user/$data/Raw data/Mort_Inpatient.xlsx", firstrow clear
drop if region==""
rename (_1-Y) (ipd_mort_num1_19 ipd_mort_num2_19 ipd_mort_num3_19 ipd_mort_num4_19 ///
			ipd_mort_num5_19 ipd_mort_num6_19 ipd_mort_num7_19 ipd_mort_num8_19 ///
			ipd_mort_num9_19 ipd_mort_num10_19 ipd_mort_num11_19 ipd_mort_num12_19 ///
			ipd_mort_num1_20 ipd_mort_num2_20 ipd_mort_num3_20 ipd_mort_num4_20 ///
			ipd_mort_num5_20 ipd_mort_num6_20 ipd_mort_num7_20 ipd_mort_num8_20 ///
			ipd_mort_num9_20 ipd_mort_num10_20 ipd_mort_num11_20 ipd_mort_num12_20 )
merge 1:1 region using  "$user/$data/Data for analysis/tmpR.dta"
drop _merge 
save  "$user/$data/Data for analysis/tmpR.dta", replace			
	
/*******************************************************************************
*END
*******************************************************************************


*drop missing observation 
eegentotal =rowtotal(hyper_util1_19 - road_util12_20)
drop if total==0 
drop total 
egenstr facname = facilityname
duplicates tag region facname, gen(tag)

replace facname = "Centro de Salud Familiar Cardenal Silva Henríquez_Peñalolén" ///
		if facname=="Centro de Salud Familiar Cardenal Silva Henríquez" & municipality=="Peñalolén"
replace facname ="Posta de Salud Rural Cayumapu_Pangui" if facname=="Posta de Salud Rural Cayumapu" ///
	& municipality=="Panguipulli"		
replace facname="Posta de Salud Rural Idahue_Colta" if facname=="Posta de Salud Rural Idahue" & municipality=="Coltauco"
replace facname="SAPU Eduardo Frei Montalva_Cisterna" if facname=="SAPU Eduardo Frei Montalva" & municipality=="La Cisterna"
replace facname="SAPU Juan Pablo II_Serena" if facname=="SAPU Juan Pablo II" & municipality=="La Serena"
replace facname="SAR Alemania_Calama" if facname=="SAR Alemania" & municipality=="Calama"


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
