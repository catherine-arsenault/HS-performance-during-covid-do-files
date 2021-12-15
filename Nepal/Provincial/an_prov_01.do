* Nepal provincial analysis

use "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", clear

*******************************************************************************
* Descriptive table (see analysis plan)
********************************************************************************
* Average number of new COVID cases per month by province

* Average number of outpatient visits before COVID and during COVID 

* Services: opd_util, ipd_util, er_util, fp_util, del_util, cs_util, anc_util, pnc_util 
*			diarr_util, pneum_util, bcg_qual, pent_qual, measles_qual, pneum_qual, 
*			hivtest_qual, tbdetect_qual, diab_util, hyper_util

********************************************************************************
* ITS analysis
********************************************************************************
tsset prov rmonth
********************************************************************************
* OPD
* Province 1 
	eststo: itsa opd_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_1.pdf", replace

* Province 2 
	eststo: itsa opd_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/opd_util_2.pdf", replace
	
* Province 3 
	eststo: itsa opd_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_3.pdf", replace
	
* Province 4 
	eststo: itsa opd_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)400000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/opd_util_4.pdf", replace
	
* Province 5
	eststo: itsa opd_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)600000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_5.pdf", replace
	
* Province 6 
	eststo: itsa opd_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)300000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_6.pdf", replace
	
* Province 7
	eststo: itsa opd_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100000)500000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Outpatient visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/opd_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/opd_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Outpatient Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 
					 

********************************************************************************					 
* IPD

* Province 1 
	eststo: itsa ipd_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_1.pdf", replace

* Province 2 
	eststo: itsa ipd_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/ipd_util_2.pdf", replace
	
* Province 3 
	eststo: itsa ipd_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_3.pdf", replace
	
* Province 4 
	eststo: itsa ipd_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/ipd_util_4.pdf", replace
	
* Province 5
	eststo: itsa ipd_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_5.pdf", replace
	
* Province 6 
	eststo: itsa ipd_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_6.pdf", replace
	
* Province 7
	eststo: itsa ipd_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Inpatient visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/ipd_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/ipd_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Inpatient Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* ER Visits 

* Province 1 
	eststo: itsa er_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)50000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_1.pdf", replace

* Province 2 
	eststo: itsa er_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(8000)40000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/er_util_2.pdf", replace
	
* Province 3 
	eststo: itsa er_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(30000)150000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_3.pdf", replace
	
* Province 4 
	eststo: itsa er_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)40000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/er_util_4.pdf", replace
	
* Province 5
	eststo: itsa er_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(10000)50000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_5.pdf", replace
	
* Province 6 
	eststo: itsa er_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_6.pdf", replace
	
