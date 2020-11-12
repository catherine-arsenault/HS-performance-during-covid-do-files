# HS-performance-during-covid-do-files
This repository contains STATA do files and R scripts used to recode, clean and analyse dhis2 and HMIS data for the project: 
Health System Performance during Covid-19: mapping the indirect effects of a health crisis.
Harvard T.H. Chan School of Public Health, Department of Global Health and Population
PIs Catherine Arsenault and Margaret E. Kruk

Types of do files

# Master do files
  Example: Main_ETH
  This runs all the do files to arrive at the final datasets for Ethiopia.
  
# Dataset creation do files
  Example name: cr_ETH_01.
  1st creation do file for Ethiopia. This imports raw data and recodes variable names.

# Cleaning do files
  Example name: clean_ETH. 
  Cleaning do file for Ethiopia. This do file implements our data cleaning strategy (imputes 0s, identifies and removes outliers and performs "complete case analysis" (i.e. restricts sample to facilities that report consistently)). 
  
# Analysis do files
  Example name: an_ETH_01.
  1st analysis do file for Ethiopia. This performs the analyses used for policy briefs. E.g. calculating changes in services since Covid, contrasting Q2 2020 to Q2 2019.
  
 # Formatting do files (for google data studio)
 Example: format_ETH
 This do file formats the final, cleaned data, to use to create a dashboard in google data studio.
