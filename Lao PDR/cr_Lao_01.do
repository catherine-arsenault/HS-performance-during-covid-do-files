* HS performance during Covid
* Jan 14, 2021
* Lao, January 2019 - October 2020
* Facility level analysis 
* Created by MK Kim 

clear all
set more off
********************************************************************************
********************************************************************************
*Import raw data: VOLUMES OF SERVICES (all facilities + district health offices (DC))

*Family planning 2019 
	 import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_1 Modern contraceptive use.csv", clear
	 rename ïorgunitlevel1 country 
	 *1) permanent method 
	 egen fp_perm_util1_19 = rowtotal(january2019femalesterilizationne january2019femalesterilizationco january2019malesterilizationnewu january2019malesterilizationcont), mi
	 egen fp_perm_util2_19 = rowtotal(february2019femalesterilizationn february2019femalesterilizationc february2019malesterilizationnew february2019malesterilizationcon), mi 
	 egen fp_perm_util3_19 = rowtotal(march2019femalesterilizationnewu march2019femalesterilizationcont march2019malesterilizationnewuse march2019malesterilizationcontin), mi 
	 egen fp_perm_util4_19 = rowtotal(april2019femalesterilizationnewu april2019femalesterilizationcont april2019malesterilizationnewuse april2019malesterilizationcontin), mi 
	 egen fp_perm_util5_19 = rowtotal(may2019femalesterilizationnewuse may2019femalesterilizationcontin may2019malesterilizationnewusers may2019malesterilizationcontinue), mi 
	 egen fp_perm_util6_19 = rowtotal(june2019femalesterilizationnewus june2019femalesterilizationconti june2019malesterilizationnewuser june2019malesterilizationcontinu), mi 
	 egen fp_perm_util7_19 = rowtotal(july2019femalesterilizationnewus july2019femalesterilizationconti july2019malesterilizationnewuser july2019malesterilizationcontinu), mi 
	 egen fp_perm_util8_19 = rowtotal(august2019femalesterilizationnew august2019femalesterilizationcon august2019malesterilizationnewus august2019malesterilizationconti), mi 
	 egen fp_perm_util9_19 = rowtotal(september2019femalesterilization v159 september2019malesterilizationne september2019malesterilizationco), mi 
	 egen fp_perm_util10_19 = rowtotal(october2019femalesterilizationne october2019femalesterilizationco october2019malesterilizationnewu october2019malesterilizationcont), mi 
	 egen fp_perm_util11_19 = rowtotal(november2019femalesterilizationn november2019femalesterilizationc november2019malesterilizationnew november2019malesterilizationcon), mi 
	 egen fp_perm_util12_19 = rowtotal(december2019femalesterilizationn december2019femalesterilizationc december2019malesterilizationnew december2019malesterilizationcon), mi 
	 
	 *2) short acting method 
	 egen fp_sa_util1_19 = rowtotal(january2019combinedpillnewuser january2019combinedpillcontinueu january2019emergencypillnewuser january2019emergencypillcontinue january2019singlepillnewusers january2019singlepillcontinueuse january2019deposeinjectablenewus january2019deposeinjectableconti january2019condomsnewusers january2019condomscontinueusers), mi 
	 
	 egen fp_sa_util2_19 = rowtotal(february2019combinedpillnewuser february2019combinedpillcontinue february2019emergencypillnewuser february2019emergencypillcontinu february2019singlepillnewusers february2019singlepillcontinueus february2019deposeinjectablenewu february2019deposeinjectablecont february2019condomsnewusers february2019condomscontinueusers), mi 
	 
	 egen fp_sa_util3_19 = rowtotal(march2019combinedpillnewuser march2019combinedpillcontinueuse march2019emergencypillnewuser march2019emergencypillcontinueus march2019singlepillnewusers march2019singlepillcontinueusers march2019deposeinjectablenewuser march2019deposeinjectablecontinu march2019condomsnewusers march2019condomscontinueusers), mi 
	 
	 egen fp_sa_util4_19 = rowtotal(april2019combinedpillnewuser april2019combinedpillcontinueuse april2019emergencypillnewuser april2019emergencypillcontinueus april2019singlepillnewusers april2019singlepillcontinueusers april2019deposeinjectablenewuser april2019deposeinjectablecontinu april2019condomsnewusers april2019condomscontinueusers), mi 
	 
	 egen fp_sa_util5_19 = rowtotal(may2019combinedpillnewuser may2019combinedpillcontinueuser may2019emergencypillnewuser may2019emergencypillcontinueuser may2019singlepillnewusers may2019singlepillcontinueusers may2019deposeinjectablenewusers may2019deposeinjectablecontinueu may2019condomsnewusers may2019condomscontinueusers), mi 
	 
	 egen fp_sa_util6_19 = rowtotal(june2019combinedpillnewuser june2019combinedpillcontinueuser june2019emergencypillnewuser june2019emergencypillcontinueuse june2019singlepillnewusers june2019singlepillcontinueusers june2019deposeinjectablenewusers june2019deposeinjectablecontinue june2019condomsnewusers june2019condomscontinueusers), mi 
	 
	 egen fp_sa_util7_19 = rowtotal(july2019combinedpillnewuser july2019combinedpillcontinueuser july2019emergencypillnewuser july2019emergencypillcontinueuse july2019singlepillnewusers july2019singlepillcontinueusers july2019deposeinjectablenewusers july2019deposeinjectablecontinue july2019condomsnewusers july2019condomscontinueusers), mi 
	 
	 egen fp_sa_util8_19 = rowtotal(august2019combinedpillnewuser august2019combinedpillcontinueus august2019emergencypillnewuser august2019emergencypillcontinueu august2019singlepillnewusers august2019singlepillcontinueuser august2019deposeinjectablenewuse august2019deposeinjectablecontin august2019condomsnewusers august2019condomscontinueusers), mi 
	 
	 egen fp_sa_util9_19 = rowtotal(september2019combinedpillnewuser september2019combinedpillcontinu september2019emergencypillnewuse september2019emergencypillcontin september2019singlepillnewusers september2019singlepillcontinueu september2019deposeinjectablenew september2019deposeinjectablecon september2019condomsnewusers september2019condomscontinueuser), mi 
	 
	 egen fp_sa_util10_19 = rowtotal(october2019combinedpillnewuser october2019combinedpillcontinueu october2019emergencypillnewuser october2019emergencypillcontinue october2019singlepillnewusers october2019singlepillcontinueuse october2019deposeinjectablenewus october2019deposeinjectableconti october2019condomsnewusers october2019condomscontinueusers), mi 
	 
	 egen fp_sa_util11_19 = rowtotal(november2019combinedpillnewuser november2019combinedpillcontinue november2019emergencypillnewuser november2019emergencypillcontinu november2019singlepillnewusers november2019singlepillcontinueus november2019deposeinjectablenewu november2019deposeinjectablecont november2019condomsnewusers november2019condomscontinueusers), mi 
	 
	 egen fp_sa_util12_19 = rowtotal(december2019combinedpillnewuser december2019combinedpillcontinue december2019emergencypillnewuser december2019emergencypillcontinu december2019singlepillnewusers december2019singlepillcontinueus december2019deposeinjectablenewu december2019deposeinjectablecont december2019condomsnewusers december2019condomscontinueusers), mi 
	 
	 *3) long acting 
	 egen fp_la_util1_19 = rowtotal(january2019iudnewusers january2019iudcontinueusers january2019implantnewusers january2019implantcontinueusers), mi 
	 egen fp_la_util2_19 = rowtotal(february2019iudnewusers february2019iudcontinueusers february2019implantnewusers february2019implantcontinueusers), mi 
	 egen fp_la_util3_19 = rowtotal(march2019iudnewusers march2019iudcontinueusers march2019implantnewusers march2019implantcontinueusers), mi 
	 egen fp_la_util4_19 = rowtotal(april2019iudnewusers april2019iudcontinueusers april2019implantnewusers april2019implantcontinueusers), mi 
	 egen fp_la_util5_19 = rowtotal(may2019iudnewusers may2019iudcontinueusers may2019implantnewusers may2019implantcontinueusers), mi 
	 egen fp_la_util6_19 = rowtotal(june2019iudnewusers june2019iudcontinueusers june2019implantnewusers june2019implantcontinueusers), mi 
	 egen fp_la_util7_19 = rowtotal(july2019iudnewusers july2019iudcontinueusers july2019implantnewusers july2019implantcontinueusers), mi 
	 egen fp_la_util8_19 = rowtotal(august2019iudnewusers august2019iudcontinueusers august2019implantnewusers august2019implantcontinueusers), mi 
	 egen fp_la_util9_19 = rowtotal(september2019iudnewusers september2019iudcontinueusers september2019implantnewusers september2019implantcontinueuser), mi 
	 egen fp_la_util10_19 = rowtotal(october2019iudnewusers october2019iudcontinueusers october2019implantnewusers october2019implantcontinueusers), mi 
	 egen fp_la_util11_19 = rowtotal(november2019iudnewusers november2019iudcontinueusers november2019implantnewusers november2019implantcontinueusers), mi 
	 egen fp_la_util12_19 = rowtotal(december2019iudnewusers december2019iudcontinueusers december2019implantnewusers december2019implantcontinueusers), mi 
	 
	keep org* fp* 
	save "$user/$data/Data for analysis/tmp.dta", replace 

