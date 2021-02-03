
* HS performance during Covid
* Jan 6, 2021 
* TB Quarterly data, 2019 and 2020
clear all
set more off	

**Import and name 2019 data 

import excel "$user/$data/Raw/2019/Ethiopia_2019_January to December_all death & quarterly data_03_08_2020/Ethiopia_TB_Quarterly_2019_January to December_ by woreda.xlsx", clear firstrow

rename (Numberofbacteriologicallyconf G H I Totalnumberofnewbacteriologi K L M R S T U) ///
	(tbdetect_qual1 tbdetect_qual2 tbdetect_qual3 tbdetect_qual4 tbdenom_qual1 tbdenom_qual2 tbdenom_qual3 tbdenom_qual4 tbnum_qual1 tbnum_qual2 tbnum_qual3 tbnum_qual4)

drop N-Q V-AD	
	
* Create unique facility id
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

egen unit_id = concat(region zone organisationunitname)
order region zone organisationunitname unit_id

save "$user/$data/Data for analysis/tmp_TB.dta", replace

*Import and name 2020 data

import delimited "$user/$data/Raw/2020/Ethiopia_Health system performance during Covid_data extraction_2020_January to June_14_09_2020_GC - Final/Ethiopia_2020_January to June_all death & quarterly data_14_09_2020/Ethiopia_TB_Quarterly_2020_January to woreda_csv.csv", clear

rename (numberofbacteriologicallyconfirm v7 totalnumberofnewbacteriologicall v9 v12 v13) ///
	(tbdetect_qual5 tbdetect_qual6 tbdenom_qual5 tbdenom_qual6 tbnum_qual5 tbnum_qual6)

drop v10 v11 v14	
	
* Create unique facility id
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

egen unit_id = concat(region zone organisationunitname)
order region zone organisationunitname unit_id

merge 1:1  region zone organisationunitname using "$user/$data/Data for analysis/tmp_TB.dta"
drop _merge

order tbdetect_qual1 tbdetect_qual2 tbdetect_qual3 tbdetect_qual4 tbdetect_qual5 tbdetect_qual6 ///
	tbdenom_qual1 tbdenom_qual2 tbdenom_qual3 tbdenom_qual4 tbdenom_qual5 tbdenom_qual6 ///
	tbnum_qual1 tbnum_qual2 tbnum_qual3 tbnum_qual4 tbnum_qual5 tbnum_qual6, after(unit_id)
	

	
save "$user/$data/Data for analysis/EthiopiaTB_Jan19-June20_WIDE.dta", replace
rm "$user/$data/Data for analysis/tmp_TB.dta"

