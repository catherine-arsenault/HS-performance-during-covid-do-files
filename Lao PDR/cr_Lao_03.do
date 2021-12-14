* HS resilience during Covid
* Lao, 2021

* Deliveries
import excel "$user/$data/Raw data/2021/facility/Lao_2021_Jan_Oct_facility_4 Facility delivery.xls", firstrow clear
rename (January2021DeliveryatHF-June2021DeliveryatHF) (del_util1_21	del_util2_21 ///
	del_util3_21	del_util4_21	del_util5_21	del_util6_21 )
keep org* del*
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace

* Outpatient
import excel "$user/$data/Raw data/2021/facility/Lao_2021_Jan_Oct_facility_11 OPD.xls", firstrow clear
rename (January2021OPDOutpatientvis-June2021OPDOutpatientvisits) (opd_util1_21	///
opd_util2_21 opd_util3_21	opd_util4_21	opd_util5_21	opd_util6_21 )
keep org* opd*
merge 1:1 org* using "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace

*Inpatient
import excel "$user/$data/Raw data/2021/facility/Lao_2021_Jan_Oct_facility_12 IPD.xls", firstrow clear
rename (January2021IPDInpatientvisi-June2021IPDInpatientvisits) (ipd_util1_21	///
ipd_util2_21 ipd_util3_21	ipd_util4_21	ipd_util5_21	ipd_util6_21 )
keep org* ipd*
merge 1:1 org* using "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace

*Diabetes
import excel "$user/$data/Raw data/2021/facility/Lao_2021_Jan_Oct_facility_15 DM.xls", firstrow clear
rename (January2021OPDDiabetes-June2021OPDDiabetes) (diab_util1_21	///
diab_util2_21 diab_util3_21	diab_util4_21	diab_util5_21	diab_util6_21 )
keep org* diab*
merge 1:1 org* using "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace

*Pentavalent
import excel "$user/$data/Raw data/2021/facility/Lao_2021_Jan_Oct_facility_25 Penta3.xls", firstrow clear
rename (January2021MonthlyPenta3-June2021MonthlyPenta3) (pent_qual1_21	///
pent_qual2_21 pent_qual3_21	pent_qual4_21	pent_qual5_21	pent_qual6_21 )
keep org* pent*
merge 1:1 org* using "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta"
drop _merge
drop orgunitlevel1 
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace

import excel "$user/$data/Raw data/2021/facility/namematch.xlsx", firstrow clear
merge 1:1 orgunitlevel2 orgunitlevel3 orgunitlevel4 organisationunitname using ///
	"$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta"
drop _merge 
replace orgunitlevel2 = orgunitlevel2new if orgunitlevel2new!=""
replace orgunitlevel3 = orgunitlevel3new if orgunitlevel3new!=""
replace orgunitlevel4 = orgunitlevel4new if orgunitlevel4new!=""
replace organisationunitname = organisationunitnamenew if organisationunitnamenew!=""

drop *new 
save "$user/$data/Data for analysis/Lao_Jan19-Jun21_WIDE.dta", replace
