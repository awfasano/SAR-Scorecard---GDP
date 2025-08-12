

global data  "C:\Users\vgald\OneDrive\Desktop\SAR_DATA\3. Output"
global out   "C:\Users\vgald\OneDrive\Desktop\SAR_DATA\4. Indicators"




*******  GDP    

forvalues i = 2010(1)2022 {
import delimited "$data\GDP\gdp_by_admin0_aggregated_`i'.csv", case(preserve) clear
tempfile  L0_gdp_`i'
save  "`L0_gdp_`i''"
}

use  `L0_gdp_2010' ,clear
forvalues i = 2011(1)2022 {
append using  `L0_gdp_`i''
}

save "$data\GDP\gdp_by_admin0_aggregated.dta" , replace



use  "$data\GDP\gdp_by_admin0_aggregated.dta",  clear
gsort -Disputed  L0_NAME  year
drop   wb_status
gen  variable="total_gdp"
gen var_label = "Total GDP (millions USD  in 2017 PPP)"
rename  total_gdp  value 
order   geo_level year sovereign Disputed L0_CODE L0_NAME variable var_label value
tempfile  gdp0
save  "`gdp0'"



forvalues i = 2010(1)2022 {
import delimited "$data\GDP\gdp_by_admin1_aggregated_`i'.csv", case(preserve) clear
tempfile  L1_gdp_`i'
save  "`L1_gdp_`i''"
}

use  `L1_gdp_2010' ,clear
forvalues i = 2011(1)2022 {
append using  `L1_gdp_`i''
}

save "$data\GDP\gdp_by_admin1_aggregated.dta" , replace


use "$data\GDP\gdp_by_admin1_aggregated.dta" , clear

gsort -Disputed  L0_NAME  L1_NAME  year
drop   wb_status
gen  variable="total_gdp"
gen var_label = "Total GDP (millions USD  in 2017 PPP)"
rename  total_gdp  value 
order   geo_level year  sovereign Disputed L0_CODE L0_NAME  L1_CODE L1_NAME variable var_label value

tempfile  gdp1
save  "`gdp1'"


forvalues i = 2010(1)2022 {
import delimited "$data\GDP\gdp_by_admin2_aggregated_`i'.csv", case(preserve) clear
tempfile  L2_gdp_`i'
save  "`L2_gdp_`i''"
}

use  `L2_gdp_2010' ,clear
forvalues i = 2011(1)2022 {
append using  `L2_gdp_`i''
}

save "$data\GDP\gdp_by_admin2_aggregated.dta" , replace



use "$data\GDP\gdp_by_admin2_aggregated.dta" , clear


gsort -Disputed  L0_NAME  L1_NAME  L2_NAME year
drop   wb_status
gen  variable="total_gdp"
gen var_label = "Total GDP (millions USD  in 2017 PPP)"
rename  total_gdp  value 
order   geo_level year  sovereign Disputed L0_CODE L0_NAME  L1_CODE L1_NAME  L2_CODE L2_NAME variable var_label value

tempfile  gdp2
save  "`gdp2'"


use  `gdp0'  , clear
append using  `gdp1'
append using  `gdp2'

order  geo_level year  sovereign Disputed L0_CODE L0_NAME L1_CODE L1_NAME L2_CODE L2_NAME variable var_label value

export delimited using "$out\GDP_spatial_Indicators_Levels_0_1_2.csv", replace







