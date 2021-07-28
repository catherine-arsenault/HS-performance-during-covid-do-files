
*** MAIN do file (user global analysis)


* Data quality analysis
* Ethiopia, Haiti, KZN, Lao, Nepal
* Completeness

* use the raw data (dataset at the begining of the cleaning do file)

* Sentinel indicators
* Creates appendix to assess completeness
collapse (count) fp_util-tbdetect_qual , by (year month)
			  
foreach x of global all {
	cap egen max`x'=max(`x')
	cap gen completeness_`x'= `x'/max`x'
	cap drop max`x'
}		
export excel using "$analysis/Appendices/Data completeness.xlsx", sheet(Ethiopia) firstrow(variable) replace  

* Outliers
*copy the commands in the cleaning do files
* add a count
