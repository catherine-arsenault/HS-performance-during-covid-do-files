global p4 "Health System Performance Covid (shared)/Paper 4 Stringency"
cd "$user/$p4/Data"
import delimited "$user/$p4/Data/owid-covid-data.csv", clear

gen hsr = 1 if inlist(iso_code, "CHL", "ETH", "GHA", "HTI","KOR","LAO","MEX","NPL","THA")
tab iso_code if hsr==1
keep if hsr==1

/********* Generate case summaries*********/
 tab location if positive_rate==. /*Haiti and Laos dont have TPR info**/
 gen date2=date(date,"YMD",2021)
 format date2 %td
 keep if date2>=date("01042020","DMY") & date2<=date("31122020","DMY")
 gen month=month(date2)
 tab month
 sort location month
foreach var of varlist new_cases new_cases_per_million new_deaths{
 by location month: egen `var'_totmonth=sum(`var')
 }
 sort location month
 duplicates drop location month, force
 keep iso_code location month  new_cases_totmonth new_cases_per_million_totmonth population new_deaths_totmonth
rename iso_code country
replace country="NEP" if country=="NPL"
 sort country month
 save covid_cases, replace
 
 
 /****** Format GDP data *********************/
clear
use gdp
replace country="NEP" if country=="NPL"
replace country="KZN" if country=="ZAF"
sort country
save gdp_formatted, replace 

 /***** Merge all data sources - GDP, National COVID case, Provincial COVID cases (KZN-SA)  and Stringency data***********/
 clear
 use "$user/$p4/Data/Multip4_national_targeted.dta"
 sort country
 merge country using  gdp_formatted
 drop if _merge==2
 drop _merge
 sort country month
 merge country month using covid_cases
 drop _merge
 sort country month
 merge country month using  kzn_cases, update
 drop if _merge==2 
 /********* Complete missing data for KZN *********/
replace population=11531628 if country=="KZN" & population==.
gen cases_per_mil=(new_cases_totmonth/population)*1000000
gen deaths_per_mil=(new_deaths_totmonth/population)*1000000
save hsr_allmerged, replace
/***********************************************************/
/************** Exploratory data analysis ****************/
/**********************************************************/

/**** Summarize the service items  data ********/
sort country month service
by country month service: egen mean_rel_vol=mean(relative_vol)
gen mean_rel_vol_perc=mean_rel_vol*100
gen rel_vol_perc=relative_vol*100
forval i=1(1)5{  
twoway (line mean_rel_vol_perc month if service==`i',lcolor(red) lwidth(medthick)) (scatter rel_vol_perc month if service==`i',mcolor(red) msize(vsmall))(line stringency_mean month if service==`i',yaxis(2) lwidth(medthick) lcolor(blue) ), by( country ) ytitle("Service type `i' Relative Service Volume")  
graph save "$user/$p4/Graphs/twoway_vol_string_`i'.gph", replace
}  

/*** RMN****/
twoway (line mean_rel_vol_perc month if service==1,lcolor(navy) lwidth(medthick) ///
	     ylabel(0(25)150,angle(horizontal)) ytitle("Relative service volume (%)")) ///
	   (scatter rel_vol_perc month if service==1,mcolor(navy) msize(vsmall)) ///
	   (line stringency_mean month if service==1, yaxis(2) ytitle("Stringency index (%)", ///
	    axis(2)) ylabel(0(25)150, angle(horizontal) axis(2)) lwidth(medthick) lcolor(maroon) ), ///
		 graphregion(color(white)) xtitle("Month") by(country, noiy title("Reproductive, maternal, or newborn") cols(5)) 
		
graph save "$user/$p4/Graphs/twoway_vol_string_rmn.gph", replace

/*** Summative ****/
twoway (line mean_rel_vol_perc month if service==2,lcolor(navy) lwidth(medthick) ylabel(0(25)150,angle(horizontal)) ytitle("Relative service volume (%)")) ///
 (scatter rel_vol_perc month if service==2,mcolor(navy) msize(vsmall)) ///
 (line stringency_mean month if service==2, yaxis(2) ytitle("Stringency index (%)", axis(2)) ylabel(0(25)150, angle(horizontal) axis(2)) lwidth(medthick) lcolor(maroon)), xtitle("Month") by(country, noiy title("Service use overall and injuries") cols(5))
graph save "$user/$p4/Graphs/twoway_vol_string_summ.gph", replace


/*** Child ****/
twoway (line mean_rel_vol_perc month if service==3,lcolor(navy) lwidth(medthick) ylabel(0(25)150,angle(horizontal)) ytitle("Relative service volume (%)")) ///
 (scatter rel_vol_perc month if service==3,mcolor(navy) msize(vsmall)) ///
 (line stringency_mean month if service==3, yaxis(2) ytitle("Stringency index (%)", axis(2)) ylabel(0(25)150, angle(horizontal) axis(2)) lwidth(medthick) lcolor(maroon)), xtitle("Month") by(country, noiy title("Child health services") cols(5))
