# HS-performance-during-covid-do-files
This repository contains STATA do files and R scripts used to recode, clean and analyse dhis2 and HMIS data for the project: 
Health System Performance during Covid-19: mapping the indirect effects of a health crisis.
Harvard T.H. Chan School of Public Health, Department of Global Health and Population

Types of do files:


# Dataset creation
# Example name: cr_ETH_01
1st creation do file for Ethiopia. This imports raw data, recodes variable names, calculates sums, and reshapes the data.

# Cleaning do file
# Example name: clean_ETH_01 
1st cleaning do file for Ethiopia. This do file implements our data cleaning strategy (imputes 0s, identifies and removesoutliers, calculates completeness, performs "complete case analysis" (i.e. restricts sample to facilities that report consistently)). After cleaning, this do file also calculates rates.

# Analysis
# Example name: an_ETH_01
1st analysis do file for Ethiopia. This performs the analyses used for policy briefs. E.g. calculating changes in services since Covid.
