* Do file created by Anagaw Derseh, AAU
* Dec 9 2020
* Creates graphs by facility type
* Uses the dataset: Ethiopia_Jan19-Aug20_WIDE_CCA_DB


***CREATING IMPORTANT VARIABLES AND RESHAPE THE DATA INTO LONG FORM
**FIRST COPY AND PASTE THE DATA FROM EXCEL INTO STATA DATA EDITOR SHEET
rename organisationunitname facility
gen facility_type =1 if strpos(facility, "Health center" )
replace facility_type =1 if strpos(facility, "Health Center" )
replace facility_type =1 if strpos(facility, "health center" )
replace facility_type =0 if strpos(facility, "Hospital" )
replace facility_type =0 if strpos(facility, "hospital" )
replace facility_type =2 if strpos(facility, "Clinic" )
replace facility_type =2 if strpos(facility, "clinic" )
replace facility_type =0 if strpos(facility, "HOSPITAL" )
replace facility_type =2 if strpos(facility, "CLINIC" )
replace facility_type =1 if strpos(facility, "HEALTH CENTER" )
lab def facility_type 1 "Health center" 0 "Hospital" 2 "Clinic" 3 "Woreda health office"
replace facility_type =3 if strpos(facility, "WorHO" )
br facility facility_type
lab val facility_type facility_type
save "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_WIDE_CCA_DB.dta", replace



use "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_WIDE_CCA_DB.dta", clear
***RESHAPE THE DATA INTO LONG FORM AND CREATE NEW VARIABLE FOR MONTH OF SERVICE USE
***rename for reshape
rename *11_19 *Nov2019
rename *12_19 *Dec2019
rename *1_19 *Jan2019
rename *2_19 *Feb2019
rename *3_19 *Mar2019
rename *4_19 *Apr2019
rename *5_19 *May2019
rename *6_19 *Jun2019
rename *7_19 *Jul2019
rename *8_19 *Aug2019
rename *9_19 *Sep2019
rename *10_19 *Oct2019


rename *1_20 *Jan2020
rename *2_20 *Feb2020
rename *3_20 *Mar2020
rename *4_20 *Apr2020
rename *5_20 *May2020
rename *6_20 *Jun2020
rename *7_20 *Jul2020
rename *8_20 *Aug2020


reshape long fp_util diab_util hyper_util diab_qual_num hyper_qual_num sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom totalipd_mort, i(region zone facility facility_type) j(month, string) 

save "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_LONG_CCA_DB.dta", replace






use "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_LONG_CCA_DB.dta, clear
**Create new variable for months
gen month_new =1 if month == "Jan2019"
replace month_new =2 if month == "Feb2019"
replace month_new =3 if month == "Mar2019"
replace month_new =4 if month == "Apr2019"
replace month_new =5 if month == "May2019"
replace month_new =6 if month == "Jun2019"
replace month_new =7 if month == "Jul2019"
replace month_new =8 if month == "Aug2019"
replace month_new =9 if month == "Sep2019"
replace month_new =10 if month == "Oct2019"
replace month_new =11 if month == "Nov2019"
replace month_new =12 if month == "Dec2019"
replace month_new =13 if month == "Jan2020"
replace month_new =14 if month == "Feb2020"
replace month_new =15 if month == "Mar2020"
replace month_new =16 if month == "Apr2020"
replace month_new =17 if month == "May2020"
replace month_new =18 if month == "Jun2020"
replace month_new =19 if month == "Jul2020"
replace month_new =20 if month == "Aug2020"

lab def month_new 1 "Jan 2019" 2 "Feb 2019" 3 "Mar 2019" 4 "Apr 2019" 5 "May 2019" 6 "Jun 2019" 7 "Jul 2019" 8 "Aug 2019" 9 "Sep 2019" 10 "Oct 2019" 11 "Nov 2019" 12 "Dec 2019" 13 "Jan 2020" 14 "Feb 2020" 15 "Mar 2020" 16 "Apr 2020" 17 "May 2020" 18 "Jun 2020" 19 "Jul 2020" 20 "Aug 2020"
lab val month_new month_new
order month_new, after(month)
sort region zone facility facility_type month_new
drop if facility_type ==.

save "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_LONG_CCA_DB_cleaned.dta", replace





use "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_LONG_CCA_DB_cleaned.dta", clear
*** Creating total service utilziaiton by facility type and month
*** Reshape the data into wide form to create variables for monthly service use per facility type 
use "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_LONG_CCA_DB_cleaned.dta", clear
collapse (sum) fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom totalipd_mort diab_util hyper_util diab_qual_num hyper_qual_num, by(facility_type month_new) 
reshape wide fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util sam_util totaldel ipd_util er_util road_util cerv_qual opd_util hivsupp_qual_num vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual art_util newborn_mort_num sb_mort_num mat_mort_num er_mort_num ipd_mort_num kmc_qual_num kmc_qual_denom resus_qual_num resus_qual_denom totalipd_mort diab_util hyper_util diab_qual_num hyper_qual_num, i(month_new)  j(facility_type)  


