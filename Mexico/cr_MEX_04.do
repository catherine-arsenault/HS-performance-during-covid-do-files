* HS performance during Covid
* Nov 9, 2020 
* Mexico - IMSS, Update with August 2020 data

clear all
set more off	
global user "/Users/acatherine/Dropbox (Harvard University)"
*global user "/Users/minkyungkim/Dropbox (Harvard University)"
global data "/HMIS Data for Health System Performance Covid (Mexico)"

import spss using "$user/$data/Raw/7.Indicadores_IMSS_Agosto_2020_9Nov20.sav", clear

rename Delegación Delegation
replace Delegation = "México Oriente" if Delegation== "México  Oriente"
replace Delegation = "México Poniente" if Delegation== "México  Poniente"
* 35 delegations, data in wide form