*Family Planning District Health office totals 2019 
	 import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_1 Modern contraceptive use_DC.csv", clear
	 rename ïorgunitlevel1 country 
	*1) permanent method 
	 egen fp_perm_util1_19 = rowtotal(january2019femalesterilizationne january2019femalesterilizationco january2019malesterilizationnewu january2019malesterilizationcont), mi
	 egen fp_perm_util2_19 = rowtotal(february2019femalesterilizationn february2019femalesterilizationc february2019malesterilizationnew february2019malesterilizationcon), mi 
	 egen fp_perm_util3_19 = rowtotal(march2019femalesterilizationnewu march2019femalesterilizationcont march2019malesterilizationnewuse march2019malesterilizationcontin), mi 
	 egen fp_perm_util4_19 = rowtotal(april2019femalesterilizationnewu april2019femalesterilizationcont april2019malesterilizationnewuse april2019malesterilizationcontin), mi 
	 egen fp_perm_util5_19 = rowtotal(may2019femalesterilizationnewuse may2019femalesterilizationcontin may2019malesterilizationnewusers may2019malesterilizationcontinue), mi 
	 egen fp_perm_util6_19 = rowtotal(june2019femalesterilizationnewus june2019femalesterilizationconti june2019malesterilizationnewuser june2019malesterilizationcontinu), mi 
	 egen fp_perm_util7_19 = rowtotal(july2019femalesterilizationnewus july2019femalesterilizationconti july2019malesterilizationnewuser july2019malesterilizationcontinu), mi 
	 egen fp_perm_util8_19 = rowtotal(august2019femalesterilizationnew august2019femalesterilizationcon august2019malesterilizationnewus august2019malesterilizationconti), mi 
	 egen fp_perm_util9_19 = rowtotal(september2019femalesterilization v159 september2019malesterilizationne september2019malesterilizationco), mi 
	 egen fp_perm_util10_19 = rowtotal(october2019femalesterilizationne october2019femalesterilizationco october2019malesterilizationnewu october2019malesterilizationcont), mi 
	 egen fp_perm_util11_19 = rowtotal(november2019femalesterilizationn november2019femalesterilizationc november2019malesterilizationnew november2019malesterilizationcon), mi 
	 egen fp_perm_util12_19 = rowtotal(december2019femalesterilizationn december2019femalesterilizationc december2019malesterilizationnew december2019malesterilizationcon), mi 
	 
	*2) short acting method 
	 egen fp_sa_util1_19 = rowtotal(january2019combinedpillnewuser january2019combinedpillcontinueu january2019emergencypillnewuser january2019emergencypillcontinue january2019singlepillnewusers january2019singlepillcontinueuse january2019deposeinjectablenewus january2019deposeinjectableconti january2019condomsnewusers january2019condomscontinueusers), mi 
	 
	 egen fp_sa_util2_19 = rowtotal(february2019combinedpillnewuser february2019combinedpillcontinue february2019emergencypillnewuser february2019emergencypillcontinu february2019singlepillnewusers february2019singlepillcontinueus february2019deposeinjectablenewu february2019deposeinjectablecont february2019condomsnewusers february2019condomscontinueusers), mi 
	 
	 egen fp_sa_util3_19 = rowtotal(march2019combinedpillnewuser march2019combinedpillcontinueuse march2019emergencypillnewuser march2019emergencypillcontinueus march2019singlepillnewusers march2019singlepillcontinueusers march2019deposeinjectablenewuser march2019deposeinjectablecontinu march2019condomsnewusers march2019condomscontinueusers), mi 
	 
	 egen fp_sa_util4_19 = rowtotal(april2019combinedpillnewuser april2019combinedpillcontinueuse april2019emergencypillnewuser april2019emergencypillcontinueus april2019singlepillnewusers april2019singlepillcontinueusers april2019deposeinjectablenewuser april2019deposeinjectablecontinu april2019condomsnewusers april2019condomscontinueusers), mi 
	 
	 egen fp_sa_util5_19 = rowtotal(may2019combinedpillnewuser may2019combinedpillcontinueuser may2019emergencypillnewuser may2019emergencypillcontinueuser may2019singlepillnewusers may2019singlepillcontinueusers may2019deposeinjectablenewusers may2019deposeinjectablecontinueu may2019condomsnewusers may2019condomscontinueusers), mi 
	 
	 egen fp_sa_util6_19 = rowtotal(june2019combinedpillnewuser june2019combinedpillcontinueuser june2019emergencypillnewuser june2019emergencypillcontinueuse june2019singlepillnewusers june2019singlepillcontinueusers june2019deposeinjectablenewusers june2019deposeinjectablecontinue june2019condomsnewusers june2019condomscontinueusers), mi 
	 
	 egen fp_sa_util7_19 = rowtotal(july2019combinedpillnewuser july2019combinedpillcontinueuser july2019emergencypillnewuser july2019emergencypillcontinueuse july2019singlepillnewusers july2019singlepillcontinueusers july2019deposeinjectablenewusers july2019deposeinjectablecontinue july2019condomsnewusers july2019condomscontinueusers), mi 
	 
	 egen fp_sa_util8_19 = rowtotal(august2019combinedpillnewuser august2019combinedpillcontinueus august2019emergencypillnewuser august2019emergencypillcontinueu august2019singlepillnewusers august2019singlepillcontinueuser august2019deposeinjectablenewuse august2019deposeinjectablecontin august2019condomsnewusers august2019condomscontinueusers), mi 
	 
	 egen fp_sa_util9_19 = rowtotal(september2019combinedpillnewuser september2019combinedpillcontinu september2019emergencypillnewuse september2019emergencypillcontin september2019singlepillnewusers september2019singlepillcontinueu september2019deposeinjectablenew september2019deposeinjectablecon september2019condomsnewusers september2019condomscontinueuser), mi 
	 
	 egen fp_sa_util10_19 = rowtotal(october2019combinedpillnewuser october2019combinedpillcontinueu october2019emergencypillnewuser october2019emergencypillcontinue october2019singlepillnewusers october2019singlepillcontinueuse october2019deposeinjectablenewus october2019deposeinjectableconti october2019condomsnewusers october2019condomscontinueusers), mi 
	 
	 egen fp_sa_util11_19 = rowtotal(november2019combinedpillnewuser november2019combinedpillcontinue november2019emergencypillnewuser november2019emergencypillcontinu november2019singlepillnewusers november2019singlepillcontinueus november2019deposeinjectablenewu november2019deposeinjectablecont november2019condomsnewusers november2019condomscontinueusers), mi 
	 
	 egen fp_sa_util12_19 = rowtotal(december2019combinedpillnewuser december2019combinedpillcontinue december2019emergencypillnewuser december2019emergencypillcontinu december2019singlepillnewusers december2019singlepillcontinueus december2019deposeinjectablenewu december2019deposeinjectablecont december2019condomsnewusers december2019condomscontinueusers), mi 
	 
	 *3) long acting 
	 egen fp_la_util1_19 = rowtotal(january2019iudnewusers january2019iudcontinueusers january2019implantnewusers january2019implantcontinueusers), mi 
	 egen fp_la_util2_19 = rowtotal(february2019iudnewusers february2019iudcontinueusers february2019implantnewusers february2019implantcontinueusers), mi 
	 egen fp_la_util3_19 = rowtotal(march2019iudnewusers march2019iudcontinueusers march2019implantnewusers march2019implantcontinueusers), mi 
	 egen fp_la_util4_19 = rowtotal(april2019iudnewusers april2019iudcontinueusers april2019implantnewusers april2019implantcontinueusers), mi 
	 egen fp_la_util5_19 = rowtotal(may2019iudnewusers may2019iudcontinueusers may2019implantnewusers may2019implantcontinueusers), mi 
	 egen fp_la_util6_19 = rowtotal(june2019iudnewusers june2019iudcontinueusers june2019implantnewusers june2019implantcontinueusers), mi 
	 egen fp_la_util7_19 = rowtotal(july2019iudnewusers july2019iudcontinueusers july2019implantnewusers july2019implantcontinueusers), mi 
	 egen fp_la_util8_19 = rowtotal(august2019iudnewusers august2019iudcontinueusers august2019implantnewusers august2019implantcontinueusers), mi 
	 egen fp_la_util9_19 = rowtotal(september2019iudnewusers september2019iudcontinueusers september2019implantnewusers september2019implantcontinueuser), mi 
	 egen fp_la_util10_19 = rowtotal(october2019iudnewusers october2019iudcontinueusers october2019implantnewusers october2019implantcontinueusers), mi 
	 egen fp_la_util11_19 = rowtotal(november2019iudnewusers november2019iudcontinueusers november2019implantnewusers november2019implantcontinueusers), mi 
	 egen fp_la_util12_19 = rowtotal(december2019iudnewusers december2019iudcontinueusers december2019implantnewusers december2019implantcontinueusers), mi 
	
	keep org* fp* 
	append using "$user/$data/Data for analysis/tmp.dta"
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
*Family Planning 2020 
	 import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_1 Modern contraceptive use.csv", clear
	rename ïorgunitlevel1 country 
	*1) permanent method 
	egen fp_perm_util1_20 = rowtotal(january2020femalesterilizationne january2020femalesterilizationco january2020malesterilizationnewu january2020malesterilizationcont), mi 
	egen fp_perm_util2_20 = rowtotal(february2020femalesterilizationn february2020femalesterilizationc february2020malesterilizationnew february2020malesterilizationcon), mi 
	egen fp_perm_util3_20 = rowtotal(march2020femalesterilizationnewu march2020femalesterilizationcont march2020malesterilizationnewuse march2020malesterilizationcontin), mi 
	egen fp_perm_util4_20 = rowtotal(april2020femalesterilizationnewu april2020femalesterilizationcont april2020malesterilizationnewuse april2020malesterilizationcontin), mi 
	egen fp_perm_util5_20 = rowtotal(may2020femalesterilizationnewuse may2020femalesterilizationcontin may2020malesterilizationnewusers may2020malesterilizationcontinue), mi 
	egen fp_perm_util6_20 = rowtotal(june2020femalesterilizationnewus june2020femalesterilizationconti june2020malesterilizationnewuser june2020malesterilizationcontinu), mi 
	egen fp_perm_util7_20 = rowtotal(july2020femalesterilizationnewus july2020femalesterilizationconti july2020malesterilizationnewuser july2020malesterilizationcontinu), mi 
	egen fp_perm_util8_20 = rowtotal(august2020femalesterilizationnew august2020femalesterilizationcon august2020malesterilizationnewus august2020malesterilizationconti), mi 
	egen fp_perm_util9_20 = rowtotal(september2020femalesterilization v159 september2020malesterilizationne september2020malesterilizationco), mi 
	egen fp_perm_util10_20 = rowtotal(october2020femalesterilizationne october2020femalesterilizationco october2020malesterilizationnewu october2020malesterilizationcont), mi 
	
	*2) short acting method 
	egen fp_sa_util1_20 = rowtotal(january2020combinedpillnewuser january2020combinedpillcontinueu january2020condomsnewusers january2020condomscontinueusers january2020deposeinjectablenewus january2020deposeinjectableconti january2020emergencypillnewuser january2020emergencypillcontinue january2020singlepillnewusers january2020singlepillcontinueuse), mi 
	
	egen fp_sa_util2_20 = rowtotal(february2020combinedpillnewuser february2020combinedpillcontinue february2020condomsnewusers february2020condomscontinueusers february2020deposeinjectablenewu february2020deposeinjectablecont february2020emergencypillnewuser february2020emergencypillcontinu february2020singlepillnewusers february2020singlepillcontinueus), mi 
	
	egen fp_sa_util3_20 = rowtotal(march2020combinedpillnewuser march2020combinedpillcontinueuse march2020condomsnewusers march2020condomscontinueusers march2020deposeinjectablenewuser march2020deposeinjectablecontinu march2020emergencypillnewuser march2020emergencypillcontinueus march2020singlepillnewusers march2020singlepillcontinueusers), mi 
	
	egen fp_sa_util4_20 = rowtotal(april2020combinedpillnewuser april2020combinedpillcontinueuse april2020condomsnewusers april2020condomscontinueusers april2020deposeinjectablenewuser april2020deposeinjectablecontinu april2020emergencypillnewuser april2020emergencypillcontinueus april2020singlepillnewusers april2020singlepillcontinueusers), mi 
	
	egen fp_sa_util5_20 = rowtotal(may2020combinedpillnewuser may2020combinedpillcontinueuser may2020condomsnewusers may2020condomscontinueusers may2020deposeinjectablenewusers may2020deposeinjectablecontinueu may2020emergencypillnewuser may2020emergencypillcontinueuser may2020singlepillnewusers may2020singlepillcontinueusers), mi 
	
	egen fp_sa_util6_20 = rowtotal(june2020combinedpillnewuser june2020combinedpillcontinueuser june2020condomsnewusers june2020condomscontinueusers june2020deposeinjectablenewusers june2020deposeinjectablecontinue june2020emergencypillnewuser june2020emergencypillcontinueuse june2020singlepillnewusers june2020singlepillcontinueusers), mi 
	
	egen fp_sa_util7_20 = rowtotal(july2020combinedpillnewuser july2020combinedpillcontinueuser july2020condomsnewusers july2020condomscontinueusers july2020deposeinjectablenewusers july2020deposeinjectablecontinue july2020emergencypillnewuser july2020emergencypillcontinueuse july2020singlepillnewusers july2020singlepillcontinueusers), mi 
	
	egen fp_sa_util8_20 = rowtotal(august2020combinedpillnewuser august2020combinedpillcontinueus august2020condomsnewusers august2020condomscontinueusers august2020deposeinjectablenewuse august2020deposeinjectablecontin august2020emergencypillnewuser august2020emergencypillcontinueu august2020singlepillnewusers august2020singlepillcontinueuser), mi 
	
	egen fp_sa_util9_20 = rowtotal(september2020combinedpillnewuser september2020combinedpillcontinu september2020condomsnewusers september2020condomscontinueuser september2020deposeinjectablenew september2020deposeinjectablecon september2020emergencypillnewuse september2020emergencypillcontin september2020singlepillnewusers september2020singlepillcontinueu), mi 
	
	egen fp_sa_util10_20 = rowtotal(october2020combinedpillnewuser october2020combinedpillcontinueu october2020condomsnewusers october2020condomscontinueusers october2020deposeinjectablenewus october2020deposeinjectableconti october2020emergencypillnewuser october2020emergencypillcontinue october2020singlepillnewusers october2020singlepillcontinueuse), mi 
	
	 *3) long acting 
	 egen fp_la_util1_20 = rowtotal(january2020iudnewusers january2020iudcontinueusers january2020implantnewusers january2020implantcontinueusers), mi 
	 
	 egen fp_la_util2_20 = rowtotal(february2020iudnewusers february2020iudcontinueusers february2020implantnewusers february2020implantcontinueusers), mi 
	 
	 egen fp_la_util3_20 = rowtotal(march2020iudnewusers march2020iudcontinueusers march2020implantnewusers march2020implantcontinueusers), mi 
	 
	 egen fp_la_util4_20 = rowtotal(april2020iudnewusers april2020iudcontinueusers april2020implantnewusers april2020implantcontinueusers), mi 
	 
	 egen fp_la_util5_20 = rowtotal(may2020iudnewusers may2020iudcontinueusers may2020implantnewusers may2020implantcontinueusers), mi 
	 
	 egen fp_la_util6_20 = rowtotal(june2020iudnewusers june2020iudcontinueusers june2020implantnewusers june2020implantcontinueusers), mi 
	 
	 egen fp_la_util7_20 = rowtotal(july2020iudnewusers july2020iudcontinueusers july2020implantnewusers july2020implantcontinueusers), mi 
	 
	 egen fp_la_util8_20 = rowtotal(august2020iudnewusers august2020iudcontinueusers august2020implantnewusers august2020implantcontinueusers), mi 
	 
	 egen fp_la_util9_20 = rowtotal(september2020iudnewusers september2020iudcontinueusers september2020implantnewusers september2020implantcontinueuser), mi 
	 
	 egen fp_la_util10_20 = rowtotal(october2020iudnewusers october2020iudcontinueusers october2020implantnewusers october2020implantcontinueusers), mi 
	
	keep org* fp* 
	save "$user/$data/Data for analysis/tmp.dta", replace 
	
