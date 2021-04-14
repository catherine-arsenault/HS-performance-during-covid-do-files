* Health system performance during Covid-19 
* Created by Catherine Arsenault
* Effect of Covid-19 on health service utilization in 10 countries
* This do file creates line graphs


* Chile
* no opd_util

* Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear

collapse (sum) opd_util anc_util , by( year month)
replace opd_util=opd_util/1000
replace anc_util=anc_util/1000
sort year month 
gen time= _n
rename opd_util ethiopia_opd
rename anc_util ethiopia_anc
lab var ethiopia_opd "Ethiopia"
lab var ethiopia_anc "Ethiopia"
save  "$user/$analysis/tmp.dta", replace 

* Ghana
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

collapse (sum) opd_util anc_util , by(year month)
replace opd_util=opd_util/1000
replace anc_util=anc_util/1000
sort year month 
gen time= _n
rename opd_util ghana_opd
rename anc_util ghana_anc
lab var ghana_opd "Ghana"
lab var ghana_anc "Ghana"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace

* Haiti 

* Korea 

* Nepal
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear

collapse (sum) opd_util anc_util , by(year month)
replace opd_util=opd_util/1000
replace anc_util=anc_util/1000
sort year month 
gen time= _n
rename opd_util nepal_opd
rename anc_util nepal_anc
lab var nepal_opd "Nepal"
lab var nepal_anc "Nepal"
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

* Mexico 
use "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear

collapse (sum) opd_util, by(year month)
replace opd_util=opd_util/1000
sort year month 
gen time= _n
rename opd_util mex
lab var mex "Mexico (IMSS)"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace

* Thailand
use "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear 

collapse (sum) opd_util anc_util , by(year month)
replace opd_util=opd_util/1000
replace anc_util= anc_util/1000
sort year month 
gen time= _n
rename opd_util thailand_opd
rename anc_util thailand_anc 
lab var thailand_opd "Thailand"
lab var thailand_anc "Thailand"
merge 1:1 time using "$user/$analysis/tmp.dta"
drop _merge 
save "$user/$analysis/tmp.dta", replace




********************************************************************************
* LINE GRAPH FOR OUTPATIENT VISITS (IN THOUSANDS)
********************************************************************************

twoway (line ethiopia time, lcolor(green)) (line nepal time, lcolor(red)) ///
	   (line kzn time, lcolor(yellow))  (line lao time, lcolor(blue))  ///
	   (line mex time, lcolor(mint)) (line ghana time, lcolor(black)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("Outpatient visits (in thousands) (January 2019-December 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))

* inside xlabel()  glcolor(teal%75) glpattern(dash)


********************************************************************************
* LINE GRAPH FOR ANC VISITS (IN THOUSANDS)
********************************************************************************

twoway (line ethiopia_anc time, lcolor(green)) (line ghana_anc time, lcolor(black))  ///
		(line nepal_anc time, lcolor(red)) (line thailand_anc time, lcolor(pink)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("Antenatal care visits (in thousands) (January 2019-December 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))
	   
