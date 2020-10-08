#################################################################
# HS performance during Covid                        ############
# Haiti DHIS2, January 2019 - June 2020              #############
#################################################################

rm(list = ls())  # Delete everything that is in R's memory

# Load necessary library
library(tidyverse)
library(data.table)
library(ggpubr)
library(zoo); library(lubridate)
library(writexl)
library(readxl)
library(dplyr)
library(plyr)
library(tibble)
library(mice)
library(Hmisc)
library(readr)

# Neena's working directory
setwd("~/Dropbox (Harvard University)/HMIS Data for Health System Performance Covid (Haiti)")

# Import data - now just the consolidated sheet 
data_dhis <- read_csv("Raw data/Haiti_consolidated_data_elements_2018_2020_9_4_2020.csv")

# View(data_dhis)

#### Facility Delivery 
# Reshape del_util to long and create data frame for del_util that just contains org variables, Date and del_util 

del_util <- gather(data_dhis, Date, del_util, "Accouchements Institutionnels Janvier 2018":"Accouchements Institutionnels Juillet 2020")
del_util <- del_util %>%
            select(orgunitlevel1, 
                   orgunitlevel2, 
                   orgunitlevel3, 
                   orgunitlevel4, 
                   orgunitlevel5, 
                   orgunitlevel6, 
                   organisationunitid, 
                   organisationunitname, 
                   organisationunitcode, 
                   organisationunitdescription, 
                   Date,
                   del_util)

# Removing the text before the date so just month and year 

del_util$Date <- str_remove(del_util$Date, "Accouchements Institutionnels ")


#### Postnatal visits
# Reshape pnc_util to long and create data frame for pnc_util that just contains org variables, Date and pnc_util
pnc_util <- gather(data_dhis, Date, pnc_util, "Consultations postnatales Janvier 2018":"Consultations postnatales Juillet 2020")
pnc_util <- pnc_util %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         pnc_util)

# Removing the text before the date so just month and year 
pnc_util$Date <- str_remove(pnc_util$Date, "Consultations postnatales ")

# Doing the same as above for all variables

#### Live births 
live_birth <- gather(data_dhis, Date, live_birth, "Naissances Vivantes Institutionnels Janvier 2018":"Naissances Vivantes Institutionnels Juillet 2020")
live_birth <- live_birth %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         live_birth)

live_birth$Date <- str_remove(live_birth$Date, "Naissances Vivantes Institutionnels ")


#### C-sections

cs_util <- gather(data_dhis, Date, cs_util, "Total d'accouchements institutionnels par cesarienne Janvier 2018": "Total d'accouchements institutionnels par cesarienne Juillet 2020")
cs_util <- cs_util %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         cs_util)

cs_util$Date <- str_remove(cs_util$Date, "Total d'accouchements institutionnels par cesarienne ")

#### Malnutrition screening = "Nbre d'Enfants vus pour la premiere fois"
malnu_util <- gather(data_dhis, Date, malnu_util, "Nbre d'Enfants vus pour la premiere fois, peses/mesures (Pds-T/T-Age) Janvier 2018":"Nbre d'Enfants vus pour la premiere fois, peses/mesures (Pds-T/T-Age) Juillet 2020")
malnu_util <- malnu_util %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         malnu_util)

# Have to use \\ to "escape" other symbols in the variable name 
malnu_util$Date <- str_remove(malnu_util$Date, "Nbre d'Enfants vus pour la premiere fois\\, peses\\/mesures \\(Pds\\-T\\/T\\-Age\\) ")

#### Diabetes visits
## Diab_util involves two data frames, that I join at the end 

diab_util_old <- gather(data_dhis, Date, diab_util_old, "Anciens Cas Diabete Janvier 2018": "Anciens Cas Diabete Juillet 2020")
diab_util_old <- diab_util_old %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         diab_util_old)

diab_util_old$Date <- str_remove(diab_util_old$Date, "Anciens Cas Diabete ")

# New Diabetes visits
diab_util_new <- gather(data_dhis, Date, diab_util_new, "Nouveaux Cas Diabete Janvier 2018":"Nouveaux Cas Diabete Juillet 2020")
diab_util_new <- diab_util_new %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         diab_util_new)

diab_util_new$Date <- str_remove(diab_util_new$Date, "Nouveaux Cas Diabete ")

## Joining both data frames to create diab_util variable 

diab_util <- full_join(diab_util_new, diab_util_old,
                        by = c("orgunitlevel1", 
                               "orgunitlevel2", 
                               "orgunitlevel3", 
                               "orgunitlevel4", 
                               "orgunitlevel5", 
                               "orgunitlevel6", 
                               "organisationunitid", 
                               "organisationunitname", 
                               "organisationunitcode", 
                               "organisationunitdescription",
                               "Date"))

