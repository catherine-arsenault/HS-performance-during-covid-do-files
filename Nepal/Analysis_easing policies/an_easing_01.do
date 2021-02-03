* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

use "$user/$data/Data for analysis/Nepal_palika_Jan19-Nov20_clean_easing.dta", clear

global vars fp_sa_util anc_util del_util cs_util pnc_util
 
* Descriptives
ta eased_8_20 if tag // 323 out of 753 (43%) eased containment policies in August 

* Number of Palika and total volume of services by month
table month, c(N fp_sa_util sum fp_sa_util N anc_util sum anc_util) 
table month, c(N del_util sum del_util N cs_util sum cs_util)
table month, c(N pnc_util sum pnc_util )
* Number of Palika and total volume of services by month and treatment status
foreach x of global vars {
	di "`x'"
	table month , c(N `x' sum `x' ) by(eased_8_20)
}

*Parrallel trends graphs 
collapse (sum) fp_sa_util anc_util del_util cs_util pnc_util, by(month eased_8_20 )
sort eased  month

line fp_sa_util month if eased_8_20 == 1 || line fp_sa_util month if eased_8_20 == 0, title("Contraceptive users") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line anc_util month if eased_8_20 == 1 || line anc_util month if eased_8_20 == 0, title("Antenatal Care Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line del_util month if eased_8_20 == 1 || line del_util month if eased_8_20 == 0, title("Facility Deliveries") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line cs_util month if eased_8_20 == 1 || line cs_util month if eased_8_20 == 0, title("C-Sections") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line pnc_util month if eased_8_20 == 1 || line pnc_util month if eased_8_20 == 0, title("PNC Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

*How do we do this for the treatment varying over time? 
