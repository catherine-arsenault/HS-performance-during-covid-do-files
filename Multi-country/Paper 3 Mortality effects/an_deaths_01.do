* HS resilience during COVID-19 study
* Effect of the pandemic on institutional deaths 

********************************************************************************
* 1 CHILE 
 u "$user/$CHLdata/Data for analysis/CHLtmp_deaths.dta", clear
* Newborn
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	qui xtreg neo_mort_numrate rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_neo_mort
	qui xtreg neo_mort_numrate rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_neo_mort
	collapse (mean) *rate linear season_neo , by(rmonth)
			
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Chile neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)16, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/CHL_neo.pdf", replace
* Inpatient
 u "$user/$CHLdata/Data for analysis/CHLtmp_deaths.dta", clear
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	qui xtreg ipd_mort_numrate rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_ipd_mort
	qui xtreg ipd_mort_numrate rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_ipd_mort
		
	collapse (mean) *rate linear season_ipd , by(rmonth)

	twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Chile inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(20)70, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/CHL_ipd.pdf", replace
********************************************************************************
* 2 ETHIOPIA 
 u "$user/$ETHdata/Data for analysis/ETHtmp_deaths.dta", clear
	foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate ipd_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_ipd_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ethiopia neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)14, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/ETH_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ethiopia stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(5)25, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/ETH_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ethiopia maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)3, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/ETH_mat.pdf", replace	
*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ethiopia inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(5)40, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/ETH_ipd.pdf", replace
********************************************************************************
* 3 GHANA 
 u "$user/$GHAdata/Data for analysis/GHAtmp_deaths.dta", clear 
	foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate ipd_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_ipd_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ghana neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)7, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/GHA_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ghana stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)14, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/GHA_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ghana maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)1.4, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/GHA_mat.pdf", replace	
*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Ghana inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(5)30, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/GHA_ipd.pdf", replace

********************************************************************************
* 4 HAITI 
 u "$user/$HTIdata/Data for analysis/HTItmp_deaths.dta", clear 
	foreach v in sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	foreach v in sb_mort_numrate mat_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) sb_mort_numrate-season_mat_mort_num , by(rmonth)
			
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Haiti maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)8, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/HTI_mat.pdf", replace	
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Haiti stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(5)55, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/HTI_sb.pdf", replace	
		
********************************************************************************
* 5 KZN
u "$user/$KZNdata/Data for analysis/KZNtmp_deaths.dta", clear 
foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate ipd_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_ipd_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("KwaZulu-Natal neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)12, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KZN_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("KwaZulu-Natal stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(5)30, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KZN_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("KwaZulu-Natal maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)2, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KZN_mat.pdf", replace	
*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("KwaZulu-Natal inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(10)70, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/KZN_ipd.pdf", replace
********************************************************************************
* 6 LAO
u "$user/$LAOdata/Data for analysis/LAOtmp_deaths.dta", clear 
foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate  {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_mat_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Laos neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)12, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/LAO_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Laos stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)10, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/LAO_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Laos maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)2, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/LAO_mat.pdf", replace	
********************************************************************************
* 7 Mexico
u "$user/$MEXdata/Data for analysis/MEXtmp_deaths.dta", clear 
foreach v in neo_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	gen er_mort_numrate = (er_mort_num/er_util)*1000
	foreach v in neo_mort_numrate  mat_mort_numrate ipd_mort_numrate er_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_er_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Mexico neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)12, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/MEX_neo.pdf", replace			
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Mexico maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)1.2, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/MEX_mat.pdf", replace
*ER
twoway (scatter er_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_er_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_er_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit er_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit er_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Mexico emergency room deaths per 1,000 visits (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)10, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/MEX_er.pdf", replace
*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Mexico inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(250)1000, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/MEX_ipd.pdf", replace

********************************************************************************
* 8 NEPAL
u "$user/$NEPdata/Data for analysis/NEPtmp_deaths.dta", clear 
foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate ipd_mort_numrate  {
	qui xtreg `v' rmonth if rmonth<15 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<15 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_ipd_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<15, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=15 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Nepal neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)8, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/NEP_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<15, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=15 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Nepal stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)20, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/NEP_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<15, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=15 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Nepal maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)1, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/NEP_mat.pdf", replace
*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_mort_numrate rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth, lpattern(vshortdash) lcolor(grey)) ///
		(lfit linear_ipd_mort_numrate rmonth if rmonth<15, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=15 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(14, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Nepal inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(2)16, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/NEP_ipd.pdf", replace
********************************************************************************
* 9 KOR
u "$user/$KORdata/Data for analysis/KORtmp_deaths.dta", clear 
foreach v in neo_mort_num sb_mort_num mat_mort_num {
		gen `v'rate= (`v'/totaldel)*1000
	}
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	foreach v in neo_mort_numrate sb_mort_numrate mat_mort_numrate ipd_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) neo_mort_numrate-season_ipd_mort_numrate , by(rmonth)
	
* Newborn
	twoway (scatter neo_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_neo_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_neo_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit neo_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit neo_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("South Korea neonatal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)5, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KOR_neo.pdf", replace		
*Stillbirths
	twoway (scatter sb_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_sb_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_sb_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit sb_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit sb_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("South Korea stillbirths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)5, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KOR_sb.pdf", replace	
*Maternal deaths
twoway (scatter mat_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_mat_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_mat_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit mat_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit mat_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("South Korea maternal deaths per 1,000 deliveries (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(0.2)1.2, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
			
		graph export "$analysis/Results/Graphs/KOR_mat.pdf", replace

*Inpatient deaths
twoway (scatter ipd_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_ipd_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_ipd_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit ipd_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit ipd_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("South Korea inpatient deaths per 1,000 admissions (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(3)20, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/KOR_ipd.pdf", replace
********************************************************************************
* 9 KOR
u "$user/$THAdata/Data for analysis/THAtmp_deaths.dta", clear 
		gen road_mort_numrate= (road_mort_num/road_util)*1000

	foreach v in road_mort_numrate {
	qui xtreg `v' rmonth if rmonth<16 , i(reg) fe cluster (reg)
		predict linear_`v'
	qui xtreg `v' rmonth i.season if rmonth<16 , i(reg) fe cluster (reg)
		predict season_`v'
	}	
	collapse (mean) road_mort_numrate linear_road_mort_numrate season_road_mort_numrate , by(rmonth)
	
	*Inpatient deaths
twoway (scatter road_mort_numrate rmonth, msize(vsmall)  sort) ///
		(line linear_road_ rmonth, lpattern(dash) lcolor(green)) ///
		(line season_road_ rmonth , lpattern(vshortdash) lcolor(grey)) ///
		(lfit road_mort_numrate rmonth if rmonth<16, lcolor(green)) ///
		(lfit road_mort_numrate rmonth if rmonth>=16 & rmonth<=24, lcolor(red)), ///
		ylabel(, labsize(small)) xline(15, lpattern(dash) lcolor(black)) ///
		xtitle("", size(small)) legend(off) graphregion(color(white)) ///
		title("Thailand road traffic deaths per 1,000 accidents (2019-2020)", size(small))  ///
		xlabel(1(1)24) xlabel(,  labsize(vsmall)) ylabel(0(1)5, labsize(vsmall)) ///
		xlabel(, labels valuelabels labsize(tiny))
		
		graph export "$analysis/Results/Graphs/THA_road.pdf", replace

