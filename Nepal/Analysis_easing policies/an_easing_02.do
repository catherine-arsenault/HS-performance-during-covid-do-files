* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off

use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta"

*Primary care variables selected: ANC, Contraceptives, PNC, Diarrhea, Pneumonia, Pentavalent vaccine, Outpatient, Diabetes, Hypertension, HIV testing, TB detection, 

*** TABLE 4 ***
* Simple comparison of means - two period comparison of just April to June compared to August to September
tabstat anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 0 & post == 0, stat(N mean) col(stat)
tabstat anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 1 & post == 0, stat(N mean) col(stat)
tabstat  anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util ///
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 0 & post == 1, stat(N mean) col(stat)
tabstat  anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual if eased_fixed == 1 & post == 1, stat(N mean) col(stat)


*** Difference-in-differences analysis- treatment status fixed based on treatment in month 8 
* RMNCAH Services 

eststo: xtreg anc_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg fp_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pent_qual eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: RMNCH Services") mtitles ("ANC Visits" "Contraceptives" "PNC Visits" "Child diarrhea visits" "Child pneumonia visits" "Pentavalent vaccine") rename(eased_fixed_post Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

* Other services
eststo: xtreg opd_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased_fixed_post covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased_fixed_post Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

*** Difference-in-differences analysis - time varying treatment status 
* RMNCAH Services 

eststo: xtreg anc_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg fp_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pent_qual eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: RMNCH Services") mtitles ("ANC Visits" "Contraceptives" "PNC Visits" "Child diarrhea visits" "Child pneumonia visits" "Pentavalent vaccine") rename(eased_tv Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

* Other services
eststo: xtreg opd_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased_tv covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased_tv Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

*** Difference-in-differences analysis - early versus late  
* RMNCAH Services 

eststo: xtreg anc_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg fp_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pent_qual eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression: RMNCH Services") mtitles ("ANC Visits" "Contraceptives" "PNC Visits" "Child diarrhea visits" "Child pneumonia visits" "Pentavalent vaccine") rename(eased_fixed_post "Eased early" eased_late_post "Eased late" covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear

* Other services
eststo: xtreg opd_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diab_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hyper_util eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg hivtest_qual eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg tbdetect_qual eased_fixed_post eased_late_post covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Outpatient visits" "Diabetes visits" "Hypertension visits" "HIV tests" "TB tests") rename(eased_fixed_post "Eased early" eased_late_post "Eased late" covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear


/* Old code 
*** MODEL 1 **** 
*** Simple DD with two time periods - pre period is month 6, post period is month 8 *** 
eststo: xtreg fp_util post eased_ covid_case, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util post eased_ covid_case, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util post eased_ covid_case, i(palikaid) fe cluster(palikaid)
eststo: xtreg del_util post eased_ covid_case, i(palikaid) fe cluster(palikaid)
eststo: xtreg cs_util post eased_ covid_case, i(palikaid) fe cluster(palikaid)
esttab, rename(post Post)
esttab, ci r2 ar2 compress title("Table 5: Simple DD regression, eased in August, controlling for Covid-19 cases") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(post Post eased_ Eased "covid_case" "Covid case")

* eased_ is the DD coeffcients 

eststo clear 

*** MODEL 2***
*** Multiple pre-periods and August as the post-period ***
preserve 
* Only keep 3 months before and 1 month after, omitting July
keep if inlist(month, 4, 5, 6, 8)

* Create a variable = 1 for those areas that eased by August
* It's = 1 also for the pre-period: it's a defining and fixed characteristic of the places that at some time eased restrictions.
	gen tmp = 1 if eased_==1
	recode tmp (.=0)
	bysort palikaid:egen evereased = max(tmp)


eststo: xtreg fp_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg anc_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg pnc_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg del_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg cs_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

esttab, ci r2 ar2 compress nobaselevels drop(1.evereased) title("Table 6: DD regression analysis with 4 time periods, fixed treatment status") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(covid_case "Covid cases" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 5.month#1.evereased "Eased*Mo 5" 6.month#1.evereased "Eased*Mo 6" 8.month#1.evereased "Eased*Mo 8")

* 8.month#evereased is DD coefficient 

eststo clear 


*** ADDING MORE INDICATORS *** 

eststo: xtreg pent_qual covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg bcg_qual covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg measles_qual covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg opv3_qual covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg pneum_qual covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg diarr_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

eststo: xtreg pneum_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

test 5.month#1.evereased  6.month#1.evereased

esttab, ci r2 ar2 compress nobaselevels drop(1.evereased) title("Table 6: DD regression analysis with 4 time periods, fixed treatment status") mtitles ("Pentavalent vaccine" "BCG vaccine" "Measles vaccine" "OPV vaccine" "Pneum vaccine" "Diarrhea visits" "Pneumonia visits") rename(covid_case "Covid cases" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 5.month#1.evereased "Eased*Mo 5" 6.month#1.evereased "Eased*Mo 6" 8.month#1.evereased "Eased*Mo 8")

* 8.month#evereased is DD coefficient 

eststo clear 


restore

*** MODEL 3 ***
* Difference-in-differences regression with multiple pre and post periods, time-varying treatment

eststo: xtreg fp_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg del_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg cs_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("Table 8: DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(eased_ Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear


*** ADDING MORE INDICATORS ****

eststo: xtreg pent_qual eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg bcg_qual eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg measles_qual eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg opv3_qual eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_qual eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Pentavalent vaccine" "BCG vaccine" "Measles vaccine" "OPV vaccine" "Pneum vaccine" "Diarrhea visits" "Pneumonia visits") rename(eased_ Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9")

eststo clear


*** MODEL 4 *** NOT SURE 
*** Multiple pre-periods and August and September as post period, looking at if the effect differs based on easing in months 8 and 9, or easing in just month 9 ***

gen early = eased_cat == 2

gen late = eased_cat == 3

replace early = . if month == 7
replace late = . if month == 7
replace late = 0 if month == 8

order org* year month post eased_ early late eased_cat eased_8_20

eststo: xtreg fp_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

test early==late

eststo: xtreg anc_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

test early==late

eststo: xtreg pnc_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

test early==late

eststo: xtreg del_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

test early==late

eststo: xtreg cs_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

test early==late

esttab, ci r2 ar2 compress nobaselevels title("Table 10: Difference-in differences regression looking at easing in month 8 versus month 9") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(eased_ "Eased" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9" early "Early" late "Late"  covid_case "Covid cases")

eststo clear 

*** ADDING MORE INDICATORS *** 

eststo: xtreg pent_qual early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg bcg_qual early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg measles_qual early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg opv3_qual early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_qual early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg diarr_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pneum_util early late covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("Table 10: Difference-in differences regression looking at easing in month 8 versus month 9") mtitles ("Pentavalent vaccine" "BCG vaccine" "Measles vaccine" "OPV vaccine" "Pneum vaccine" "Diarrhea visits" "Pneumonia visits") rename(eased_ "Eased" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9" early "Early" late "Late"covid_case "Covid cases")

eststo clear 


