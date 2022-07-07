* Nepal provincial analysis

clear all
use "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", clear

gen sick_visits = diarr_util + pneum_util 
global all opd_util ipd_util er_util fp_sa_util del_util cs_util anc_util ///
pnc_util sick_visits pent_qual measles_qual hivtest_qual tbdetect_qual diab_util hyper_util 

*******************************************************************************
* Descriptive table (see analysis plan)
********************************************************************************
* Total number of COVID cases per month by province in 

* Average number of outpatient visits before COVID and during COVID 
*
* ITS analysis
*
* Services: opd_util, ipd_util, er_util, fp_util, del_util, cs_util, anc_util, 
* pnc_util diarr_util, pneum_util, pent_qual, measles_qual,
* hivtest_qual, tbdetect_qual, diab_util, hyper_util
********************************************************************************

* Descriptive table
********************************************************************************
** Table 1 - Total COVID cases & Avg OPD visits pre and post COVID **
preserve
keep province timeafter Npalika covid_case opd_util
gen pre_covid_opd = opd_util if timeafter == 0
gen post_covid_opd = opd_util if timeafter > 0
drop timeafter opd_util 
collapse (first) Npalika (sum) covid_case (mean) pre_covid_opd post_covid_opd, by (province)
export excel "$user/$analysis/table_1_output.xlsx", firstrow(variables) replace
restore 

** Appendix table 
preserve
foreach var of global all {
	gen pre_`var' = `var' if timeafter == 0
	gen post_`var'=`var' if timeafter > 0
	
}
keep province Npalika pre* post*
collapse (first) Npalika (mean) pre* post*, by (province)
order province Npalika *opd* *ipd* *_er* *fp* *del* *cs* *anc* *pnc* *sick* *pent* *measles* *hiv* *tb* *diab* *hyper*
export excel "$user/$analysis/appendix_prepost_means.xlsx", firstrow(variables) replace
restore 

*Test for autocorrelation
********************************************************************************
tsset prov rmonth
log using "$user/$analysis/autocorrelation", replace
foreach var of global all {
	forval i =1/7 {
		quietly itsa `var' i.season,  single treatid(`i') trperiod(15) lag(1) replace
		actest, lags(6)
	}
} 
log close
*ITS Analysis 
********************************************************************************
tsset prov rmonth
* OPD
* Province 1 
	eststo: itsa opd_util i.season,  single treatid(1) trperiod(15) lag(1)  replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_1.pdf", replace

* Province 2 
	eststo: itsa opd_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/opd_util_2.pdf", replace
	
* Province 3 
	eststo: itsa opd_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Bagmati Province") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_3.pdf", replace
	
* Province 4 
	eststo: itsa opd_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)400000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Gandaki Province") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/opd_util_4.pdf", replace
	
* Province 5
	eststo: itsa opd_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)600000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_5.pdf", replace
	
* Province 6 
	eststo: itsa opd_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)300000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Karnali Province") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_6.pdf", replace
	
* Province 7
	eststo: itsa opd_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Sudurpashchim Province") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/opd_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Outpatient visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

					 
********************************************************************************					 
* IPD

* Province 1 
	eststo: itsa ipd_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_1.pdf", replace

* Province 2 
	eststo: itsa ipd_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/ipd_util_2.pdf", replace
	
* Province 3 
	eststo: itsa ipd_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_3.pdf", replace
	
* Province 4 
	eststo: itsa ipd_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/ipd_util_4.pdf", replace
	
* Province 5
	eststo: itsa ipd_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_5.pdf", replace
	
* Province 6 
	eststo: itsa ipd_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_6.pdf", replace
	
* Province 7
	eststo: itsa ipd_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/ipd_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Inpatient visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* ER Visits 

* Province 1 
	eststo: itsa er_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)50000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_1.pdf", replace

* Province 2 
	eststo: itsa er_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(8000)40000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/er_util_2.pdf", replace
	
* Province 3 
	eststo: itsa er_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(30000)150000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_3.pdf", replace
	
* Province 4 
	eststo: itsa er_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)40000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/er_util_4.pdf", replace
	
* Province 5
	eststo: itsa er_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)50000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_5.pdf", replace
	
* Province 6 
	eststo: itsa er_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_6.pdf", replace
	
