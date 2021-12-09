* Health system resilience during Covid-19 
* Associations between COVID-19 lockdowns and health service disruptions in 10 countries 

* Analyses

use "$user/$analysis/Data/Multip4_combined.dta", clear

regress relative ib(4).serv stringency_mean rmonth ib(5).co 

regress relative ib(4).serv stringency_mean if country=="KOR"

regress relative ib(4).serv curfew soe school_close work_close public_event ///
		restrict_gather public_trnsprt stay_home move_restr int_trav info_camp ib(5).co 
		
		*interaction term between country and stringency 
		*random intercept by country 
		
mixed 
