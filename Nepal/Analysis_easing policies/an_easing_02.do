* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
set more off
use "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_easing.dta"

* Simple comparison of means - two period comparison of just April to June compared to August to October 
tabstat fp_sa_util anc_util del_util cs_util pnc_util if post_simp==0 , stat(N mean) col(stat)
tabstat fp_sa_util anc_util del_util cs_util pnc_util if post_simp==1 & eased_ == 0 , stat(N mean) col(stat)
tabstat fp_sa_util anc_util del_util cs_util pnc_util if post_simp==1 & eased_ == 1 , stat(N mean) col(stat)

* Mean comparison of palikas that fully maintained, fully eased or switched (just post-period, Aug & Sept)
tabstat fp_sa_util anc_util del_util cs_util pnc_util if eased_cat == 1 , stat(N mean) col(stat)
tabstat fp_sa_util anc_util del_util cs_util pnc_util if eased_cat == 2 , stat(N mean) col(stat)
tabstat fp_sa_util anc_util del_util cs_util pnc_util if eased_cat == 3 , stat(N mean) col(stat)

*Sebastian's suggested preliminary analysis (fixed, post period as just August)
preserve 
* Only keep 3 months before and 1 month after, omitting July
keep if inlist(month, 4, 5, 6, 8)

* Create a variable = 1 for those areas that eased by August
* It's = 1 also for the pre-period: it's a defining and fixed characteristic of the places that at some time eased restrictions.
	gen tmp = 1 if eased_==1
	recode tmp (.=0)
	bysort palikaid:egen evereased = max(tmp)

xtreg fp_sa_util month##evereased, i(palikaid) fe cluster(palikaid)

xtreg anc_util month##evereased, i(palikaid) fe cluster(palikaid)

xtreg pnc_util month##evereased, i(palikaid) fe cluster(palikaid)

xtreg del_util month##evereased, i(palikaid) fe cluster(palikaid)

xtreg cs_util month##evereased, i(palikaid) fe cluster(palikaid)

* Adding Covid-19 cases as a covariate

xtreg fp_sa_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

xtreg anc_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

xtreg pnc_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

xtreg del_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

xtreg cs_util covid_case month##evereased, i(palikaid) fe cluster(palikaid)

restore


*TIME VARYING POLICY CHANGE

*DID estimates with variable policy changes with covid case and covid death 
quietly reg fp_sa_util i.palikaid i.month eased_ covid_case covid_death_, vce(cluster palikaid)
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

* Cluster SEs at the palika level because of serial correlation: you have multiple months of observation for each palika
* Same results as regression above 

xtreg fp_sa_util eased_ covid_case covid_death_ i.month, i(palikaid) fe cluster(palikaid)



quietly reg anc_util i.palikaid i.month eased_ covid_case covid_death_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month eased_ covid_case covid_death_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month eased_ covid_case covid_death_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month eased_ covid_case covid_death_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

*DID estimates with variable policy changes with just covid cases 
quietly reg fp_sa_util i.palikaid i.month eased_ covid_case , r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month eased_ covid_case , r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month eased_ covid_case , r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month eased_ covid_case , r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month eased_ covid_case, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])


*DID estimates with variable policy changes (without covid case and covid death)
quietly reg fp_sa_util i.palikaid i.month eased_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month eased_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month eased_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month eased_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month eased_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])


* FIXED POLICY CHANGE 
** There are very few palikas that maintained the whole post period (just August and September )

*DID estimates with only eased or only maintained with covid case and death 
quietly reg fp_sa_util i.palikaid i.month did_eased_cat_2 covid_case covid_death_ , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month did_eased_cat_2 covid_case covid_death_ , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month did_eased_cat_2 covid_case covid_death_ , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month did_eased_cat_2 covid_case covid_death_ , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month did_eased_cat_2 covid_case covid_death_ , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

*DID estimates with only eased or only maintained with only covid case 
quietly reg fp_sa_util i.palikaid i.month did_eased_cat_2 covid_case , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month did_eased_cat_2 covid_case , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month did_eased_cat_2 covid_case , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month did_eased_cat_2 covid_case , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month did_eased_cat_2 covid_case , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