* Province 7
	eststo: itsa er_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/er_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(ER Visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* SA Contraceptive users 

* Province 1 
	eststo: itsa fp_sa_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_1.pdf", replace

* Province 2 
	eststo: itsa fp_sa_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/fp_sa_util_2.pdf", replace
	
* Province 3 
	eststo: itsa fp_sa_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_3.pdf", replace
	
* Province 4 
	eststo: itsa fp_sa_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(20000)100000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/fp_sa_util_4.pdf", replace
	
* Province 5
	eststo: itsa fp_sa_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_5.pdf", replace
	
* Province 6 
	eststo: itsa fp_sa_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(20000)100000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_6.pdf", replace
	
* Province 7
	eststo: itsa fp_sa_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/fp_sa_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Short acting Contraceptive users) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* Facility deliveries 

* Province 1 
	eststo: itsa del_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_1.pdf", replace

* Province 2 
	eststo: itsa del_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/del_util_2.pdf", replace
	
* Province 3 
	eststo: itsa del_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_3.pdf", replace
	
* Province 4 
	eststo: itsa del_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/del_util_4.pdf", replace
	
* Province 5
	eststo: itsa del_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_5.pdf", replace
	
* Province 6 
	eststo: itsa del_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_6.pdf", replace
	
* Province 7
	eststo: itsa del_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/del_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Facility Deliveries) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* C-sections

* Province 1 
	eststo: itsa cs_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_1.pdf", replace

* Province 2 
	eststo: itsa cs_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/cs_util_2.pdf", replace
	
* Province 3 
	eststo: itsa cs_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_3.pdf", replace
	
* Province 4 
	eststo: itsa cs_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/cs_util_4.pdf", replace
	
* Province 5
	eststo: itsa cs_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_5.pdf", replace
	
* Province 6 
	eststo: itsa cs_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_6.pdf", replace
	
* Province 7
	eststo: itsa cs_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/cs_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(C-sections) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear  

********************************************************************************					 
* ANC Visits

* Province 1 
	eststo: itsa anc_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_1.pdf", replace

* Province 2 
	eststo: itsa anc_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/anc_util_2.pdf", replace
	
* Province 3 
	eststo: itsa anc_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_3.pdf", replace
	
* Province 4 
	eststo: itsa anc_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/anc_util_4.pdf", replace
	
* Province 5
	eststo: itsa anc_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_5.pdf", replace
	
* Province 6 
	eststo: itsa anc_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_6.pdf", replace
	
* Province 7
	eststo: itsa anc_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/anc_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Antenatal care visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 

* PNC Visits

* Province 1 
	eststo: itsa pnc_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_1.pdf", replace

* Province 2 
	eststo: itsa pnc_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pnc_util_2.pdf", replace
	
* Province 3 
	eststo: itsa pnc_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_3.pdf", replace
	
* Province 4 
	eststo: itsa pnc_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pnc_util_4.pdf", replace
	
* Province 5
	eststo: itsa pnc_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_5.pdf", replace
	
* Province 6 
	eststo: itsa pnc_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_6.pdf", replace
	
* Province 7
	eststo: itsa pnc_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pnc_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(PNC Visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* Combining diarrhea visits and sick child visits

* Province 1 
	eststo: itsa sick_visits i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/sick_visits_1.pdf", replace

* Province 2 
	eststo: itsa sick_visits i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/sick_visits_2.pdf", replace
	
* Province 3 
	eststo: itsa sick_visits i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/sick_visits3.pdf", replace
	
* Province 4 
	eststo: itsa sick_visits i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/sick_visits_4.pdf", replace
	
* Province 5
	eststo: itsa sick_visits i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/sick_visits_5.pdf", replace
	
* Province 6 
	eststo: itsa sick_visits i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/sick_visits_6.pdf", replace
	
* Province 7
	eststo: itsa sick_visits i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Sick child Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/sick_visitsl_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/sick_visits.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Sick child visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 

********************************************************************************					 
* Pentavalent vaccinations

* Province 1 
	eststo: itsa pent_qual i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_1.pdf", replace

* Province 2 
	eststo: itsa pent_qual i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pent_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa pent_qual i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa pent_qual i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pent_qual_4.pdf", replace
	
* Province 5
	eststo: itsa pent_qual i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa pent_qual i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_6.pdf", replace
	
* Province 7
	eststo: itsa pent_qual i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pent_qual.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Pentavalent vaccinations) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 


********************************************************************************					 
* Measles vaccinations

* Province 1 
	eststo: itsa measles_qual i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_1.pdf", replace