#Sum old and new visits 
diab_util$diab_util = diab_util$diab_util_new + diab_util$diab_util_old

# Drop new and old variables so just diab_util remains 
diab_util <- select(diab_util, 
                    "orgunitlevel1", 
                    "orgunitlevel2", 
                    "orgunitlevel3", 
                    "orgunitlevel4", 
                    "orgunitlevel5", 
                    "orgunitlevel6", 
                    "organisationunitid", 
                    "organisationunitname", 
                    "organisationunitcode", 
                    "organisationunitdescription",
                    "Date",
                    "diab_util")

### Hypertension visits
## hyper_util involves two data frames, that I join at the end, as above

# Hypertension visits old
hyper_util_old <- gather(data_dhis, Date, hyper_util_old, "Anciens Cas HTA Janvier 2018":"Anciens Cas HTA Juillet 2020")
hyper_util_old <- hyper_util_old %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         hyper_util_old)

hyper_util_old$Date <- str_remove(hyper_util_old$Date, "Anciens Cas HTA ")

# Hypertension visits new 
hyper_util_new <- gather(data_dhis, Date, hyper_util_new, "Nouveaux Cas HTA Janvier 2018":"Nouveaux Cas HTA Juillet 2020")
hyper_util_new <- hyper_util_new %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         hyper_util_new)

hyper_util_new$Date <- str_remove(hyper_util_new$Date, "Nouveaux Cas HTA ")

hyper_util <- full_join(hyper_util_new, hyper_util_old,
                        by = c("orgunitlevel1", 
                               "orgunitlevel2", 
                               "orgunitlevel3", 
                               "orgunitlevel4", 
                               "orgunitlevel5", 
                               "orgunitlevel6", 
                               "organisationunitid", 
                               "organisationunitname", 
                               "organisationunitcode", 
                               "organisationunitdescription",
                               "Date"))
# Sum old and new 
hyper_util$hyper_util = hyper_util$hyper_util_new + hyper_util$hyper_util_old

# Drop old and new so just hyper_util remains 
hyper_util <- select(hyper_util, 
                    "orgunitlevel1", 
                    "orgunitlevel2", 
                    "orgunitlevel3", 
                    "orgunitlevel4", 
                    "orgunitlevel5", 
                    "orgunitlevel6", 
                    "organisationunitid", 
                    "organisationunitname", 
                    "organisationunitcode", 
                    "organisationunitdescription",
                    "Date",
                    "hyper_util")

# Institutional Mortality
ipd_mort <- gather(data_dhis, Date, ipd_mort, "Deces Janvier 2018":"Deces Juillet 2020")
ipd_mort <- ipd_mort %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         ipd_mort)

ipd_mort$Date <- str_remove(ipd_mort$Date, "Deces ")

### Maternal Mort
# Number of maternal deaths per delivery
mat_mort <- gather(data_dhis, Date, mat_mort, "Nombre de Décès maternels par Accouchements Janvier 2018":"Nombre de Décès maternels par Accouchements Juillet 2020")
mat_mort <- mat_mort %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         mat_mort)

mat_mort$Date <- str_remove(mat_mort$Date, "Nombre de Décès maternels par Accouchements ")

## Number of Dental Visits
dent_util <- gather(data_dhis, Date, dent_util, "Nbre Clients en soins bucco-dentaires Janvier 2018":"Nbre Clients en soins bucco-dentaires Juillet 2020")
dent_util <- dent_util %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         dent_util)

dent_util$Date <- str_remove(dent_util$Date, "Nbre Clients en soins bucco-dentaires ")

## Child Diarrhea visits
diarr_util <- gather(data_dhis, Date, diarr_util, "Diarrhee sanglante Janvier 2018":"Diarrhee sanglante Juillet 2020")
diarr_util <- diarr_util %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         diarr_util)

diarr_util$Date <- str_remove(diarr_util$Date, "Diarrhee sanglante ")

### TB cases detected - THIS INDICATOR IS SLIGHTLY DIFFERENT THAN THE ONE IN CELESTIN'S CODE (can't find another tuberculosis indicator)
tbdetect_qual <- gather(data_dhis, Date, tbdetect_qual, "Nouveaux cas de Tuberculose pulmonaire a frottis + Janvier 2018":"Nouveaux cas de Tuberculose pulmonaire a frottis + Juillet 2020")
tbdetect_qual <- tbdetect_qual %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         tbdetect_qual)

