* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021
********************************************************************************
* Haiti (by département)
********************************************************************************
use "$user/$HTIdata/Data for analysis/Haiti_su_24months_for_analyses.dta",  clear

rename orgunitlevel2 departement
collapse (sum) $HTIall, by (departement year month)
encode departement, gen(dpt)

/* Vars needed for ITS (we expect both a change in level and in slope: 
	rmonth from 1 to 24 = underlying trend in the outcome
	PostCovid = level change in the outcome after Covid
	timeafter = slope change after Covid */ 
gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
sort dpt rmonth
gen postCovid = rmonth>15 // pandemic period is months 16-24
gen timeafter= rmonth-15
replace timeafter=0 if timeafter<0

save "$user/$HTIdata/Data for analysis/HTItmp.dta",  replace




********************************************************************************
* Haiti GRAPHS
********************************************************************************
* Deliveries
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			 xtset dpt rmonth
			 xtgee del_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename del_util del_util_real
			predict del_util

			collapse (sum) del_util_real del_util , by(rmonth)

			twoway (line del_util_real rmonth,  sort) (line del_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(2000)14000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_del_util.pdf", replace

* ANC			
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>15 
			 xtset dpt rmonth
			 xtgee anc_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename anc_util anc_util_real
			predict anc_util

			collapse (sum) anc_util_real anc_util , by(rmonth)

			twoway (line anc_util_real rmonth, sort) (line anc_util rmonth), ///
			ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Antenatal care visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)80000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_anc_util.pdf", replace
* ANC	(scatter)		
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			
			collapse (sum) anc_util , by(rmonth)
			
			twoway (scatter anc_util rmonth, msize(small) sort) ///
			(lfit anc_util rmonth if rmonth<15) (lfit anc_util rmonth if rmonth>=15, lcolor(green)) , ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(10000)80000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_anc_util.pdf", replace
						
* OPD		
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			xtset dpt rmonth
			 xtgee opd_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename opd_util opd_util_real
			predict opd_util

			collapse (sum) opd_util_real opd_util , by(rmonth)

			twoway (line opd_util_real rmonth,  sort) (line opd_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Outpatient visits", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(100000)800000, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/HTI_opd_util.pdf", replace
* Diabetes
			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			 drop if rmonth>14
			 xtset dpt rmonth
			 xtgee diab_util rmonth , family(gaussian) ///
				link(identity) corr(exchangeable) vce(robust)	

			u "$user/$HTIdata/Data for analysis/HTItmp.dta", clear
			rename diab_util diab_util_real
			predict diab_util

			collapse (sum) diab_util_real diab_util , by(rmonth)

			twoway (line diab_util_real rmonth,  sort) (line diab_util rmonth), ///
			ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
			xtitle("Months since January 2019", size(small)) legend(off) ///
			graphregion(color(white)) title("Haiti", size(small)) ///
			xlabel(1(1)24) xlabel(, labsize(small)) ylabel(0(1000)7000, labsize(small))
			
			graph export "$analysis/Results/Graphs/HTI_diab_util.pdf", replace	
		
rm "$user/$HTIdata/Data for analysis/HTItmp.dta"


