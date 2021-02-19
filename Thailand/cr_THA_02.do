* HS performance during Covid
* Created Feb 17, 2021
* Thailand - Provincial level from Oct2018 - Dec 2020


*Dengue cases 
import excel using "$user/$data/Raw data/Received_021621/Provincial - Dengue cases 2018 to 2021.xlsx", firstrow clear
drop AC //drop Jan 2021, not included in the analysis 
rename (B-AB) (dengue_util10_18 dengue_util11_18 dengue_util12_18 dengue_util1_19 ///
dengue_util2_19	dengue_util3_19	dengue_util4_19	dengue_util5_19	///
dengue_util6_19	dengue_util7_19	dengue_util8_19	dengue_util9_19	///
dengue_util10_19	dengue_util11_19	dengue_util12_19 dengue_util1_20 ///
dengue_util2_20	dengue_util3_20	dengue_util4_20	dengue_util5_20	///
dengue_util6_20	dengue_util7_20	dengue_util8_20	dengue_util9_20	///
dengue_util10_20	dengue_util11_20	dengue_util12_20)
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace


*Dental services 
import excel using "$user/$data/Raw data/Received_021621/Provincial - Dental services 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (dental_util10_18	dental_util11_18 dental_util12_18 dental_util1_19	///
dental_util2_19	dental_util3_19	dental_util4_19	dental_util5_19	dental_util6_19	///
dental_util7_19	dental_util8_19	dental_util9_19	dental_util10_19	dental_util11_19 ///
dental_util12_19 dental_util1_20	dental_util2_20	dental_util3_20	dental_util4_20	///
dental_util5_20	dental_util6_20	dental_util7_20	dental_util8_20	dental_util9_20	///
dental_util10_20 dental_util11_20 dental_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

