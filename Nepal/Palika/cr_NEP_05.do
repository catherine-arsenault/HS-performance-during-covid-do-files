* HS performance during Covid
* Dec 3, 2021 
* Nepal, Jan-Jul 2021
* Palika level data analysis 

clear all
set more off
********************************************************************************
* Recode raw data
********************************************************************************
* Short acting fp method (fp_sa)
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_fp.csv", clear
drop organisationunitdescription
egen fp_sa_util1_21 = rowtotal( magh2077familyplanningprogramtem v10 v11 v12 ///
						v13 v14 v15 v16 magh2077safemotherhoodprogramsaf v18), m
egen fp_sa_util2_21 = rowtotal(falgun2077familyplanningprogramt v20 v21 v22 v23 ///
						v24 v25 v26 falgun2077safemotherhoodprograms v28), m
egen fp_sa_util3_21 = rowtotal(chaitra2077familyplanningprogram v30 v31 v32 ///
						v33 v34 v35 v36 chaitra2077safemotherhoodprogram v38), m
egen fp_sa_util4_21 = rowtotal(baishak2078familyplanningprogram v40 v41 v42 ///
						v43 v44 v45 v46 baishak2078safemotherhoodprogram v48), m
egen fp_sa_util5_21 = rowtotal(jestha2078familyplanningprogramt v50 v51 v52 v53 ///
						v54 v55 v56 jestha2078safemotherhoodprograms v58), m
egen fp_sa_util6_21 = rowtotal(asar2078familyplanningprogramtem v60 v61 v62 v63 ///
						v64 v65 v66 asar2078safemotherhoodprogramsaf v68), m 
drop shrawan2078toasar2079familyplann-v78

	keep org* fp* 

*3 municipalities changed name
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"

save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
********************************************************************************
* ANC
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_anc_del_cs_pnc.csv", clear
drop organisationunitdescription shrawan2078toasar2079safemotherh-v57
egen anc_util1_21= rowtotal(magh2077safemotherhoodprogramant v10 ), m
egen anc_util2_21= rowtotal(falgun2077safemotherhoodprograma v17 ), m
egen anc_util3_21= rowtotal( chaitra2077safemotherhoodprogram v24), m
egen anc_util4_21= rowtotal(baishak2078safemotherhoodprogram v31 ), m
egen anc_util5_21= rowtotal(jestha2078safemotherhoodprograma v38 ), m
egen anc_util6_21= rowtotal(asar2078safemotherhoodprogramant v45 ), m

* Deliveries
rename (magh2077safemotherhoodprogramdel falgun2077safemotherhoodprogramd v25 ///
	v32 jestha2078safemotherhoodprogramd asar2078safemotherhoodprogramdel) ///
	(del_util1_21 del_util2_21 del_util3_21 del_util4_21 del_util5_21 del_util6_21 )
*C/S
egen cs_util1_21=rowtotal(magh2077safemotherhoodprogramtyp v13 v14 ), m 
egen cs_util2_21=rowtotal(falgun2077safemotherhoodprogramt v20 v21 ), m
egen cs_util3_21=rowtotal(v26 v27 v28 ), m
egen cs_util4_21=rowtotal(v33 v34 v35 ), m
egen cs_util5_21=rowtotal(jestha2078safemotherhoodprogramt v41 v42 ), m
egen cs_util6_21=rowtotal(asar2078safemotherhoodprogramtyp v48 v49 ), m
*PNC
rename (magh2077safemotherhoodprogram3pn falgun2077safemotherhoodprogram3 v29 v36 jestha2078safemotherhoodprogram3 asar2078safemotherhoodprogram3pn ) (pnc_util1_21 ///
pnc_util2_21 pnc_util3_21 pnc_util4_21 pnc_util5_21 pnc_util6_21)

keep org* anc* del* cs* pnc* 
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
drop _merge
save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace

********************************************************************************
* Child diarrhea
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_child.csv", clear
drop organisationunitdescription shrawan2078toasar2079cbimci259mo-v57
egen diarr_util1_21=rowtotal(magh2077cbimci259monthsclassific v10 v11 v12 v13 ), m
egen diarr_util2_21=rowtotal(falgun2077cbimci259monthsclassif v17 v18 v19 v20 ), m
egen diarr_util3_21=rowtotal(chaitra2077cbimci259monthsclassi v24 v25 v26 v27 ), m
egen diarr_util4_21=rowtotal(baishak2078cbimci259monthsclassi v31 v32 v33 v34 ), m
egen diarr_util5_21=rowtotal(jestha2078cbimci259monthsclassif v38 v39 v40 v41 ), m
egen diarr_util6_21=rowtotal(asar2078cbimci259monthsclassific v45 v46 v47 v48 ), m
* Child pneumonia
egen pneum_util1_21 = rowtotal(v14 magh2077cbimci259monthsorcclassi ), m
egen pneum_util2_21 = rowtotal(v21 falgun2077cbimci259monthsorcclas ), m
egen pneum_util3_21 = rowtotal(v28 chaitra2077cbimci259monthsorccla ), m
egen pneum_util4_21 = rowtotal(v35 baishak2078cbimci259monthsorccla ), m
egen pneum_util5_21 = rowtotal(v42 jestha2078cbimci259monthsorcclas ), m
egen pneum_util6_21 = rowtotal(v49 asar2078cbimci259monthsorcclassi ), m

	keep org*  diarr* pneum* 
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
	
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
********************************************************************************
* BCG 
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_vax.csv", clear
drop organisationunitdescription shrawan2078toasar2079immunizatio-v43

rename (magh2077immunizationprogramvacci falgun2077immunizationprogramvac ///
chaitra2077immunizationprogramva baishak2078immunizationprogramva ///
jestha2078immunizationprogramvac asar2078immunizationprogramvacci ) (bcg_qual1_21 ///
 bcg_qual2_21 bcg_qual3_21 bcg_qual4_21 bcg_qual5_21 bcg_qual6_21)
* Penta 3rd dose
rename (v10 v15 v20 v25 v30 v35) (pent_qual1_21 pent_qual2_21 pent_qual3_21 ///
pent_qual4_21 pent_qual5_21 pent_qual6_21)
* MMR 
egen measles_qual1_21=rowtotal(magh2077immunizationprogramchild v12), m 
egen measles_qual2_21=rowtotal(falgun2077immunizationprogramchi v17 ), m 
egen measles_qual3_21=rowtotal(chaitra2077immunizationprogramch v22  ), m 
egen measles_qual4_21=rowtotal(baishak2078immunizationprogramch v27  ), m 
egen measles_qual5_21=rowtotal(jestha2078immunizationprogramchi v32), m 
egen measles_qual6_21=rowtotal( asar2078immunizationprogramchild v37  ), m 
* Pneumococcal 
rename (v13 v18 v23 v28 v33 v38) (pneum_qual1_21 pneum_qual2_21  pneum_qual3_21 ///
pneum_qual4_21  pneum_qual5_21  pneum_qual6_21)

	keep org* bcg* pent* measles*  pneum*
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
********************************************************************************
* ER 
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_er_ipd_diab_hyper.csv", clear
drop organisationunitdescription  shrawan2078toasar2079clientsrece-shrawan2078toasar2079opdmorbidit
egen er_util1_21=rowtotal(magh2077clientsreceivedemergency v10 v11 v12), m
egen er_util2_21=rowtotal(falgun2077clientsreceivedemergen v17 v18 v19 ), m
egen er_util3_21=rowtotal(chaitra2077clientsreceivedemerge v24 v25 v26 ), m
egen er_util4_21=rowtotal(baishak2078clientsreceivedemerge v31 v32 v33 ), m
egen er_util5_21=rowtotal(jestha2078clientsreceivedemergen v38 v39 v40 ), m
egen er_util6_21=rowtotal(asar2078clientsreceivedemergency v45 v46 v47 ), m
* Inpatients
rename(magh2077inpatientmorbiditycases falgun2077inpatientmorbiditycase ///
chaitra2077inpatientmorbiditycas baishak2078inpatientmorbiditycas ///
jestha2078inpatientmorbiditycase asar2078inpatientmorbiditycases) (ipd_util1_21 ///
ipd_util2_21 ipd_util3_21 ipd_util4_21 ipd_util5_21 ipd_util6_21)
* Diabetes
rename (magh2077outpatientmorbiditynutri falgun2077outpatientmorbiditynut ///
chaitra2077outpatientmorbiditynu baishak2078outpatientmorbiditynu ///
jestha2078outpatientmorbiditynut asar2078outpatientmorbiditynutri) (diab_util1_21 ///
diab_util2_21 diab_util3_21 diab_util4_21  diab_util5_21  diab_util6_21 )
* Hypertension
rename (magh2077opdmorbiditycardiovascul falgun2077opdmorbiditycardiovasc ///
chaitra2077opdmorbiditycardiovas baishak2078opdmorbiditycardiovas ///
jestha2078opdmorbiditycardiovasc asar2078opdmorbiditycardiovascul) (hyper_util1_21 ///
hyper_util2_21 hyper_util3_21 hyper_util4_21 hyper_util5_21 hyper_util6_21)
	
	keep org* er_util* ipd_util* diab* hyper* 

	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