* Province 7
	eststo: itsa er_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ER visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/er_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/er_util.rtf", replace /// 
	ci compress nobaselevels drop() title(ER Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* SA Contraceptive users 

* Province 1 
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_1.pdf", replace

* Province 2 
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/fp_sa_util_2.pdf", replace
	
* Province 3 
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_3.pdf", replace
	
* Province 4 
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(20000)100000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/fp_sa_util_4.pdf", replace
	
* Province 5
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_5.pdf", replace
	
* Province 6 
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(20000)100000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_6.pdf", replace
	
* Province 7
	eststo: itsa fp_sa_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(50000)200000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("SA Contraceptive users, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/fp_sa_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/fp_sa_util.rtf", replace /// 
	ci compress nobaselevels drop() title(SA Contraceptive users) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* Facility deliveries 

* Province 1 
	eststo: itsa del_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_1.pdf", replace

* Province 2 
	eststo: itsa del_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/del_util_2.pdf", replace
	
* Province 3 
	eststo: itsa del_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries , Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_3.pdf", replace
	
* Province 4 
	eststo: itsa del_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/del_util_4.pdf", replace
	
* Province 5
	eststo: itsa del_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_5.pdf", replace
	
* Province 6 
	eststo: itsa del_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_6.pdf", replace
	
* Province 7
	eststo: itsa del_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Facility deliveries, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/del_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/del_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Facility deliveries) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* C-sections

* Province 1 
	eststo: itsa cs_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_1.pdf", replace

* Province 2 
	eststo: itsa cs_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/cs_util_2.pdf", replace
	
* Province 3 
	eststo: itsa cs_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_3.pdf", replace
	
* Province 4 
	eststo: itsa cs_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/cs_util_4.pdf", replace
	
* Province 5
	eststo: itsa cs_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_5.pdf", replace
	
* Province 6 
	eststo: itsa cs_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_6.pdf", replace
	
* Province 7
	eststo: itsa cs_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("C-sections, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/cs_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/cs_util.rtf", replace /// 
	ci compress nobaselevels drop() title(C-sections) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* ANC Visits

* Province 1 
	eststo: itsa anc_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_1.pdf", replace

* Province 2 
	eststo: itsa anc_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/anc_util_2.pdf", replace
	
* Province 3 
	eststo: itsa anc_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_3.pdf", replace
	
* Province 4 
	eststo: itsa anc_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/anc_util_4.pdf", replace
	
* Province 5
	eststo: itsa anc_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_5.pdf", replace
	
* Province 6 
	eststo: itsa anc_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_6.pdf", replace
	
* Province 7
	eststo: itsa anc_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("ANC Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/anc_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/anc_util.rtf", replace /// 
	ci compress nobaselevels drop() title(ANC Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 

* PNC Visits

* Province 1 
	eststo: itsa pnc_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_1.pdf", replace

* Province 2 
	eststo: itsa pnc_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pnc_util_2.pdf", replace
	
* Province 3 
	eststo: itsa pnc_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_3.pdf", replace
	
* Province 4 
	eststo: itsa pnc_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pnc_util_4.pdf", replace
	
* Province 5
	eststo: itsa pnc_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_5.pdf", replace
	
* Province 6 
	eststo: itsa pnc_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_6.pdf", replace
	
* Province 7
	eststo: itsa pnc_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("PNC Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pnc_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pnc_util.rtf", replace /// 
	ci compress nobaselevels drop() title(PNC Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* Diarrhea Visits

* Province 1 
	eststo: itsa diarr_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diarr_util_1.pdf", replace

* Province 2 
	eststo: itsa diarr_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/diarr_util_2.pdf", replace
	
* Province 3 
	eststo: itsa diarr_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diarr_util_3.pdf", replace
	
* Province 4 
	eststo: itsa diarr_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/diarr_util_4.pdf", replace
	
* Province 5
	eststo: itsa diarr_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diarr_util_5.pdf", replace
	
* Province 6 
	eststo: itsa diarr_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diarr_util_6.pdf", replace
	
* Province 7
	eststo: itsa diarr_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diarrhea Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diarr_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/diarr_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Diarrhea Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* Pneumonia Visits

* Province 1 
	eststo: itsa pneum_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_util_1.pdf", replace

* Province 2 
	eststo: itsa pneum_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pneum_util_2.pdf", replace
	
* Province 3 
	eststo: itsa pneum_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_util_3.pdf", replace
	
* Province 4 
	eststo: itsa pneum_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pneum_util_4.pdf", replace
	
* Province 5
	eststo: itsa pneum_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_util_5.pdf", replace
	
* Province 6 
	eststo: itsa pneum_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)4000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_util_6.pdf", replace
	
* Province 7
	eststo: itsa pneum_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneumonia Visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pneum_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Pneumonia Visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 
	
********************************************************************************					 
* BCG vaccinations

* Province 1 
	eststo: itsa bcg_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/bcg_qual_1.pdf", replace

* Province 2 
	eststo: itsa bcg_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/bcg_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa bcg_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/bcg_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa bcg_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/bcg_qual_4.pdf", replace
	
* Province 5
	eststo: itsa bcg_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/bcg_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa bcg_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/bcg_qual_6.pdf", replace
	
* Province 7
	eststo: itsa bcg_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("BCG Vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/bcg_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/bcg_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(BCG Vaccinations) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 


********************************************************************************					 
* Pentavalent vaccinations

* Province 1 
	eststo: itsa pent_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_1.pdf", replace

* Province 2 
	eststo: itsa pent_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pent_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa pent_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa pent_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pent_qual_4.pdf", replace
	
* Province 5
	eststo: itsa pent_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa pent_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_6.pdf", replace
	
* Province 7
	eststo: itsa pent_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pentavalent vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pent_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pent_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(Pentavalent Vaccinations) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 


********************************************************************************					 
* Measles vaccinations

* Province 1 
	eststo: itsa measles_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_1.pdf", replace

* Province 2 
	eststo: itsa measles_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/measles_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa measles_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa measles_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/measles_qual_4.pdf", replace
	
* Province 5
	eststo: itsa measles_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)30000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa measles_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_6.pdf", replace
	
* Province 7
	eststo: itsa measles_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Measles vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/measles_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/measles_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(Measles Vaccinations) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* Pneum vaccinations

* Province 1 
	eststo: itsa pneum_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_qual_1.pdf", replace

* Province 2 
	eststo: itsa pneum_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/pneum_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa pneum_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa pneum_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/pneum_qual_4.pdf", replace
	
* Province 5
	eststo: itsa pneum_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa pneum_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)6000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_qual_6.pdf", replace
	
* Province 7
	eststo: itsa pneum_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Pneum vaccinations, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/pneum_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/pneum_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(Pneum Vaccinations) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear 

********************************************************************************					 
* HIV testing
			 
* Province 1 
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_1.pdf", replace

* Province 2 
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/hivtest_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(15000)80000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/hivtest_qual_4.pdf", replace
	
* Province 5
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)6000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_6.pdf", replace
	
* Province 7
	eststo: itsa hivtest_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(4000)16000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("HIV tests conducted, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hivtest_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/hivtest_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(HIV tests conducted) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear
	
********************************************************************************					 
* Diabetes visits 
			 
* Province 1 
	eststo: itsa diab_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_1.pdf", replace

* Province 2 
	eststo: itsa diab_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(1000)5000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/diab_util_2.pdf", replace
	
* Province 3 
	eststo: itsa diab_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_3.pdf", replace
	
* Province 4 
	eststo: itsa diab_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(1000)6000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/diab_util_4.pdf", replace
	
* Province 5
	eststo: itsa diab_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)8000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_5.pdf", replace
	
* Province 6 
	eststo: itsa diab_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(300)1500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_6.pdf", replace
	
* Province 7
	eststo: itsa diab_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)2000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Diabetes visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/diab_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/diab_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Diabetes visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear

********************************************************************************					 
* Hypertension visits 
			 
* Province 1 
	eststo: itsa hyper_util i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_1.pdf", replace

* Province 2 
	eststo: itsa hyper_util i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/hyper_util_2.pdf", replace
	
* Province 3 
	eststo: itsa hyper_util i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(5000)25000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_3.pdf", replace
	
* Province 4 
	eststo: itsa hyper_util i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(3000)15000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/hyper_util_4.pdf", replace
	
* Province 5
	eststo: itsa hyper_util i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_5.pdf", replace
	
* Province 6 
	eststo: itsa hyper_util i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(500)3000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_6.pdf", replace
	
* Province 7
	eststo: itsa hyper_util i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(2000)10000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("Hypertension visits, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/hyper_util_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/hyper_util.rtf", replace /// 
	ci compress nobaselevels drop() title(Hypertension visits) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear

********************************************************************************					 
* TB cases detected visits 
			 
* Province 1 
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(1) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 1") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_1.pdf", replace

* Province 2 
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(2) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 2") ytitle("") xtitle("Month"))
					 
	graph export "$user/$analysis/Graphs/tbdetect_qual_2.pdf", replace
	
* Province 3 
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(3) trperiod(15) lag(1) replace /// 
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 3") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_3.pdf", replace
	
* Province 4 
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(4) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 4") ytitle("") xtitle("Month"))	
					 
	graph export "$user/$analysis/Graphs/tbdetect_qual_4.pdf", replace
	
* Province 5
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(5) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(200)1000, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 5") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_5.pdf", replace
	
* Province 6 
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(6) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detected, Province 6") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_6.pdf", replace
	
* Province 7
	eststo: itsa tbdetect_qual i.season covid_case,  single treatid(7) trperiod(15) lag(1) replace ///
			figure(xlabel(1(1)24) ylabel(0(100)500, labsize(vsmall)) graphregion(color(white)) ///
		    legend(off) title("TB cases detecteds, Province 7") ytitle("") xtitle("Month"))
	
	graph export "$user/$analysis/Graphs/tbdetect_qual_7.pdf", replace
	
	esttab using "$user/$analysis/Regression output/tbdetect_qual.rtf", replace /// 
	ci compress nobaselevels drop() title(TB cases detected) /// 
	cells (b(star fmt(1)) ci(par fmt(0))) /// 
	mtitles ("Province 1" "Province 2" "Province 3" "Province 4" "Province 5" "Province 6" "Province 7") /// 
	rename()
	
	eststo clear
