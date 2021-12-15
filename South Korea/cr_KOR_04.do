
* South Korea, Jan19 - Jun2021 data

import excel using "$user/$data/Raw data/(211209)output_SouthKorea.xlsx", firstrow clear
keep org* NumberoffacilitydeliveriesJa-CM NumberofoutpatientvisitsJanu-IH ///
		NumberofinpatientadmissionsJ-JL Numberofdiabeticpatientsvisi-LT
		
		
* Facility deliveries 
rename (NumberoffacilitydeliveriesJa-CM) ///
	(totaldel1_19	totaldel2_19	totaldel3_19	totaldel4_19	totaldel5_19 ///
	totaldel6_19	totaldel7_19	totaldel8_19	totaldel9_19	totaldel10_19 ///
	totaldel11_19	totaldel12_19 totaldel1_20	totaldel2_20	totaldel3_20 ///
	totaldel4_20	totaldel5_20	totaldel6_20	totaldel7_20	totaldel8_20 ///
	totaldel9_20    totaldel10_20	totaldel11_20	totaldel12_20 totaldel1_21	///
	totaldel2_21	totaldel3_21 totaldel4_21	totaldel5_21)  
	
* Outpatient visits 
rename (NumberofoutpatientvisitsJanu-IH) ///
		(opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	///
		opd_util5_19	opd_util6_19	opd_util7_19	opd_util8_19	///
		opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19 ///
		opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	///
		opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20 ///
		opd_util9_20 	opd_util10_20	opd_util11_20	opd_util12_20 opd_util1_21 ///
		opd_util2_21	opd_util3_21	opd_util4_21	opd_util5_21)

* Inpatient admissions 
rename (NumberofinpatientadmissionsJ-JL) ///
	    (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	///
		ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	///
		ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19 ///
		ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	///
		ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20 ///
		ipd_util9_20 	ipd_util10_20	ipd_util11_20	ipd_util12_20 ipd_util1_21 ///
		ipd_util2_21	ipd_util3_21	ipd_util4_21	ipd_util5_21)
		
* Diabetic patients 
rename (Numberofdiabeticpatientsvisi-LT) ///
		(diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19 ///
		diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19 ///
		diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19  ///
		diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	///
		diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20 ///
		diab_util9_20 	diab_util10_20	diab_util11_20	diab_util12_20 ///
		diab_util1_21	diab_util2_21	diab_util3_21	diab_util4_21	///
		diab_util5_21)

drop orgunitlevel1

drop if region=="" | region=="total"

reshape long  totaldel  diab_util  opd_util  ipd_util , i(region) j(month) string 
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year =2021 if month=="1_21" | month=="2_21" | month=="3_21" | month=="4_21" | month=="5_21" ///
				| month=="6_21" 
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20" | month =="1_21"
replace mo = 2 if month =="2_19" | month =="2_20" | month =="2_21"
replace mo = 3 if month =="3_19" | month =="3_20" | month =="3_21"
replace mo = 4 if month =="4_19" | month =="4_20" | month =="4_21"
replace mo = 5 if month =="5_19" | month =="5_20" | month =="5_21"
replace mo = 6 if month =="6_19" | month =="6_20" | month =="6_21"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort  region year month
order region year month 	
		
save "$user/$data/Data for analysis/Korea_su_29months.dta", replace		
