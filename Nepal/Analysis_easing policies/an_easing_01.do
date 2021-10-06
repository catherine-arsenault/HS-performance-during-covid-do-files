* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear


global vars anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual
 
* Descriptives
ta eased_fixed if tag // 240 out of 753 (32.61%) eased containment policies in August 

* Number of Palika and total volume of services by month
table (month), nototals stat(count fp_util anc_util) stat(sum fp_util anc_util) 
table (month), nototals stat(count pnc_util diarr_util) stat(sum  pnc_util diarr_util) 
table (month), nototals stat(count pneum_util pent_qual) stat(sum pneum_util pent_qual)
table (month), nototals stat(count opd_util diab_uti) stat(sum opd_util diab_uti)
table (month), nototals stat(count hyper_util hivtest_qual) stat(sum hyper_util hivtest_qual)
table (month), nototals stat(count tbdetect_qual) stat(sum tbdetect_qual)

* Number of Palika and total volume of services by month and treatment statusn - AVERAGE
foreach x of global vars {
	di "`x'"
	table (month)() (eased_fixed), stat(count `x') stat(sum `x' ) 
}

*Parrallel trends graphs - Treated/control: Fixed policy change based on treatment status in August - AVERAGE

collapse (mean) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual, by(month eased_fixed)

foreach var of global vars {

twoway (scatter `var' month if eased_fixed == 1, mcolor(green)) (line `var' month if eased_fixed == 1, lcolor(green)) (scatter `var' month if eased_fixed == 0, mcolor(navy)) (line `var' month if eased_fixed == 0, lcolor(navy)), title(`var') ytitle("Average number of visits") xtitle(Month) legend(label (1 "") label (2 "Eased policies (treated)") label (3 "") label (4 "Maintained policies (control)"))

graph export "$user/$analysis/Graphs/fixed_`var'.pdf", replace

}

*Parrallel trends graphs - Lifted early, late or never - AVERAGE
clear
u "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear

collapse (mean) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual, by(month eased_fixed eased_late)

foreach var of global vars {

twoway (scatter `var' month if eased_fixed == 1, mcolor(green)) (line `var' month if eased_fixed == 1, lcolor(green)) (scatter `var' month if eased_late == 1, mcolor(maroon)) (line `var' month if eased_late == 1, lcolor(maroon)) (scatter `var' month if eased_fixed == 0 & eased_late == 0, mcolor(navy)) (line `var' month if eased_fixed == 0 & eased_late == 0, lcolor(navy)), title("`var'") ytitle("Average number of visits") xtitle(Month) legend(label (1 "") label (2 "Eased policies early") label (3 "") label (4 "Eased policies late") label (5 "") label (6 "Mainted policies (control)"))


graph export "$user/$analysis/Graphs/early_late_`var'.pdf", replace

}

*Parrallel trends graphs - Treated/control: Fixed policy change based on treatment status in August - SUM
clear
u "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear

collapse (sum) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual, by(month eased_fixed)

foreach var of global vars {

twoway (scatter `var' month if eased_fixed == 1, mcolor(green)) (line `var' month if eased_fixed == 1, lcolor(green)) (scatter `var' month if eased_fixed == 0, mcolor(navy)) (line `var' month if eased_fixed == 0, lcolor(navy)), title(`var') ytitle("Sum of visits") xtitle(Month) legend(label (1 "") label (2 "Eased policies (treated)") label (3 "") label (4 "Maintained policies (control)"))

graph export "$user/$analysis/Graphs/sum_fixed_`var'.pdf", replace

}

*Parrallel trends graphs - Lifted early, late or never - SUM
clear
u "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear

collapse (sum) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual, by(month eased_fixed eased_late)

foreach var of global vars {

twoway (scatter `var' month if eased_fixed == 1, mcolor(green)) (line `var' month if eased_fixed == 1, lcolor(green)) (scatter `var' month if eased_late == 1, mcolor(maroon)) (line `var' month if eased_late == 1, lcolor(maroon)) (scatter `var' month if eased_fixed == 0 & eased_late == 0, mcolor(navy)) (line `var' month if eased_fixed == 0 & eased_late == 0, lcolor(navy)), title("`var'") ytitle("Sum of number of visits") xtitle(Month) legend(label (1 "") label (2 "Eased policies early") label (3 "") label (4 "Eased policies late") label (5 "") label (6 "Mainted policies (control)"))


graph export "$user/$analysis/Graphs/sum_early_late_`var'.pdf", replace

}


/* Old code 
* Graphs with confidence intervals 
			collapse (mean) y = anc_util (semean) se_y = anc_util, by(month eased_fixed)
			gen yu = y + 1.96*se_y
			gen yl = y - 1.96*se_y
 
			twoway (scatter y month if eased_fixed == 1, sort) ///
			(rcap yu yl month if eased_fixed == 1) (line y month if eased_fixed==1) ///
			(scatter y month if eased_fixed==0) ///
			(rcap yu  yl month if eased_fixed==0) (line y month if eased_fixed==0), ///
			title("ANC visits") xtitle("Month") ytitle(Average) legend(off) scheme(s2mono)
			
