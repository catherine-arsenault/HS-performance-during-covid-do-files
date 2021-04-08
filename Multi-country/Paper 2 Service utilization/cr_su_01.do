* Health system performance during Covid-19 
* Created by Catherine Arsenault

********************************************************************************
* Creates appendix to asesss completeness 
********************************************************************************

* Open final dataset in Ethiopia
use "$user/$ETHdata/Data for analysis/Ethiopia_Jan19-Dec20_WIDE_CCA_DB.dta", clear
* Reshape
reshape long   opd_util er_util road_util ipd_util fp_util sti_util anc_util ///
              del_util cs_util pnc_util diarr_util pneum_util sam_util vacc_qual ///
			  bcg_qual pent_qual measles_qual opv3_qual pneum_qual rota_qual ///
			   art_util hiv_supp_qual_num diab_util hyper_util ///
			  diab_detec hyper_detec diab_qual_num hyper_qual_num ///
			 , i(region zone org* ) j(month) string
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

collapse (count) opd_util er_util road_util ipd_util fp_util sti_util anc_util ///
              del_util cs_util pnc_util diarr_util pneum_util sam_util vacc_qual ///
			  bcg_qual pent_qual measles_qual opv3_qual pneum_qual rota_qual ///
			   art_util hiv_supp_qual_num diab_util hyper_util ///
			  diab_detec hyper_detec diab_qual_num hyper_qual_num ///
			  , by (year month)
			  
foreach x of global ETHall {
	egen max`x'=max(`x')
	gen completeness_`x'= `x'/max`x'
	drop max`x'
}		
export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Ethiopia) firstrow(variable) replace  



* Open final dataset in Nepal 
use "$user/$NEPdata/Data for analysis/Nepal_palika_Jan19-Dec20_WIDE_CCA_DB.dta", clear

export excel using "$user/$analysis/Appendices/Data completeness.xlsx", sheet(Nepal) firstrow(variable)  