*Family Planning district health office (DC) 2020 
	 import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_1 Modern contraceptive use_DC.csv", clear
	rename ïorgunitlevel1 country 
	*1) permanent method 
	egen fp_perm_util1_20 = rowtotal(january2020femalesterilizationne january2020femalesterilizationco january2020malesterilizationnewu january2020malesterilizationcont), mi 
	egen fp_perm_util2_20 = rowtotal(february2020femalesterilizationn february2020femalesterilizationc february2020malesterilizationnew february2020malesterilizationcon), mi 
	egen fp_perm_util3_20 = rowtotal(march2020femalesterilizationnewu march2020femalesterilizationcont march2020malesterilizationnewuse march2020malesterilizationcontin), mi 
	egen fp_perm_util4_20 = rowtotal(april2020femalesterilizationnewu april2020femalesterilizationcont april2020malesterilizationnewuse april2020malesterilizationcontin), mi 
	egen fp_perm_util5_20 = rowtotal(may2020femalesterilizationnewuse may2020femalesterilizationcontin may2020malesterilizationnewusers may2020malesterilizationcontinue), mi 
	egen fp_perm_util6_20 = rowtotal(june2020femalesterilizationnewus june2020femalesterilizationconti june2020malesterilizationnewuser june2020malesterilizationcontinu), mi 
	egen fp_perm_util7_20 = rowtotal(july2020femalesterilizationnewus july2020femalesterilizationconti july2020malesterilizationnewuser july2020malesterilizationcontinu), mi 
	egen fp_perm_util8_20 = rowtotal(august2020femalesterilizationnew august2020femalesterilizationcon august2020malesterilizationnewus august2020malesterilizationconti), mi 
	egen fp_perm_util9_20 = rowtotal(september2020femalesterilization v159 september2020malesterilizationne september2020malesterilizationco), mi 
	egen fp_perm_util10_20 = rowtotal(october2020femalesterilizationne october2020femalesterilizationco october2020malesterilizationnewu october2020malesterilizationcont), mi 
	
	*2) short acting method 
	egen fp_sa_util1_20 = rowtotal(january2020combinedpillnewuser january2020combinedpillcontinueu january2020condomsnewusers january2020condomscontinueusers january2020deposeinjectablenewus january2020deposeinjectableconti january2020emergencypillnewuser january2020emergencypillcontinue january2020singlepillnewusers january2020singlepillcontinueuse), mi 
	
	egen fp_sa_util2_20 = rowtotal(february2020combinedpillnewuser february2020combinedpillcontinue february2020condomsnewusers february2020condomscontinueusers february2020deposeinjectablenewu february2020deposeinjectablecont february2020emergencypillnewuser february2020emergencypillcontinu february2020singlepillnewusers february2020singlepillcontinueus), mi 
	
	egen fp_sa_util3_20 = rowtotal(march2020combinedpillnewuser march2020combinedpillcontinueuse march2020condomsnewusers march2020condomscontinueusers march2020deposeinjectablenewuser march2020deposeinjectablecontinu march2020emergencypillnewuser march2020emergencypillcontinueus march2020singlepillnewusers march2020singlepillcontinueusers), mi 
	
	egen fp_sa_util4_20 = rowtotal(april2020combinedpillnewuser april2020combinedpillcontinueuse april2020condomsnewusers april2020condomscontinueusers april2020deposeinjectablenewuser april2020deposeinjectablecontinu april2020emergencypillnewuser april2020emergencypillcontinueus april2020singlepillnewusers april2020singlepillcontinueusers), mi 
	
	egen fp_sa_util5_20 = rowtotal(may2020combinedpillnewuser may2020combinedpillcontinueuser may2020condomsnewusers may2020condomscontinueusers may2020deposeinjectablenewusers may2020deposeinjectablecontinueu may2020emergencypillnewuser may2020emergencypillcontinueuser may2020singlepillnewusers may2020singlepillcontinueusers), mi 
	
	egen fp_sa_util6_20 = rowtotal(june2020combinedpillnewuser june2020combinedpillcontinueuser june2020condomsnewusers june2020condomscontinueusers june2020deposeinjectablenewusers june2020deposeinjectablecontinue june2020emergencypillnewuser june2020emergencypillcontinueuse june2020singlepillnewusers june2020singlepillcontinueusers), mi 
	
	egen fp_sa_util7_20 = rowtotal(july2020combinedpillnewuser july2020combinedpillcontinueuser july2020condomsnewusers july2020condomscontinueusers july2020deposeinjectablenewusers july2020deposeinjectablecontinue july2020emergencypillnewuser july2020emergencypillcontinueuse july2020singlepillnewusers july2020singlepillcontinueusers), mi 
	
	egen fp_sa_util8_20 = rowtotal(august2020combinedpillnewuser august2020combinedpillcontinueus august2020condomsnewusers august2020condomscontinueusers august2020deposeinjectablenewuse august2020deposeinjectablecontin august2020emergencypillnewuser august2020emergencypillcontinueu august2020singlepillnewusers august2020singlepillcontinueuser), mi 
	
	egen fp_sa_util9_20 = rowtotal(september2020combinedpillnewuser september2020combinedpillcontinu september2020condomsnewusers september2020condomscontinueuser september2020deposeinjectablenew september2020deposeinjectablecon september2020emergencypillnewuse september2020emergencypillcontin september2020singlepillnewusers september2020singlepillcontinueu), mi 
	
	egen fp_sa_util10_20 = rowtotal(october2020combinedpillnewuser october2020combinedpillcontinueu october2020condomsnewusers october2020condomscontinueusers october2020deposeinjectablenewus october2020deposeinjectableconti october2020emergencypillnewuser october2020emergencypillcontinue october2020singlepillnewusers october2020singlepillcontinueuse), mi 
	
	 *3) long acting 
	 egen fp_la_util1_20 = rowtotal(january2020iudnewusers january2020iudcontinueusers january2020implantnewusers january2020implantcontinueusers), mi 
	 
	 egen fp_la_util2_20 = rowtotal(february2020iudnewusers february2020iudcontinueusers february2020implantnewusers february2020implantcontinueusers), mi 
	 
	 egen fp_la_util3_20 = rowtotal(march2020iudnewusers march2020iudcontinueusers march2020implantnewusers march2020implantcontinueusers), mi 
	 
	 egen fp_la_util4_20 = rowtotal(april2020iudnewusers april2020iudcontinueusers april2020implantnewusers april2020implantcontinueusers), mi 
	 
	 egen fp_la_util5_20 = rowtotal(may2020iudnewusers may2020iudcontinueusers may2020implantnewusers may2020implantcontinueusers), mi 
	 
	 egen fp_la_util6_20 = rowtotal(june2020iudnewusers june2020iudcontinueusers june2020implantnewusers june2020implantcontinueusers), mi 
	 
	 egen fp_la_util7_20 = rowtotal(july2020iudnewusers july2020iudcontinueusers july2020implantnewusers july2020implantcontinueusers), mi 
	 
	 egen fp_la_util8_20 = rowtotal(august2020iudnewusers august2020iudcontinueusers august2020implantnewusers august2020implantcontinueusers), mi 
	 
	 egen fp_la_util9_20 = rowtotal(september2020iudnewusers september2020iudcontinueusers september2020implantnewusers september2020implantcontinueuser), mi 
	 
	 egen fp_la_util10_20 = rowtotal(october2020iudnewusers october2020iudcontinueusers october2020implantnewusers october2020implantcontinueusers), mi 
	
	keep org* fp* 
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
****************************************************************************************************
*Antenatal care 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_3 Antenatal care.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019anc1stvisitbyhealthfa-december2019anc1stvisitbyhealthf) (anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19	anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19)
	keep org* anc*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*Antenatal care district-DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_3 Antenatal care_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019anc1stvisitbyhealthfa-december2019anc1stvisitbyhealthf) (anc_util1_19	anc_util2_19	anc_util3_19	anc_util4_19	anc_util5_19	anc_util6_19	anc_util7_19	anc_util8_19	anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19)	
	keep org* anc*
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
*Antenatal care 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_3 Antenatal care.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020anc1stvisitbyhealthfa-october2020anc1stvisitbyhealthfa)	(anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20	anc_util7_20	anc_util8_20	anc_util9_20	anc_util10_20)	
	keep org* anc*
	save "$user/$data/Data for analysis/tmp.dta", replace