tbdetect_qual$Date <- str_remove(tbdetect_qual$Date, "Nouveaux cas de Tuberculose pulmonaire a frottis \\+ ")
##MK: this indicator is completely missing. 

### Cervical Cancer Screening by VIA
cerv_qual <- gather(data_dhis, Date, cerv_qual, "Nbre de Femmes benificiaires d'une inspection visuelle a l'acide acetique (IVAA) Janvier 2018":"Nbre de Femmes benificiaires d'une inspection visuelle a l'acide acetique (IVAA) Juillet 2020")
cerv_qual <- cerv_qual %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         cerv_qual)

cerv_qual$Date <- str_remove(cerv_qual$Date, "Nbre de Femmes benificiaires d'une inspection visuelle a l'acide acetique \\(IVAA\\) ")

### Outpatient visits 
# 1
opd_util1 <- gather(data_dhis, Date, opd_util1, "Visites des Clientes PF | Repartition des vistes Janvier 2018":"Visites des Clientes PF | Repartition des vistes Juillet 2020")
opd_util1 <- opd_util1 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util1)

opd_util1$Date <- str_remove(opd_util1$Date, "Visites des Clientes PF \\| Repartition des vistes ")

# 2
opd_util2 <- gather(data_dhis, Date, opd_util2, "Visites des Enfants 1 - 4 ans | Repartition des visites Janvier 2018":"Visites des Enfants 1 - 4 ans | Repartition des visites Juillet 2020")
opd_util2 <- opd_util2 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util2)

opd_util2$Date <- str_remove(opd_util2$Date, "Visites des Enfants 1 - 4 ans \\| Repartition des visites ")

#3
opd_util3 <- gather(data_dhis, Date, opd_util3, "Visites des Enfants 10 - 14 ans | Repartition des visites Janvier 2018":"Visites des Enfants 10 - 14 ans | Repartition des visites Juillet 2020")
opd_util3 <- opd_util3 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util3)

opd_util3$Date <- str_remove(opd_util3$Date, "Visites des Enfants 10 - 14 ans \\| Repartition des visites ")

#4
opd_util4 <- gather(data_dhis, Date, opd_util4, "Visites des Enfants 5 - 9 ans | Repartition des visites Janvier 2018":"Visites des Enfants 5 - 9 ans | Repartition des visites Juillet 2020")
opd_util4 <- opd_util4 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util4)

opd_util4$Date <- str_remove(opd_util4$Date, "Visites des Enfants 5 - 9 ans \\| Repartition des visites ")

#5
opd_util5 <- gather(data_dhis, Date, opd_util5, "Visites des Enfants < 1 an | Repartition des visites Janvier 2018":"Visites des Enfants < 1 an | Repartition des visites Juillet 2020")
opd_util5 <- opd_util5 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util5)

opd_util5$Date <- str_remove(opd_util5$Date, "Visites des Enfants < 1 an \\| Repartition des visites ")


#6 
opd_util6 <- gather(data_dhis, Date, opd_util6, "Visites des Femmes Enceintes | Repartition des visites Janvier 2018": "Visites des Femmes Enceintes | Repartition des visites Juillet 2020")
opd_util6 <- opd_util6 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util6)

opd_util6$Date <- str_remove(opd_util6$Date, "Visites des Femmes Enceintes \\| Repartition des visites ")


#7
opd_util7 <- gather(data_dhis, Date, opd_util7, "Visites des Jeunes adultes 15 - 19 ans | Repartition des visites Janvier 2018": "Visites des Jeunes adultes 15 - 19 ans | Repartition des visites Juillet 2020")
opd_util7 <- opd_util7 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util7)

opd_util7$Date <- str_remove(opd_util7$Date, "Visites des Jeunes adultes 15 - 19 ans \\| Repartition des visites ")

#8
opd_util8 <- gather(data_dhis, Date, opd_util8, "Visites des Personnes a mobilite reduite (moteur) Janvier 2018": "Visites des Personnes a mobilite reduite (moteur) Juillet 2020")
opd_util8 <- opd_util8 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util8)

opd_util8$Date <- str_remove(opd_util8$Date, "Visites des Personnes a mobilite reduite \\(moteur\\) ")

#9
opd_util9 <- gather(data_dhis, Date, opd_util9, "Visites des Personnes a mobilite reduite (sensoriel) Janvier 2018": "Visites des Personnes a mobilite reduite (sensoriel) Juillet 2020")
opd_util9 <- opd_util9 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util9)