*DID estimates with only eased or only maintained
quietly reg fp_sa_util i.palikaid i.month did_eased_cat_2 , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month did_eased_cat_2 , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month did_eased_cat_2 , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month did_eased_cat_2 , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month did_eased_cat_2 , r
margins, at(did_eased_cat_2 = (0 1)) post
lincom (_b[2._at]-_b[1._at])


*PLACEBO TEST 
*Fixed policy change from above, pre-period is March and April, post is May and June
*Everyone under national policy during this whole period 

*DID estimates with only eased or only maintained - PLACEBO TEST 
quietly reg fp_sa_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

*DID estimates with only eased or only maintained - PLACEBO TEST with covid case
quietly reg fp_sa_util i.palikaid i.month did_eased_cat_plac covid_case , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg anc_util i.palikaid i.month did_eased_cat_plac covid_case , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg del_util i.palikaid i.month did_eased_cat_plac covid_case , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg cs_util i.palikaid i.month did_eased_cat_plac covid_case , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

quietly reg pnc_util i.palikaid i.month did_eased_cat_plac covid_case , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

*can't do with Covid deaths, I think because first Covid death is in May 

*Sensitivity analyses
preserve
keep if inlist(orgunitlevel2, "5 Province 5", "6 Karnali Province", "7 Sudurpashchim Province")




restore



/* Old code 
* Probably won't use this 
* DID estimates fixed policy change - 
reg fp_sa_util post eased_8_20  did_eased_8_20 , r
reg anc_util post eased_8_20  did_eased_8_20 , r
reg del_util post eased_8_20  did_eased_8_20 , r
reg cs_util post eased_8_20  did_eased_8_20 , r
reg pnc_util post eased_8_20  did_eased_8_20 , r
* could also do reg anc_util post##eased_8_20


**** IF AUGUST WERE TREATMENT INDICATOR 

* Placebo tests
* Family planning - placebo test 
reg fp_sa_util post_plac eased_8_20 did_eased_8_20_plac, r

* Antenatal care visits - placebo test 
reg anc_util post_plac eased_8_20 did_eased_8_20_plac, r

* Facility deliveries - placebo test 
reg del_util post_plac eased_8_20 did_eased_8_20_plac, r

* C-sections - placebo test 
reg cs_util post_plac eased_8_20 did_eased_8_20_plac, r

* Postnatal care visits - placebo test 
reg pnc_util post_plac eased_8_20 did_eased_8_20_plac, r 
***failed, p < 0.05 


* DID estimates 
* Family planning 
reg fp_sa_util post eased_8_20 did_eased_8_20, r

* Antenatal care visits 
reg anc_util post eased_8_20 did_eased_8_20, r

* Facility deliveries 
reg del_util post eased_8_20 did_eased_8_20, r

* C-sections
reg cs_util post eased_8_20 did_eased_8_20, r

* Postnatal care visits
reg pnc_util post eased_8_20 did_eased_8_20, r 


*** MULTIPLE POST PERIODS 
* Family planning 
reg fp_sa_util post eased_8_20 eased_9_20 eased_10_20 eased_11_20 did_eased_8_20 did_eased_9_20 did_eased_10_20 did_eased_11_20, r

* Antenatal care visits 
reg anc_util post eased_8_20 eased_9_20 eased_10_20 eased_11_20 did_eased_8_20 did_eased_9_20 did_eased_10_20 did_eased_11_20, r

* Facility deliveries 
reg del_util post eased_8_20 eased_9_20 eased_10_20 eased_11_20 did_eased_8_20 did_eased_9_20 did_eased_10_20 did_eased_11_20, r

* C-sections
reg cs_util post eased_8_20 eased_9_20 eased_10_20 eased_11_20 did_eased_8_20 did_eased_9_20 did_eased_10_20 did_eased_11_20, r

* Postnatal care visits
reg pnc_util post eased_8_20 eased_9_20 eased_10_20 eased_11_20 did_eased_8_20 did_eased_9_20 did_eased_10_20 did_eased_11_20, r

