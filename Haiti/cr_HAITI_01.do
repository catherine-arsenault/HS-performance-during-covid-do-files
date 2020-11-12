* HS performance during Covid
* Oct 21, 2020 
* Haiti, January 2019 - June 2020
* Data recoding, Catherine Arsenault
*global user "/Users/acatherine/Dropbox (Harvard University)"
clear all 
set more off 

import delimited using "$user/$data/Raw data/Haiti_consolidated_data_elements_2018_2020_9_4_2020.csv", clear

* Total deliveries
rename (accouchementsinstitutionnelsjanv-v41) ///
(totaldel1_18	totaldel2_18	totaldel3_18	totaldel4_18	totaldel5_18	///
totaldel6_18	totaldel7_18	totaldel8_18	totaldel9_18	totaldel10_18	///
totaldel11_18	totaldel12_18	totaldel1_19	totaldel2_19	totaldel3_19	///
totaldel4_19	totaldel5_19	totaldel6_19	totaldel7_19	totaldel8_19	///
totaldel9_19	totaldel10_19	totaldel11_19	totaldel12_19 	totaldel1_20	///
totaldel2_20	totaldel3_20	totaldel4_20	totaldel5_20	totaldel6_20	///
totaldel7_20					)

* PNC visits 
rename (consultationspostnatalesjanvier2-v72) ///
( pncm_util1_18	pncm_util2_18	pncm_util3_18	pncm_util4_18	pncm_util5_18	///
pncm_util6_18	pncm_util7_18	pncm_util8_18	pncm_util9_18	pncm_util10_18	///
pncm_util11_18	pncm_util12_18 pncm_util1_19	pncm_util2_19	pncm_util3_19	///
pncm_util4_19	pncm_util5_19	pncm_util6_19	pncm_util7_19	pncm_util8_19	///
pncm_util9_19	pncm_util10_19	pncm_util11_19	pncm_util12_19 pncm_util1_20	///
pncm_util2_20	pncm_util3_20	pncm_util4_20	pncm_util5_20	pncm_util6_20	///
pncm_util7_20					)

/* PNC visits (children seen for the first time, unclear what the difference with 
indicator above is. We will check with Jean Paul)*/
rename (nbredenfantsvuspourlapremierefoi-v878 ) ///
(pncc_util1_18	pncc_util2_18	pncc_util3_18	pncc_util4_18	pncc_util5_18	pncc_util6_18	pncc_util7_18	pncc_util8_18	pncc_util9_18	pncc_util10_18	pncc_util11_18	pncc_util12_18 pncc_util1_19	pncc_util2_19	pncc_util3_19	pncc_util4_19	pncc_util5_19	pncc_util6_19	pncc_util7_19	pncc_util8_19	pncc_util9_19	pncc_util10_19	pncc_util11_19	pncc_util12_19 pncc_util1_20	pncc_util2_20	pncc_util3_20	pncc_util4_20	pncc_util5_20	pncc_util6_20	pncc_util7_20					)

rename (naissancesvivantesinstitutionnel-v103) ///
(livebirths1_18	livebirths2_18	livebirths3_18	livebirths4_18 livebirths5_18	///
livebirths6_18	livebirths7_18	livebirths8_18	livebirths9_18	livebirths10_18	///
livebirths11_18	livebirths12_18 livebirths1_19	livebirths2_19	livebirths3_19	///
livebirths4_19	livebirths5_19	livebirths6_19	livebirths7_19	livebirths8_19	///
livebirths9_19	livebirths10_19	livebirths11_19	livebirths12_19 livebirths1_20	///
livebirths2_20	livebirths3_20	livebirths4_20	livebirths5_20	livebirths6_20	///
livebirths7_20					)

rename (nbreclientsensoinsbuccodentaires-v165) ///
(dental_util1_18 dental_util2_18  dental_util3_18   dental_util4_18 dental_util5_18	///
dental_util6_18	 dental_util7_18  dental_util8_18	dental_util9_18	dental_util10_18 ///
dental_util11_18 dental_util12_18 dental_util1_19	dental_util2_19	dental_util3_19	///
dental_util4_19	 dental_util5_19  dental_util6_19	dental_util7_19 dental_util8_19	///
dental_util9_19	 dental_util10_19 dental_util11_19	dental_util12_19 dental_util1_20 ///
dental_util2_20	 dental_util3_20  dental_util4_20	dental_util5_20	dental_util6_20	///
dental_util7_20 )

rename (visitesdesclientespfrepartitiond-v196) ///
(fp_util1_18	fp_util2_18		fp_util3_18		fp_util4_18		fp_util5_18	///
 fp_util6_18	fp_util7_18		fp_util8_18		fp_util9_18		fp_util10_18 ///
 fp_util11_18	fp_util12_18	fp_util1_19		fp_util2_19		fp_util3_19	///
 fp_util4_19	fp_util5_19		fp_util6_19		fp_util7_19		fp_util8_19	///
 fp_util9_19	fp_util10_19	fp_util11_19	fp_util12_19	fp_util1_20	///
 fp_util2_20	fp_util3_20		fp_util4_20		fp_util5_20		fp_util6_20	///
 fp_util7_20					)