opd_util9$Date <- str_remove(opd_util9$Date, "Visites des Personnes a mobilite reduite \\(sensoriel\\) ")

#10
opd_util10 <- gather(data_dhis, Date, opd_util10, "Visites des jeunes adultes 20 - 24 ans | Repartition des visites Janvier 2018": "Visites des jeunes adultes 20 - 24 ans | Repartition des visites Juillet 2020")
opd_util10 <- opd_util10 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util10)

opd_util10$Date <- str_remove(opd_util10$Date, "Visites des jeunes adultes 20 - 24 ans \\| Repartition des visites ")

#11
opd_util11 <- gather(data_dhis, Date, opd_util11, "Vistes des Autres Adultes | Repartition des visites Janvier 2018": "Vistes des Autres Adultes | Repartition des visites Juillet 2020")
opd_util11 <- opd_util11 %>%
  select(orgunitlevel1, 
         orgunitlevel2, 
         orgunitlevel3, 
         orgunitlevel4, 
         orgunitlevel5, 
         orgunitlevel6, 
         organisationunitid, 
         organisationunitname, 
         organisationunitcode, 
         organisationunitdescription, 
         Date,
         opd_util11)

opd_util11$Date <- str_remove(opd_util11$Date, "Vistes des Autres Adultes \\| Repartition des visites ")

# Joining all opd_util data frames
opd_util <- full_join(opd_util1, opd_util2, by = c("orgunitlevel1", 
                               "orgunitlevel2", 
                               "orgunitlevel3", 
                               "orgunitlevel4", 
                               "orgunitlevel5", 
                               "orgunitlevel6", 
                               "organisationunitid", 
                               "organisationunitname", 
                               "organisationunitcode", 
                               "organisationunitdescription",
                               "Date")) %>%
              full_join(., opd_util3, by = c("orgunitlevel1", 
                                           "orgunitlevel2", 
                                           "orgunitlevel3", 
                                           "orgunitlevel4", 
                                           "orgunitlevel5", 
                                           "orgunitlevel6", 
                                           "organisationunitid", 
                                           "organisationunitname", 
                                           "organisationunitcode", 
                                           "organisationunitdescription",
                                           "Date")) %>%
              full_join(., opd_util4, by = c("orgunitlevel1", 
                                            "orgunitlevel2", 
                                            "orgunitlevel3", 
                                            "orgunitlevel4", 
                                            "orgunitlevel5", 
                                            "orgunitlevel6", 
                                            "organisationunitid", 
                                            "organisationunitname", 
                                            "organisationunitcode", 
                                            "organisationunitdescription",
                                            "Date")) %>%
              full_join(., opd_util5, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util6, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util7, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util8, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util9, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util10, by = c("orgunitlevel1", 
                                             "orgunitlevel2", 
                                             "orgunitlevel3", 
                                             "orgunitlevel4", 
                                             "orgunitlevel5", 
                                             "orgunitlevel6", 
                                             "organisationunitid", 
                                             "organisationunitname", 
                                             "organisationunitcode", 
                                             "organisationunitdescription",
                                             "Date")) %>%
              full_join(., opd_util11, by = c("orgunitlevel1", 
                                              "orgunitlevel2", 
                                              "orgunitlevel3", 
                                              "orgunitlevel4", 
                                              "orgunitlevel5", 
                                              "orgunitlevel6", 
                                              "organisationunitid", 
                                              "organisationunitname", 
                                              "organisationunitcode", 
                                              "organisationunitdescription",
                                              "Date")) 

# Sum all opd
# When summing, I set missing to 0 (so no longer is NA, is now 0 in the sum column - not sure if that is okay or not)
opd_util$opd_util <- rowSums(opd_util[,c("opd_util1", "opd_util2", "opd_util3", "opd_util4", "opd_util5", "opd_util6", "opd_util7", "opd_util8", "opd_util9", "opd_util10", "opd_util11")], na.rm = TRUE)
# Drop old and new so just opd_util remains 
opd_util <- select(opd_util, 
                     "orgunitlevel1", 
                     "orgunitlevel2", 
                     "orgunitlevel3", 
                     "orgunitlevel4", 
                     "orgunitlevel5", 
                     "orgunitlevel6", 
                     "organisationunitid", 
                     "organisationunitname", 
                     "organisationunitcode", 
                     "organisationunitdescription",
                     "Date",
                     "opd_util")



