* Health system performance during Covid-19 
* Created by Catherine Arsenault
* Effect of Covid-19 on health service utilization in 10 countries
* This do file creates line graphs

set scheme s1color

/***********************************************************
*Jan 2019 as reference
***********************************************************
* Chile
use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear

collapse (sum) anc del, by( year month)

sort year month 
gen time= _n
foreach x in anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct chile_`x'
	lab var chile_`x' "Chile"
	}

save  "$analysis/tmp.dta", replace 

* Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct ethiopia_`x'
	lab var ethiopia_`x' "Ethiopia"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 	
save  "$analysis/tmp.dta", replace 

* Ghana
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct ghana_`x'
	lab var ghana_`x' "Ghana"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Haiti 

use "$user/$HTIdata/Data for analysis/Haiti_su_18months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct haiti_`x'
	lab var haiti_`x' "Haiti"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Korea 
use "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct korea_`x'
	lab var korea_`x' "Korea"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Nepal
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct nepal_`x'
	lab var nepal_`x' "Nepal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* KZN
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct kzn_`x'
	lab var kzn_`x' "KwaZulu-Natal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Lao
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct lao_`x'
	lab var lao_`x' "Lao"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Mexico 
use "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct mexico_`x'
	lab var mexico_`x' "Mexico"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Thailand
use "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear 

collapse (sum) opd anc, by( year month)

sort year month 
gen time= _n
foreach x in opd anc {
	gen ref_`x' = `x'_util if time==1
	carryforward ref_`x', replace
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct thailand_`x'
	lab var thailand_`x' "Thailand"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 

drop ref* *_util
save "$analysis/tmp.dta", replace


*****************
* LINE GRAPH 
*****************

twoway (line ethiopia_opd time, lcolor(green)) (line ghana_opd time, lcolor(red)) ///
	   (line haiti_opd time, lcolor(yellow))  (line korea_opd time, lcolor(blue))  ///
	   (line kzn_opd time, lcolor(mint)) (line lao_opd time, lcolor(ltblue)) ///
	   (line mexico_opd time, lcolor(orange)) (line nepal_opd time, lcolor(purple)) ///
	   (line thailand_opd time, lcolor(gs5)) ///
	   , ylabel(0(50)200, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white))  ///
	   title("Outpatient visits relative to Jan 2019 (Jan 2019-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny)) xtitle("Month", size(small)) ytitle("Percent relative to Jan 2019", size(small)) ///
	   saving("$analysis/Graphs/opd1.gph", replace)
	   
twoway (line chile_anc time, lcolor(black)) (line ethiopia_anc time, lcolor(green)) (line ghana_anc time, lcolor(red)) ///
	   (line haiti_anc time, lcolor(yellow))  (line korea_anc time, lcolor(blue))  ///
	   (line kzn_anc time, lcolor(mint)) (line lao_anc time, lcolor(ltblue)) ///
	   (line mexico_anc time, lcolor(orange)) (line nepal_anc time, lcolor(purple)) ///
	   (line thailand_anc time, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("ANC visits relative to Jan 2019 (Jan 2019-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to Jan 2019", size(small)) ///
	   saving("$analysis/Graphs/anc1.gph", replace) 

twoway (line chile_del time, lcolor(black)) (line ethiopia_del time, lcolor(green)) (line ghana_del time, lcolor(red)) ///
	   (line haiti_del time, lcolor(yellow))  (line korea_del time, lcolor(blue))  ///
	   (line kzn_del time, lcolor(mint)) (line lao_del time, lcolor(ltblue)) ///
	   (line mexico_del time, lcolor(orange)) (line nepal_del time, lcolor(purple)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("Deliveries relative to Jan 2019 (Jan 2019-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to Jan 2019", size(small)) ///
	   saving("$analysis/Graphs/del1.gph", replace) 
	   
grc1leg "$analysis/Graphs/opd1.gph" "$analysis/Graphs/anc1.gph" "$analysis/Graphs/del1.gph" ///
	, legendfrom("$analysis/Graphs/anc1.gph") row(2) col(2)
 	   
* inside xlabel()  glcolor(teal%75) glpattern(dash)

* another option is a scatter plot
twoway (scatter ethiopia_opd time, lcolor(green) msize(vsmall)) (scatter ghana_opd time, lcolor(red) msize(vsmall)) ///
	   (scatter haiti_opd time, lcolor(yellow) msize(vsmall))  (scatter korea_opd time, lcolor(blue) msize(vsmall))  ///
	   (scatter kzn_opd time, lcolor(mint) msize(vsmall)) (scatter lao_opd time, lcolor(ltblue) msize(vsmall)) ///
	   (scatter mexico_opd time, lcolor(orange) msize(vsmall)) (scatter nepal_opd time, lcolor(purple) msize(vsmall)) ///
	   (scatter thailand_opd time, lcolor(gs5) msize(vsmall)) ///
	   , ylabel(0(50)200, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white))  ///
	   title("Outpatient visits relative to Jan 2019 (Jan 2019-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny)) xtitle("Month", size(small)) ytitle("Percent relative to Jan 2019", size(small)) ///
	   saving("$analysis/Graphs/opd1.gph", replace)

* or separate plots per country
local colors green red yellow blue mint ltblue orange purple gs5 

foreach c in ethiopia ghana haiti korea kzn lao mexico nepal thailand {	
	local counter = `counter' + 1
	local color: word `counter' of `colors'
twoway (line `c'_opd time, lcolor("`color'")) ///
	   , ylabel(0(50)200, labsize(vsmall)) xlabel(#24,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white))  ///
	    xtitle("`c'", size(small)) ytitle("Percent relative to Jan 2019", size(small)) ///
	   saving("$analysis/Graphs/opd_`c'.gph", replace)
}

grc1leg "$analysis/Graphs/opd_ethiopia.gph" "$analysis/Graphs/opd_ghana.gph" ///
		"$analysis/Graphs/opd_haiti.gph" 	"$analysis/Graphs/opd_korea.gph" ///
		"$analysis/Graphs/opd_kzn.gph" 	"$analysis/Graphs/opd_lao.gph" ///
		"$analysis/Graphs/opd_mexico.gph" 	"$analysis/Graphs/opd_nepal.gph" ///
		"$analysis/Graphs/opd_thailand.gph" , 	 ///
		title("Outpatient visits relative to January 2019 (January 2019-December 2020)", size(small)) 
* Removeed legend by hand

*/