rename (visitesdesfemmesenceintesreparti-v351) ///
(anc_util1_18	anc_util2_18	anc_util3_18	anc_util4_18	anc_util5_18	///
anc_util6_18	anc_util7_18	anc_util8_18	anc_util9_18	anc_util10_18	///
anc_util11_18	anc_util12_18 	anc_util1_19	anc_util2_19	anc_util3_19	///
anc_util4_19	anc_util5_19	anc_util6_19	anc_util7_19	anc_util8_19	///
anc_util9_19	anc_util10_19	anc_util11_19	anc_util12_19  	anc_util1_20	///
anc_util2_20	anc_util3_20	anc_util4_20	anc_util5_20	anc_util6_20	///
anc_util7_20				 )

rename ( totaldaccouchementsinstitutionne-v537) ///
(cs_util1_18	cs_util2_18	cs_util3_18	cs_util4_18	cs_util5_18	cs_util6_18	cs_util7_18	cs_util8_18	cs_util9_18	cs_util10_18	cs_util11_18	cs_util12_18 cs_util1_19	cs_util2_19	cs_util3_19	cs_util4_19	cs_util5_19	cs_util6_19	cs_util7_19	cs_util8_19	cs_util9_19	cs_util10_19	cs_util11_19	cs_util12_19 cs_util1_20	cs_util2_20	cs_util3_20	cs_util4_20	cs_util5_20	cs_util6_20	cs_util7_20		 )

rename (diarrheesanglantejanvier2018-diarrheesanglantejuillet2020) ///
(diarr_util1_18	diarr_util2_18	diarr_util3_18	diarr_util4_18	diarr_util5_18	diarr_util6_18	diarr_util7_18	diarr_util8_18	diarr_util9_18	diarr_util10_18	diarr_util11_18	diarr_util12_18 diarr_util1_19	diarr_util2_19	diarr_util3_19	diarr_util4_19	diarr_util5_19	diarr_util6_19	diarr_util7_19	diarr_util8_19	diarr_util9_19	diarr_util10_19	diarr_util11_19	diarr_util12_19 diarr_util1_20	diarr_util2_20	diarr_util3_20	diarr_util4_20	diarr_util5_20	diarr_util6_20	diarr_util7_20					)
* opd_util
rename (visitesdesenfants14ansrepartitio-v227) ///
(tmpa1_18	tmpa2_18	tmpa3_18	tmpa4_18	tmpa5_18	tmpa6_18	tmpa7_18	///
tmpa8_18	tmpa9_18	tmpa10_18	tmpa11_18	tmpa12_18 ///
tmpa1_19	tmpa2_19	tmpa3_19	tmpa4_19	tmpa5_19	tmpa6_19	tmpa7_19	///
tmpa8_19	tmpa9_19	tmpa10_19	tmpa11_19	tmpa12_19 ///
tmpa1_20	tmpa2_20	tmpa3_20	tmpa4_20	tmpa5_20	tmpa6_20	tmpa7_20					)

rename (visitesdesenfants1014ansrepartit-v258) ///
( tmpb1_18	tmpb2_18	tmpb3_18	tmpb4_18	tmpb5_18	tmpb6_18	tmpb7_18	///
tmpb8_18	tmpb9_18	tmpb10_18	tmpb11_18	tmpb12_18 ///
tmpb1_19	tmpb2_19	tmpb3_19	tmpb4_19	tmpb5_19	tmpb6_19	tmpb7_19	///
tmpb8_19	tmpb9_19	tmpb10_19	tmpb11_19	tmpb12_19 ///
tmpb1_20	tmpb2_20	tmpb3_20	tmpb4_20	tmpb5_20	tmpb6_20	tmpb7_20					)

rename (visitesdesenfants59ansrepartitio-v289) ///
(tmpc1_18	tmpc2_18	tmpc3_18	tmpc4_18	tmpc5_18	tmpc6_18	tmpc7_18	///
tmpc8_18	tmpc9_18	tmpc10_18	tmpc11_18	   tmpc12_18 tmpc1_19	///
tmpc2_19	tmpc3_19	tmpc4_19	tmpc5_19	tmpc6_19	tmpc7_19	///
tmpc8_19	tmpc9_19	tmpc10_19	tmpc11_19	 tmpc12_19  tmpc1_20	///
tmpc2_20	tmpc3_20	tmpc4_20	tmpc5_20	tmpc6_20	tmpc7_20)

rename (visitesdesenfants1anrepartitiond-v320) ///
(tmpd1_18	tmpd2_18	tmpd3_18	tmpd4_18	tmpd5_18	tmpd6_18 tmpd7_18	///
tmpd8_18	tmpd9_18	tmpd10_18	tmpd11_18	tmpd12_18 tmpd1_19	tmpd2_19	///
tmpd3_19	tmpd4_19	tmpd5_19	tmpd6_19	tmpd7_19	tmpd8_19 tmpd9_19	///
tmpd10_19	tmpd11_19	tmpd12_19 tmpd1_20	tmpd2_20	tmpd3_20	tmpd4_20	///
tmpd5_20	tmpd6_20	tmpd7_20					 )

rename (visitesdesjeunesadultes1519ansre-v382) ///
(tmpe1_18	tmpe2_18	tmpe3_18	tmpe4_18	tmpe5_18	tmpe6_18	tmpe7_18	tmpe8_18	tmpe9_18	tmpe10_18	tmpe11_18	tmpe12_18 tmpe1_19	tmpe2_19	tmpe3_19	tmpe4_19	tmpe5_19	tmpe6_19	tmpe7_19	tmpe8_19	tmpe9_19	tmpe10_19	tmpe11_19	tmpe12_19 tmpe1_20	tmpe2_20	tmpe3_20	tmpe4_20	tmpe5_20	tmpe6_20	tmpe7_20					 )

