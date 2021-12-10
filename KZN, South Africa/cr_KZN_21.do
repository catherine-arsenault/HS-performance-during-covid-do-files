* HS performance during Covid
* July 8, 2020 
* South Africa, January 2019 - December 2020 
* Anna Gage, code checked by: Catherine Arsenault
clear all
set more off	

* Jan-Dec 2020
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/South Africa_Province_District_Sub_District_Facility - Dec2020.xlsx", firstrow clear
rename (orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 OPDheadcountsum) (Province District SubDistrict Facility OPDheadcounttotal)
drop organisationunitname Hospitalpublic NonFixedfacilitysatellitehe
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020.dta", replace 
	/*OPD was missing from original 2020 data-- need to merge in separately--NO LONGER NEED TO DO WITH UPDATED 2020 DATA
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/Missing Facility Data Element - 18Oct2020.xls", firstrow clear
rename (organisationunitname) (Facility)
drop orgunitlevel1-orgunitlevel4 Admissions I
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020_2.dta", replace */

*Jan-June 2021
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/SA Facility Data Jan-Jun2021 - Dec2021.xlsx", firstrow clear
rename (orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4 OPDheadcountsum) (Province District SubDistrict Facility OPDheadcounttotal)
drop organisationunitname 
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2021.dta", replace 

* Jan-Dec 2019
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/South Africa_2019_Jan-Dec_Facility.xlsx", firstrow clear

*Append in additional months
append using "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020.dta"
/*merge 1:1 Facility periodname using "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020_2.dta"
drop _merge */

*Append 2021 data

append using "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2021.dta"

*Months
encode periodname, gen(month)
recode month (1/3=4) (4 5=8) (6 7=12) (8/10=2) (11/13=1) (14 15=7) (16/18=6) (19/21=3) (22/24=5) (25 26=11) (27 28=10) (29 30=9)
lab def mlbl 1 "January" 2 "February" 3 "March" 4 "April" 5 "May" 6 "June" 7 "July" 8 "August" 9 "September" 10 "October" 11 "November" 12 "December"
lab val month mlbl
gen year = 2019 if regexm(periodname,"2019")
	replace year = 2020 if regexm(periodname,"2020") 
	replace year = 2021 if regexm(periodname,"2021")
gen rmonth = month
	replace rmonth = 12+month if year==2020
	replace rmonth = 24+month if year==2021
lab var month "Month"
lab var year "Year"
lab var rmonth "Running month"
drop periodname

*Drop all empty variables
foreach var of varlist _all {
     capture assert mi(`var')
     if !_rc {
        drop `var'
     }
 }
**** Renaming variables and creating indicators****

*District and subdistrict
encode SubDistrict, gen(subdist)
encode District, gen(dist)
drop District SubDistrict
lab def dlbl 1 "Amajuba District"	2 "Harry Gwala District"	3 "King Cetshwayo District"	4 "Ugu District"	5 "Umkhanyakude District"	6"Umzinyathi District"	7 "Uthukela District" 8	"Zululand District" 	9 "eThekwini Metropolitan"	10 "iLembe District"	11 "uMgungundlovu District"
lab val dist dlbl 

*Indicators: only keep the 2021 indicators
* Volumes

rename (Deliveryinfacilitysum Deliverybycaesareansection OPDheadcounttotal Diabetestreatmentvisit ) (totaldel cs_util opd_util diab_util)

replace totaldel = cs_util if cs_util>totaldel & cs_util<.
gen del_util = totaldel-cs_util
replace del_util = totaldel if del_util==.

rename DTaPIPVHibHBVHexavalent3r pent_qual 	
	   
*replace AdmissionsTotal = BK if rmonth>12
rename AdmissionsTotal ipd_util 

lab var totaldel "Total of deliveries and c-sections"

keep Province-Facility totaldel opd_util diab_util pent_qual ipd_util rmonth-dist

save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/2021_fac_long.dta", replace 

* Reshape to wide
reshape wide totaldel-ipd_util, i(Facility Province dist subdist) j(rmonth)

*2858 "facilities", though many are pharmacies, non-medical, etc. Dropping all facilities that don't report any data
egen all_visits =rowtotal(totaldel* opd_util* diab_util* pent_qual* ipd_util*), missing
drop if all_visits==.
drop all_visits
*Retains 1090 facilities with some data during 2019-2021

save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide21.dta", replace

rm "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020.dta"
rm "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2021.dta"
*rm "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/tmp2020_2.dta"