********************************************************************************
* Outpatients	
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_opd.csv", clear
drop organisationunitdescription  shrawan2078toasar2079disaggregat
rename (magh2077disaggregationbysexcaste falgun2077disaggregationbysexcas chaitra2077disaggregationbysexca baishak2078disaggregationbysexca jestha2078disaggregationbysexcas asar2078disaggregationbysexcaste) (opd_util1_21 opd_util2_21 opd_util3_21 opd_util4_21 ///
opd_util5_21 opd_util6_21 )
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
	drop _merge
	save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
********************************************************************************
* TB
import delimited "$user/$data/Raw data/Palika/2021/Nepal_2021_tb_hiv.csv", clear
drop organisationunitdescription  shrawan2078toasar2079disaggregat shrawan2078toasar2079virologyhiv
rename (magh2077disaggregationbysexcaste falgun2077disaggregationbysexcas ///
chaitra2077disaggregationbysexca baishak2078disaggregationbysexca ///
jestha2078disaggregationbysexcas asar2078disaggregationbysexcaste) ///
(tbdetect_qual1_21 tbdetect_qual2_21 tbdetect_qual3_21 tbdetect_qual4_21 ///
tbdetect_qual5_21 tbdetect_qual6_21 )

rename ( magh2077virologyhivtestconducted falgun2077virologyhivtestconduct ///
chaitra2077virologyhivtestconduc baishak2078virologyhivtestconduc ///
jestha2078virologyhivtestconduct asar2078virologyhivtestconducted) (hivtest_qual1_21 ///
hivtest_qual2_21 hivtest_qual3_21 hivtest_qual4_21 hivtest_qual5_21 hivtest_qual6_21 )
 
	keep org* tbdet* hivtest* 
	duplicates tag org* , gen(tag)
	
	replace organisationunitname = "60904 Dhorchaur Rural Municipality" if organisationunitname =="60904 Siddha Kumakh Rural Municipality"
	replace organisationunitname = "10507 Diprung Rural Municipality" if organisationunitname =="10507 Diprung Chuichumma Rural Municipality"
	replace organisationunitname = "20611 Boudhimai Municipality" if organisationunitname =="20611 Baudhimai Municipality"
	
	merge 1:1 org* using "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta"
	drop _merge tag 
	
* Fixing province codes
	order org*
	drop  organisationunitid organisationunitcode 		 
	replace orgunitlevel3= orgunitlevel2 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel2 = orgunitlevel1 if orgunitlevel1=="1 Province 1"
	replace orgunitlevel1 = "Nepal" if orgunitlevel1=="1 Province 1"				
	replace orgunitlevel2 = "5 Province 5" if orgunitlevel2 == "5 Lumbini Province"
	* 1 palika changed name in 2021
	replace orgunitlevel4 ="70905 Mahakali Municipality" if orgunitlevel4=="70905 Dodharachadani  Municipality"
	replace organisationunitname ="70905 Mahakali Municipality" if organisationunitname=="70905 Dodharachadani  Municipality"
	
	save "$user/$data/Data for analysis/Nepal_palika_2021_WIDE.dta", replace