rename ( visitesdespersonnesamobiliteredu-v413) ///
(tmpf1_18	tmpf2_18	tmpf3_18	tmpf4_18	tmpf5_18	tmpf6_18	tmpf7_18	tmpf8_18	tmpf9_18	tmpf10_18	tmpf11_18	tmpf12_18 tmpf1_19	tmpf2_19	tmpf3_19	tmpf4_19	tmpf5_19	tmpf6_19	tmpf7_19	tmpf8_19	tmpf9_19	tmpf10_19	tmpf11_19	tmpf12_19 tmpf1_20	tmpf2_20	tmpf3_20	tmpf4_20	tmpf5_20	tmpf6_20	tmpf7_20					 )

rename ( v414-v444) ///
(tmpg1_18	tmpg2_18	tmpg3_18	tmpg4_18	tmpg5_18	tmpg6_18	tmpg7_18	tmpg8_18	tmpg9_18	tmpg10_18	tmpg11_18	tmpg12_18 tmpg1_19	tmpg2_19	tmpg3_19	tmpg4_19	tmpg5_19	tmpg6_19	tmpg7_19	tmpg8_19	tmpg9_19	tmpg10_19	tmpg11_19	tmpg12_19 tmpg1_20	tmpg2_20	tmpg3_20	tmpg4_20	tmpg5_20	tmpg6_20	tmpg7_20					 )

rename (visitesdesjeunesadultes2024ansre-v475 ) ///
( tmph1_18	tmph2_18	tmph3_18	tmph4_18	tmph5_18	tmph6_18	tmph7_18	tmph8_18	tmph9_18	tmph10_18	tmph11_18	tmph12_18 tmph1_19	tmph2_19	tmph3_19	tmph4_19	tmph5_19	tmph6_19	tmph7_19	tmph8_19	tmph9_19	tmph10_19	tmph11_19	tmph12_19 tmph1_20	tmph2_20	tmph3_20	tmph4_20	tmph5_20	tmph6_20	tmph7_20					)

rename ( vistesdesautresadultesrepartitio-v506) ///
(tmpi1_18	tmpi2_18	tmpi3_18	tmpi4_18	tmpi5_18	tmpi6_18	tmpi7_18	tmpi8_18	tmpi9_18	tmpi10_18	tmpi11_18	tmpi12_18 tmpi1_19	tmpi2_19	tmpi3_19	tmpi4_19	tmpi5_19	tmpi6_19	tmpi7_19	tmpi8_19	tmpi9_19	tmpi10_19	tmpi11_19	tmpi12_19 tmpi1_20	tmpi2_20	tmpi3_20	tmpi4_20	tmpi5_20	tmpi6_20	tmpi7_20					 )