***********************************************************
*Jan 2020 as reference
***********************************************************
* Chile
use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear

collapse (sum) anc del, by( year month)

sort year month 
gen time= _n
foreach x in anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct chile_`x'
	lab var chile_`x' "Chile"
	}

save  "$analysis/tmp.dta", replace 

* Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct ethiopia_`x'
	lab var ethiopia_`x' "Ethiopia"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 	
save  "$analysis/tmp.dta", replace 

* Ghana
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct ghana_`x'
	lab var ghana_`x' "Ghana"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Haiti 

use "$user/$HTIdata/Data for analysis/Haiti_su_18months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct haiti_`x'
	lab var haiti_`x' "Haiti"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Korea 
use "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct korea_`x'
	lab var korea_`x' "Korea"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Nepal
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct nepal_`x'
	lab var nepal_`x' "Nepal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* KZN
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct kzn_`x'
	lab var kzn_`x' "KwaZulu-Natal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Lao
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct lao_`x'
	lab var lao_`x' "Lao"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Mexico 
use "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
gen time= _n
foreach x in opd anc del {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct mexico_`x'
	lab var mexico_`x' "Mexico"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Thailand
use "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear 

collapse (sum) opd anc, by( year month)

sort year month 
gen time= _n
foreach x in opd anc {
	gen ref_`x' = `x'_util if time==13
	sort ref_`x'
	carryforward ref_`x', replace
	sort time
	gen `x'_pct = `x'_util*100/ref_`x' 
	rename `x'_pct thailand_`x'
	lab var thailand_`x' "Thailand"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 

lab def month_lbl 13 "Jan" 14 "Feb" 15 "Mar" 16 "Apr" 17 "May" 18 "Jun" 19 "Jul" 20 "Aug" 21 "Sep" 22 "Oct" 23 "Nov" 24 "Dec"
lab val time month_lbl

drop ref* *_util
save "$analysis/tmp.dta", replace

*****************
* LINE GRAPH 
*****************
twoway (line ethiopia_opd time if time>12, lcolor(green)) (line ghana_opd time if time>12, lcolor(red)) ///
	   (line haiti_opd time if time>12, lcolor(yellow))  (line korea_opd time if time>12, lcolor(blue))  ///
	   (line kzn_opd time if time>12, lcolor(mint)) (line lao_opd time if time>12, lcolor(ltblue)) ///
	   (line mexico_opd time if time>12, lcolor(orange)) (line nepal_opd time if time>12, lcolor(purple)) ///
	   (line thailand_opd time if time>12, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("Outpatient visits relative to Jan 2020 (Jan-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny)) xtitle("Month", size(small)) ytitle("Percent relative to Jan 2020", size(small)) ///
	   saving("$analysis/Graphs/opd2.gph", replace)
	   
twoway (line ethiopia_anc time if time>12, lcolor(green)) (line ghana_anc time if time>12, lcolor(red)) ///
	   (line haiti_anc time if time>12, lcolor(yellow))  (line korea_anc time if time>12, lcolor(blue))  ///
	   (line kzn_anc time if time>12, lcolor(mint)) (line lao_anc time if time>12, lcolor(ltblue)) ///
	   (line mexico_anc time if time>12, lcolor(orange)) (line nepal_anc time if time>12, lcolor(purple)) ///
	   (line thailand_anc time if time>12, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("ANC visits relative to Jan 2020 (Jan-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to Jan 2020", size(small)) ///
	   saving("$analysis/Graphs/anc2.gph", replace) 

twoway (line ethiopia_del time if time>12, lcolor(green)) (line ghana_del time if time>12, lcolor(red)) ///
	   (line haiti_del time if time>12, lcolor(yellow))  (line korea_del time if time>12, lcolor(blue))  ///
	   (line kzn_del time if time>12, lcolor(mint)) (line lao_del time if time>12, lcolor(ltblue)) ///
	   (line mexico_del time if time>12, lcolor(orange)) (line nepal_del time if time>12, lcolor(purple)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(15) graphregion(color(white)) xtitle("") ///
	   title("Deliveries relative to Jan 2020 (Jan-Dec 2020)", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to Jan 2020", size(small)) ///
	   saving("$analysis/Graphs/del2.gph", replace) 
	   
grc1leg "$analysis/Graphs/opd2.gph" "$analysis/Graphs/anc2.gph" "$analysis/Graphs/del2.gph" ///
	, legendfrom("$analysis/Graphs/anc2.gph") row(2) col(2)

***********************************************************
*Past year as reference
***********************************************************
* Chile
use "$user/$CHLdata/Data for analysis/Chile_su_22months_for_analyses.dta", clear

collapse (sum) anc del, by( year month)

sort year month 
reshape wide anc_util del_util, i(month) j(year)
gen time= _n

foreach x in anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct chile_`x'
	lab var chile_`x' "Chile"
	}

save  "$analysis/tmp.dta", replace 

* Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct ethiopia_`x'
	lab var ethiopia_`x' "Ethiopia"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 	
save  "$analysis/tmp.dta", replace 

* Ghana
use "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct ghana_`x'
	lab var ghana_`x' "Ghana"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Haiti 

use "$user/$HTIdata/Data for analysis/Haiti_su_18months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct haiti_`x'
	lab var haiti_`x' "Haiti"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Korea 
use "$user/$KORdata/Data for analysis/Korea_su_21months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct korea_`x'
	lab var korea_`x' "Korea"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Nepal
use "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct nepal_`x'
	lab var nepal_`x' "Nepal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* KZN
use "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct kzn_`x'
	lab var kzn_`x' "KwaZulu-Natal"
	}
	
merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Lao
use "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct lao_`x'
	lab var lao_`x' "Lao"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Mexico 
use "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta", clear

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct mexico_`x'
	lab var mexico_`x' "Mexico"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 
save "$analysis/tmp.dta", replace

* Thailand
use "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta", clear 

collapse (sum) opd anc del, by( year month)

sort year month 
reshape wide opd_util anc_util del_util, i(month) j(year)
gen time= _n

foreach x in opd anc del {
	gen `x'_pct = `x'_util2020*100/`x'_util2019 
	rename `x'_pct thailand_`x'
	lab var thailand_`x' "Thailand"
	}

merge 1:1 time using "$analysis/tmp.dta"
drop _merge 

drop *_util*
save "$analysis/tmp.dta", replace

*****************
* LINE GRAPH 
*****************
twoway (line ethiopia_opd time, lcolor(green)) (line ghana_opd time, lcolor(red)) ///
	   (line haiti_opd time, lcolor(yellow))  (line korea_opd time, lcolor(blue))  ///
	   (line kzn_opd time, lcolor(mint)) (line lao_opd time, lcolor(ltblue)) ///
	   (line mexico_opd time, lcolor(orange)) (line nepal_opd time, lcolor(purple)) ///
	   (line thailand_opd time, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(3) yline(100) graphregion(color(white))  ///
	   title("Outpatient visits in 2020 relative to same month 2019", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny)) xtitle("Month", size(small)) ytitle("Percent relative to 2019", size(small)) ///
	   saving("$analysis/Graphs/opd3.gph", replace)
	   
twoway (line chile_anc time, lcolor(black)) (line ethiopia_anc time, lcolor(green)) (line ghana_anc time, lcolor(red)) ///
	   (line haiti_anc time, lcolor(yellow))  (line korea_anc time, lcolor(blue))  ///
	   (line kzn_anc time, lcolor(mint)) (line lao_anc time, lcolor(ltblue)) ///
	   (line mexico_anc time, lcolor(orange)) (line nepal_anc time, lcolor(purple)) ///
	   (line thailand_anc time, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(3) yline(100) graphregion(color(white))  ///
	   title("ANC visits in 2020 relative to same month 2019", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to 2019", size(small)) ///
	   saving("$analysis/Graphs/anc3.gph", replace) 

twoway (line chile_del time, lcolor(black)) (line ethiopia_del time, lcolor(green)) (line ghana_del time, lcolor(red)) ///
	   (line haiti_del time, lcolor(yellow))  (line korea_del time, lcolor(blue))  ///
	   (line kzn_del time, lcolor(mint)) (line lao_del time, lcolor(ltblue)) ///
	   (line mexico_del time, lcolor(orange)) (line nepal_del time, lcolor(purple)) ///
	   (line thailand_del time, lcolor(gs5)) ///
	   , ylabel(#6, labsize(vsmall)) xlabel(#12,  labsize(vsmall) valuelabel grid glwidth(thin)) ///
	   xline(3) yline(100) graphregion(color(white))  ///
	   title("Deliveries in 2020 relative to same month 2019", size(small)) ///
	   legend(rows(2) rowgap(tiny) colgap(tiny) keygap(tiny) size(vsmall) region(margin(tiny) ///
	   lcolor(none)) bmargin(tiny))	xtitle("Month", size(small)) ytitle("Percent relative to 2019", size(small)) ///
	   saving("$analysis/Graphs/del3.gph", replace) 
	   
grc1leg "$analysis/Graphs/opd3.gph" "$analysis/Graphs/anc3.gph" "$analysis/Graphs/del3.gph" ///
	, legendfrom("$analysis/Graphs/anc3.gph") row(2) col(2)