* Province 2 
	eststo: itsa measles_qual i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/measles_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa measles_qual i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa measles_qual i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/measles_qual_4.pdf", replace
	
* Province 5
	eststo: itsa measles_qual i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa measles_qual i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_6.pdf", replace
	
* Province 7
	eststo: itsa measles_qual i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/measles_qual.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Measles vaccinations) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear 


********************************************************************************					 
* HIV testing
			 
* Province 1 
	eststo: itsa hivtest_qual i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_1.pdf", replace

* Province 2 
	eststo: itsa hivtest_qual i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/hivtest_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa hivtest_qual i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(15000)80000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa hivtest_qual i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/hivtest_qual_4.pdf", replace
	
* Province 5
	eststo: itsa hivtest_qual i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa hivtest_qual i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)6000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_6.pdf", replace
	
* Province 7
	eststo: itsa hivtest_qual i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(4000)16000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/hivtest_qual.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(HIV tests conducted) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear
	
********************************************************************************					 
* Diabetes visits 
			 
* Province 1 
	eststo: itsa diab_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_1.pdf", replace

* Province 2 
	eststo: itsa diab_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/diab_util_2.pdf", replace
	
* Province 3 
	eststo: itsa diab_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_3.pdf", replace
	
* Province 4 
	eststo: itsa diab_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)6000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/diab_util_4.pdf", replace
	
* Province 5
	eststo: itsa diab_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_5.pdf", replace
	
* Province 6 
	eststo: itsa diab_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(300)1500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_6.pdf", replace
	
* Province 7
	eststo: itsa diab_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/diab_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Diabetes visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear

********************************************************************************					 
* Hypertension visits 
			 
* Province 1 
	eststo: itsa hyper_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_1.pdf", replace

* Province 2 
	eststo: itsa hyper_util i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/hyper_util_2.pdf", replace
	
* Province 3 
	eststo: itsa hyper_util i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_3.pdf", replace
	
* Province 4 
	eststo: itsa hyper_util i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/hyper_util_4.pdf", replace
	
* Province 5
	eststo: itsa hyper_util i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_5.pdf", replace
	
* Province 6 
	eststo: itsa hyper_util i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)3000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_6.pdf", replace
	
* Province 7
	eststo: itsa hyper_util i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/hyper_util.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(Hypertension visits) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear

********************************************************************************					 
* TB cases detected visits 
			 
* Province 1 
	eststo: itsa tbdetect_qual i.season,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_1.pdf", replace

* Province 2 
	eststo: itsa tbdetect_qual i.season,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/tbdetect_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa tbdetect_qual i.season,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa tbdetect_qual i.season,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/tbdetect_qual_4.pdf", replace
	
* Province 5
	eststo: itsa tbdetect_qual i.season,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa tbdetect_qual i.season,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_6.pdf", replace
	
* Province 7
	eststo: itsa tbdetect_qual i.season,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detecteds, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/tbdetect_qual.rtf", replace /// 
	wide b(2) ci(2) noobs nobaselevels compress ///
	drop() title(TB cases detected) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename(_t "Pre-period slope" _x15 "Level change" _x_t15 "Post-period slope change" 2.season "Season 2" /// 
	3.season "Season 3" 4.season "Season 4")
	
	eststo clear

	
******************************************************************************************
*** Forest plots - percent change in utilization, including UCL and LCL (level change) ***
*** Using the average in the pre-period ***


global all opd_util ipd_util er_util fp_sa_util del_util cs_util anc_util pnc_util sick_visits ///
pent_qual measles_qual hivtest_qual tbdetect_qual diab_util hyper_util tbdetect_qual


* Organized by province 