egen opd_util1_18 = rowtotal (fp_util1_18 tmpa1_18  tmpb1_18    tmpc1_18    tmpd1_18    tmpe1_18    tmpf1_18    tmpg1_18    tmph1_18    tmpi1_18  anc_util1_18 )
egen opd_util2_18 = rowtotal (fp_util2_18 tmpa2_18	tmpb2_18	tmpc2_18	tmpd2_18	tmpe2_18	tmpf2_18	tmpg2_18	tmph2_18	tmpi2_18  anc_util2_18 ) , m 
egen opd_util3_18 = rowtotal (fp_util3_18 tmpa3_18	tmpb3_18	tmpc3_18	tmpd3_18	tmpe3_18	tmpf3_18	tmpg3_18	tmph3_18	tmpi3_18  anc_util3_18 ) , m 
egen opd_util4_18 = rowtotal (fp_util4_18  tmpa4_18	tmpb4_18	tmpc4_18	tmpd4_18	tmpe4_18	tmpf4_18	tmpg4_18	tmph4_18	tmpi4_18  anc_util4_18 ) , m 
egen opd_util5_18 = rowtotal (fp_util5_18  tmpa5_18	tmpb5_18	tmpc5_18	tmpd5_18	tmpe5_18	tmpf5_18	tmpg5_18	tmph5_18	tmpi5_18  anc_util5_18) , m 
egen opd_util6_18 = rowtotal (fp_util6_18 tmpa6_18	tmpb6_18	tmpc6_18	tmpd6_18	tmpe6_18	tmpf6_18	tmpg6_18	tmph6_18	tmpi6_18  anc_util6_18 ) , m 
egen opd_util7_18 = rowtotal (fp_util7_18 tmpa7_18	tmpb7_18	tmpc7_18	tmpd7_18	tmpe7_18	tmpf7_18	tmpg7_18	tmph7_18	tmpi7_18  anc_util7_18 ) , m 
egen opd_util8_18 = rowtotal (fp_util8_18  tmpa8_18	tmpb8_18	tmpc8_18	tmpd8_18	tmpe8_18	tmpf8_18	tmpg8_18	tmph8_18	tmpi8_18  anc_util8_18) , m 
egen opd_util9_18 = rowtotal (fp_util9_18 tmpa9_18	tmpb9_18	tmpc9_18	tmpd9_18	tmpe9_18	tmpf9_18	tmpg9_18	tmph9_18	tmpi9_18  anc_util9_18 ) , m 
egen opd_util10_18 = rowtotal (fp_util10_18  tmpa10_18	tmpb10_18	tmpc10_18	tmpd10_18	tmpe10_18	tmpf10_18	tmpg10_18	tmph10_18	tmpi10_18 anc_util10_18) , m 
egen opd_util11_18 = rowtotal (fp_util11_18 tmpa11_18	tmpb11_18	tmpc11_18	tmpd11_18	tmpe11_18	tmpf11_18	tmpg11_18	tmph11_18	tmpi11_18 anc_util11_18 ) , m 
egen opd_util12_18 = rowtotal (fp_util12_18 tmpa12_18	tmpb12_18	tmpc12_18	tmpd12_18	tmpe12_18	tmpf12_18	tmpg12_18	tmph12_18	tmpi12_18 anc_util12_18 ) , m 
egen opd_util1_19 = rowtotal (fp_util1_19 tmpa1_19	tmpb1_19	tmpc1_19	tmpd1_19	tmpe1_19	tmpf1_19	tmpg1_19	tmph1_19	tmpi1_19  anc_util1_19 ) , m 
egen opd_util2_19 = rowtotal (fp_util2_19 tmpa2_19	tmpb2_19	tmpc2_19	tmpd2_19	tmpe2_19	tmpf2_19	tmpg2_19	tmph2_19	tmpi2_19  anc_util2_19) , m 
egen opd_util3_19 = rowtotal (fp_util3_19 tmpa3_19	tmpb3_19	tmpc3_19	tmpd3_19	tmpe3_19	tmpf3_19	tmpg3_19	tmph3_19	tmpi3_19  anc_util3_19 ) , m 
egen opd_util4_19 = rowtotal (fp_util4_19  tmpa4_19	tmpb4_19	tmpc4_19	tmpd4_19	tmpe4_19	tmpf4_19	tmpg4_19	tmph4_19	tmpi4_19  anc_util4_19) , m 
egen opd_util5_19 = rowtotal (fp_util5_19 tmpa5_19	tmpb5_19	tmpc5_19	tmpd5_19	tmpe5_19	tmpf5_19	tmpg5_19	tmph5_19	tmpi5_19  anc_util5_19 ) , m 
egen opd_util6_19 = rowtotal (fp_util6_19 tmpa6_19	tmpb6_19	tmpc6_19	tmpd6_19	tmpe6_19	tmpf6_19	tmpg6_19	tmph6_19	tmpi6_19  anc_util6_19 ) , m 
egen opd_util7_19 = rowtotal (fp_util7_19 tmpa7_19	tmpb7_19	tmpc7_19	tmpd7_19	tmpe7_19	tmpf7_19	tmpg7_19	tmph7_19	tmpi7_19  anc_util7_19 ) , m 
egen opd_util8_19 = rowtotal (fp_util8_19  tmpa8_19	tmpb8_19	tmpc8_19	tmpd8_19	tmpe8_19	tmpf8_19	tmpg8_19	tmph8_19	tmpi8_19  anc_util8_19) , m 
egen opd_util9_19 = rowtotal (fp_util9_19  tmpa9_19	tmpb9_19	tmpc9_19	tmpd9_19	tmpe9_19	tmpf9_19	tmpg9_19	tmph9_19	tmpi9_19  anc_util9_19) , m 
egen opd_util10_19 = rowtotal (fp_util10_19 tmpa10_19	tmpb10_19	tmpc10_19	tmpd10_19	tmpe10_19	tmpf10_19	tmpg10_19	tmph10_19	tmpi10_19  anc_util10_19 ) , m 
egen opd_util11_19 = rowtotal (fp_util11_19 tmpa11_19	tmpb11_19	tmpc11_19	tmpd11_19	tmpe11_19	tmpf11_19	tmpg11_19	tmph11_19	tmpi11_19  anc_util11_19 ) , m 
egen opd_util12_19 = rowtotal (fp_util12_19  tmpa12_19	tmpb12_19	tmpc12_19	tmpd12_19	tmpe12_19	tmpf12_19	tmpg12_19	tmph12_19	tmpi12_19  anc_util12_19) , m 
egen opd_util1_20 = rowtotal (fp_util1_20  tmpa1_20	tmpb1_20	tmpc1_20	tmpd1_20	tmpe1_20	tmpf1_20	tmpg1_20	tmph1_20	tmpi1_20  anc_util1_20) , m 
egen opd_util2_20 = rowtotal (fp_util2_20 tmpa2_20	tmpb2_20	tmpc2_20	tmpd2_20	tmpe2_20	tmpf2_20	tmpg2_20	tmph2_20	tmpi2_20  anc_util2_20) , m 
egen opd_util3_20 = rowtotal (fp_util3_20 tmpa3_20	tmpb3_20	tmpc3_20	tmpd3_20	tmpe3_20	tmpf3_20	tmpg3_20	tmph3_20	tmpi3_20  anc_util3_20 ) , m 
egen opd_util4_20 = rowtotal (fp_util4_20  tmpa4_20	tmpb4_20	tmpc4_20	tmpd4_20	tmpe4_20	tmpf4_20	tmpg4_20	tmph4_20	tmpi4_20  anc_util4_20) , m 
egen opd_util5_20 = rowtotal (fp_util5_20 tmpa5_20	tmpb5_20	tmpc5_20	tmpd5_20	tmpe5_20	tmpf5_20	tmpg5_20	tmph5_20	tmpi5_20  anc_util5_20 ) , m 
egen opd_util6_20 = rowtotal (fp_util6_20  tmpa6_20	tmpb6_20	tmpc6_20	tmpd6_20	tmpe6_20	tmpf6_20	tmpg6_20	tmph6_20	tmpi6_20  anc_util6_20) , m 
egen opd_util7_20 = rowtotal (fp_util7_20 tmpa7_20	tmpb7_20	tmpc7_20	tmpd7_20	tmpe7_20	tmpf7_20	tmpg7_20	tmph7_20	tmpi7_20  anc_util7_20 ) , m 

