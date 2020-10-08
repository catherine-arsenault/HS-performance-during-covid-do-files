* HS performance during Covid
* July 8, 2020 
* South Africa, January - December 2019
* Anna Gage, code checked by: Catherine Arsenault
clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/annagage/Dropbox (Harvard University)/Work/Short term projects/Covid Resilience data"

* Jan-Jul 2020
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/South Africa_2020_Jan-Jul_Facility.xlsx", firstrow clear
rename (orgunitlevel1 orgunitlevel2 orgunitlevel3 orgunitlevel4) (Province District SubDistrict Facility)
drop organisationunitname Hospitalpublic NonFixedfacilitysatellitehe
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for Analysis/tmp2020.dta", replace 
* Jan-Dec 2019
import excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Raw data/South Africa_2019_Jan-Dec_Facility.xlsx", firstrow clear

*Append in additional months
append using "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for Analysis/tmp2020.dta"

*Months
encode periodname, gen(month)
recode month (1 2=4) (3=8) (4=12) (5 6=2) (7 8=1) (9 10=7) (11 12 =6) (13 14=3) (15 16=5) (17=11) (18=10) (19=9)
lab def mlbl 1 "January" 2 "February" 3 "March" 4 "April" 5 "May" 6 "June" 7 "July" 8 "August" 9 "September" 10 "October" 11 "November" 12 "December"
lab val month mlbl
gen year = 2019 if regexm(periodname,"2019")
	replace year = 2020 if regexm(periodname,"2020") 
gen rmonth = month
	replace rmonth = 12+month if year==2020
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
*Facility type
gen factype = 1 if ProvincialTertiaryHospital==1
	replace factype =2 if DistrictHospital==1 
	replace factype =3 if PrivateHospital==1
	replace factype =4 if SpecialisedHospital==1
	replace factype =5 if SpecialisedPsychiatricHospital==1
	replace factype =6 if SpecialisedTBHospital==1
	replace factype =7 if regexm(Facility,"Hospital") & factype==.
	replace factype =8 if FixedCHCCDC==1 
	replace factype =9 if Fixedclinic==1
	replace factype =10 if regexm(Facility,"Mobile")
	replace factype =11 if regexm(Facility,"Pharmacy")
	replace factype =9 if regexm(Facility,"Clinic") & factype==.
	replace factype =13 if regexm(Facility,"Non-Medical") & factype==.
	replace factype =14 if regexm(Facility,"Correctional") & factype==.
	replace factype =12 if regexm(Facility,"Health Post") & factype==.

bysort Facility: carryforward factype, replace
gsort + Facility - month
by Facility: carryforward factype, replace

replace factype =15 if factype==.

lab def flbl 1 "Provincial tertiary hospital" 2 "District hospital" 3 "Private hospital" 4 "Specialized hospital" 5 "Specialized psychiatric hospital" 6 "Specialized TB hospital" 7 "Other hospital" 8 "Fixed CHC/CDC" 9 "Fixed clinic" 10 "Mobile" 11 "Pharmacy" 12 "Health post" 13 "Non-medical site" 14 "Correctional Center" 15 "Other"
lab val factype flbl
lab var factype "Facility type"

drop ProvincialTertiaryHospital DistrictHospital PrivateHospital SpecialisedHospital SpecialisedPsychiatricHospital SpecialisedTBHospital FixedCHCCDC Fixedclinic	

*District and subdistrict
encode SubDistrict, gen(subdist)
encode District, gen(dist)
drop District SubDistrict
lab def dlbl 1 "Amajuba District"	2 "Harry Gwala District"	3 "King Cetshwayo District"	4 "Ugu District"	5 "Umkhanyakude District"	6"Umzinyathi District"	7 "Uthukela District" 8	"Zululand District" 	9 "eThekwini Metropolitan"	10 "iLembe District"	11 "uMgungundlovu District"
lab val dist dlbl 

*Indicators
* Volumes
egen fp_util =rowtotal(FamilyPlanningAcceptor1019y FamilyPlanningAcceptor2035y FamilyPlanningAcceptor36year), missing

