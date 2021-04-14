* Health system performance during Covid-19 
* Created by Catherine Arsenault
* Effect of Covid-19 on health service utilization in 10 countries
* This do file creates final service utilization datasets and an appendix  

********************************************************************************
* 1 CHILE
********************************************************************************

********************************************************************************
* 2 ETHIOPIA
********************************************************************************
use "$user/$ETHdata/Data for analysis/Ethiopia_Jan19-Dec20_WIDE_CCA_DB.dta", clear
sort region zone organisationunitname orgunitlevel1 orgunitlevel4
gen unique_id=_n
* Reshape
reshape long   opd_util er_util road_util ipd_util fp_util sti_util anc_util ///
              del_util cs_util pnc_util diarr_util pneum_util sam_util vacc_qual ///
			  bcg_qual pent_qual measles_qual opv3_qual pneum_qual rota_qual ///
			   art_util hivsupp_qual_num , i(region zone org* ) j(month) string
drop *_19 *_20
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort region year month
order region year month 

* Hospital and region type indicator
gen Hospital = 1 if regexm(organ, "[Hh]ospital") | regexm(organ, "HOSPITAL") 
replace Hospital =0 if Hospital==.
gen regtype = "Urban" if region=="Addis Ababa" | region=="Dire Dawa" | region=="Harari"
replace regtype = "Agrarian" if region == "Amhara" | region=="Oromiya" ///
| region== "SNNP" | region=="Tigray"
replace regtype = "Pastoral" if region == "Afar" | region=="Ben Gum" ///
                              | region=="Gambella" | region=="Somali" 
lab var regtype "Region type"

gen rmonth= month if year==2019
replace rmonth = month+12 if year ==2020
gen postCovid = rmonth>15 // State of Emergency was March 30th, month 15. 
* Number of months since Covid
gen timeafter=0 
replace time=1 if rmonth==16
replace time=2 if rmonth==17
replace time=3 if rmonth==18
replace time=4 if rmonth==19
replace time=5 if rmonth==20
replace time=6 if rmonth==21
replace time=7 if rmonth==22
replace time=8 if rmonth==23
replace time=9 if rmonth==24

gen spring = month>=3 & month<=5
gen summer = month>=6 & month<=8
gen fall = month>=9 & month<=11
gen winter= month==12 | month==1 | month==2

* Save clean dataset for analyses
save "$user/$ETHdata/Data for analysis/Ethiopia_su_24months_for_analyses.dta", replace 

collapse (count)fp_util-art_util , by (year month)
			  
foreach x of global ETHall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Ethiopia) firstrow(variable) replace  

********************************************************************************
* 3 GHANA
********************************************************************************
u  "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta"
keep reg year month opd_util road_util ipd_util fp_util sti_util anc_util del_util ///
	 cs_util pnc_util diarr_util pneum_util malnu_util tt_qual vacc_qual ///
	 bcg_qual pent_qual measles_qual opv3_qual pneum_qual rota_qual ///
	 malaria_util tbdetect_qual diab_util hyper_util
save "$user/$GHAdata/Data for analysis/Ghana_su_24months_for_analyses.dta", replace 	 
	 
********************************************************************************
* 4 HAITI
********************************************************************************


********************************************************************************
* 5 KZN, SA
********************************************************************************
use "$user/$KZNdata/Data for analysis/KZN_Jan19-Dec20_WIDE_CCA_DB.dta", clear 
* Reshape
reshape long opd_util road_util trauma_util ipd_util icu_util anc1_util del_util ///
			  cs_util kmcn_qual pnc_util diarr_util pneum_util sam_util vacc_qual ///
			  bcg_qual pent_qual measles_qual pneum_qual rota_qual tbscreen_qual ///
			  tbdetect_qual tbtreat_qual art_util diab_util cerv_qual, ///
			  i(Province dist subdist Facility factype) j(month)
drop totaldel* *denom* *num*
gen year = 2019 if month>=1 & month<=12
replace year = 2020 if year==.
order year , after(factype)
replace month = month-12 if month>=13

* Save clean dataset for analyses
save "$user/$KZNdata/Data for analysis/KZN_su_24months_for_analyses.dta"

collapse (count) anc1_util-trauma_util, by (year month)
			  
foreach x of global KZNall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(KZN) firstrow(variable)  

********************************************************************************
* 6 LAO
********************************************************************************
use "$user/$LAOdata/Data for analysis/Lao_Jan19-Dec20_WIDE_CCA_DB.dta", clear 
reshape long opd_util road_util ipd_util fp_sa_util anc_util del_util cs_util ///
			  pnc_util bcg_qual pent_qual opv3_qual pneum_qual diab_util ///
			  hyper_util, i(org*) j(month) string