*Antenatal care DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_3 Antenatal care_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020anc1stvisitbyhealthfa-october2020anc1stvisitbyhealthfa) ///
	(anc_util1_20	anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20	///
	anc_util7_20	anc_util8_20	anc_util9_20	anc_util10_20)	
	append using "$user/$data/Data for analysis/tmp.dta"
	keep org* anc*
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
****************************************************************************************************
*Facility delivery 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_4 Facility deliveries.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019deliveryathf-december2019deliveryathf) (del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19)
	
	keep org* del*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*Facility delivery DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_4 Facility deliveries_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019deliveryathf-december2019deliveryathf) (del_util1_19	del_util2_19	del_util3_19	del_util4_19	del_util5_19	del_util6_19	del_util7_19	del_util8_19	del_util9_19	del_util10_19	del_util11_19	del_util12_19)
	
	keep org* del*
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
*Facility delivery 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_4 Facility deliveries.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020deliveryathf-october2020deliveryathf) (del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20	del_util7_20	del_util8_20	del_util9_20	del_util10_20)
	
	keep org* del*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*Facility delivery DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_4 Facility deliveries_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020deliveryathf-october2020deliveryathf) (del_util1_20	del_util2_20	del_util3_20	del_util4_20	del_util5_20	del_util6_20	del_util7_20	del_util8_20	del_util9_20	del_util10_20)
	
	keep org* del*
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
****************************************************************************************************
*C-sections 2019 	
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_5 Caesarean sections.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019caesareandelivery-december2019caesareandelivery) (cs_util1_19	cs_util2_19	cs_util3_19	cs_util4_19	cs_util5_19	cs_util6_19	cs_util7_19	cs_util8_19	cs_util9_19	cs_util10_19	cs_util11_19	cs_util12_19)
	
	keep org* cs*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*C-sections DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_5 Caesarean sections_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019caesareandelivery-december2019caesareandelivery) (cs_util1_19	cs_util2_19	cs_util3_19	cs_util4_19	cs_util5_19	cs_util6_19	cs_util7_19	cs_util8_19	cs_util9_19	cs_util10_19	cs_util11_19	cs_util12_19)
	
	keep org* cs*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