drop tmp* 
drop decesjanvier2018-decesjuillet2020
drop hsis_decesapres48heuresjanvier20-v661

* Diabetes
rename ( ancienscasdiabetejanvier2018-ancienscasdiabetejuillet2020) ///
(tmpa1_18	tmpa2_18	tmpa3_18	tmpa4_18	tmpa5_18	tmpa6_18	tmpa7_18	tmpa8_18	tmpa9_18	tmpa10_18	tmpa11_18	tmpa12_18 tmpa1_19	tmpa2_19	tmpa3_19	tmpa4_19	tmpa5_19	tmpa6_19	tmpa7_19	tmpa8_19	tmpa9_19	tmpa10_19	tmpa11_19	tmpa12_19 tmpa1_20	tmpa2_20	tmpa3_20	tmpa4_20	tmpa5_20	tmpa6_20	tmpa7_20					 )

rename ( nouveauxcasdiabetejanvier2018-nouveauxcasdiabetejuillet2020) ///
( tmpb1_18	tmpb2_18	tmpb3_18	tmpb4_18	tmpb5_18	tmpb6_18	tmpb7_18	tmpb8_18	tmpb9_18	tmpb10_18	tmpb11_18	tmpb12_18 tmpb1_19	tmpb2_19	tmpb3_19	tmpb4_19	tmpb5_19	tmpb6_19	tmpb7_19	tmpb8_19	tmpb9_19	tmpb10_19	tmpb11_19	tmpb12_19 tmpb1_20	tmpb2_20	tmpb3_20	tmpb4_20	tmpb5_20	tmpb6_20	tmpb7_20					)

egen diab_util1_18= rowtotal (tmpa1_18	tmpb1_18 ) , m 
egen diab_util2_18= rowtotal ( tmpa2_18	tmpb2_18) , m 
egen diab_util3_18= rowtotal ( tmpa3_18	tmpb3_18) , m 
egen diab_util4_18= rowtotal ( tmpa4_18	tmpb4_18) , m 
egen diab_util5_18= rowtotal (tmpa5_18	tmpb5_18 ) , m 
egen diab_util6_18= rowtotal (tmpa6_18	tmpb6_18 ) , m 
egen diab_util7_18= rowtotal (tmpa7_18	tmpb7_18 ) , m 
egen diab_util8_18= rowtotal ( tmpa8_18	tmpb8_18) , m 
egen diab_util9_18= rowtotal (tmpa9_18	tmpb9_18 ) , m 
egen diab_util10_18= rowtotal (tmpa10_18	tmpb10_18 ) , m 
egen diab_util11_18= rowtotal (tmpa11_18	tmpb11_18 ) , m 
egen diab_util12_18= rowtotal (tmpa12_18	tmpb12_18 ) , m 
egen diab_util1_19= rowtotal ( tmpa1_19	tmpb1_19) , m 
egen diab_util2_19= rowtotal ( tmpa2_19	tmpb2_19) , m 
egen diab_util3_19= rowtotal (tmpa3_19	tmpb3_19 ) , m 
egen diab_util4_19= rowtotal ( tmpa4_19	tmpb4_19) , m 
egen diab_util5_19= rowtotal (tmpa5_19	tmpb5_19 ) , m 
egen diab_util6_19= rowtotal (tmpa6_19	tmpb6_19 ) , m 
egen diab_util7_19= rowtotal ( tmpa7_19	tmpb7_19) , m 
egen diab_util8_19= rowtotal (tmpa8_19	tmpb8_19 ) , m 
egen diab_util9_19= rowtotal (tmpa9_19	tmpb9_19 ) , m 
egen diab_util10_19= rowtotal (tmpa10_19	tmpb10_19 ) , m 
egen diab_util11_19= rowtotal (tmpa11_19	tmpb11_19 ) , m 
egen diab_util12_19= rowtotal (tmpa12_19	tmpb12_19 ) , m 
egen diab_util1_20= rowtotal (tmpa1_20	tmpb1_20 ) , m 
egen diab_util2_20= rowtotal ( tmpa2_20	tmpb2_20) , m 
egen diab_util3_20= rowtotal ( tmpa3_20	tmpb3_20) , m 
egen diab_util4_20= rowtotal ( tmpa4_20	tmpb4_20) , m 
egen diab_util5_20= rowtotal ( tmpa5_20	tmpb5_20) , m 
egen diab_util6_20= rowtotal ( tmpa6_20	tmpb6_20) , m 
egen diab_util7_20= rowtotal (tmpa7_20	tmpb7_20 ) , m 

drop tmp* 

