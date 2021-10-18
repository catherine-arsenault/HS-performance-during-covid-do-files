* Effect of easing Covid-19 containment policies on health service delivery in Nepal
* January 13th 2021
* Creation do file
* Created by Catherine Arsenault and Neena Kappoor

clear all
use "$user/$data/Data for analysis/Nepal_palika_Mar20-Sep20_LONG.dta", clear

global vars anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual
 
* Descriptives
ta eased_fixed if tag // 249 out of 739 (32.48%) eased containment policies in August 

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
hyper_util hivtest_qual tbdetect_qual eased_fixed, by(month_graph palikaid)

collapse (mean) anc_util fp_util pnc_util diarr_util pneum_util pent_qual opd_util diab_util /// 
hyper_util hivtest_qual tbdetect_qual, by(month_graph eased_fixed)  

twoway (scatter anc_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line anc_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter anc_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line anc_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Antenatal care visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(20)180) ///
	   xtitle(Month) legend(off) text(35 12 "Treated" 100 12 "Control", size(small)) 
	  
	   
	   graph export "$user/$analysis/Graphs/anc_util.pdf", replace
	   
twoway (scatter fp_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line fp_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter fp_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line fp_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Family planning visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(400(100)1000) ///
	   xtitle(Month) legend(off) text(530 12 "Treated" 840 12 "Control", size(small))
	  
	   
	   graph export "$user/$analysis/Graphs/fp_util.pdf", replace

twoway (scatter pnc_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line pnc_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter pnc_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line pnc_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Postnatal care visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(10)60) ///
	   xtitle(Month) legend(off) text(8 12 "Treated" 25 12 "Control", size(small))
	   
	   graph export "$user/$analysis/Graphs/pnc_util.pdf", replace
	   
twoway (scatter diarr_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line diarr_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter diarr_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line diarr_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Diarrhea visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(10)100) ///
	   xtitle(Month) legend(off) text(25 12 "Treated" 44 12 "Control", size(small))
	  
	   
	   graph export "$user/$analysis/Graphs/diarr_util.pdf", replace
	   
twoway (scatter pneum_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line pneum_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter pneum_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line pneum_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Pneumonia visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(5)40) ///
	   xtitle(Month) legend(off) text(14 4 "Control" 20 4 "Treated", size(small))
	  
	   
	   graph export "$user/$analysis/Graphs/pneum_util.pdf", replace

twoway (scatter pent_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line pent_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter pent_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line pent_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Pentavalent vaccines", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(25)150) ///
	   xtitle(Month) legend(off) text(40 12 "Treated" 105 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/pent_qual.pdf", replace
	   

twoway (scatter opd_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line opd_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter opd_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line opd_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Outpatient visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(500)4000) ///
	   xtitle(Month) legend(off) text(1100 12 "Treated" 2150 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/opd_util.pdf", replace

twoway (scatter diab_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line diab_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter diab_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line diab_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Diabetes visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(50)200) ///
	   xtitle(Month) legend(off) text(45 12 "Treated" 110 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/diab_util.pdf", replace	   


twoway (scatter hyper_util month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line hyper_util month if eased_fixed == 1, lcolor(green)) ///
	   (scatter hyper_util month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line hyper_util month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("Hypertension visits", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(50)200) ///
	   xtitle(Month) legend(off) text(45 12 "Treated" 110 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/hyper_util.pdf", replace	  

twoway (scatter hivtest_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line hivtest_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter hivtest_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line hivtest_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("HIV Tests", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(100)1000) ///
	   xtitle(Month) legend(off) text(75 12 "Treated" 550 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/hivtest_qual.pdf", replace	   
	   
twoway (scatter tbdetect_qual month if eased_fixed == 1, mcolor(green) msize(vsmall)) ///
	   (line tbdetect_qual month if eased_fixed == 1, lcolor(green)) ///
	   (scatter tbdetect_qual month if eased_fixed == 0, mcolor(orange) msize(vsmall)) ///
	   (line tbdetect_qual month if eased_fixed == 0, lcolor(orange)), ///
	   xline(15, lpattern(dash) lcolor(black)) xline(18, lpattern(dash) lcolor(black)) ///
	   graphregion(color(white)) title("TB cases detected", size(small)) ///
	   xlabel(1(1)20) ytitle("Average number of visits per palika") ylabel(0(4)20) ///
	   xtitle(Month) legend(off) text(2 12 "Treated" 6 12 "Control", size(small))
	  
	  
	   graph export "$user/$analysis/Graphs/tbdetect_qual.pdf", replace	   

			