*C-sections 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_5 Caesarean sections.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020caesareandelivery-october2020caesareandelivery) (cs_util1_20	cs_util2_20	cs_util3_20	cs_util4_20	cs_util5_20	cs_util6_20	cs_util7_20	cs_util8_20	cs_util9_20	cs_util10_20)
	
	keep org* cs*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*C-sections DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_5 Caesarean sections_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020caesareandelivery-october2020caesareandelivery) (cs_util1_20	cs_util2_20	cs_util3_20	cs_util4_20	cs_util5_20	cs_util6_20	cs_util7_20	cs_util8_20	cs_util9_20	cs_util10_20)
	
	keep org* cs*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
****************************************************************************************************
*Postnatal care 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_6 Postnatal care.csv", clear
	rename ïorgunitlevel1 country 
	egen pnc_util1_19 = rowtotal(january2019pncwithin2days january2019pnc342days), mi 
	egen pnc_util2_19 = rowtotal(february2019pncwithin2days february2019pnc342days), mi 
	egen pnc_util3_19 = rowtotal(march2019pncwithin2days march2019pnc342days), mi 
	egen pnc_util4_19 = rowtotal(april2019pncwithin2days april2019pnc342days), mi 
	egen pnc_util5_19 = rowtotal(may2019pncwithin2days may2019pnc342days), mi 
	egen pnc_util6_19 = rowtotal(june2019pncwithin2days june2019pnc342days), mi 
	egen pnc_util7_19 = rowtotal(july2019pncwithin2days july2019pnc342days), mi 
	egen pnc_util8_19 = rowtotal(august2019pncwithin2days august2019pnc342days), mi 
	egen pnc_util9_19 = rowtotal(september2019pncwithin2days september2019pnc342days), mi 
	egen pnc_util10_19 = rowtotal(october2019pncwithin2days october2019pnc342days), mi 
	egen pnc_util11_19 = rowtotal(november2019pncwithin2days november2019pnc342days), mi 
	egen pnc_util12_19 = rowtotal(december2019pncwithin2days december2019pnc342days), mi 
	
	keep org* pnc*
	save "$user/$data/Data for analysis/tmp.dta", replace	
	
*Postnatal care DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_6 Postnatal care_DC.csv", clear
	rename ïorgunitlevel1 country 
	egen pnc_util1_19 = rowtotal(january2019pncwithin2days january2019pnc342days), mi 
	egen pnc_util2_19 = rowtotal(february2019pncwithin2days february2019pnc342days), mi 
	egen pnc_util3_19 = rowtotal(march2019pncwithin2days march2019pnc342days), mi 
	egen pnc_util4_19 = rowtotal(april2019pncwithin2days april2019pnc342days), mi 
	egen pnc_util5_19 = rowtotal(may2019pncwithin2days may2019pnc342days), mi 
	egen pnc_util6_19 = rowtotal(june2019pncwithin2days june2019pnc342days), mi 
	egen pnc_util7_19 = rowtotal(july2019pncwithin2days july2019pnc342days), mi 
	egen pnc_util8_19 = rowtotal(august2019pncwithin2days august2019pnc342days), mi 
	egen pnc_util9_19 = rowtotal(september2019pncwithin2days september2019pnc342days), mi 
	egen pnc_util10_19 = rowtotal(october2019pncwithin2days october2019pnc342days), mi 
	egen pnc_util11_19 = rowtotal(november2019pncwithin2days november2019pnc342days), mi 
	egen pnc_util12_19 = rowtotal(december2019pncwithin2days december2019pnc342days), mi 
	
	keep org* pnc*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
*Postnatal care 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_6 Postnatal care.csv", clear
	rename ïorgunitlevel1 country 
	egen pnc_util1_20 = rowtotal(january2020pncwithin2days january2020pnc342days), mi 
	egen pnc_util2_20 = rowtotal(february2020pncwithin2days february2020pnc342days), mi 
	egen pnc_util3_20 = rowtotal(march2020pncwithin2days march2020pnc342days), mi 
	egen pnc_util4_20 = rowtotal(april2020pncwithin2days april2020pnc342days), mi 
	egen pnc_util5_20 = rowtotal(may2020pncwithin2days may2020pnc342days), mi 
	egen pnc_util6_20 = rowtotal(june2020pncwithin2days june2020pnc342days), mi 
	egen pnc_util7_20 = rowtotal(july2020pncwithin2days july2020pnc342days), mi 
	egen pnc_util8_20 = rowtotal(august2020pncwithin2days august2020pnc342days), mi 
	egen pnc_util9_20 = rowtotal(september2020pncwithin2days september2020pnc342days), mi 
	egen pnc_util10_20 = rowtotal(october2020pncwithin2days october2020pnc342days), mi 
	
	keep org* pnc*
	save "$user/$data/Data for analysis/tmp.dta", replace	
	
*Postnatal care DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_6 Postnatal care_DC.csv", clear
	rename ïorgunitlevel1 country 
	egen pnc_util1_20 = rowtotal(january2020pncwithin2days january2020pnc342days), mi 
	egen pnc_util2_20 = rowtotal(february2020pncwithin2days february2020pnc342days), mi 
	egen pnc_util3_20 = rowtotal(march2020pncwithin2days march2020pnc342days), mi 
	egen pnc_util4_20 = rowtotal(april2020pncwithin2days april2020pnc342days), mi 
	egen pnc_util5_20 = rowtotal(may2020pncwithin2days may2020pnc342days), mi 
	egen pnc_util6_20 = rowtotal(june2020pncwithin2days june2020pnc342days), mi 
	egen pnc_util7_20 = rowtotal(july2020pncwithin2days july2020pnc342days), mi 
	egen pnc_util8_20 = rowtotal(august2020pncwithin2days august2020pnc342days), mi 
	egen pnc_util9_20 = rowtotal(september2020pncwithin2days september2020pnc342days), mi 
	egen pnc_util10_20 = rowtotal(october2020pncwithin2days october2020pnc342days), mi 
	
	keep org* pnc*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************		
****************************************************************************************************		*VACCINE
*BCG 2019
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_26 BCG vaccination.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019monthlybcg-december2019monthlybcg) (bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19)		 
	
	keep org* bcg*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*BCG DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_26 BCG vaccination_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2019monthlybcg-december2019monthlybcg) (bcg_qual1_19	bcg_qual2_19	bcg_qual3_19	bcg_qual4_19	bcg_qual5_19	bcg_qual6_19	bcg_qual7_19	bcg_qual8_19	bcg_qual9_19	bcg_qual10_19	bcg_qual11_19	bcg_qual12_19)		 
	
	keep org* bcg*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
