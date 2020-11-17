
* info here 

import excel " Ethiopia_2020_January to August_ by woreda csv_14_11_2020"

rename 


/* resus_qual_num
Total number of neonates resuscitated and survived 

resus_qual_denom
Total number of neonates resuscitated 

kmc_qual_num
Total number of newborns weighing <2000gm and/or premature newborns for which KMC initiated 

kmc_qual_denom
Total number of newborns weighing <2000gm and/or premature 


drop 
Total death in ICU in the reporting period 
Total discharges from ICU 
Total neonates admitted to NICU 
Total neonates discharged from NICU */

* Region names
drop orgunitlevel1 orgunitlevel4  
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
replace region ="SNNP"  if region== "Sidama Regional Health Bureau"
replace region ="Somali"  if region== "Somali Regional Health Bureau"
replace region ="Tigray" if region== "Tigray Regional Health Bureau"
order region zone organisationunitname


*MERGE TO LATEST DATASET
merge 1:1  region zone organisationunitname using "$user/$data/Data for analysis/Ethiopia_Jan19-August20_WIDE.dta"


** UPDATE MASTER DO FILE 

** UPDATE CLEANING AND RE-RUN
		* -- 4 NEW VARS 
		
** UPDATE FORMAT DO FILE AND RE-RUN 

** NEW .CSV FOR THE DASBOARD 
		*  CHECK THAT NUM IS NOT GREAT THAN DENOM
** UPDATE CODEBOOK 

** NEENA TO RELINK AND CREATE 2 NEW INDICATORS 