* Hypertension
rename (ancienscashtajanvier2018-ancienscashtajuillet2020 ) ///
(tmpa1_18	tmpa2_18	tmpa3_18	tmpa4_18	tmpa5_18	tmpa6_18	tmpa7_18	tmpa8_18	tmpa9_18	tmpa10_18	tmpa11_18	tmpa12_18 tmpa1_19	tmpa2_19	tmpa3_19	tmpa4_19	tmpa5_19	tmpa6_19	tmpa7_19	tmpa8_19	tmpa9_19	tmpa10_19	tmpa11_19	tmpa12_19 tmpa1_20	tmpa2_20	tmpa3_20	tmpa4_20	tmpa5_20	tmpa6_20	tmpa7_20					 )

rename ( nouveauxcashtajanvier2018-nouveauxcashtajuillet2020) ///
( tmpb1_18	tmpb2_18	tmpb3_18	tmpb4_18	tmpb5_18	tmpb6_18	tmpb7_18	tmpb8_18	tmpb9_18	tmpb10_18	tmpb11_18	tmpb12_18 tmpb1_19	tmpb2_19	tmpb3_19	tmpb4_19	tmpb5_19	tmpb6_19	tmpb7_19	tmpb8_19	tmpb9_19	tmpb10_19	tmpb11_19	tmpb12_19 tmpb1_20	tmpb2_20	tmpb3_20	tmpb4_20	tmpb5_20	tmpb6_20	tmpb7_20	)

egen hyper_util1_18= rowtotal (tmpa1_18	tmpb1_18 ) , m 
egen hyper_util2_18= rowtotal ( tmpa2_18	tmpb2_18) , m 
egen hyper_util3_18= rowtotal ( tmpa3_18	tmpb3_18) , m 
egen hyper_util4_18= rowtotal ( tmpa4_18	tmpb4_18) , m 
egen hyper_util5_18= rowtotal (tmpa5_18	tmpb5_18 ) , m 
egen hyper_util6_18= rowtotal (tmpa6_18	tmpb6_18 ) , m 
egen hyper_util7_18= rowtotal (tmpa7_18	tmpb7_18 ) , m 
egen hyper_util8_18= rowtotal ( tmpa8_18	tmpb8_18) , m 
egen hyper_util9_18= rowtotal (tmpa9_18	tmpb9_18 ) , m 
egen hyper_util10_18= rowtotal (tmpa10_18	tmpb10_18 ) , m 
egen hyper_util11_18= rowtotal (tmpa11_18	tmpb11_18 ) , m 
egen hyper_util12_18= rowtotal (tmpa12_18	tmpb12_18 ) , m 
egen hyper_util1_19= rowtotal ( tmpa1_19	tmpb1_19) , m 
egen hyper_util2_19= rowtotal ( tmpa2_19	tmpb2_19) , m 
egen hyper_util3_19= rowtotal (tmpa3_19	tmpb3_19 ) , m 
egen hyper_util4_19= rowtotal ( tmpa4_19	tmpb4_19) , m 
egen hyper_util5_19= rowtotal (tmpa5_19	tmpb5_19 ) , m 
egen hyper_util6_19= rowtotal (tmpa6_19	tmpb6_19 ) , m 
egen hyper_util7_19= rowtotal ( tmpa7_19	tmpb7_19) , m 
egen hyper_util8_19= rowtotal (tmpa8_19	tmpb8_19 ) , m 
egen hyper_util9_19= rowtotal (tmpa9_19	tmpb9_19 ) , m 
egen hyper_util10_19= rowtotal (tmpa10_19	tmpb10_19 ) , m 
egen hyper_util11_19= rowtotal (tmpa11_19	tmpb11_19 ) , m 
egen hyper_util12_19= rowtotal (tmpa12_19	tmpb12_19 ) , m 
egen hyper_util1_20= rowtotal (tmpa1_20	tmpb1_20 ) , m 
egen hyper_util2_20= rowtotal ( tmpa2_20	tmpb2_20) , m 
egen hyper_util3_20= rowtotal ( tmpa3_20	tmpb3_20) , m 
egen hyper_util4_20= rowtotal ( tmpa4_20	tmpb4_20) , m 
egen hyper_util5_20= rowtotal ( tmpa5_20	tmpb5_20) , m 
egen hyper_util6_20= rowtotal ( tmpa6_20	tmpb6_20) , m 
egen hyper_util7_20= rowtotal (tmpa7_20	tmpb7_20 ) , m 

drop tmp*
* Maternal deaths
rename (nombrededãcãsmaternelsparaccouch-v134) ///
(tmpa1_18	tmpa2_18	tmpa3_18	tmpa4_18	tmpa5_18	tmpa6_18	tmpa7_18	tmpa8_18	tmpa9_18	tmpa10_18	tmpa11_18	tmpa12_18 tmpa1_19	tmpa2_19	tmpa3_19	tmpa4_19	tmpa5_19	tmpa6_19	tmpa7_19	tmpa8_19	tmpa9_19	tmpa10_19	tmpa11_19	tmpa12_19 tmpa1_20	tmpa2_20	tmpa3_20	tmpa4_20	tmpa5_20	tmpa6_20	tmpa7_20					 )

rename (decesmaternelsjanvier2018-decesmaternelsjuillet2020) ///
( tmpb1_18	tmpb2_18	tmpb3_18	tmpb4_18	tmpb5_18	tmpb6_18	tmpb7_18	tmpb8_18	tmpb9_18	tmpb10_18	tmpb11_18	tmpb12_18 tmpb1_19	tmpb2_19	tmpb3_19	tmpb4_19	tmpb5_19	tmpb6_19	tmpb7_19	tmpb8_19	tmpb9_19	tmpb10_19	tmpb11_19	tmpb12_19 tmpb1_20	tmpb2_20	tmpb3_20	tmpb4_20	tmpb5_20	tmpb6_20	tmpb7_20	)