*Modify var labels to make them understandable 
lab var  fp_util0 "Hospital, fp_util"
lab var  fp_util1 "Health center, fp_util"
lab var  fp_util2 "Clinic, fp_util"
lab var  fp_util3 "Woreda office, fp_util"

lab var  sti_util0 "Hospital, sti_util"
lab var  sti_util1 "Health center, sti_util"
lab var  sti_util2 "Clinic, sti_util"
lab var  sti_util3 "Woreda office, fp_util"


lab var  anc_util0 "Hospital, anc_util"
lab var  anc_util1 "Health center, anc_util"
lab var  anc_util2 "Clinic, anc_util"
lab var  anc_util3 "Woreda office, anc_util"

lab var  del_util0 "Hospital, del_util"
lab var  del_util1 "Health center, del_util"
lab var  del_util2 "Clinic, del_util"
lab var  del_util3 "Woreda office, del_util"


lab var  cs_util0 "Hospital, cs_util"
lab var  cs_util1 "Health center, cs_util"
lab var  cs_util2 "Clinic, cs_util"
lab var  cs_util3 "Woreda office, cs_util"



lab var  pnc_util0 "Hospital, pnc_util"
lab var  pnc_util1 "Health center, pnc_util"
lab var  pnc_util2 "Clinic, pnc_util"
lab var  pnc_util3 "Woreda office, pnc_util"

lab var  diarr_util0 "Hospital, diarr_util"
lab var  diarr_util1 "Health center, diarr_util"
lab var  diarr_util2 "Clinic, diarr_util"
lab var  diarr_util3 "Woreda office, diarr_util"

lab var  pneum_util0 "Hospital, pneum_util"
lab var  pneum_util1 "Health center, pneum_util"
lab var  pneum_util2 "Clinic, pneum_util"
lab var  pneum_util3 "Woreda office, pneum_util"

lab var  sam_util0 "Hospital, sam_util"
lab var  sam_util1 "Health center, sam_util"
lab var  sam_util2 "Clinic, sam_util"
lab var  sam_util3 "Woreda office, sam_util"

lab var  totaldel0 "Hospital, totaldel"
lab var  totaldel1 "Health center, totaldel"
lab var  totaldel2 "Clinic, totaldel"
lab var  totaldel3 "Woreda office, totaldel"

lab var  ipd_util0 "Hospital, ipd_util"
lab var  ipd_util1 "Health center, ipd_util"
lab var  ipd_util2 "Clinic, ipd_util"
lab var  ipd_util3 "Woreda office, ipd_util"

lab var  er_util0 "Hospital, er_util"
lab var  er_util1 "Health center, er_util"
lab var  er_util2 "Clinic, er_util"
lab var  er_util3 "Woreda office, er_util"

lab var  road_util0 "Hospital, road_util"
lab var  road_util1 "Health center, road_util"
lab var  road_util2 "Clinic, road_util"
lab var  road_util3 "Woreda office, road_util"

lab var  cerv_qual0 "Hospital, cerv_qual"
lab var  cerv_qual1 "Health center, cerv_qual"
lab var  cerv_qual2 "Clinic, cerv_qual"
lab var  cerv_qual3 "Woreda office, cerv_qual"

lab var  opd_util0 "Hospital, opd_util"
lab var  opd_util1 "Health center, opd_util"
lab var  opd_util2 "Clinic, opd_util"
lab var  opd_util3 "Woreda office, opd_util"

lab var  hivsupp_qual_num0 "Hospital, hivsupp_qual_num"
lab var  hivsupp_qual_num1 "Health center, hivsupp_qual_num"
lab var  hivsupp_qual_num2 "Clinic, hivsupp_qual_num"
lab var  hivsupp_qual_num3 "Woreda office, hivsupp_qual_num"


lab var  vacc_qual0 "Hospital, vacc_qual"
lab var  vacc_qual1 "Health center, vacc_qual"
lab var  vacc_qual2 "Clinic, vacc_qual"
lab var  vacc_qual3 "Woreda office, vacc_qual"


lab var  pent_qual0 "Hospital, pent_qual"
lab var  pent_qual1 "Health center, pent_qual"
lab var  pent_qual2 "Clinic, pent_qual"
lab var  pent_qual3 "Woreda office, pent_qual"

lab var  bcg_qual0 "Hospital, bcg_qual"
lab var  bcg_qual1 "Health center, bcg_qual"
lab var  bcg_qual2 "Clinic, bcg_qual"
lab var  bcg_qual3 "Woreda office, bcg_qual"