*BCG 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_26 BCG vaccination.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020monthlybcg-october2020monthlybcg) (bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20	bcg_qual7_20	bcg_qual8_20	bcg_qual9_20	bcg_qual10_20)
	
	keep org* bcg*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*BCG DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_26 BCG vaccination_DC.csv", clear
	rename ïorgunitlevel1 country 
	rename (january2020monthlybcg-october2020monthlybcg) (bcg_qual1_20	bcg_qual2_20	bcg_qual3_20	bcg_qual4_20	bcg_qual5_20	bcg_qual6_20	bcg_qual7_20	bcg_qual8_20	bcg_qual9_20	bcg_qual10_20)
	
	keep org* bcg*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
****************************************************************************************************
*Penta3 2019
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_25 Pentavalent vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlypenta3-december2019monthlypenta3) (pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19)
	
	keep org* pent*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*Penta3 DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_25 Pentavalent vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlypenta3-december2019monthlypenta3) (pent_qual1_19	pent_qual2_19	pent_qual3_19	pent_qual4_19	pent_qual5_19	pent_qual6_19	pent_qual7_19	pent_qual8_19	pent_qual9_19	pent_qual10_19	pent_qual11_19	pent_qual12_19)
	
	keep org* pent*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
*Penta3 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_25 Pentavalent vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypenta3-october2020monthlypenta3) (pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20	pent_qual7_20	pent_qual8_20	pent_qual9_20	pent_qual10_20)
	
	keep org* pent*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
*Penta3 DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_25 Pentavalent vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypenta3-october2020monthlypenta3) (pent_qual1_20	pent_qual2_20	pent_qual3_20	pent_qual4_20	pent_qual5_20	pent_qual6_20	pent_qual7_20	pent_qual8_20	pent_qual9_20	pent_qual10_20)
	
	keep org* pent*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
****************************************************************************************************	
*Measles vaccine 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_27 Measles vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlymcv2-december2019monthlymcv2) (measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19)
	
	keep org* measles*
	save "$user/$data/Data for analysis/tmp.dta", replace	
	
*Measles vaccine DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_27 Measles vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlymcv2-december2019monthlymcv2) (measles_qual1_19	measles_qual2_19	measles_qual3_19	measles_qual4_19	measles_qual5_19	measles_qual6_19	measles_qual7_19	measles_qual8_19	measles_qual9_19	measles_qual10_19	measles_qual11_19	measles_qual12_19)
	
	keep org* measles*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
*Measles vaccine 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_27 Measles vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlymcv2-october2020monthlymcv2) (measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20	measles_qual6_20	measles_qual7_20	measles_qual8_20	measles_qual9_20	measles_qual10_20)
	 
	keep org* measles*
	save "$user/$data/Data for analysis/tmp.dta", replace		
	
*Measles vaccine DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_27 Measles vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlymcv2-october2020monthlymcv2) (measles_qual1_20	measles_qual2_20	measles_qual3_20	measles_qual4_20	measles_qual5_20	measles_qual6_20	measles_qual7_20	measles_qual8_20	measles_qual9_20	measles_qual10_20)
	 
	keep org* measles*
	append using "$user/$data/Data for analysis/tmp.dta" 	
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
****************************************************************************************************	
* OPV3 vaccine 2019
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_28 Polio vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlychildrengotipv-december2019monthlychildrengotip) (opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19)

	keep org* opv3*
	save "$user/$data/Data for analysis/tmp.dta", replace		
	
*OPV3 vaccine DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_28 Polio vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlychildrengotipv-december2019monthlychildrengotip) (opv3_qual1_19	opv3_qual2_19	opv3_qual3_19	opv3_qual4_19	opv3_qual5_19	opv3_qual6_19	opv3_qual7_19	opv3_qual8_19	opv3_qual9_19	opv3_qual10_19	opv3_qual11_19	opv3_qual12_19)

	keep org* opv3*
	append using "$user/$data/Data for analysis/tmp.dta" 	
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
* OPV3 vaccine 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_28 Polio vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlychildrengotipv-october2020monthlychildrengotipv) (opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20	opv3_qual7_20	opv3_qual8_20	opv3_qual9_20	opv3_qual10_20)

	keep org* opv3*
	save "$user/$data/Data for analysis/tmp.dta", replace

*OPV3 vaccine DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_28 Polio vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlychildrengotipv-october2020monthlychildrengotipv) (opv3_qual1_20	opv3_qual2_20	opv3_qual3_20	opv3_qual4_20	opv3_qual5_20	opv3_qual6_20	opv3_qual7_20	opv3_qual8_20	opv3_qual9_20	opv3_qual10_20)

	keep org* opv3*
	append using "$user/$data/Data for analysis/tmp.dta" 		
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
****************************************************************************************************	
* PCV3 vaccine 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_29 Pneumococcal vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlypcv3-december2019monthlypcv3) (pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19)

	keep org* pneum*
	save "$user/$data/Data for analysis/tmp.dta", replace	
	
*PCV3 vaccine DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_29 Pneumococcal vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019monthlypcv3-december2019monthlypcv3) (pneum_qual1_19	pneum_qual2_19	pneum_qual3_19	pneum_qual4_19	pneum_qual5_19	pneum_qual6_19	pneum_qual7_19	pneum_qual8_19	pneum_qual9_19	pneum_qual10_19	pneum_qual11_19	pneum_qual12_19)

	keep org* pneum*
	append using "$user/$data/Data for analysis/tmp.dta" 			
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
* PCV3 vaccine 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_29 Pneumococcal vaccination.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypcv3-october2020monthlypcv3) (pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20)

	keep org* pneum*
	save "$user/$data/Data for analysis/tmp.dta", replace	

* PCV3 vaccine DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_29 Pneumococcal vaccination_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020monthlypcv3-october2020monthlypcv3) (pneum_qual1_20	pneum_qual2_20	pneum_qual3_20	pneum_qual4_20	pneum_qual5_20	pneum_qual6_20	pneum_qual7_20	pneum_qual8_20	pneum_qual9_20	pneum_qual10_20)

	keep org* pneum*
	append using "$user/$data/Data for analysis/tmp.dta" 		
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
****************************************************************************************************
*VOLUME OF OTHER SERVICES 
* OPD diabetes 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_15 Care for diabetes.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opddiabetes-december2019opddiabetes) (diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19)

	keep org* diab*
	save "$user/$data/Data for analysis/tmp.dta", replace	

* OPD diabetes DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_15 Care for diabetes_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opddiabetes-december2019opddiabetes) (diab_util1_19	diab_util2_19	diab_util3_19	diab_util4_19	diab_util5_19	diab_util6_19	diab_util7_19	diab_util8_19	diab_util9_19	diab_util10_19	diab_util11_19	diab_util12_19)

	keep org* diab*
	append using "$user/$data/Data for analysis/tmp.dta" 		
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
* OPD diabetes 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_15 Care for diabetes.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opddiabetes-october2020opddiabetes) (diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20	diab_util9_20	diab_util10_20)

	keep org* diab*
	save "$user/$data/Data for analysis/tmp.dta", replace		

* OPD diabetes DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_15 Care for diabetes_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opddiabetes-october2020opddiabetes) (diab_util1_20	diab_util2_20	diab_util3_20	diab_util4_20	diab_util5_20	diab_util6_20	diab_util7_20	diab_util8_20	diab_util9_20	diab_util10_20)

	keep org* diab*
	append using "$user/$data/Data for analysis/tmp.dta" 		
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
****************************************************************************************************
* Hypertension visits 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_16 Care for hypertension.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opdhypertension-december2019opdhypertension) (hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19)
	
	keep org* hyper*
	save "$user/$data/Data for analysis/tmp.dta", replace	
	
* Hypertension visits DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_16 Care for hypertension_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opdhypertension-december2019opdhypertension) (hyper_util1_19	hyper_util2_19	hyper_util3_19	hyper_util4_19	hyper_util5_19	hyper_util6_19	hyper_util7_19	hyper_util8_19	hyper_util9_19	hyper_util10_19	hyper_util11_19	hyper_util12_19)
	
	keep org* hyper*
	append using "$user/$data/Data for analysis/tmp.dta" 			
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************		
* Hypertension visits 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_16 Care for hypertension.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdhypertension-october2020opdhypertension) (hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20	hyper_util7_20	hyper_util8_20	hyper_util9_20	hyper_util10_20)
	
	keep org* hyper*
	save "$user/$data/Data for analysis/tmp.dta", replace		

