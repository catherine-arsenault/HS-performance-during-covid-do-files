* Nepal provincial analysis

clear all
use "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", clear

gen sick_visits = diarr_util + pneum_util 
global all opd_util ipd_util er_util fp_sa_util del_util cs_util anc_util pnc_util sick_visits ///
pent_qual measles_qual hivtest_qual tbdetect_qual diab_util hyper_util 

*******************************************************************************
* Descriptive table (see analysis plan)
********************************************************************************
* Total number of COVID cases per month by province in 

* Average number of outpatient visits before COVID and during COVID 
*
* ITS analysis
*
* Services: opd_util, ipd_util, er_util, fp_util, del_util, cs_util, anc_util, pnc_util 
*			diarr_util, pneum_util, pent_qual, measles_qual,
*			hivtest_qual, tbdetect_qual, diab_util, hyper_util
*
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

*ITS Analysis 
********************************************************************************
tsset prov rmonth
* OPD
* Province 1 
	eststo: itsa opd_util i.season,  single treatid(1) trperiod(15) lag(1) replace ///
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