graph save "$user/$p4/Graphs/twoway_vol_string_child.gph", replace

/*** ART ****/
twoway (line mean_rel_vol_perc month if service==4,lcolor(navy) lwidth(medthick) ylabel(0(25)150,angle(horizontal)) ytitle("Relative service volume (%)")) ///
 (scatter rel_vol_perc month if service==4,mcolor(navy) msize(vsmall)) ///
 (line stringency_mean month if service==4, yaxis(2) ytitle("Stringency index (%)", axis(2)) ylabel(0(25)150, angle(horizontal) axis(2)) lwidth(medthick) lcolor(maroon)), xtitle("Month") by(country, noiy title("Antiretroviral therapy") cols(5))
graph save "$user/$p4/Graphs/twoway_vol_string_art.gph", replace

/*** Chronic diseases ****/
twoway (line mean_rel_vol_perc month if service==5,lcolor(navy) lwidth(medthick) ylabel(0(25)150,angle(horizontal)) ytitle("Relative service volume (%)")) ///
 (scatter rel_vol_perc month if service==5,mcolor(navy) msize(vsmall)) ///
 (line stringency_mean month if service==5, yaxis(2) ytitle("Stringency index (%)", axis(2)) ylabel(0(25)150, angle(horizontal) axis(2)) lwidth(medthick) lcolor(maroon)), xtitle("Month") by(country, noiy title("Chronic diseases") cols(5))
graph save "$user/$p4/Graphs/twoway_vol_string_chronic.gph", replace


**** Table 1 ***
preserve 
collapse (first) gdppercapitapppconstant2017inter (mean) stringency_mean cases_per_mil, by(country)
export excel table_1, firstrow(variables) sheet(1) sheetreplace
restore 

preserve
collapse (mean) relative_vol, by(country service)
reshape wide relative_vol, i(service) j(country) string
export excel table_1, firstrow(variables) sheet(2) sheetreplace 
restore 


/**********************************************************************************************/
/******************* Mixed model fitting ******************************************************/

/************************* Model building process ******************************************/ 
clear
use hsr_allmerged
gen rel_vol_perc=relative_vol*100


spearman rel_vol_perc stringency_mean cases_per_mil  month gdppercapitapppconstant2017inter

xtmixed rel_vol_perc stringency_mean cases_per_mil i.service i.month gdppercapitapppconstant2017inter || country:    , var
xtmixed rel_vol_perc c.stringency_mean##i.month  cases_per_mil i.service gdppercapitapppconstant2017inter || country:    , var

/** No sig interaction effect***/
/** Stringency is highly correlated with month...even though it is important we cannot include month****/

 /*Fitting random intercepts and storing results*/
quietly xtmixed rel_vol_perc stringency_mean cases_per_mil i.service  gdppercapitapppconstant2017inter || country:    , mle nolog
estimates store ri
/*Fitting random coefficients and storing results*/
quietly xtmixed rel_vol_perc stringency_mean cases_per_mil i.service  gdppercapitapppconstant2017inter || country:stringency_mean    , covariance(unstructure) mle nolog
estimates store rc
/*Running the likelihood-ratio test to compare*/
lrtest ri rc 
/********* No random slope needed********/
xtmixed rel_vol_perc stringency_mean cases_per_mil i.service  gdppercapitapppconstant2017inter || country:    , mle nolog var 

predict resid, residuals
predict resid_std, rstandard /* residuals/sd(Residual) */
qnorm resid_std  
hist resid_std
swilk resid_std
/****** Rescale GDP and stringency to facilitate interpretation**************/
gen gdp_1000= gdppercapitapppconstant2017inter/1000
  
foreach var of varlist stringency_mean stringency_median stringency_max{
gen `var'_per10=`var'/10
}

/*****************************************************************************/
/******************* Final models fitted *************************************/
xtmixed rel_vol_perc stringency_mean_per10 cases_per_mil i.service  gdp_1000 || country:    , var mle nolog vce(robust)

/********** Sensitivity analysis **************/
xtmixed rel_vol_perc stringency_median_per10 cases_per_mil i.service  gdp_1000 || country:    ,var  mle nolog vce(robust)
xtmixed rel_vol_perc stringency_max_per10 cases_per_mil i.service  gdp_1000 || country:    , mle nolog vce(robust) var


/************* Explore each individual measure*****************/
foreach var of varlist curfew-info_camp{
xtmixed rel_vol_perc i.`var' cases_per_mil i.service  gdp_1000 || country:    , mle nolog vce(robust) var
}
foreach var of varlist ntnl_school_close ntnl_work_close ntnl_public_event ntnl_restrict_gather ntnl_public_trnsprt ntnl_stay_home ntnl_move_restr ntnl_info_camp{
xtmixed rel_vol_perc i.`var' cases_per_mil i.service  gdp_1000 || country:    , mle nolog vce(robust) var
}


 
 
 
 