* Hypertension visits DC 2020 - new file is needed (discuss with Catherine)
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_16 Care for hypertension_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdhypertension-october2020opdhypertension) (hyper_util1_20	hyper_util2_20	hyper_util3_20	hyper_util4_20	hyper_util5_20	hyper_util6_20	hyper_util7_20	hyper_util8_20	hyper_util9_20	hyper_util10_20)
	
	keep org* hyper*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace

****************************************************************************************************
* Outpatient visits 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_11 Outpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opdoutpatientvisits-december2019opdoutpatientvisits) (opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19	opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19)
	
	keep org* opd*
	save "$user/$data/Data for analysis/tmp.dta", replace		
	
* Outpatient visits DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_11 Outpatient visits_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019opdoutpatientvisits-december2019opdoutpatientvisits) (opd_util1_19	opd_util2_19	opd_util3_19	opd_util4_19	opd_util5_19	opd_util6_19	opd_util7_19	opd_util8_19	opd_util9_19	opd_util10_19	opd_util11_19	opd_util12_19)
	
	keep org* opd*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
* Outpatient visits 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_11 Outpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdoutpatientvisits-october2020opdoutpatientvisits) (opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20	opd_util9_20	opd_util10_20) 
	
	keep org* opd*
	save "$user/$data/Data for analysis/tmp.dta", replace		
	
* Outpatient visits DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_11 Outpatient visits_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020opdoutpatientvisits-october2020opdoutpatientvisits) (opd_util1_20	opd_util2_20	opd_util3_20	opd_util4_20	opd_util5_20	opd_util6_20	opd_util7_20	opd_util8_20	opd_util9_20	opd_util10_20) 
	
	keep org* opd*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
****************************************************************************************************	
* Inpatient admissions 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_12 Inpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019ipdinpatientvisits-december2019ipdinpatientvisits) (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19)
	
	keep org* ipd*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Inpatient admissions DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_12 Inpatient visits_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019ipdinpatientvisits-december2019ipdinpatientvisits) (ipd_util1_19	ipd_util2_19	ipd_util3_19	ipd_util4_19	ipd_util5_19	ipd_util6_19	ipd_util7_19	ipd_util8_19	ipd_util9_19	ipd_util10_19	ipd_util11_19	ipd_util12_19)
	
	keep org* ipd*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
* Inpatient admissions 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_12 Inpatient visits.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020ipdinpatientvisits-october2020ipdinpatientvisits) (ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	ipd_util10_20)
	
	keep org* ipd*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Inpatient admissions DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_12 Inpatient visits_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020ipdinpatientvisits-october2020ipdinpatientvisits) (ipd_util1_20	ipd_util2_20	ipd_util3_20	ipd_util4_20	ipd_util5_20	ipd_util6_20	ipd_util7_20	ipd_util8_20	ipd_util9_20	ipd_util10_20)
	
	keep org* ipd*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
****************************************************************************************************	
* Road traffic injuries 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_14 Road trffic injury.csv", clear
	rename ïorgunitlevel1 country
	egen road_util1_19 = rowtotal(january2019opdroadtrafficinjury january2019ipdroadtrafficinjury), mi 
	egen road_util2_19 = rowtotal(february2019opdroadtrafficinjury february2019ipdroadtrafficinjury), mi 
	egen road_util3_19 = rowtotal(march2019opdroadtrafficinjury march2019ipdroadtrafficinjury), mi 
	egen road_util4_19 = rowtotal(april2019opdroadtrafficinjury april2019ipdroadtrafficinjury), mi 
	egen road_util5_19 = rowtotal(may2019opdroadtrafficinjury may2019ipdroadtrafficinjury), mi 
	egen road_util6_19 = rowtotal(june2019opdroadtrafficinjury june2019ipdroadtrafficinjury), mi 
	egen road_util7_19 = rowtotal(july2019opdroadtrafficinjury july2019ipdroadtrafficinjury), mi 
	egen road_util8_19 = rowtotal(august2019opdroadtrafficinjury august2019ipdroadtrafficinjury), mi 
	egen road_util9_19 = rowtotal(september2019opdroadtrafficinjur september2019ipdroadtrafficinjur), mi 
	egen road_util10_19 = rowtotal(october2019opdroadtrafficinjury october2019ipdroadtrafficinjury), mi 
	egen road_util11_19 = rowtotal(november2019opdroadtrafficinjury november2019ipdroadtrafficinjury), mi 
	egen road_util12_19 = rowtotal(december2019opdroadtrafficinjury december2019ipdroadtrafficinjury), mi 
	
	keep org* road*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Road traffic injuries DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_14 Road trffic injury_DC.csv", clear
	rename ïorgunitlevel1 country
	egen road_util1_19 = rowtotal(january2019opdroadtrafficinjury january2019ipdroadtrafficinjury), mi 
	egen road_util2_19 = rowtotal(february2019opdroadtrafficinjury february2019ipdroadtrafficinjury), mi 
	egen road_util3_19 = rowtotal(march2019opdroadtrafficinjury march2019ipdroadtrafficinjury), mi 
	egen road_util4_19 = rowtotal(april2019opdroadtrafficinjury april2019ipdroadtrafficinjury), mi 
	egen road_util5_19 = rowtotal(may2019opdroadtrafficinjury may2019ipdroadtrafficinjury), mi 
	egen road_util6_19 = rowtotal(june2019opdroadtrafficinjury june2019ipdroadtrafficinjury), mi 
	egen road_util7_19 = rowtotal(july2019opdroadtrafficinjury july2019ipdroadtrafficinjury), mi 
	egen road_util8_19 = rowtotal(august2019opdroadtrafficinjury august2019ipdroadtrafficinjury), mi 
	egen road_util9_19 = rowtotal(september2019opdroadtrafficinjur september2019ipdroadtrafficinjur), mi 
	egen road_util10_19 = rowtotal(october2019opdroadtrafficinjury october2019ipdroadtrafficinjury), mi 
	egen road_util11_19 = rowtotal(november2019opdroadtrafficinjury november2019ipdroadtrafficinjury), mi 
	egen road_util12_19 = rowtotal(december2019opdroadtrafficinjury december2019ipdroadtrafficinjury), mi 
	
	keep org* road*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
* Road traffic injuries 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_14 Road traffic injury.csv", clear
	rename ïorgunitlevel1 country
	egen road_util1_20 = rowtotal(january2020opdroadtrafficinjury january2020ipdroadtrafficinjury), mi 
	egen road_util2_20 = rowtotal(february2020opdroadtrafficinjury february2020ipdroadtrafficinjury), mi 
	egen road_util3_20 = rowtotal(march2020opdroadtrafficinjury march2020ipdroadtrafficinjury), mi 
	egen road_util4_20 = rowtotal(april2020opdroadtrafficinjury april2020ipdroadtrafficinjury), mi 
	egen road_util5_20 = rowtotal(may2020opdroadtrafficinjury may2020ipdroadtrafficinjury), mi 
	egen road_util6_20 = rowtotal(june2020opdroadtrafficinjury june2020ipdroadtrafficinjury), mi 
	egen road_util7_20 = rowtotal(july2020opdroadtrafficinjury july2020ipdroadtrafficinjury), mi 
	egen road_util8_20 = rowtotal(august2020opdroadtrafficinjury august2020ipdroadtrafficinjury), mi 
	egen road_util9_20 = rowtotal(september2020opdroadtrafficinjur september2020ipdroadtrafficinjur), mi 
	egen road_util10_20 = rowtotal(october2020opdroadtrafficinjury october2020ipdroadtrafficinjury), mi 
	
	keep org* road*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Road traffic injuries DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_14 Road traffic injury_DC.csv", clear
	rename ïorgunitlevel1 country
	egen road_util1_20 = rowtotal(january2020opdroadtrafficinjury january2020ipdroadtrafficinjury), mi 
	egen road_util2_20 = rowtotal(february2020opdroadtrafficinjury february2020ipdroadtrafficinjury), mi 
	egen road_util3_20 = rowtotal(march2020opdroadtrafficinjury march2020ipdroadtrafficinjury), mi 
	egen road_util4_20 = rowtotal(april2020opdroadtrafficinjury april2020ipdroadtrafficinjury), mi 
	egen road_util5_20 = rowtotal(may2020opdroadtrafficinjury may2020ipdroadtrafficinjury), mi 
	egen road_util6_20 = rowtotal(june2020opdroadtrafficinjury june2020ipdroadtrafficinjury), mi 
	egen road_util7_20 = rowtotal(july2020opdroadtrafficinjury july2020ipdroadtrafficinjury), mi 
	egen road_util8_20 = rowtotal(august2020opdroadtrafficinjury august2020ipdroadtrafficinjury), mi 
	egen road_util9_20 = rowtotal(september2020opdroadtrafficinjur september2020ipdroadtrafficinjur), mi 
	egen road_util10_20 = rowtotal(october2020opdroadtrafficinjury october2020ipdroadtrafficinjury), mi 
	
	keep org* road*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