egen mat_mort_num1_18= rowtotal (tmpa1_18	tmpb1_18 ) , m 
egen mat_mort_num2_18= rowtotal ( tmpa2_18	tmpb2_18) , m 
egen mat_mort_num3_18= rowtotal ( tmpa3_18	tmpb3_18) , m 
egen mat_mort_num4_18= rowtotal ( tmpa4_18	tmpb4_18) , m 
egen mat_mort_num5_18= rowtotal (tmpa5_18	tmpb5_18 ) , m 
egen mat_mort_num6_18= rowtotal (tmpa6_18	tmpb6_18 ) , m 
egen mat_mort_num7_18= rowtotal (tmpa7_18	tmpb7_18 ) , m 
egen mat_mort_num8_18= rowtotal ( tmpa8_18	tmpb8_18) , m 
egen mat_mort_num9_18= rowtotal (tmpa9_18	tmpb9_18 ) , m 
egen mat_mort_num10_18= rowtotal (tmpa10_18	tmpb10_18 ) , m 
egen mat_mort_num11_18= rowtotal (tmpa11_18	tmpb11_18 ) , m 
egen mat_mort_num12_18= rowtotal (tmpa12_18	tmpb12_18 ) , m 
egen mat_mort_num1_19= rowtotal ( tmpa1_19	tmpb1_19) , m 
egen mat_mort_num2_19= rowtotal ( tmpa2_19	tmpb2_19) , m 
egen mat_mort_num3_19= rowtotal (tmpa3_19	tmpb3_19 ) , m 
egen mat_mort_num4_19= rowtotal ( tmpa4_19	tmpb4_19) , m 
egen mat_mort_num5_19= rowtotal (tmpa5_19	tmpb5_19 ) , m 
egen mat_mort_num6_19= rowtotal (tmpa6_19	tmpb6_19 ) , m 
egen mat_mort_num7_19= rowtotal ( tmpa7_19	tmpb7_19) , m 
egen mat_mort_num8_19= rowtotal (tmpa8_19	tmpb8_19 ) , m 
egen mat_mort_num9_19= rowtotal (tmpa9_19	tmpb9_19 ) , m 
egen mat_mort_num10_19= rowtotal (tmpa10_19	tmpb10_19 ) , m 
egen mat_mort_num11_19= rowtotal (tmpa11_19	tmpb11_19 ) , m 
egen mat_mort_num12_19= rowtotal (tmpa12_19	tmpb12_19 ) , m 
egen mat_mort_num1_20= rowtotal (tmpa1_20	tmpb1_20 ) , m 
egen mat_mort_num2_20= rowtotal ( tmpa2_20	tmpb2_20) , m 
egen mat_mort_num3_20= rowtotal ( tmpa3_20	tmpb3_20) , m 
egen mat_mort_num4_20= rowtotal ( tmpa4_20	tmpb4_20) , m 
egen mat_mort_num5_20= rowtotal ( tmpa5_20	tmpb5_20) , m 
egen mat_mort_num6_20= rowtotal ( tmpa6_20	tmpb6_20) , m 
egen mat_mort_num7_20= rowtotal (tmpa7_20	tmpb7_20 ) , m 

drop tmp*

* Cervical cancer screening
rename (nbredefemmesbenificiairesduneins-v847) ///
(cerv_qual1_18	cerv_qual2_18	cerv_qual3_18	cerv_qual4_18	cerv_qual5_18	cerv_qual6_18	cerv_qual7_18	cerv_qual8_18	cerv_qual9_18	cerv_qual10_18	cerv_qual11_18	cerv_qual12_18 cerv_qual1_19	cerv_qual2_19	cerv_qual3_19	cerv_qual4_19	cerv_qual5_19	cerv_qual6_19	cerv_qual7_19	cerv_qual8_19	cerv_qual9_19	cerv_qual10_19	cerv_qual11_19	cerv_qual12_19 cerv_qual1_20	cerv_qual2_20	cerv_qual3_20	cerv_qual4_20	cerv_qual5_20	cerv_qual6_20	cerv_qual7_20					 )

* New TB cases 
rename (nouveauxcasdetuberculosepulmonai-v692) ///
( tb_detect1_18	tb_detect2_18	tb_detect3_18	tb_detect4_18	tb_detect5_18	tb_detect6_18	tb_detect7_18	tb_detect8_18	tb_detect9_18	tb_detect10_18	tb_detect11_18	tb_detect12_18 tb_detect1_19	tb_detect2_19	tb_detect3_19	tb_detect4_19	tb_detect5_19	tb_detect6_19	tb_detect7_19	tb_detect8_19	tb_detect9_19	tb_detect10_19	tb_detect11_19	tb_detect12_19 tb_detect1_20	tb_detect2_20	tb_detect3_20	tb_detect4_20	tb_detect5_20	tb_detect6_20	tb_detect7_20					)