### JOINING ALL DATA FRAMES TOGETHER !!
dhis_data_clean <- full_join(del_util, pnc_util, by = c("orgunitlevel1", 
                                                   "orgunitlevel2", 
                                                   "orgunitlevel3", 
                                                   "orgunitlevel4", 
                                                   "orgunitlevel5", 
                                                   "orgunitlevel6", 
                                                   "organisationunitid", 
                                                   "organisationunitname", 
                                                   "organisationunitcode", 
                                                   "organisationunitdescription",
                                                   "Date")) %>%
  full_join(., live_birth, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., cs_util, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., malnu_util, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., diab_util, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., hyper_util, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., ipd_mort, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., mat_mort, by = c("orgunitlevel1", 
                                 "orgunitlevel2", 
                                 "orgunitlevel3", 
                                 "orgunitlevel4", 
                                 "orgunitlevel5", 
                                 "orgunitlevel6", 
                                 "organisationunitid", 
                                 "organisationunitname", 
                                 "organisationunitcode", 
                                 "organisationunitdescription",
                                 "Date")) %>%
  full_join(., dent_util, by = c("orgunitlevel1", 
                                  "orgunitlevel2", 
                                  "orgunitlevel3", 
                                  "orgunitlevel4", 
                                  "orgunitlevel5", 
                                  "orgunitlevel6", 
                                  "organisationunitid", 
                                  "organisationunitname", 
                                  "organisationunitcode", 
                                  "organisationunitdescription",
                                  "Date")) %>%
  full_join(., diarr_util, by = c("orgunitlevel1", 
                                  "orgunitlevel2", 
                                  "orgunitlevel3", 
                                  "orgunitlevel4", 
                                  "orgunitlevel5", 
                                  "orgunitlevel6", 
                                  "organisationunitid", 
                                  "organisationunitname", 
                                  "organisationunitcode", 
                                  "organisationunitdescription",
                                  "Date")) %>%
  full_join(., tbdetect_qual, by = c("orgunitlevel1", 
                                  "orgunitlevel2", 
                                  "orgunitlevel3", 
                                  "orgunitlevel4", 
                                  "orgunitlevel5", 
                                  "orgunitlevel6", 
                                  "organisationunitid", 
                                  "organisationunitname", 
                                  "organisationunitcode", 
                                  "organisationunitdescription",
                                  "Date")) %>%
  full_join(., cerv_qual, by = c("orgunitlevel1", 
                                  "orgunitlevel2", 
                                  "orgunitlevel3", 
                                  "orgunitlevel4", 
                                  "orgunitlevel5", 
                                  "orgunitlevel6", 
                                  "organisationunitid", 
                                  "organisationunitname", 
                                  "organisationunitcode", 
                                  "organisationunitdescription",
                                  "Date")) %>%
  full_join(., opd_util, by = c("orgunitlevel1", 
                                  "orgunitlevel2", 
                                  "orgunitlevel3", 
                                  "orgunitlevel4", 
                                  "orgunitlevel5", 
                                  "orgunitlevel6", 
                                  "organisationunitid", 
                                  "organisationunitname", 
                                  "organisationunitcode", 
                                  "organisationunitdescription",
                                  "Date"))

write_xlsx(dhis_data_clean, "Data_Haiti_Recoded_V2_JAN2019_JUN2020.xlsx")


### Road traffic incidents 
### INDICATOR NOT IN FILE BUT WAS IN CELESTIN'S CODE, leaving code here for future iterations
# road_util <- gather(data_dhis, Date, road_util, "Nbre Accidents de la voie publique Janvier 2018":"Nbre Accidents de la voie publique Juillet 2020")
# road_util <- road_util %>%
#  select(orgunitlevel1, 
#         orgunitlevel2, 
#        orgunitlevel3, 
#         orgunitlevel4, 
#         orgunitlevel5, 
#        orgunitlevel6, 
#         organisationunitid, 
#         organisationunitname, 
#         organisationunitcode, 
#         organisationunitdescription, 
#         Date,
#         road_util)



# View(data_dhis_clean)

# Pontetial code to check work and make sure all variables were "gathered"
# Ideally, at the end you would see that no variables in the original dataset remain in the wide format if you run this for all variables 
# When I run these, my R keeps aborting I think because it is too much data 

# data_dhis <- gather(data_dhis, Date, del_util, "Accouchements Institutionnels Janvier 2018":"Accouchements Institutionnels Juillet 2020"
# data_dhis <- gather(data_dhis, Date, live_birth, "Naissances Vivantes Institutionnels Janvier 2018":"Naissances Vivantes Institutionnels Juillet 2020")
# data_dhis <- gather(data_dhis, Date, cs_util, "Total d'accouchements institutionnels par cesarienne Janvier 2018": "Total d'accouchements institutionnels par cesarienne Juillet 2020")











