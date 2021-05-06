* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off

use "$user/$data/Data for analysis/epal_palika_March20-Oct20_LONG_NK_1.dta"

* eased_: whether the municpality eased or not in that month 
* post: pre period is month 6, post period is month 8 
* eased_cat: three-category, fully eased, fully maintained and switched in months 8 and 9 

*** TABLE 4 ***
* Simple comparison of means - two period comparison of just April to June compared to August to October 
tabstat fp_util anc_util del_util cs_util pnc_util if month == 3 | 4 | 5 | 6, stat(N mean) col(stat)
tabstat fp_util anc_util del_util cs_util pnc_util if month == 8 | 9 & eased_ == 0, stat(N mean) col(stat)
tabstat fp_util anc_util del_util cs_util pnc_util if month == 8 | 9 & eased_ == 1 , stat(N mean) col(stat)


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

restore

*** MODEL 3 ***
* Difference-in-differences regression with multiple pre and post periods, time-varying treatment 

preserve

keep if inlist(month, 3, 4, 5, 6, 8, 9)

eststo: xtreg fp_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg del_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg cs_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("Table 8: DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 9") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(eased_ Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8")

eststo clear
restore

preserve
keep if inlist(month, 3, 4, 5, 6, 8)

eststo: xtreg fp_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg del_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg cs_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels title("Table 9: DD regression with multiple pre and post periods, time-varying treatment status, Months 3 through 8") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(eased_ Eased covid_case "Covid cases" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8") 

eststo clear
restore

* eased_ is the DD coefficient 

*** MODEL 4 ***
*** Multiple pre-periods and August and September as the post-period, full eased, fully maintained and switched ***

*** This is the analysis Sebastian has suggested instead of the time-varying one above, but I think considering only ~50 of the palikas eased_all (maintained policies for months 8 and 9) out of 753 palikas, that might be why these numbers are kind of odd?? 

preserve 

keep if inlist(month, 3, 4, 5, 6, 8, 9)

gen eased_all = eased_cat == 2

gen maintained_all = eased_cat == 1

gen switch = eased_cat == 3

order org* year month post eased_ eased_cat eased_all maintained_all switch

eststo: xtreg fp_util eased_all##month switch##month covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg anc_util eased_all##month switch##month covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg pnc_util eased_all##month switch##month covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg del_util eased_all##month switch##month covid_case i.month, i(palikaid) fe cluster(palikaid)
eststo: xtreg cs_util eased_all##month switch##month covid_case i.month, i(palikaid) fe cluster(palikaid)

esttab, ci r2 ar2 compress nobaselevels drop(1.eased_all#4.month 1.eased_all#5.month 1.eased_all#6.month 1.eased_all#9.month 1.switch#4.month 1.switch#5.month 1.switch#6.month 1.switch#9.month) title("Table 10: Difference-in differences regression accounting for municipalities that switched") mtitles ("Contraceptives" "ANC Visits" "PNC Visits" "Deliveries" "C-sections") rename(1.eased_all "Eased all" 4.month "Month 4" 5.month "Month 5" 6.month "Month 6" 8.month "Month 8" 9.month "Month 9" 1.eased_all#8.month "EasedxMo 8" 1.switch "Switch" 1.switch#8.month "SwtchxMo 8" covid_case "Covid cases")

* 1.switch#8.month and 1.eased_#8.month are DD coefficents 

eststo clear
restore

*** I reported these results from Model 3 in my thesis presentation because I think maybe just looking at the effects right after the easing (month 8 and maybe month 9) makes the most sense since most lift in month 9 and 10 (Table 3 in my Masters Thesis Draft)


/*  

*TIME VARYING POLICY CHANGE
* Cluster SEs at the palika level because of serial correlation: you have multiple months of observation for each palika

*DID estimates with variable policy changes without covid case
xtreg fp_sa_util eased_ i.month, i(palikaid) fe cluster(palikaid)
xtreg anc_util eased_ i.month, i(palikaid) fe cluster(palikaid)
xtreg pnc_util eased_ i.month, i(palikaid) fe cluster(palikaid)
xtreg del_util eased_ i.month, i(palikaid) fe cluster(palikaid)
xtreg cs_util eased_ i.month, i(palikaid) fe cluster(palikaid)

*Sensitivity analyses (will add here)
preserve
keep if inlist(orgunitlevel2, "5 Province 5", "6 Karnali Province", "7 Sudurpashchim Province")
xtreg fp_sa_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
xtreg anc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
xtreg pnc_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
xtreg del_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
xtreg cs_util eased_ covid_case i.month, i(palikaid) fe cluster(palikaid)
restore
