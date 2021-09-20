* Health system performance during Covid-19 
* Effect of Covid on health service utilization in 10 countries
* Created by Catherine Arsenault, May 4, 2021

********************************************************************************
* CHILE 
********************************************************************************
use "$user/$CHLdata/Data for analysis/CHLtmp.dta", clear

********************************************************************************
* CHILE GRAPHS
********************************************************************************
* Deliveries
			qui xtreg del_util rmonth if rmonth<16 , i(reg) fe cluster(reg) // linear prediction
			predict linear_del_util
			qui xtreg del_util rmonth i.spring i.summer i.fall i.winter ///
				if rmonth<16 , i(reg) fe cluster(reg) // w. seasonal adj
			predict season_del_util 
			
			collapse del_util linear_del_util season_del_util  , by(rmonth)
			
			twoway (scatter del_util rmonth, msize(vsmall)  sort) ///
				(line linear_del_util rmonth, lpattern(dash) lcolor(green)) ///
				(line season_del_util rmonth , lpattern(vshortdash) lcolor(eltblue)) ///
				(lfit del_util rmonth if rmonth<16, lcolor(green)) ///
				(lfit del_util rmonth if rmonth>=16, lcolor(red)), ///
				ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
				xtitle("", size(small)) legend(off) ///
				ytitle("Average number per region", size(vsmall)) ///
				graphregion(color(white)) title("Chile Deliveries", size(small)) ///
				xlabel(1(1)24) xlabel(, labsize(vsmall)) ylabel(0(100)800, labsize(vsmall))
			
			graph export "$analysis/Results/Graphs/CHL_del_util.pdf", replace

rm "$user/$CHLdata/Data for analysis/CHLtmp.dta"
