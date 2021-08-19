* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all

use "$user/$data/Data for analysis/Nepal_palika_March20-Oct20_LONG_NK_1.dta", clear



global vars fp_util anc_util del_util cs_util pnc_util
 
* Descriptives
ta eased_8_20 if tag // 237 out of 753 (31.47%) eased containment policies in August 

* Number of Palika and total volume of services by month
table (month), nototals stat(count fp_util anc_util) stat(sum fp_util anc_util) 
table (month), nototals stat(count del_util cs_util) stat(sum del_util cs_util) 
table (month), nototals stat(count pnc_util) stat(sum pnc_util)
* Number of Palika and total volume of services by month and treatment status
foreach x of global vars {
	di "`x'"
	table (month)() (eased_8_20), stat(count `x') stat(sum `x' ) 
}



*Parrallel trends graphs - Treated/control: Fixed policy change based on August
collapse (sum) fp_util anc_util del_util cs_util pnc_util, by(month eased_8_20)
sort eased  month

line fp_util month if eased_8_20 == 1 || line fp_util month if eased_8_20 == 0, title("Contraceptive users") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line anc_util month if eased_8_20 == 1 || line anc_util month if eased_8_20 == 0, title("Antenatal Care Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line del_util month if eased_8_20 == 1 || line del_util month if eased_8_20 == 0, title("Facility Deliveries") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line cs_util month if eased_8_20 == 1 || line cs_util month if eased_8_20 == 0, title("C-Sections") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line pnc_util month if eased_8_20 == 1 || line pnc_util month if eased_8_20 == 0, title("PNC Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))


/*
* Parrallel trends graphs - Two-category: fully eased and fully maintained
preserve

collapse (sum) fp_util anc_util del_util cs_util pnc_util, by(month eased_cat_2 )
sort eased  month

line fp_util month if eased_cat_2 == 1 || line fp_util month if eased_cat_2 == 0, title("Contraceptive users") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line anc_util month if eased_cat_2 == 1 || line anc_util month if eased_cat_2 == 0, title("Antenatal Care Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line del_util month if eased_cat_2 == 1 || line del_util month if eased_cat_2 == 0, title("Facility Deliveries") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line cs_util month if eased_cat_2 == 1 || line cs_util month if eased_cat_2 == 0, title("C-Sections") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

line pnc_util month if eased_cat_2 == 1 || line pnc_util month if eased_cat_2 == 0, title("PNC Visits") ytitle("Actual number") xtitle(Month) legend( label (1 "Eased policies") label (2 "Maintained policies (control)"))

restore