rename (Antenatal1stvisittotal Deliveryinfacilitysum Deliverybycaesareansection Infantpostnatalvisitwithin6 ///
        Diarrhoeaseparationunder5yea Pneumonianewinchildunder5y Severeacutemalnutritioninchi ///
		ARTclientremainonARTendof OPDheadcounttotal Diabetestreatmentvisit Hypertensionvisitbyclienton ///
		Emergencyheadcounttotal) ///
		(anc1_util del_util cs_util pnc_util diarr_util pneum_util sam_util art_util opd_util diab_util ///
		hyper_util er_util)
		
egen road_util = rowtotal(EmergencycaseMotorVehicleA AF AH), missing

* Quality 
rename (NeonateReceived24hrKMC Cervicalcancerscreening30yea ScreenforTBsymptoms5yearsa ///
		DSTBconfirmed5yearsandolde DSTBtreatmentstart5yearsan) ///
	   (kmcn_qual cerv_qual tbscreen_qual tbdetect_qual tbtreat_qual)

replace cerv_qual = Cervicalcancerscreeninginnon if rmonth>=16 
	
rename (DTaPIPVHibHBVHexavalent3r BCGdose Measles2nddose PCV3rddoseunder1year RV2nddoseunder1year ///
	    Immunisedfullyunder1yearnew) ///
	   (pent_qual bcg_qual measles_qual pneum_qual rota_qual vacc_qual)	
	   
*Mortality (numerators)
rename (Deathinfacility06days Stillbirthinfacility Maternaldeathinfacility Inpatientdeathstotal ///
		InpatientdeathTrauma InpatientdeathICU ) ///
		(newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num trauma_mort_num icu_mort_num) 
		
* Mortality (denominators)
rename ( AdmissionsTotal AdmissionsTrauma AdmissionICU)	( ipd_util trauma_util icu_util)
egen totaldel = rowtotal( del_util cs_util), m // did Deliveryinfacilitysum already include csections?

lab var fp_util "Number of new and current users of contraceptives THROUGH MARCH 2020 ONLY"
lab var road_util "Number of patients with road traffic injuries"
lab var hyper_util "Number of patients treated for hypertension THROUGH MARCH 2020 ONLY"
lab var totaldel "Total of deliveries and c-sections"

drop FamilyPlanningAcceptor1019y FamilyPlanningAcceptor2035y FamilyPlanningAcceptor36year ///
	 Deliveryinfacilitytotal Motherpostnatalvisitwithin6 EmergencycaseMotorVehicleA AF ///
	 PHCheadcount5yearsandolder  TBsymptomatic5yearsandolder TBinvestigationdone5yearsan OPV1st Livebirthinfacility Totalbirthsinfacilitysum AH AI Clientsscreen Cervicalcancer* Diabetesclient BK Casualty

order fp_util anc1_util-opd_util ipd_util er_util icu_util road_util trauma_util diab_util-tbtreat_qual vacc_qual pent_qual-rota_qual newborn_mort_num sb_mort_num mat_mort_num ipd_mort_num  icu_mort_num trauma_mort_num, after(factype)	

keep Province Facility rmonth-dist
save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/2019_fac_long.dta", replace 

* Reshape to wide
reshape wide fp_util-trauma_mort_num, i(Facility factype Province dist subdist) j(rmonth)

*2833 "facilities", though many are pharmacies, non-medical, etc. Dropping all facilities that don't report any data all year
egen all_visits =rowtotal(fp_util1-trauma_mort_num19), missing
drop if all_visits==.
drop all_visits
*Retains 1021 facilities with some data during 2019-2020

order Province dist subdist Facility factype fp_util* anc*_util* del_util* cs_util* pnc_util* diarr_util* pneum_util* sam_util* art_util* opd_util* ipd_util* er_util* road_util* diab_util* hyper_util* kmcn_qual* cerv_qual* tbscreen_qual* tbdetect_qual* tbtreat_qual* vacc_qual* pent_qual* bcg_qual* measles_qual* pneum_qual* rota_qual* newborn_mort_num* sb_mort_num*  mat_mort_num* ipd_mort_num*  icu_mort_num* icu_util* trauma_mort_num*

save "$user/HMIS Data for Health System Performance Covid (South Africa)/Data for analysis/fac_wide.dta", replace

*export excel using "$user/HMIS Data for Health System Performance Covid (South Africa)/Data cleaning/South Africa_2019_Jan-Dec_Facility_reshaped.xlsx", firstrow(var) replace



