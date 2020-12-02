/* Imports raw data and renames variables for Jan 2019 - August 2020 for 
newborn resuscitation and KMC initiated, merge with other data 
updated by MK Kim 
11/18/20 
*/

*Import raw data
import delimited "$user/$data/Raw/2020/Ethiopia_2020_January to August_ by woreda csv_14_11_2020.csv", clear

*months in data are in correct order 
*rename variables 
*Total number of neonates resuscitated 
rename totalnumberofneonatesresuscitate v6
rename (v6-v25) (resus_qual_denom1_19	resus_qual_denom2_19	resus_qual_denom3_19	resus_qual_denom4_19	resus_qual_denom5_19	resus_qual_denom6_19	resus_qual_denom7_19	resus_qual_denom8_19	resus_qual_denom9_19	resus_qual_denom10_19	resus_qual_denom11_19	resus_qual_denom12_19 resus_qual_denom1_20	resus_qual_denom2_20	resus_qual_denom3_20	resus_qual_denom4_20	resus_qual_denom5_20	resus_qual_denom6_20	resus_qual_denom7_20	resus_qual_denom8_20)

*Total number of neonates resuscitated and survived 
rename (v26-v45) (resus_qual_num1_19	resus_qual_num2_19	resus_qual_num3_19	resus_qual_num4_19	resus_qual_num5_19	resus_qual_num6_19	resus_qual_num7_19	resus_qual_num8_19	resus_qual_num9_19	resus_qual_num10_19	resus_qual_num11_19	resus_qual_num12_19 resus_qual_num1_20	resus_qual_num2_20	resus_qual_num3_20	resus_qual_num4_20	resus_qual_num5_20	resus_qual_num6_20	resus_qual_num7_20	resus_qual_num8_20)

*Total number of newborns weighing <2000gm and/or premature 
rename totalnumberofnewbornsweighing200 v46
rename (v46-v65) (kmc_qual_denom1_19	kmc_qual_denom2_19	kmc_qual_denom3_19	kmc_qual_denom4_19	kmc_qual_denom5_19	kmc_qual_denom6_19	kmc_qual_denom7_19	kmc_qual_denom8_19	kmc_qual_denom9_19	kmc_qual_denom10_19	kmc_qual_denom11_19	kmc_qual_denom12_19 kmc_qual_denom1_20	kmc_qual_denom2_20	kmc_qual_denom3_20	kmc_qual_denom4_20	kmc_qual_denom5_20	kmc_qual_denom6_20	kmc_qual_denom7_20	kmc_qual_denom8_20)

*Total number of newborns weighing <2000gm and/or premature newborns for which KMC initiated 
rename (v66-v85) (kmc_qual_num1_19	kmc_qual_num2_19	kmc_qual_num3_19	kmc_qual_num4_19	kmc_qual_num5_19	kmc_qual_num6_19	kmc_qual_num7_19	kmc_qual_num8_19	kmc_qual_num9_19	kmc_qual_num10_19	kmc_qual_num11_19	kmc_qual_num12_19 kmc_qual_num1_20	kmc_qual_num2_20	kmc_qual_num3_20	kmc_qual_num4_20	kmc_qual_num5_20	kmc_qual_num6_20	kmc_qual_num7_20	kmc_qual_num8_20)

/*drop Total death in ICU in the reporting period 
Total discharges from ICU 
Total neonates admitted to NICU 
Total neonates discharged from NICU 
due to now relevant to our study */ 
drop totaldeathinicuinthereportingper-v169



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
sort region zone organisationunitname 
merge 1:1  region zone organisationunitname using "$user/$data/Data for analysis/Ethiopia_Jan19-August20_WIDE.dta"
drop _merge
*53 observations not merged. Merging data have additional 53 observations that are missing from the new data. 

save "$user/$data/Data for analysis/Ethiopia_Jan19-August20_WIDE.dta", replace


** UPDATE MASTER DO FILE - done 

** UPDATE CLEANING AND RE-RUN - done 
		* -- 4 NEW VARS 
		
** UPDATE FORMAT DO FILE AND RE-RUN - done 

** NEW .CSV FOR THE DASBOARD 
		*  CHECK THAT NUM IS NOT GREAT THAN DENOM - need to discuss with CA 
** UPDATE CODEBOOK -done 

** NEENA TO RELINK AND CREATE 2 NEW INDICATORS 
