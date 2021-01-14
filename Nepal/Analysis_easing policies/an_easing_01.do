* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

global user "/Users/neenakapoor/Dropbox (Harvard University)/HMIS Data for Health System Performance Covid (Nepal)"

use "$user/$data/Data for analysis/Nepal_palika_Jan19-Jun20_easing_an_011320.dta"

*Parrallel trends graphs 

collapse (sum) fp_util anc_util del_util cs_util pnc_util, by(month eased_8_20)

line fp_util month if eased_8_20 == 0 || line fp_util month if eased_8_20 == 1, sort 

line anc_util month if eased_8_20 == 0 || line anc_util month if eased_8_20 == 1, sort

line del_util month if eased_8_20 == 0 || line del_util month if eased_8_20 == 1, sort

line cs_util month if eased_8_20 == 0 || line cs_util month if eased_8_20 == 1, sort

line pnc_util month if eased_8_20 == 0 || line pnc_util month if eased_8_20 == 1, sort