* Estimated perinatal deaths (stillbirths and newborn)
* Total deliveries - live births
gen peri_mort_num1_18 = totaldel1_18 - livebirths1_18
gen peri_mort_num2_18 = totaldel2_18 -livebirths2_18 
gen peri_mort_num3_18 = totaldel3_18 -livebirths3_18 
gen peri_mort_num4_18 = totaldel4_18 -livebirths4_18 
gen peri_mort_num5_18 = totaldel5_18 -livebirths5_18 
gen peri_mort_num6_18 = totaldel6_18 -livebirths6_18 
gen peri_mort_num7_18 = totaldel7_18 -livebirths7_18 
gen peri_mort_num8_18 = totaldel8_18 -livebirths8_18 
gen peri_mort_num9_18 = totaldel9_18 -livebirths9_18 
gen peri_mort_num10_18 = totaldel10_18 -livebirths10_18 
gen peri_mort_num11_18 = totaldel11_18 -livebirths11_18 
gen peri_mort_num12_18 = totaldel12_18 -livebirths12_18 

gen peri_mort_num1_19 = totaldel1_19 - livebirths1_19
gen peri_mort_num2_19 = totaldel2_19 -livebirths2_19 
gen peri_mort_num3_19 = totaldel3_19 -livebirths3_19 
gen peri_mort_num4_19 = totaldel4_19 -livebirths4_19 
gen peri_mort_num5_19 = totaldel5_19 -livebirths5_19 
gen peri_mort_num6_19 = totaldel6_19 -livebirths6_19 
gen peri_mort_num7_19 = totaldel7_19 -livebirths7_19 
gen peri_mort_num8_19 = totaldel8_19 -livebirths8_19 
gen peri_mort_num9_19 = totaldel9_19 -livebirths9_19 
gen peri_mort_num10_19 = totaldel10_19 -livebirths10_19 
gen peri_mort_num11_19 = totaldel11_19 -livebirths11_19 
gen peri_mort_num12_19 = totaldel12_19 -livebirths12_19  

gen peri_mort_num1_20 = totaldel1_20 - livebirths1_20
gen peri_mort_num2_20 = totaldel2_20 -livebirths2_20 
gen peri_mort_num3_20 = totaldel3_20 -livebirths3_20 
gen peri_mort_num4_20 = totaldel4_20 -livebirths4_20 
gen peri_mort_num5_20 = totaldel5_20 -livebirths5_20 
gen peri_mort_num6_20 = totaldel6_20 -livebirths6_20 
gen peri_mort_num7_20 = totaldel7_20 -livebirths7_20 
forval i =1/12 {
	replace peri_mort_num`i'_18 = 0 if peri_mort_num`i'_18 <0 & peri_mort_num`i'_18!=.
	replace peri_mort_num`i'_19 = 0 if peri_mort_num`i'_19 <0 & peri_mort_num`i'_19!=.
}	
forval i =1/7 {
	replace peri_mort_num`i'_20 = 0 if peri_mort_num`i'_20 <0 & peri_mort_num`i'_20!=.
}
drop livebirths*  

gen del_util1_18 = totaldel1_18 - cs_util1_18
gen del_util2_18 = totaldel2_18 -cs_util2_18 
gen del_util3_18 = totaldel3_18 -cs_util3_18 
gen del_util4_18 = totaldel4_18 -cs_util4_18 
gen del_util5_18 = totaldel5_18 -cs_util5_18 
gen del_util6_18 = totaldel6_18 -cs_util6_18 
gen del_util7_18 = totaldel7_18 -cs_util7_18 
gen del_util8_18 = totaldel8_18 -cs_util8_18 
gen del_util9_18 = totaldel9_18 -cs_util9_18 
gen del_util10_18 = totaldel10_18 -cs_util10_18 
gen del_util11_18 = totaldel11_18 -cs_util11_18 
gen del_util12_18 = totaldel12_18 -cs_util12_18 

gen del_util1_19 = totaldel1_19 - cs_util1_19
gen del_util2_19 = totaldel2_19 -cs_util2_19 
gen del_util3_19 = totaldel3_19 -cs_util3_19 
gen del_util4_19 = totaldel4_19 -cs_util4_19 
gen del_util5_19 = totaldel5_19 -cs_util5_19 
gen del_util6_19 = totaldel6_19 -cs_util6_19 
gen del_util7_19 = totaldel7_19 -cs_util7_19 
gen del_util8_19 = totaldel8_19 -cs_util8_19 
gen del_util9_19 = totaldel9_19 -cs_util9_19 
gen del_util10_19 = totaldel10_19 -cs_util10_19 
gen del_util11_19 = totaldel11_19 -cs_util11_19 
gen del_util12_19 = totaldel12_19 -cs_util12_19  

gen del_util1_20 = totaldel1_20 - cs_util1_20
gen del_util2_20 = totaldel2_20 -cs_util2_20 
gen del_util3_20 = totaldel3_20 -cs_util3_20 
gen del_util4_20 = totaldel4_20 -cs_util4_20 
gen del_util5_20 = totaldel5_20 -cs_util5_20 
gen del_util6_20 = totaldel6_20 -cs_util6_20 
gen del_util7_20 = totaldel7_20 -cs_util7_20 

forval i=1/12 {
	replace del_util`i'_18 = totaldel`i'_18 if del_util`i'_18==.
	replace del_util`i'_19 = totaldel`i'_19 if del_util`i'_19==.
}
forval i=1/7 {
	replace del_util`i'_20 = totaldel`i'_20 if del_util`i'_20==.
}
save "$user/$data/Data for analysis/Haiti_Jan18-Jul20_WIDE.dta", replace

	
