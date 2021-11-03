* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear

global vars anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual measles_qual
 
* Descriptives
ta eased_fixed if tag // 257 out of 739 (34.18%) eased containment policies in August  * but this is after cleaning

* Number of Palika and total volume of services by month
table (year month), nototals stat(count fp_util anc_util) stat(sum fp_util anc_util) 
table (year month), nototals stat(count pnc_util diarr_util) stat(sum  pnc_util diarr_util) 
table (year month), nototals stat(count pneum_util pent_qual) stat(sum pneum_util pent_qual)
table (year month), nototals stat(count opd_util diab_uti) stat(sum opd_util diab_uti)
table (year month), nototals stat(count hyper_util hivtest_qual) stat(sum hyper_util hivtest_qual)
table (year month), nototals stat(count tbdetect_qual) stat(sum tbdetect_qual)

* Number of Palika and total volume of services by month and treatment statusn - AVERAGE
foreach x of global vars {
	di "`x'"
	table (year month)() (eased_fixed), stat(count `x') stat(sum `x' ) 
}

*Parrallel trends graphs - Treated/control: Fixed policy change based on treatment status in August 
collapse (mean) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual measles_qual eased_fixed, by(month_graph palikaid)

collapse (mean) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual measles_qual, by(month_graph eased_fixed)  

twoway (scatter anc_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line anc_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter anc_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line anc_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Antenatal care visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(20)180) ///
	   xtitle(Month) legend(off) text(35 5 "Lifted lockdown" 122 5  "Maintained lockdown" /// 
	   158 16.5 "National"  152 16.5 "lockdown" 146 16.5 "(pre-period)" /// 
	   158 19.5 "National" 152 19.5 "lockdown lifted" 146 19.5 "(post-period)", size(small)) 
	  
	   
	   graph export "$user/$analysis/Graphs/anc_util.pdf", replace
	   
twoway (scatter fp_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line fp_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter fp_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line fp_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Contraceptive users", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(400(100)1000) ///
	   xtitle(Month) legend(off) text(580 5 "Lifted lockdown" 850 5 "Maintained lockdown" /// 
	   950 16.5 "National"  930 16.5 "lockdown" 910 16.5 "(pre-period)" /// 
	   950 19.5 "National" 930 19.5 "lockdown lifted" 910 19.5 "(post-period)", size(small))
	  
	   
	   graph export "$user/$analysis/Graphs/fp_util.pdf", replace

twoway (scatter pnc_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line pnc_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter pnc_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line pnc_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Postnatal care visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(10)60) ///
	   xtitle(Month) legend(off) text(6 5 "Eased policies" 22 4.5  "Maintained policies" /// 
	   50 16.5 "National"  48 16.5 "lockdown" 46 16.5 "(pre-period)" /// 
	   50 19.5 "National" 48 19.5 "lockdown lifted" 46 19.5 "(post-period)", size(small))
	   
	   graph export "$user/$analysis/Graphs/pnc_util.pdf", replace
	   
	   
twoway (scatter pneum_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line pneum_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter pneum_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line pneum_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Pneumonia visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(5)40) ///
	   xtitle(Month) legend(off) text(14 5  "Maintained policies" 20 5 "Eased policies" /// 
	   34 16.5 "National"  32.5 16.5 "lockdown" 31 16.5 "(pre-period)" /// 
	   34 19.5 "National" 32.5 19.5 "lockdown lifted" 31 19.5 "(post-period)", size(small))
	   
	   graph export "$user/$analysis/Graphs/pneum_util.pdf", replace

twoway (scatter measles_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line measles_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter measles_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line measles_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Measles vaccines", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(25)250) ///
	   xtitle(Month) legend(off) text(75 12 "Eased policies" 125 12  "Maintained policies" ///
	   225 16.5 "National"  215 16.5 "lockdown" 205 16.5 "(pre-period)" /// 
	   225 19.5 "National" 215 19.5 "lockdown lifted" 205 19.5 "(post-period)", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/measles_qual.pdf", replace
	   

twoway (scatter opd_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line opd_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter opd_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line opd_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Outpatient visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(500)4000) ///
	   xtitle(Month) legend(off) text(1300 4.5 "Eased policies" 2150 4.4  "Maintained policies" ///
	   3400 16.5 "National"  3250 16.5 "lockdown" 3100 16.5 "(pre-period)" /// 
	   3400 19.5 "National" 3250 19.5 "lockdown lifted" 3100 19.5 "(post-period)", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/opd_util.pdf", replace

twoway (scatter diab_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line diab_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter diab_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line diab_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Diabetes visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(50)200) ///
	   xtitle(Month) legend(off) text(44 5 "Eased policies" 110 5  "Maintained policies" /// 
	   178 16.5 "National"  172 16.5 "lockdown" 166 16.5 "(pre-period)" /// 
	   178 19.5 "National" 172 19.5 "lockdown lifted" 166 19.5 "(post-period)", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/diab_util.pdf", replace	   


twoway (scatter hyper_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line hyper_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter hyper_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line hyper_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("Hypertension visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(50)200) ///
	   xtitle(Month) legend(off) text(45 12 "Eased policies" 110 12  "Maintained policies" /// 
	   168 16.5 "National"  162 16.5 "lockdown" 156 16.5 "(pre-period)" /// 
	   168 19.5 "National" 162 19.5 "lockdown lifted" 156 19.5 "(post-period)", size(small))
	  
	   graph export "$user/$analysis/Graphs/hyper_util.pdf", replace	  

twoway (scatter hivtest_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line hivtest_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter hivtest_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line hivtest_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("HIV Tests", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(100)1000) ///
	   xtitle(Month) legend(off) text(70 5 "Eased policies" 450 4.2  "Maintained policies" ///
	   880 16.5 "National"  850 16.5 "lockdown" 820 16.5 "(pre-period)" /// 
	   880 19.5 "National" 850 19.5 "lockdown lifted" 820 19.5 "(post-period)", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/hivtest_qual.pdf", replace	   
	   
twoway (scatter tbdetect_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line tbdetect_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter tbdetect_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line tbdetect_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(ebg)) xline(18, lpattern(dash) lcolor(ebg)) ///
	   graphregion(color(white)) title("TB cases detected", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(4)20) ///
	   xtitle(Month) legend(off) text(3.75 5 "Eased policies" 8 5  "Maintained policies" /// 
	   18 16.5 "National"  17.3 16.5 "lockdown" 16.6 16.5 "(pre-period)" /// 
	   18 19.5 "National" 17.3 19.5 "lockdown lifted" 16.6 19.5 "(post-period)", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/tbdetect_qual.pdf", replace	   

			