*Diarrhea cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - Diarrhea cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (diarr_util10_18 diarr_util11_18 diarr_util12_18 diarr_util1_19 ///
diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19 ///
diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19 ///
diarr_util12_19 diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20 ///
diarr_util5_20	diarr_util6_20	diarr_util7_20	diarr_util8_20	diarr_util9_20 ///
diarr_util10_20	diarr_util11_20	diarr_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* Early ANC visits 
import excel using "$user/$data/Raw data/Received_021621/Provincial - Early ANC Cases 2018 to 2021.xlsx", firstrow clear
drop B-M AC //No data from Oct2018 to Sept 2019 
rename (N-AB) (anc_util10_19 anc_util11_19	anc_util12_19 anc_util1_20	///
	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	///
	anc_util6_20	anc_util7_20	anc_util8_20	anc_util9_20	///
	anc_util10_20	anc_util11_20	anc_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* IPD Visit 
import excel using "$user/$data/Raw data/Received_021621/Provincial - IPD Visit 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) ( ipd_util10_18	ipd_util11_18	ipd_util12_18 ipd_util1_19 ///
	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	///
	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	///
	ipd_util10_19	ipd_util11_19	ipd_util12_19 ipd_util1_20	///
	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	///
	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	///
	ipd_util10_20	ipd_util11_20 ipd_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* Malaria cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - Malaria cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (mal_qual10_18	mal_qual11_18	mal_qual12_18 mal_qual1_19	///
mal_qual2_19	mal_qual3_19	mal_qual4_19	mal_qual5_19	///
mal_qual6_19	mal_qual7_19	mal_qual8_19	mal_qual9_19	///
mal_qual10_19	mal_qual11_19	mal_qual12_19 mal_qual1_20	///
mal_qual2_20	mal_qual3_20	mal_qual4_20	mal_qual5_20	///
mal_qual6_20	mal_qual7_20	mal_qual8_20	mal_qual9_20	///
mal_qual10_20	mal_qual11_20 mal_qual12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* New Coronary Heart Diseases
import excel using "$user/$data/Raw data/Received_021621/Provincial - New Coronary Heart disease cases 2018 to 2021.xlsx", firstrow clear
drop AC 
rename (B-AB) (heart_util10_18 heart_util11_18 heart_util12_18 heart_util1_19 ///
	heart_util2_19	heart_util3_19	heart_util4_19	heart_util5_19	///
	heart_util6_19	heart_util7_19	heart_util8_19	heart_util9_19	///
	heart_util10_19	heart_util11_19	heart_util12_19 heart_util1_20	///
	heart_util2_20	heart_util3_20	heart_util4_20	heart_util5_20	///
	heart_util6_20	heart_util7_20	heart_util8_20	heart_util9_20	///
	heart_util10_20	heart_util11_20	heart_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* New diabetes cases 
import excel using "$user/$data/Raw data/Received_021621/Provincial - New diabetes cases 2018 to 2021.xlsx", firstrow clear
drop AC 
rename (B-AB) (diab_util10_18 diab_util11_18 diab_util12_18 diab_util1_19 ///
diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	///
diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	///
diab_util10_19	diab_util11_19	diab_util12_19 diab_util1_20	///
diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	///
diab_util6_20	diab_util7_20	diab_util8_20	diab_util9_20	///
diab_util10_20	diab_util11_20	diab_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* Hypertension cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - New hypertension cases 2018 to 2021.xlsx", firstrow clear
drop AC 
rename (B-AB) (hyper_util10_18 hyper_util11_18 hyper_util12_18 ///
hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	///
hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	///
hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19 ///
hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	///
hyper_util5_20	hyper_util6_20	hyper_util7_20	hyper_util8_20	///
hyper_util9_20	hyper_util10_20	hyper_util11_20	hyper_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

* New stroke cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - New stroke cases 2018 to 2021.xlsx", firstrow clear
drop AC 
rename (B-AB) (stroke_util10_18 stroke_util11_18 stroke_util12_18 ///
stroke_util1_19	stroke_util2_19	stroke_util3_19	stroke_util4_19	///
stroke_util5_19	stroke_util6_19	stroke_util7_19	stroke_util8_19	///
stroke_util9_19	stroke_util10_19	stroke_util11_19	stroke_util12_19 ///
stroke_util1_20	stroke_util2_20	stroke_util3_20	stroke_util4_20	///
stroke_util5_20	stroke_util6_20	stroke_util7_20	stroke_util8_20	///
stroke_util9_20	stroke_util10_20	stroke_util11_20	stroke_util12_20 )
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace

*Outpatient 
import excel using "$user/$data/Raw data/Received_021621/Provincial - OPD Visit 2018 to 2021.xlsx", firstrow clear
drop  AC 
rename (B-AB) ///
(opd_util10_18 opd_util11_18 opd_util12_18 opd_util1_19 opd_util2_19 opd_util3_19 ///
opd_util4_19 opd_util5_19 opd_util6_19 opd_util7_19 opd_util8_19 opd_util9_19 ///
opd_util10_19 opd_util11_19 opd_util12_19 opd_util1_20 opd_util2_20 opd_util3_20 ///
opd_util4_20  opd_util5_20  opd_util6_20  opd_util7_20  opd_util8_20 opd_util9_20 ///
opd_util10_20 opd_util11_20 opd_util12_20 )
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace
   

*Pneumonia cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - Pneumonia cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (pneum_qual10_18	pneum_qual11_18	pneum_qual12_18 pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19 pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20 pneum_qual11_20 pneum_qual12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace
   
*Preterm delivery 
import excel using "$user/$data/Raw data/Received_021621/Provincial - Preterm delivery cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (predel_util10_18 predel_util11_18 predel_util12_18 ///
predel_util1_19	predel_util2_19	predel_util3_19	predel_util4_19	///
predel_util5_19	predel_util6_19	predel_util7_19	predel_util8_19	///
predel_util9_19	predel_util10_19	predel_util11_19	predel_util12_19 ///
predel_util1_20	predel_util2_20	predel_util3_20	predel_util4_20	///
predel_util5_20	predel_util6_20	predel_util7_20	predel_util8_20	///
predel_util9_20	predel_util10_20	predel_util11_20	predel_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace 
 
*Total delivery cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - Total delivery cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (totaldel10_18 totaldel11_18 totaldel12_18 totaldel1_19 ///
	totaldel2_19	totaldel3_19	totaldel4_19	totaldel5_19	///
	totaldel6_19	totaldel7_19	totaldel8_19	totaldel9_19	///
	totaldel10_19	totaldel11_19	totaldel12_19 ///
	totaldel1_20	totaldel2_20	totaldel3_20	totaldel4_20	totaldel5_20 ///
	totaldel6_20	totaldel7_20	totaldel8_20	totaldel9_20	totaldel10_20 ///
	totaldel11_20	totaldel12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace 

*Traffic accident cases
import excel using "$user/$data/Raw data/Received_021621/Provincial - Traffic accident cases 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (road_util10_18 road_util11_18 road_util12_18 road_util1_19 ///
	road_util2_19	road_util3_19	road_util4_19	road_util5_19	///
	road_util6_19	road_util7_19	road_util8_19	road_util9_19	///
	road_util10_19	road_util11_19	road_util12_19 road_util1_20	///
	road_util2_20	road_util3_20	road_util4_20	road_util5_20	///
	road_util6_20	road_util7_20	road_util8_20	road_util9_20	///
	road_util10_20	road_util11_20	road_util12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace 

*Traffic accident deaths 
import excel using "$user/$data/Raw data/Received_021621/Provincial - Traffic accident death 2018 to 2021.xlsx", firstrow clear
drop AC
rename (B-AB) (road_mort_num10_18 road_mort_num11_18 road_mort_num12_18 ///
road_mort_num1_19	road_mort_num2_19	road_mort_num3_19	road_mort_num4_19 ///
road_mort_num5_19	road_mort_num6_19	road_mort_num7_19	road_mort_num8_19 ///
road_mort_num9_19	road_mort_num10_19	road_mort_num11_19	road_mort_num12_19 ///
road_mort_num1_20	road_mort_num2_20	road_mort_num3_20	road_mort_num4_20 ///
road_mort_num5_20	road_mort_num6_20	road_mort_num7_20	road_mort_num8_20 ///
road_mort_num9_20	road_mort_num10_20	road_mort_num11_20	road_mort_num12_20)
merge 1:1 Province using "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta"
drop _merge
save  "$user/$data/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", replace 


set obs 78
replace Province="National" if Province==""

*******************************************************************************
* RESHAPE TO LONG FORM
********************************************************************************
reshape long opd_util ipd_util dental_util diab_util dengue_util diarr_util heart_util hyper_util stroke_util predel_util totaldel road_util road_mort_num mal_qual pneum_qual anc_util, i(Prov) j(month) string 

	
* Labels (And dashboard format) - monthly collected data 
lab var opd_util  "Number outpatient (family medicine clinic  & opd specialty) visits"
lab var ipd_util "Number of inpatient admissions total"
lab var dental_util "Number of dental visits"
lab var diab_util "Diabetes cases"
lab var dengue_util "Dengue cases"
lab var diarr_util "Diarrhea cases" 
lab var heart_util "Coronary heart disease cases"
lab var hyper_util "Hypertension cases "
lab var stroke_util "Stroke cases "
lab var predel_util "Preterm delivery cases"
lab var totaldel "Total delivery cases "
lab var road_util "Traffic accident cases "
lab var road_mort_num "Traffic deaths"
lab var mal_qual "Number malaria cases diagnosed"	
lab var pneum_qual "Number of pneumonia cases"
lab var anc_util "Total number of antenatal care visits"	
	
	
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="11_20" | month=="12_20" 

				   
replace year = 2019 if month=="1_19" |	month=="2_19" |	month=="3_19" |	month=="4_19" | ///
					   month=="5_19" |	month=="6_19"  | month=="7_19" | month=="8_19" | ///
				       month=="9_19" |	month=="10_19" | month=="11_19" | month=="12_19" 
					   
replace year = 2018 if month=="10_18" | month=="11_18" | month=="12_18" | month=="Q4_18"					   
					   

gen mo = 1 if month =="1_19" | month =="1_20" 
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month=="10_18"| month =="10_19" | month =="10_20" 
replace mo = 11 if month=="11_18"| month =="11_19" | month =="11_20" 
replace mo = 12 if month=="12_18"| month =="12_19" | month =="12_20"


order Province year mo 
drop month 
rename mo month 


save "$user/$data/Data for analysis/Thailand_Oct18-Dec20_clean.dta", replace


***END***

	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