lab var  measles_qual0 "Hospital, measles_qual"
lab var  measles_qual1 "Health center, measles_qual"
lab var  measles_qual2 "Clinic, measles_qual"
lab var  measles_qual3 "Woreda office, measles_qual"


lab var  opv3_qual0 "Hospital, opv3_qual"
lab var  opv3_qual1 "Health center, opv3_qual"
lab var  opv3_qual2 "Clinic, opv3_qual"
lab var  opv3_qual3 "Woreda office, opv3_qual"


lab var  pneum_qual0 "Hospital, pneum_qual"
lab var  pneum_qual1 "Health center, pneum_qual"
lab var  pneum_qual2 "Clinic, pneum_qual"
lab var  pneum_qual3 "Woreda office, pneum_qual"

lab var  rota_qual0 "Hospital, rota_qual"
lab var  rota_qual1 "Health center, rota_qual"
lab var  rota_qual2 "Clinic, rota_qual"
lab var  rota_qual3 "Woreda office, rota_qual"

lab var  art_util0 "Hospital, art_util"
lab var  art_util1 "Health center, art_util"
lab var  art_util2 "Clinic, art_util"
lab var  art_util3 "Woreda office, art_util"


lab var  newborn_mort_num0 "Hospital, newborn_mort_num"
lab var  newborn_mort_num1 "Health center, newborn_mort_num"
lab var  newborn_mort_num2 "Clinic, newborn_mort_num"
lab var  newborn_mort_num3 "Woreda office, newborn_mort_num"

lab var  sb_mort_num0 "Hospital, sb_mort_num"
lab var  sb_mort_num1 "Health center, sb_mort_num"
lab var  sb_mort_num2 "Clinic, sb_mort_num"
lab var  sb_mort_num3 "Woreda office, sb_mort_num"


lab var  mat_mort_num0 "Hospital, mat_mort_num"
lab var  mat_mort_num1 "Health center, mat_mort_num"
lab var  mat_mort_num2 "Clinic, mat_mort_num"
lab var  mat_mort_num3 "Woreda office, mat_mort_num"


lab var  er_mort_num0 "Hospital, er_mort_num"
lab var  er_mort_num1 "Health center, er_mort_num"
lab var  er_mort_num2 "Clinic, er_mort_num"
lab var  er_mort_num3 "Woreda office, er_mort_num"


lab var  ipd_mort_num0 "Hospital, ipd_mort_num"
lab var  ipd_mort_num1 "Health center, ipd_mort_num"
lab var  ipd_mort_num2 "Clinic, ipd_mort_num"
lab var  ipd_mort_num3 "Woreda office, ipd_mort_num"

lab var  kmc_qual_num0 "Hospital, kmc_qual_num"
lab var  kmc_qual_num1 "Health center, kmc_qual_num"
lab var  kmc_qual_num2 "Clinic, kmc_qual_num"
lab var  kmc_qual_num3 "Woreda office, kmc_qual_num"

lab var  kmc_qual_denom0 "Hospital, kmc_qual_denom"
lab var  kmc_qual_denom1 "Health center, kmc_qual_denom"
lab var  kmc_qual_denom2 "Clinic, kmc_qual_denom"
lab var  kmc_qual_denom3 "Woreda office, kmc_qual_denom"

lab var  resus_qual_num0 "Hospital, resus_qual_num"
lab var  resus_qual_num1 "Health center, resus_qual_num"
lab var  resus_qual_num2 "Clinic, resus_qual_num"
lab var  resus_qual_num3 "Woreda office, resus_qual_num"

lab var  resus_qual_denom0 "Hospital, resus_qual_denom"
lab var  resus_qual_denom1 "Health center, resus_qual_denom"
lab var  resus_qual_denom2 "Clinic, resus_qual_denom"
lab var  resus_qual_denom3 "Woreda office, resus_qual_denom"

lab var  totalipd_mort0 "Hospital, totalipd_mort"
lab var  totalipd_mort1 "Health center, totalipd_mort"
lab var  totalipd_mort2 "Clinic, totalipd_mort"
lab var  totalipd_mort3 "Woreda office, totalipd_mort"

lab var  diab_util0 "Hospital, diab_util"
lab var  diab_util1 "Health center, diab_util"
lab var  diab_util2 "Clinic, diab_util"
lab var  diab_util3 "Woreda office, diab_util"

lab var  hyper_util0 "Hospital, hyper_util"
lab var  hyper_util1 "Health center, hyper_util"
lab var  hyper_util2 "Clinic, hyper_util"
lab var  hyper_util3 "Woreda office, hyper_util"

lab var  diab_qual_num0 "Hospital, diab_qual_num"
lab var  diab_qual_num1 "Health center, diab_qual_num"
lab var  diab_qual_num2 "Clinic, diab_qual_num"
lab var  diab_qual_num3 "Woreda office, diab_qual_num"

