* HS performance during Covid
* February 8 2021
* Ghana
* PI Catherine Arsenault, Analyst MK Kim
* Formating for google data studio dashboard
/****************************************************************
This do file formats the dataset for the interactive dashboard 
created in google data studio
****************************************************************
 
		COLLAPSE TO PROVINCE TOTALS AND RESHAPE FOR DASHBOARD

*****************************************************************/

u "$user/$data/Data for analysis/GHA_Jan19-Dec20_WIDE_final.dta", clear


global volume fp_util sti_util anc_util del_util cs_util pnc_util diarr_util pneum_util ///
			  malnu_util
global vaccine tt_qual vacc_qual pent_qual bcg_qual measles_qual opv3_qual pneum_qual rota_qual 
global other opd_util ipd_util road_util diab_util hyper_util malaria_util ///
			 tbdetect_qual 
global mortality ipd_mort_num newborn_mort_num sb_mort_num mat_mort_num totaldel
global all $volume $vaccine $other $mortality 


* Create year and month variables  
gen year = 2019 
replace year = 2020 if period =="January 2020" | period =="February 2020" | period =="March 2020" | period == "April 2020" | period =="May 2020" | period =="June 2020" | period =="July 2020" | period == "August 2020" | period == "September 2020" |  period == "October 2020" |  period == "November 2020" |  period == "December 2020"

gen month = . 
replace month = 1 if period == "January 2019" | period == "January 2020"
replace month = 2 if period == "February 2019" | period == "February 2020"
replace month = 3 if period == "March 2019" | period == "March 2020"
replace month = 4 if period == "April 2019" | period == "April 2020"
replace month = 5 if period == "May 2019" | period == "May 2020"
replace month = 6 if period == "June 2019" | period == "June 2020"
replace month = 7 if period == "July 2019" | period == "July 2020"
replace month = 8 if period == "August 2019" | period == "August 2020"
replace month = 9 if period == "September 2019" | period == "September 2020"
replace month = 10 if period == "October 2019" | period == "October 2020"
replace month = 11 if period == "November 2019" | period == "November 2020"
replace month = 12 if period == "December 2019" | period == "December 2020"

drop period 
order region year month 

* Save dataset for analyses
save "$user/$data/Data for analysis/Ghana_su_24months.dta"


* Reshaping for data visualisations
preserve
	keep if year == 2020
	foreach v of global all {
		rename(`v')(`v'20)
	}
	drop year
	save "$user/$data/temp.dta", replace
restore
keep if year==2019
foreach v of global all {
	rename(`v')(`v'19)
	}
drop year
merge m:m region month using "$user/$data/temp.dta"
drop _merge
rm "$user/$data/temp.dta"
save "$user/$data/Data for analysis/GHA_Jan19-Dec20.dta", replace 

*Create national totals 
collapse (sum) fp_util19-rota_qual20, by(month) 
gen region  ="National"
append using "$user/$data/Data for analysis/GHA_Jan19-Dec20.dta"
order region 
sort region month 
export delimited using "$user/$data/Ghana_Jan19-Dec20_fordashboard.csv", replace



/* Create year and month variables  
gen year = 2019 
replace year = 2020 if period =="January 2020" | period =="February 2020" | period =="March 2020" | period == "April 2020" | period =="May 2020" | period =="June 2020" | period =="July 2020" | period == "August 2020" | period == "September 2020" |  period == "October 2020" |  period == "November 2020" |  period == "December 2020"

gen month = . 
replace month = 1 if period == "January 2019" | period == "January 2020"
replace month = 2 if period == "February 2019" | period == "February 2020"
replace month = 3 if period == "March 2019" | period == "March 2020"
replace month = 4 if period == "April 2019" | period == "April 2020"
replace month = 5 if period == "May 2019" | period == "May 2020"
replace month = 6 if period == "June 2019" | period == "June 2020"
replace month = 7 if period == "July 2019" | period == "July 2020"
replace month = 8 if period == "August 2019" | period == "August 2020"
replace month = 9 if period == "September 2019" | period == "September 2020"
replace month = 10 if period == "October 2019" | period == "October 2020"
replace month = 11 if period == "November 2019" | period == "November 2020"
replace month = 12 if period == "December 2019" | period == "December 2020"

drop period 
order region year month 
*/
