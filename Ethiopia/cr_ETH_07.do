* HS resilience during Covid
* Created Dec 11, 2021
* Ethiopia, Jan-June 2021

import excel using "$user/$data/Raw/2021/Ethiopia_Health system performance during Covid_data extraction_2021_January to June_07_06_2021_GC - Final/Ethiopia_2021_January to June_ by Woreda_07_12_2021_EC@.xlsx", firstrow clear

* OPD
rename (NumberofoutpatientvisitsTir-NumberofoutpatientvisitsSene) (opd_util1_21 ///
		opd_util2_21 opd_util3_21 opd_util4_21 opd_util5_21 opd_util6_21 )
* IPD
rename (NumberofinpatientadmissionsT-NumberofinpatientadmissionsS) (ipd_util1_21 ///
	ipd_util2_21 ipd_util3_21 ipd_util4_21 ipd_util5_21 ipd_util6_21 )
	
* Deliveries
rename (Totalnumberofbirthsattended-W) (del_util1_21 del_util2_21 del_util3_21 ///
	del_util4_21 del_util5_21 del_util6_21) 
	
* Pentavalent
rename(BN-BS) (pent_qual1_21	pent_qual2_21	pent_qual3_21	pent_qual4_21	///
	pent_qual5_21	pent_qual6_21)

replace orgunitlevel3="Kolfe Subcity" if orgunitlevel4=="Kolfe Health Center"
replace orgunitlevel3="Kolfe Subcity" if orgunitlevel4=="Lomi Meda Health Center"
replace orgunitlevel3="Kolfe Subcity" if orgunitlevel4=="MikililandHealth Center"
replace orgunitlevel4= "Woreda 11 Health Center" if orgunitlevel4=="Woreda11 Health Center"
replace organisationunitname= "Woreda 11 Health Center" if organisationunitname=="Woreda11 Health Center"
replace orgunitlevel3="Bole Sub City" if orgunitlevel4=="Amoraw Health Center"
replace orgunitlevel3="Bole Sub City" if orgunitlevel4=="Bole Arabesa Health Center"
replace orgunitlevel3="Bole Sub City" if orgunitlevel4=="Goro Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Bole Sub City" if orgunitlevel4=="Meri Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Yeka Sub City" if orgunitlevel4=="Raey Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Bole Sub City" if orgunitlevel4=="Sumit Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Yeka Sub City" if orgunitlevel4=="Woreda 13 Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Yeka Sub City" if orgunitlevel4=="Woreda 14 Hidase Health center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Yeka Sub City" if orgunitlevel4=="Yeka Abado Health Center" & orgunitlevel2=="Addis Ababa Regional Health Bureau"
replace orgunitlevel3="Goro Operational WorHO" if orgunitlevel3=="Sabiyan General Hospital"
replace orgunitlevel4="Sabiyan PHCU" if organisationunitname=="Sabiyan General Hospital" 
replace organisationunitname="Sabiyan PHCU" if organisationunitname=="Sabiyan General Hospital" 
replace orgunitlevel4= "Asela Specialized" if orgunitlevel4=="Asela Specialized Hospital"
replace organisationunitname= "Asela Specialized" if organisationunitname=="Asela Specialized Hospital"
replace orgunitlevel3="Bishoft Town ZHD" if orgunitlevel3=="Bishoftu Town ZHD"

replace orgunitlevel4= "Jimma University Specialized " if orgunitlevel4=="Jimma University Specialized Hospital"
replace organisationunitname= "Jimma University Specialized " if organisationunitname=="Jimma University Specialized Hospital"

keep org* opd* ipd* del_* pent_*
egen rowtotal=rowtotal(del_util1_21 ipd_util6_21), m 
drop if rowtot==.

duplicates tag org* , gen(dup)
drop if dup==1

merge 1:1 org* using "$user/$data/Data for analysis/Ethiopia_Jan19-Dec20_WIDE.dta"
drop _merge  

save "$user/$data/Data for analysis/Ethiopia_Jan19-Jun21_WIDE.dta", replace 
