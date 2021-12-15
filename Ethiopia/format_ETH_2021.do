* HS resilience during COVID
* Format do file
* Ethiopia Jan19-Jun21

clear all 
set more off
global volumes del_util opd_util ipd_util pent_qual

u  "$user/$data/Data for analysis/Ethiopia_Jan19-Jun21_WIDE_CCA.dta", clear

/****************************************************************
 FORMAT DATASET FOR ANALYSES
*****************************************************************/
sort region zone org* 
reshape long del_util opd_util ipd_util pent_qual , ///
				i(region zone org*) j(month) string

* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year =2021 if month=="1_21" | month=="2_21" | month=="3_21" | month=="4_21" | month=="5_21" ///
				| month=="6_21" 
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20" | month =="1_21"
replace mo = 2 if month =="2_19" | month =="2_20" | month =="2_21"
replace mo = 3 if month =="3_19" | month =="3_20" | month =="3_21"
replace mo = 4 if month =="4_19" | month =="4_20" | month =="4_21"
replace mo = 5 if month =="5_19" | month =="5_20" | month =="5_21"
replace mo = 6 if month =="6_19" | month =="6_20" | month =="6_21"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort region zone org*  year month 


* Hospital indicator
gen Hospital = 1 if regexm(organ, "[Hh]ospital") | regexm(organ, "HOSPITAL") 
replace Hospital =0 if Hospital==.
* Region type indicator 
gen regtype = "Urban" if region=="Addis Ababa" | region=="Dire Dawa" | region=="Harari"
replace regtype = "Agrarian" if region == "Amhara" | region=="Oromiya" ///
| region== "SNNP" | region=="Tigray"
replace regtype = "Pastoral" if region == "Afar" | region=="Ben Gum" ///
                              | region=="Gambella" | region=="Somali" 
lab var regtype "Region type"

order region regtype zone org* Hospital  year month 

save "$user/$data/Data for analysis/Ethiopia_su_30months.dta", replace 

/* Code to identify clinics (private) 
replace factype =2 if regexm(organ, "[Cc]linic") | regexm(organ, "CLINIC") | ///
                           regexm(organ, "CLINIK")  |  regexm(organ, "[Cc]linik") | ///
						   regexm(organ, "[Nn]GO") | regexm(organ, "[Cc]linc") | ///
						   regexm(organ, "[Cc]LINC") | regexm(organ, "[Cc]ilinik") | ///
						   regexm(organ, "[Kk]linik") | regexm(organ, "[Kk]ilinik") | ///
						   regexm(organ, "[Cc]ilinic") | regexm(organ, " [Nn]go") | ///
						   regexm(organ, "[Cc]LIINC") | regexm(organ, "[Cc]lnic") 





