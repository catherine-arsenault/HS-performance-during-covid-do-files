* HS performance during Covid
* Oct 21, 2020 
* Haiti, January 2019 - June 2020
* Data recoding, Catherine Arsenault
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Haiti)"

import delimited using "$user/$data/Raw data/Haiti_consolidated_data_elements_2018_2020_9_4_2020.csv", clear

rename (accouchementsinstitutionnelsjanv-v41) ///
(totaldel1_18	totaldel2_18	totaldel3_18	totaldel4_18	totaldel5_18	///
totaldel6_18	totaldel7_18	totaldel8_18	totaldel9_18	totaldel10_18	///
totaldel11_18	totaldel12_18	totaldel1_19	totaldel2_19	totaldel3_19	///
totaldel4_19	totaldel5_19	totaldel6_19	totaldel7_19	totaldel8_19	///
totaldel9_19	totaldel10_19	totaldel11_19	totaldel12_19 	totaldel1_20	///
totaldel2_20	totaldel3_20	totaldel4_20	totaldel5_20	totaldel6_20	///
totaldel7_20					)

rename (consultationspostnatalesjanvier2-v72) ///
( pncm_util1_18	pncm_util2_18	pncm_util3_18	pncm_util4_18	pncm_util5_18	///
pncm_util6_18	pncm_util7_18	pncm_util8_18	pncm_util9_18	pncm_util10_18	///
pncm_util11_18	pncm_util12_18 pncm_util1_19	pncm_util2_19	pncm_util3_19	///
pncm_util4_19	pncm_util5_19	pncm_util6_19	pncm_util7_19	pncm_util8_19	///
pncm_util9_19	pncm_util10_19	pncm_util11_19	pncm_util12_19 pncm_util1_20	///
pncm_util2_20	pncm_util3_20	pncm_util4_20	pncm_util5_20	pncm_util6_20	///
pncm_util7_20					)