****************************************************************************************************		* MORTALITY 
* Neonatal deaths 2019 						
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_31 Neonatal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019deathneonatal07days-december2019deathneonatal07days) (neo_mort_num1_19	neo_mort_num2_19	neo_mort_num3_19	neo_mort_num4_19	neo_mort_num5_19	neo_mort_num6_19	neo_mort_num7_19	neo_mort_num8_19	neo_mort_num9_19	neo_mort_num10_19	neo_mort_num11_19	neo_mort_num12_19)
									
	keep org* neo*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Neonatal deaths DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_31 Neonatal mortality_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019deathneonatal07days-december2019deathneonatal07days) (neo_mort_num1_19	neo_mort_num2_19	neo_mort_num3_19	neo_mort_num4_19	neo_mort_num5_19	neo_mort_num6_19	neo_mort_num7_19	neo_mort_num8_19	neo_mort_num9_19	neo_mort_num10_19	neo_mort_num11_19	neo_mort_num12_19)
									
	keep org* neo*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
* Neonatal deaths 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_31 Neonatal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020deathneonatal07days-october2020deathneonatal07days) (neo_mort_num1_20	neo_mort_num2_20	neo_mort_num3_20	neo_mort_num4_20	neo_mort_num5_20	neo_mort_num6_20	neo_mort_num7_20	neo_mort_num8_20	neo_mort_num9_20	neo_mort_num10_20)
	
	keep org* neo*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Neonatal deaths DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_31 Neonatal mortality_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020deathneonatal07days-october2020deathneonatal07days) (neo_mort_num1_20	neo_mort_num2_20	neo_mort_num3_20	neo_mort_num4_20	neo_mort_num5_20	neo_mort_num6_20	neo_mort_num7_20	neo_mort_num8_20	neo_mort_num9_20	neo_mort_num10_20)
	
	keep org* neo*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************
****************************************************************************************************	
* Stillbirths 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_32 Stillbirth rate.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019stillbirth28weeks-december2019stillbirth28weeks) (sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19)
	
	keep org* sb*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Stillbirths DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_32 Stillbirth rate_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019stillbirth28weeks-december2019stillbirth28weeks) (sb_mort_num1_19	sb_mort_num2_19	sb_mort_num3_19	sb_mort_num4_19	sb_mort_num5_19	sb_mort_num6_19	sb_mort_num7_19	sb_mort_num8_19	sb_mort_num9_19	sb_mort_num10_19	sb_mort_num11_19	sb_mort_num12_19)
	
	keep org* sb*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************	
* Stillbirths 2020
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_32 Stillbirth rate.csv", clear	
	rename ïorgunitlevel1 country
	rename (january2020stillbirth28weeks-october2020stillbirth28weeks) (sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	sb_mort_num5_20	sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20	sb_mort_num9_20	sb_mort_num10_20)
	
	keep org* sb*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Stillbirths DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_32 Stillbirth rate_DC.csv", clear	
	rename ïorgunitlevel1 country
	rename (january2020stillbirth28weeks-october2020stillbirth28weeks) (sb_mort_num1_20	sb_mort_num2_20	sb_mort_num3_20	sb_mort_num4_20	sb_mort_num5_20	sb_mort_num6_20	sb_mort_num7_20	sb_mort_num8_20	sb_mort_num9_20	sb_mort_num10_20)
	
	keep org* sb*
	append using "$user/$data/Data for analysis/tmp.dta" 
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"
	
****************************************************************************************************
****************************************************************************************************
* Maternal deaths 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_33 Maternal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019maternaldeaths-december2019maternaldeaths) (mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19)
	
	keep org* mat*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Maternal deaths DC 2019 
	import delimited "$user/$data/Raw data/2019/facility/Lao_2019_Jan to Dec_facility_33 Maternal mortality_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2019maternaldeaths-december2019maternaldeaths) (mat_mort_num1_19	mat_mort_num2_19	mat_mort_num3_19	mat_mort_num4_19	mat_mort_num5_19	mat_mort_num6_19	mat_mort_num7_19	mat_mort_num8_19	mat_mort_num9_19	mat_mort_num10_19	mat_mort_num11_19	mat_mort_num12_19)
	
	keep org* mat*
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

****************************************************************************************************	
* Maternal deaths 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_33 Maternal mortality.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020maternaldeaths-october2020maternaldeaths) (mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20	mat_mort_num6_20	mat_mort_num7_20	mat_mort_num8_20	mat_mort_num9_20	mat_mort_num10_20)
	
	keep org* mat*
	save "$user/$data/Data for analysis/tmp.dta", replace
	
* Maternal deaths DC 2020 
	import delimited "$user/$data/Raw data/2020/facility/Lao_2020_Jan to Dec_facility_33 Maternal mortality_DC.csv", clear
	rename ïorgunitlevel1 country
	rename (january2020maternaldeaths-october2020maternaldeaths) (mat_mort_num1_20	mat_mort_num2_20	mat_mort_num3_20	mat_mort_num4_20	mat_mort_num5_20	mat_mort_num6_20	mat_mort_num7_20	mat_mort_num8_20	mat_mort_num9_20	mat_mort_num10_20)
	
	keep org* mat*
	append using "$user/$data/Data for analysis/tmp.dta"
	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	rm "$user/$data/Data for analysis/tmp.dta"

	
****************************************************************************************************
****************************************************************************************************
* Total delivery 2019 
	egen totaldel1_19 = rowtotal(del_util1_19 cs_util1_19), m
	egen totaldel2_19 =	rowtotal(del_util2_19 cs_util2_19), m
	egen totaldel3_19 =	rowtotal(del_util3_19 cs_util3_19), m
	egen totaldel4_19 =	rowtotal(del_util4_19 cs_util4_19), m
	egen totaldel5_19=	rowtotal(del_util5_19 cs_util5_19), m
	egen totaldel6_19=	rowtotal(del_util6_19 cs_util6_19), m
	egen totaldel7_19=	rowtotal(del_util7_19 cs_util7_19), m
	egen totaldel8_19=	rowtotal(del_util8_19 cs_util8_19), m
	egen totaldel9_19=	rowtotal(del_util9_19 cs_util9_19), m
	egen totaldel10_19=	rowtotal(del_util10_19 cs_util10_19), m
	egen totaldel11_19=	rowtotal(del_util11_19 cs_util11_19), m
	egen totaldel12_19=	rowtotal(del_util11_19 cs_util11_19), m	
		
*Total delivery 2020
	egen totaldel1_20 = rowtotal(del_util1_20 cs_util1_20), m
	egen totaldel2_20 =	rowtotal(del_util2_20 cs_util2_20), m
	egen totaldel3_20 =	rowtotal(del_util3_20 cs_util3_20), m
	egen totaldel4_20 =	rowtotal(del_util4_20 cs_util4_20), m
	egen totaldel5_20=	rowtotal(del_util5_20 cs_util5_20), m
	egen totaldel6_20=	rowtotal(del_util6_20 cs_util6_20), m
	egen totaldel7_20=	rowtotal(del_util7_20 cs_util7_20), m
	egen totaldel8_20=	rowtotal(del_util8_20 cs_util8_20), m
	egen totaldel9_20=	rowtotal(del_util9_20 cs_util9_20), m
	egen totaldel10_20=	rowtotal(del_util10_20 cs_util10_20), m

	merge 1:1  org* using "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", replace
	

*******************************************************************************
*To merge with new Jan20-Dec20 dataset 
*Drop Jan20-Oct20 data 

u "$user/$data/Data for analysis/Lao_Jan19-Oct20_WIDE.dta", clear

global volumes fp_perm_util fp_sa_util fp_la_util anc_util del_util cs_util ///
			   pnc_util bcg_qual totaldel pent_qual measles_qual opv3_qual pneum_qual ///
			   diab_util hyper_util opd_util ipd_util road_util 
global mortality neo_mort_num sb_mort_num mat_mort_num 
global all $volumes $mortality 

foreach var of global all {
	drop `var'1_20 - `var'10_20
}

* Drop empty facilities
egen total = rowtotal(mat_mort_num1_19-totaldel12_19), m 
drop if total==.
drop total

save "$user/$data/Data for analysis/Lao_Jan19-Dec19_WIDE.dta", replace

********************************************************************************************
*END
********************************************************************************************


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
							
