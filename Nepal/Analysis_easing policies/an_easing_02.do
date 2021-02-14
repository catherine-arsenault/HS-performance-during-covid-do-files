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


* DID estimates fixed policy change
reg fp_sa_util post eased_8_20  did_eased_8_20 , r
reg anc_util post eased_8_20  did_eased_8_20 , r
reg del_util post eased_8_20  did_eased_8_20 , r
reg cs_util post eased_8_20  did_eased_8_20 , r
reg pnc_util post eased_8_20  did_eased_8_20 , r
* could also do reg anc_util post##eased_8_20


*DID estimates with variable policy changes
quietly reg fp_sa_util i.palikaid i.month eased_ covid_case covid_death_, r
margins, at(eased_= (0 1)) post
lincom (_b[2._at]-_b[1._at])

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


*DID estimates with only eased or only maintained - PLACEBO TEST 
reg fp_sa_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

reg anc_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

reg del_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

reg cs_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])

reg pnc_util i.palikaid i.month did_eased_cat_plac , r
margins, at(did_eased_cat_plac = (0 1)) post
lincom (_b[2._at]-_b[1._at])





/* Old code 

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