foreach p in 1 2 3 4 5 6 7 {
	putexcel set "$user/$analysis/Percent change in utilization v1.xlsx", sheet("`p'") modify
	putexcel A1 = "province" B1 = "service" C1="avg_preCovid" D1= "pct_change" E1="lcl_pct_change" F1="ucl_pct_change" 
	local i = 1
	tsset prov rmonth
	foreach var of global all {
		local i = `i'+1
		itsa `var' i.season,  single treatid(`p') trperiod(15) lag(1) replace
		mat m1= r(table) 
		mat b = m1[1..., 2]'
		scalar beta = b[1,1]
		scalar lcl = b[1,5]
		scalar ucl = b[1,6]
		sum `var' if timeafter == 0 & prov == `p'
		scalar avg = r(mean)
		scalar pct_chg = (beta/avg)*100
		scalar lcl_pct_chg = (lcl/avg)*100
		scalar ucl_pct_chg = (ucl/avg)*100
		putexcel A`i' = "Province `p'"
		putexcel B`i' = "`var'"
		putexcel C`i' = `r(mean)'
		putexcel D`i' = pct_chg
		putexcel E`i' = lcl_pct_chg 
		putexcel F`i' = ucl_pct_chg 
		scalar drop _all	
	}
	
}

* Organized by service type 

foreach var of global all {
	putexcel set "$user/$analysis/Percent change in utilization v2.xlsx", sheet("`var'") modify
	putexcel A1 = "province" B1 = "service" C1="avg_preCovid" D1= "pct_change" E1="lcl_pct_change" F1="ucl_pct_change" 
	local i = 1
	tsset prov rmonth
	foreach p in 1 2 3 4 5 6 7 {
		local i = `i'+1
		itsa `var' i.season,  single treatid(`p') trperiod(15) lag(1) replace
		mat m1= r(table) 
		mat b = m1[1..., 2]'
		scalar beta = b[1,1]
		scalar lcl = b[1,5]
		scalar ucl = b[1,6]
		sum `var' if timeafter == 0 & prov == `p'
		scalar avg = r(mean)
		scalar pct_chg = (beta/avg)*100
		scalar lcl_pct_chg = (lcl/avg)*100
		scalar ucl_pct_chg = (ucl/avg)*100
		putexcel A`i' = "Province `p'"
		putexcel B`i' = "`var'"
		putexcel C`i' = `r(mean)'
		putexcel D`i' = pct_chg
		putexcel E`i' = lcl_pct_chg 
		putexcel F`i' = ucl_pct_chg 
		scalar drop _all	
	}
	
}

* Meta analysis to pull estimates by province
import excel using "$user/$analysis/Percent change in utilization v2.xlsx", sheet("opd_util") firstrow clear
save  "$user/$analysis/tmp.dta", replace

foreach var in ipd_util er_util fp_sa_util del_util cs_util anc_util ///
pnc_util sick_visits pent_qual measles_qual hivtest_qual tbdetect_qual diab_util hyper_util  {
import excel using "$user/$analysis/Percent change in utilization v2.xlsx", sheet("`var'") firstrow clear
append using "$user/$analysis/tmp.dta" 
save  "$user/$analysis/tmp.dta", replace
}


metan pct_change lcl_pct_change ucl_pct_change, by(province) random nograph

