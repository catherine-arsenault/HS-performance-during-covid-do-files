* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Neena Kappoor

clear all
set more off

use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta"


drop if year == 2019
drop if month == 1 | month == 2

*Primary care variables selected: ANC, Contraceptives, PNC, *Diarrhea, Pneumonia, *Pentavalent vaccine, Measles vaccine, Outpatient, Diabetes, Hypertension, HIV testing, TB detection, 

*** TABLE 1 ***
* Simple comparison of means 
tabstat fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual if eased_fixed == 0 , stat(N mean) col(stat)
tabstat fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual if eased_fixed == 1 , stat(N mean) col(stat)

summtab if post == 0, contvars(fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(eased_fixed) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(pre-period) replace title(Table1)

summtab if post == 1, contvars(fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(eased_fixed) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(post-period) replace title(Table1)

summtab if eased_fixed == 1, contvars(fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(post) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(treated) replace title(Table1)

summtab if eased_fixed == 0, contvars(fp_util anc_util pnc_util pneum_util measles_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(post) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(control) replace title(Table1)


* Number of new COVID cases - since COVID cases is at the district level and treatment status is at the palika level, this is basically double/triple/quadruple counting the COVID cases ... 
preserve 
collapse (first) covid_case, by(orgunitlevel3 organisationunitname month eased_fixed post)
collapse (sum) covid_case, by(eased_fixed post)
export excel "$user/$analysis/Table1.xlsx", firstrow(variables) sheet(covid_cases, replace)
restore 

*Palika populations
preserve
collapse (first) Totalpopulation, by(organisationunitname eased_fixed)
collapse (sum) Totalpopulation, by(eased_fixed)

export excel "$user/$analysis/Table1.xlsx", firstrow(variables) sheet(palikapopulationtotal, replace)
restore 

preserve
collapse (first) Totalpopulation, by(organisationunitname eased_fixed)
collapse (mean) Totalpopulation, by(eased_fixed)
export excel "$user/$analysis/Table1.xlsx", firstrow(variables) sheet(palikapopulationavg, replace)

restore 


*** Difference-in-differences analysis - time varying treatment status 

eststo: xtreg fp_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg measles_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)

eststo: xtreg opd_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab using "$user/$analysis/DD tables/ddtable.rtf", replace ci r2 ar2 compress nobaselevels drop(_cons)title("DD regression: Primary care services") cells (b(star fmt(3)) ci(par fmt(2))) mtitles ("Contraceptive users" "ANC Visits" "PNC Visits" "Child pneumonia visits" "Measles vaccine" "Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB cases detected") rename(eased "Lockdowns lifted" covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" )

eststo clear

*** Difference-in-differences analysis - time varying treatment status - dropping month 3 as a sensitivity analysis 

preserve 
drop if month == 3
eststo: xtreg fp_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg measles_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)

eststo: xtreg opd_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)


esttab using "$user/$analysis/DD tables/ddtablesa.rtf", replace ci r2 ar2 compress nobaselevels drop(_cons)title("DD regression: Primary care services") cells (b(star fmt(3)) ci(par fmt(2))) mtitles ("Contraceptive users" "ANC Visits" "PNC Visits" "Child pneumonia visits" "Measles vaccine" "Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB cases detected") rename(eased "Lockdowns lifted" covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" )

eststo clear
restore 



* Parallel trends assessment
preserve
drop if month == 3

eststo: xtreg fp_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg anc_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed  
eststo: xtreg pnc_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg pneum_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg measles_qual month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg opd_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed 
eststo: xtreg  diab_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg hyper_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg hivtest_qual month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
eststo: xtreg tbdetect_qual month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed


esttab using "$user/$analysis/DD tables/ddtablept.rtf", replace ci r2 ar2 compress nobaselevels drop(_cons 1.eased_fixed)title("DD regression: Parallel trends test") cells (b(star fmt(3)) ci(par fmt(2))) mtitles ( "Contraceptive users" "ANC Visits" "PNC Visits" "Child pneumonia visits" "Measles vaccine" "Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased "Lockdowns lifted"covid_case "Covid cases" 5.month "May" 6.month "June" 8.month "August" 5.month#1.eased_fixed "May*Lifted" 6.month#1.eased_fixed "June*Lifted" 8.month#1.eased_fixed "August*Lifted")


eststo clear 


restore 

*** Excluded Diarrhea visits and Pentavalent vaccines because of parallel trends test
xtreg diarr_util month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed
xtreg pent_qual month##eased_fixed covid_case, i(palikaid) fe cluster(palikaid)
test 5.month#1.eased_fixed 6.month#1.eased_fixed


/*
* Pre/post instead of month fixed effects - RMNCAH
eststo: xtreg anc_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg fp_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg pent_qual eased covid_case post, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: RMNCH Services") mtitles ("ANC Visits" "Contraceptives" "PNC Visits" "Child diarrhea visits" "Child pneumonia visits" "Pentavalent vaccine") rename(eased Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

* Pre/Post instead of month fixed effects - Other services 
eststo: xtreg opd_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased covid_case post, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased covid_case post, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: Other primary care services") mtitles ("Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased Eased covid_case "Covid cases")

eststo clear
