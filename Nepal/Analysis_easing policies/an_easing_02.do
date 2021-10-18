* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off

use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta"

drop if year == 2019
drop if month == 1 | month == 2

*Primary care variables selected: ANC, Contraceptives, PNC, Diarrhea, Pneumonia, Pentavalent vaccine, Outpatient, Diabetes, Hypertension, HIV testing, TB detection, 

*** TABLE 1 ***
* Simple comparison of means 
tabstat anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 0 , stat(N mean) col(stat)
tabstat anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 1 , stat(N mean) col(stat)
tabstat  anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util ///
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 0, stat(N mean) col(stat)
tabstat  anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 1 , stat(N mean) col(stat)

** Do you have any suggestions for producing the Table 1? I tried summtab, but I still have to divide the N by number of months to get palikas per service type. I also don't think I need SD or %nonmissing. 

summtab if post == 0, contvars(anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(eased_fixed) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(pre-period) replace title(Table1)

summtab if post == 1, contvars(anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util hyper_util hivtest_qual tbdetect_qual)  by(eased_fixed) pnonmiss mean directory("$user/$analysis") excel excelname(Table1) sheetname(post-period) replace title(Table1)

*** Difference-in-differences analysis - time varying treatment status 
* RMNCAH Services 

eststo: xtreg anc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg fp_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pent_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: RMNCH Services") mtitles ("ANC Visits" "Contraceptives" "PNC Visits" "Child diarrhea visits" "Child pneumonia visits" "Pentavalent vaccine") rename(eased Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear


* Other primary care services
eststo: xtreg opd_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: Other primary care services") mtitles ("Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8")

eststo clear