lab var  hyper_qual_num0 "Hospital, hyper_qual_num"
lab var  hyper_qual_num1 "Health center, hyper_qual_num"
lab var  hyper_qual_num2 "Clinic, hyper_qual_num"
lab var  hyper_qual_num3 "Woreda office, hyper_qual_num"

rename *0 *_Ho
rename *1 *_HC
rename *2 *_Cl
rename *3 *_WHO


save "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_DB_TOTAL_reshaped.dta", replace














*****TREND ANALYSIS IN SERVICE UTILIZATION BASED ON FACILITY TYPE

use "/Users/anagaw/Documents/HS performance/Ethiopia_Jan19-Aug20_DB_TOTAL_reshaped.dta", clear

***VOLUME OF RMNCH SERVICES BASED ON FACILITY TYPE 
*Figure 1: Contraceptive users
graph twoway line fp_util_Ho  fp_util_HC fp_util_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of new and current users of contraceptives}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of consultations for STI care  
graph twoway line sti_util_Ho  sti_util_HC sti_util_Cl    month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of consultations for STI care}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of caesarean sections
graph twoway line cs_util_Ho cs_util_HC cs_util_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of caesarean sections}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children treated with ORS for diarrhea
graph twoway line diarr_util_Ho diarr_util_HC diarr_util_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children treated with ORS for diarrhea}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of consultations for sick child care - pneumonia
graph twoway line pneum_util_Ho  pneum_util_HC  pneum_util_Cl  month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of consultations for sick child care - pneumonia}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children screened for malnutrition
graph twoway line sam_util_Ho  sam_util_HC  sam_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children screened for malnutrition}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of postnatal visits w. 7 days of birth 
graph twoway line pnc_util_Ho pnc_util_HC  pnc_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of postnatal visits w. 7 days of birth}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Antinatal care visit
graph twoway line anc_util_Ho anc_util_HC anc_util_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of antenatal care visits}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Facility delivery
graph twoway line del_util_Ho del_util_HC del_util_Cl  month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of facility deliveries}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 







***VACCINES
*Figure 1: Number of fully vaccinated children by age 1
graph twoway line vacc_qual_Ho  vacc_qual_HC vacc_qual_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of fully vaccinated children by age 1}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 
 
*Figure 1: Number of children vaccinated with bcg vaccine
graph twoway line bcg_qual_Ho bcg_qual_HC  bcg_qual_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with bcg vaccine}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children vaccinated with 3rd dose pentavalent
graph twoway line pent_qual_Ho pent_qual_HC pent_qual_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with 3rd dose pentavalent}", size(medium)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children vaccinated with measles vaccine
graph twoway line measles_qual_Ho  measles_qual_HC measles_qual_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with measles vaccine}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children vaccinated with 3rd dose orial polio vaccine
graph twoway line opv3_qual_Ho  opv3_qual_HC  opv3_qual_Cl  month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with 3rd dose orial polio vaccine}", size(medlarge)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children vaccinated with pneumococcal vaccine
graph twoway line pneum_qual_Ho pneum_qual_HC pneum_qual_Cl month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with pneumococcal vaccine}", size(medlarge)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of children vaccinated with rotavirus vaccine
graph twoway line rota_qual_Ho rota_qual_HC rota_qual_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of children vaccinated with rotavirus vaccine}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 







***VOLUME OF OTHER SERVICES
*Figure 1: Number of diabetic patient visits PC clinics 
graph twoway line diab_util_Ho diab_util_HC diab_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of diabetic patient visits PC clinics }") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of hypertensive patients visits PC clinics
graph twoway line hyper_util_Ho hyper_util_HC hyper_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of hypertensive patients visits PC clinics}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of adult and children on ART 
graph twoway line art_util_Ho art_util_HC art_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of adult and children on ART }") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number outpatient (family medicine clinic & opd speciality) visits
graph twoway line opd_util_Ho opd_util_HC opd_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number outpatient (family medicine clinic & opd speciality) visits}", size(medium)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of emergency room visits
graph twoway line er_util_Ho er_util_HC er_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of emergency room visits}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of inpatient admissions total
graph twoway line ipd_util_Ho ipd_util_HC ipd_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of inpatient admissions total}", size(medlarge)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of road traffic injuries 
graph twoway line road_util_Ho road_util_HC road_util_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of road traffic injuries}") xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 

*Figure 1: Number of women 30-49 screened with VIA for cervical cancer
graph twoway line cerv_qual_Ho cerv_qual_HC cerv_qual_Cl   month_new, xlabel(1 4 8 12 16 20, valuelabel) title("{bf:Number of women 30-49 screened with VIA for cervical cancer}", size(medium)) xline(15, lwidth(thick))  lwidth(*1.9 *1.9 *1.9) xtitle(Month) 
















