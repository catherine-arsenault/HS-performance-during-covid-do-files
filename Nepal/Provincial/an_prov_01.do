* Nepal provincial analysis

use "$user/$NEPdata/Data for analysis/Nepal_provincial_analysis.dta", clear

*******************************************************************************
* Descriptive table (see analysis plan)
********************************************************************************
* Average number of new COVID cases per month by province

* Average number of outpatient visits before COVID and during COVID 

********************************************************************************
* ITS analysis
********************************************************************************
tsset prov rmonth
********************************************************************************
* OPD
* Province 1 
	itsa opd_util i.season ,  single treatid(1) trperiod(15) lag(1) replace ///
	figure(xlabel(1(1)24) ylabel(0(50000)400000, labsize(vsmall)) graphregion(color(white)) ///
					 legend(off) ytitle("")) 			 
* Province 2 
	itsa opd_util,  single treatid(2) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 3 
	itsa opd_util,  single treatid(3) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 4 
	itsa opd_util,  single treatid(4) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 					 	
* Province 5
	itsa opd_util,  single treatid(5) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 6 
	itsa opd_util,  single treatid(6) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 7
	itsa opd_util,  single treatid(7) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
********************************************************************************					 
* HIV testing
* Province 1 
	itsa hivtest_qual,  single treatid(1) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 ylabel(0(5000)20000, labsize(vsmall)) graphregion(color(white)) ///
					 legend(off) ytitle("")) 			 
* Province 2 
	itsa hivtest_qual,  single treatid(2) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 3 
	itsa hivtest_qual,  single treatid(3) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 4 
	itsa hivtest_qual,  single treatid(4) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 					 	
* Province 5
	itsa hivtest_qual,  single treatid(5) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 6 
	itsa hivtest_qual,  single treatid(6) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
* Province 7
	itsa hivtest_qual,  single treatid(7) trperiod(15) lag(1) replace figure(xlabel(1(1)24) ///
					 graphregion(color(white)) ///
					 legend(off) ytitle("")) 
