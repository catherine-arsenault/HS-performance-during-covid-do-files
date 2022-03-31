
* 1 CHL
u "$user/$CHLdata/Data for analysis/CHLtmp_deaths.dta", clear 
preserve 
collapse (sum) ipd_mort_num-totaldel (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(CHL, replace) firstrow(var)
restore

collapse (sum) ipd_mort_num-totaldel (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(CHL, replace) firstrow(var)
* 2 ETH
u "$user/$ETHdata/Data for analysis/ETHtmp_deaths.dta", clear 
preserve 
collapse (sum) totaldel-ipd_mort_num  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(ETH, replace) firstrow(var)
restore

collapse (sum) sb_mort_num neo_mort_num  ipd_util mat_mort_num  ///
	totaldel ipd_mort_num (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate-ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(ETH, replace) firstrow(var) 
* 3 GHA
u "$user/$GHAdata/Data for analysis/GHAtmp_deaths.dta", clear 
preserve 
collapse (sum) ipd_util-totaldel  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(GHA, replace) firstrow(var)
restore
collapse (sum) ipd_util-totaldel (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate-ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(GHA, replace ) firstrow(var) 
* 4 HTI
u "$user/$HTIdata/Data for analysis/HTItmp_deaths.dta", clear 
preserve 
collapse (sum) sb_mort_num-totaldel  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(HTI, replace) firstrow(var)
restore
collapse (sum) sb_mort_num-totaldel (first) country , by(reg postCovid)
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
collapse (mean) mat_mort_numrate sb_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(HTI, replace) firstrow(var) 
* 5 KZN
u "$user/$KZNdata/Data for analysis/KZNtmp_deaths.dta", clear 
preserve 
collapse (sum) totaldel-ipd_mort_num  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(KZN, replace) firstrow(var)
restore
collapse (sum) totaldel-ipd_mort_num (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate-ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(KZN, replace) firstrow(var) 
* 6 LAO
u "$user/$LAOdata/Data for analysis/LAOtmp_deaths.dta", clear 
preserve 
collapse (sum) neo_mort_num-totaldel  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(LAO, replace) firstrow(var)
restore
collapse (sum) neo_mort_num-totaldel (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
collapse (mean) neo_mort_numrate mat_mort_numrate sb_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(LAO, replace) firstrow(var) 
* 7 MEX
u "$user/$MEXdata/Data for analysis/MEXtmp_deaths.dta", clear 
preserve 
collapse (sum) neo_mort_num-ipd_mort_num  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(MEX, replace) firstrow(var)
restore
collapse (sum)  neo_mort_num er_util ipd_util mat_mort_num er_mort_num ///
	totaldel ipd_mort_num (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
	gen er_mort_numrate= (er_mort_num/er_util)*1000
collapse (mean) neo_mort_numrate-er_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(MEX, replace) firstrow(var) 
* 8 NEP
u "$user/$NEPdata/Data for analysis/NEPtmp_deaths.dta", clear  
preserve 
collapse (sum) sb_mort_num-ipd_util  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(NEP, replace) firstrow(var)
restore
collapse (sum) sb_mort_num neo_mort_num  ipd_util mat_mort_num  ///
	totaldel ipd_mort_num (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate-ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(NEP, replace) firstrow(var) 
* 9 SKOR
u "$user/$KORdata/Data for analysis/KORtmp_deaths.dta", clear  
preserve 
collapse (sum) totaldel-ipd_mort_num  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(SKOR, replace) firstrow(var)
restore
collapse (sum) sb_mort_num neo_mort_num  ipd_util mat_mort_num  ///
	totaldel ipd_mort_num (first) country , by(reg postCovid)
	gen neo_mort_numrate= (neo_mort_num/totaldel)*1000
	gen mat_mort_numrate= (mat_mort_num/totaldel)*1000
	gen sb_mort_numrate= (sb_mort_num/totaldel)*1000
	gen ipd_mort_numrate= (ipd_mort_num/ipd_util)*1000
collapse (mean) neo_mort_numrate-ipd_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(KOR, replace) firstrow(var) 
* 9 THA
u "$user/$THAdata/Data for analysis/THAtmp_deaths.dta", clear 
preserve 
collapse (sum) road_mort_num road_util  (first) country , by(postCovid)
export excel using "$analysis/Results/sums.xlsx", sheet(THA, replace) firstrow(var)
restore
collapse (sum) road_mort_num road_util , by(reg postCovid)
	gen road_mort_numrate= (road_mort_num/road_util)*1000
collapse (mean) road_mort_numrate, by(postCovid)
export excel using "$analysis/Results/barcharts.xlsx", sheet(THA, replace) firstrow(var) 
