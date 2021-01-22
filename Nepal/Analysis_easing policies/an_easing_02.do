* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

global user "/Users/neenakapoor/Dropbox (Harvard University)/HMIS Data for Health System Performance Covid (Nepal)"

use "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_easing_an_011320.dta"

* Family planning - placebo test 
reg fp_util time eased_8_20 did_eased_8_20, r

* Antenatal care visits - placebo test 
reg anc_util time eased_8_20 did_eased_8_20, r

* Facility deliveries - placebo test 
reg del_util time eased_8_20 did_eased_8_20, r

* C-sections - placebo test 
reg cs_util time eased_8_20 did_eased_8_20, r

* Postnatal care visits - placebo test 
reg pnc_util time eased_8_20 did_eased_8_20, r 
***failed, p < 0.05 