/*
. metan pct_change	lcl_pct_change ucl_pct_change, by(province) random	nograph

Study	ES    [95% Conf. Interval]     % Weight
		
Province 1
1	-51.955   -66.512   -37.398          1.26
2	-2.056    -6.732     2.620          1.42
3	-19.795   -63.847    24.256          0.62
4	-1.075   -12.392    10.241          1.33
5	-29.319   -53.546    -5.093          1.03
6	-64.321   -97.974   -30.669          0.81
7	11.631   -50.300    73.561          0.40
8	-27.103   -60.683     6.478          0.81
9	-45.093   -84.984    -5.202          0.69
10	-32.815   -51.529   -14.101          1.16
11	-87.697   -120.725   -54.670         0.83
12	-68.325   -99.475   -37.175          0.87
13	-33.903   -55.882   -11.924          1.08
14	-19.003   -78.772    40.766          0.42
15	-3.359   -11.231     4.513          1.38
Sub-total	  
D+L pooled ES	-30.870   -43.672   -18.067         14.11
		
Province 2
16	-60.161   -78.723   -41.599          1.17
17	-28.708   -57.871     0.454          0.91
18	-24.057   -44.528    -3.586          1.12
19	-48.362   -76.192   -20.531          0.94
20	-11.122   -54.536    32.291          0.63
21	-21.977   -59.294    15.339          0.74
22	-24.730   -48.368    -1.093          1.04
23	-77.638   -136.482   -18.794         0.43
24	-26.339   -55.501     2.824          0.91
25	-3.796   -10.625     3.034          1.40
26	-24.613   -43.113    -6.112          1.17
27	2.186   -22.232    26.604          1.02
28	-5.724   -33.245    21.796          0.95
29	-1.186   -37.683    35.311          0.75
30	-20.541   -83.051    41.969          0.39
Sub-total	  
D+L pooled ES	-23.590   -35.454   -11.725         13.58
		
Province 3
31	-34.186   -55.609   -12.764          1.10
32	-93.263   -143.753   -42.774         0.53
33	-19.252   -51.269    12.764          0.85
34	-63.564   -73.552   -53.575          1.35
35	-64.281   -80.506   -48.056          1.22
36	-27.844   -69.898    14.210          0.65
37	-46.264   -73.695   -18.833          0.95
38	-45.785   -79.934   -11.637          0.80
39	-25.666   -50.316    -1.016          1.02
40	-1.410    -8.460     5.640          1.39
41	1.651   -15.508    18.811          1.20
42	-46.389   -64.652   -28.127          1.17
43	-31.872   -75.139    11.395          0.63
44	-22.875   -38.078    -7.672          1.25
45	-40.371   -63.663   -17.079          1.05
Sub-total	  
D+L pooled ES	-36.101   -51.857   -20.345         15.17
		
Province 4
46	-2.177   -17.903    13.549          1.23
47	-9.949   -54.735    34.837          0.61
48	-29.116   -68.189     9.956          0.71
49	-57.260   -83.226   -31.293          0.99
50	-13.895   -46.836    19.045          0.83
51	-35.245   -49.912   -20.577          1.26
52	-2.887    -6.079     0.305          1.43
53	-63.640   -80.268   -47.013          1.21
54	-42.533   -81.897    -3.169          0.70
55	-45.704   -67.687   -23.720          1.08
56	-13.295   -23.939    -2.650          1.34
57	-60.493   -88.829   -32.158          0.93
58	-8.316   -28.975    12.343          1.12
59	-20.252   -43.397     2.893          1.06
60	-15.458   -58.868    27.953          0.63
Sub-total	  
D+L pooled ES	-27.659   -40.138   -15.181         15.12
		
Province 5
61	-59.713   -75.741   -43.686          1.23
62	-12.522   -27.556     2.513          1.25
63	-67.155   -86.088   -48.222          1.16
64	-16.391   -39.556     6.773          1.06
65	-66.626   -80.586   -52.666          1.27
66	-29.295   -68.030     9.440          0.71
67	-52.928   -81.656   -24.199          0.92
68	-32.133   -55.105    -9.161          1.06
69	-32.485   -80.915    15.945          0.55
70	-29.237   -56.921    -1.553          0.95
71	-48.739   -67.662   -29.816          1.16
72	16.972   -17.073    51.018          0.80
73	-3.819   -18.378    10.741          1.26
74	-16.512   -48.219    15.196          0.85
75	-2.362   -40.789    36.065          0.72
Sub-total	  
D+L pooled ES	-31.646   -45.886   -17.406         14.95
		
Province 6
76	-41.993   -69.964   -14.022          0.94
77	-28.415   -56.140    -0.689          0.95
78	-43.108   -83.346    -2.870          0.68
79	-3.749   -55.779    48.282          0.51
80	-7.317   -18.797     4.163          1.32
81	-2.411   -10.725     5.904          1.38
82	-53.149   -88.698   -17.599          0.77
83	-10.094   -25.813     5.624          1.23
84	-40.736   -87.957     6.485          0.57
85	-49.435   -72.767   -26.104          1.05
86	-2.359   -26.105    21.387          1.04
87	-17.030   -40.124     6.063          1.06
88	2.884   -26.681    32.450          0.90
89	-59.771   -104.176   -15.366         0.61
90	-31.213   -86.990    24.564          0.46
Sub-total	  
D+L pooled ES	-21.350   -31.491   -11.210         13.48
		
Province 7
91	-0.405   -29.517    28.708          0.91
92	-19.512   -39.348     0.324          1.14
93	-27.501   -62.518     7.517          0.78
94	-11.715   -31.020     7.590          1.15
95	-23.376   -47.448     0.695          1.03
96	-6.003   -11.311    -0.694          1.41
97	-60.280   -81.575   -38.985          1.10
98	9.115   -22.325    40.554          0.86
99	-30.174   -58.670    -1.679          0.93
100	21.163   -69.868   112.193          0.22
101	-43.346   -73.482   -13.211          0.89
102	-21.429   -52.554     9.696          0.87
103	-22.979   -72.727    26.770          0.54
104	-29.259   -65.361     6.843          0.76
105	-19.014   -44.854     6.825          0.99
Sub-total	  
D+L pooled ES	-20.690   -30.894   -10.485         13.58