drop *_19 *_20
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort org* year month
order org*  year month 

* Save clean dataset for analyses
save "$user/$LAOdata/Data for analysis/Lao_su_24months_for_analyses.dta"

collapse (count) fp_sa_util-road_util , by (year month)
			  
foreach x of global LAOall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Lao) firstrow(variable)  

********************************************************************************
* 7 MEXICO
********************************************************************************
use "$user/$MEXdata/Data for analysis/IMSS_Jan19-Dec20final_WIDE.dta", clear 
* Reshape
reshape long opd_util er_util ipd_util fp_util sti_util anc_util del_util cs_util ///
			 diarr_util pneum_util malnu_util bcg_qual pent_qual measles_qual ///
			 opv3_qual pneum_qual rota_qual art_util diab_util hyper_util ///
			 cerv_util breast_util , i( Deleg ) j(month) string
drop *19 *20 HF* 
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month num_del
sort Del year month
order Del year month 

* Save clean dataset for analyses
save "$user/$MEXdata/Data for analysis/Mexico_su_24months_for_analyses.dta"
********************************************************************************
* 8 NEPAL
********************************************************************************
use "$user/$NEPdata/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_DB.dta", clear
* Reshape
reshape long   opd_util er_util ipd_util fp_sa_util fp_perm_util fp_la_util anc_util del_util cs_util ///
			  pnc_util diarr_util pneum_util bcg_qual pent_qual measles_qual ///
			  opv3_qual pneum_qual tbdetect_qual hivtest_qual hyper_util diab_util ///
			 , i( org* ) j(month) string
drop *_19 *_20
* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" |	month=="5_20" | ///
				   month=="6_20"  | month=="7_20" |	month=="8_20" |	month=="9_20" |	month=="10_20" | ///
				   month=="11_20" |	month=="12_20"
replace year = 2019 if year==.
gen mo = 1 if month =="1_19" | month =="1_20"
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month =="10_19" | month =="10_20"
replace mo = 11 if month =="11_19" | month =="11_20"
replace mo = 12 if month =="12_19" | month =="12_20"
drop month	
rename mo month
sort org* year month
order org*  year month 

* Save clean dataset for analyses
save "$user/$NEPdata/Data for analysis/Nepal_su_24months_for_analyses.dta"

drop fp_perm_util fp_la_util // not included in multi country paper
collapse (count) fp_sa_util-pneum_qual , by (year month)
			  
foreach x of global NEPall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Nepal) firstrow(variable)  


********************************************************************************
* 9 SOUTH KOREA
********************************************************************************


********************************************************************************
* 10 THAILAND
********************************************************************************
use  "$user/$THAdata/Data for analysis/Thailand_Oct18-Dec20_WIDE.dta", clear
drop *18
reshape long opd_util ipd_util dental_util diab_util dengue_util diarr_util ///
             heart_util hyper_util stroke_util predel_util totaldel road_util ///
			 road_mort_num malaria_util pneum_util anc_util, i(Prov) j(month) string 

* Month and year
gen year = 2020 if month=="1_20" |	month=="2_20" |	month=="3_20" |	month=="4_20" | ///
				   month=="5_20" |	month=="6_20"  | month=="7_20" | month=="8_20" | ///
				   month=="9_20" |	month=="10_20" | month=="11_20" | month=="12_20" 

				   
replace year = 2019 if month=="1_19" |	month=="2_19" |	month=="3_19" |	month=="4_19" | ///
					   month=="5_19" |	month=="6_19"  | month=="7_19" | month=="8_19" | ///
				       month=="9_19" |	month=="10_19" | month=="11_19" | month=="12_19" 					   
					   
gen mo = 1 if month =="1_19" | month =="1_20" 
replace mo = 2 if month =="2_19" | month =="2_20"
replace mo = 3 if month =="3_19" | month =="3_20"
replace mo = 4 if month =="4_19" | month =="4_20"
replace mo = 5 if month =="5_19" | month =="5_20"
replace mo = 6 if month =="6_19" | month =="6_20"
replace mo = 7 if month =="7_19" | month =="7_20"
replace mo = 8 if month =="8_19" | month =="8_20"
replace mo = 9 if month =="9_19" | month =="9_20"
replace mo = 10 if month=="10_18"| month =="10_19" | month =="10_20" 
replace mo = 11 if month=="11_18"| month =="11_19" | month =="11_20" 
replace mo = 12 if month=="12_18"| month =="12_19" | month =="12_20"
order Province year mo 
drop month 
rename mo month 
sort Province year month

* Save  dataset for analyses
save "$user/$THAdata/Data for analysis/Thailand_su_24months_for_analyses.dta"
