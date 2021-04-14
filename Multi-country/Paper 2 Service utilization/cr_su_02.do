* Health system performance during Covid-19 
* Created by Catherine Arsenault
* Effect of Covid-19 on health service utilization in 10 countries
* This do file creates line graphs

* Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear

collapse (sum) opd_util, by(year month)
replace opd_util=opd_util/1000
sort year month 
gen time= _n
rename opd_util ethiopia
lab var ethiopia "Ethiopia"
save  "$user/$analysis/tmp.dta", replace 

* Nepal
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear

collapse (sum) opd_util, by(year month)
replace opd_util=opd_util/1000
sort year month 
gen time= _n
rename opd_util nepal
lab var nepal "Nepal"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace

* KZN
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta", clear

collapse (sum) opd_util, by(year month)
replace opd_util=opd_util/1000
sort year month 
gen time= _n
rename opd_util kzn
lab var kzn "KwaZulu-Natal"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace

* Lao
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", clear

collapse (sum) opd_util, by(year month)
replace opd_util=opd_util/1000
sort year month 
gen time= _n
rename opd_util lao
lab var lao "Lao PDR"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace


twoway (line ethiopia time, lcolor(green)) (line nepal time, lcolor(red)) ///
	   (line kzn time, lcolor(yellow)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin) ///
	   glcolor(teal%75) glpattern(dash)) xline(15) graphregion(color(white)) ///
	   title("Outpatient visits per 1,000 people (January 2019-December 2020", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))

