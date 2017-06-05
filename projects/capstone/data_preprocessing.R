####### The purpose of this script is to convert the csv files into a querriable database
pacman::p_load(data.table, tidyverse)

#extract the zip file names from the folder
tempListLoan = list.files(path = 'data/', pattern="*.csv")


#read the csv files
listings <- data.table::rbindlist(lapply(tempListLoan,
                             function(file) fread(paste0("data/", file),
                                                  na.strings=c("NA","","n/a","N/A", "<NA>"),
                                                  strip.white=TRUE,
                                                  fill =TRUE)))

describe(listings[ sample(1:nrow(listings), size = 20000, replace = FALSE), 151:200])
names(listings[ , 61:100])









# pre-process and clean the data.
listings <- listings %>% 
  # remove listings that have been withdrown by customer request
  filter(listing_status_reason != 'Withdrawn') %>% 
  # remove the following columns ince they are either completely empty or redundant
  select(-c(member_key, listing_status_reason, verification_stage,
            income_range_description, borrower_metropolitan_area,
            amount_participation, 
            
            )) %>% 
  # convert the following variables to numeric
  mutate_each(funs(as.numeric(.)),
              listing_number, listing_status, listing_amount,
              amount_funded, amount_remaining, percent_funded,
              funding_threshold, estimated_return, estimated_loss_rate,
              lender_yield, effective_yield, borrower_rate, borrower_apr,
              listing_term, listing_monthly_payment, prosper_score, income_range,
              stated_monthly_income, dti_wprosper_loan, months_employed,
              prior_prosper_loans_active, prior_prosper_loans, 
              prior_prosper_loans_principal_borrowed, prior_prosper_loans_principal_outstanding,
              prior_prosper_loans_balance_outstanding, prior_prosper_loans_cycles_billed,
              prior_prosper_loans_ontime_payments, prior_prosper_loans_late_cycles,
              prior_prosper_loans_late_payments_one_month_plus, max_prior_prosper_loan,
              min_prior_prosper_loan, prior_prosper_loan_earliest_pay_off, prior_prosper_loans31dpd,
              prior_prosper_loans61dpd, lender_indicator, all001, all002, all003,
              all005, all006, all007, all010, all021, all022, all023, all024,
              all026, all051, all052, all062, all064, all067, all071, all081,
              all082, all090, all101, all102, all106, all108, all118, all124, 
              all126, all127, all130, all134, all136, all141, all142, all144,
              all145, all146, all151, all155, all156, all201, all202, all207,
              all208, all301, all403, all501, all502, all503, all504, all505,
              all524, all601, all701, all702, all703, all720, all740, all780,
              all790, all801, all803, all804, all805, all806, all807, all901,
              all903, all904, all905, all906, bac001, bac002, bac005, bac007,
              bac022, bac026, bac028, bac031, bac035, bac042, bac044, bac045,
              bac071, bac081, bac084, bac159, bac302, bac303, bac401, 
              
              
              ) %>% 
  # convert the following variables to factors




                                    "listing_number"                                  
[3] "credit_pull_date"                                 "listing_start_date"                              
[5] "listing_end_date"                                 "listing_creation_date"                           
[7] "loan_origination_date"                            "listing_status"                                  
[9] "listing_status_reason"                            "verification_stage"                              
[11] "listing_amount"                                   "amount_funded"                                   
[13] "amount_remaining"                                 "percent_funded"                                  
[15] "partial_funding_indicator"                        "funding_threshold"                               
[17] "prosper_rating"                                   "estimated_return"                                
[19] "estimated_loss_rate"                              "lender_yield"                                    
[21] "effective_yield"                                  "borrower_rate"                                   
[23] "borrower_apr"                                     "listing_term"                                    
[25] "listing_monthly_payment"                          "scorex"                                          
[27] "scorex_change"                                    "fico_score"                                      
[29] "prosper_score"                                    "listing_category_id"                             
[31] "income_range"                                     "income_range_description"                        
[33] "stated_monthly_income"                            "income_verifiable"                               
[35] "dti_wprosper_loan"                                "employment_status_description"                   
[37] "occupation"                                       "months_employed"                                 
[39] "borrower_state"                                   "borrower_city"                                   
[41] "borrower_metropolitan_area"                       "prior_prosper_loans_active"                      
[43] "prior_prosper_loans"                              "prior_prosper_loans_principal_borrowed"          
[45] "prior_prosper_loans_principal_outstanding"        "prior_prosper_loans_balance_outstanding"         
[47] "prior_prosper_loans_cycles_billed"                "prior_prosper_loans_ontime_payments"             
[49] "prior_prosper_loans_late_cycles"                  "prior_prosper_loans_late_payments_one_month_plus"
[51] "max_prior_prosper_loan"                           "min_prior_prosper_loan"                          
[53] "prior_prosper_loan_earliest_pay_off"              "prior_prosper_loans31dpd"                        
[55] "prior_prosper_loans61dpd"                         "lender_indicator"                                
[57] "group_indicator"                                  "group_name"                                      
[59] "channel_code"                                     "amount_participation"                            
[61] "all001"                                           "all002"                                          
[63] "all003"                                           "all005"                                          
[65] "all006"                                           "all007"                                          
[67] "all010"                                           "all021"                                          
[69] "all022"                                           "all023"                                          
[71] "all024"                                           "all026"                                          
[73] "all051"                                           "all052"                                          
[75] "all062"                                           "all064"                                          
[77] "all067"                                           "all071"                                          
[79] "all081"                                           "all082"                                          
[81] "all090"                                           "all101"                                          
[83] "all102"                                           "all106"                                          
[85] "all108"                                           "all118"                                          
[87] "all124"                                           "all126"                                          
[89] "all127"                                           "all130"                                          
[91] "all134"                                           "all136"                                          
[93] "all141"                                           "all142"                                          
[95] "all144"                                           "all145"                                          
[97] "all146"                                           "all151"                                          
[99] "all155"                                           "all156"                                          
[101] "all201"                                           "all202"                                          
[103] "all207"                                           "all208"                                          
[105] "all301"                                           "all403"                                          
[107] "all501"                                           "all502"                                          
[109] "all503"                                           "all504"                                          
[111] "all505"                                           "all524"                                          
[113] "all601"                                           "all701"                                          
[115] "all702"                                           "all703"                                          
[117] "all720"                                           "all740"                                          
[119] "all780"                                           "all790"                                          
[121] "all801"                                           "all803"                                          
[123] "all804"                                           "all805"                                          
[125] "all806"                                           "all807"                                          
[127] "all901"                                           "all903"                                          
[129] "all904"                                           "all905"                                          
[131] "all906"                                           "bac001"                                          
[133] "bac002"                                           "bac005"                                          
[135] "bac007"                                           "bac022"                                          
[137] "bac026"                                           "bac028"                                          
[139] "bac031"                                           "bac035"                                          
[141] "bac042"                                           "bac044"                                          
[143] "bac045"                                           "bac071"                                          
[145] "bac081"                                           "bac084"                                          
[147] "bac159"                                           "bac302"                                          
[149] "bac303"                                           "bac401"                                          
[151] "bac403"                                           "bac501"                                          
[153] "bac502"                                           "bac503"                                          
[155] "bac550"                                           "bac584"                                          
[157] "bac589"                                           "bac601"                                          
[159] "bac751"                                           "bac752"                                          
[161] "bac804"                                           "bac901"                                          
[163] "bac908"                                           "bnk026"                                          
[165] "brr026"                                           "fil022"                                          
[167] "fin601"                                           "heq001"                                          
[169] "iln002"                                           "iln007"                                          
[171] "iln022"                                           "iln023"                                          
[173] "iln071"                                           "iln075"                                          
[175] "iln081"                                           "iln101"                                          
[177] "iln102"                                           "iln112"                                          
[179] "iln126"                                           "iln127"                                          
[181] "iln201"                                           "iln301"                                          
[183] "iln403"                                           "iln502"                                          
[185] "iln503"                                           "iln601"                                          
[187] "iln701"                                           "iln702"                                          
[189] "iln804"                                           "iln901"                                          
[191] "iln903"                                           "iln908"                                          
[193] "iln914"                                           "ref001"                                          
[195] "rep001"                                           "rep002"                                          
[197] "rep026"                                           "rep075"                                          
[199] "rep302"                                           "rep503"                                          
[201] "rep601"                                           "rep904"                                          
[203] "rep908"                                           "rev001"                                          
[205] "rev002"                                           "rev006"                                          
[207] "rev007"                                           "rev022"                                          
[209] "rev024"                                           "rev026"                                          
[211] "rev028"                                           "rev038"                                          
[213] "rev071"                                           "rev081"                                          
[215] "rev086"                                           "rev101"                                          
[217] "rev102"                                           "rev106"                                          
[219] "rev115"                                           "rev125"                                          
[221] "rev126"                                           "rev130"                                          
[223] "rev159"                                           "rev201"                                          
[225] "rev202"                                           "rev301"                                          
[227] "rev302"                                           "rev401"                                          
[229] "rev403"                                           "rev502"                                          
[231] "rev503"                                           "rev524"                                          
[233] "rev550"                                           "rev584"                                          
[235] "rev585"                                           "rev589"                                          
[237] "rev590"                                           "rev601"                                          
[239] "rev701"                                           "rev702"                                          
[241] "rev703"                                           "rev720"                                          
[243] "rev740"                                           "rev751"                                          
[245] "rev752"                                           "rev901"                                          
[247] "rev904"                                           "rev908"                                          
[249] "rtl001"                                           "rtl002"                                          
[251] "rtr001"                                           "rtr002"                                          
[253] "rtr005"                                           "rtr026"                                          
[255] "rtr159"                                           "rtr303"                                          
[257] "rtr401"                                           "rtr403"                                          
[259] "rtr501"                                           "rtr903"                                          
[261] "ale001"                                           "ale002"                                          
[263] "ale005"                                           "ale007"                                          
[265] "ale022"                                           "ale023"                                          
[267] "ale026"                                           "ale071"                                          
[269] "ale074"                                           "ale075"                                          
[271] "ale076"                                           "ale077"                                          
[273] "ale078"                                           "ale080"                                          
[275] "ale081"                                           "ale084"                                          
[277] "ale403"                                           "ale501"                                          
[279] "ale502"                                           "ale503"                                          
[281] "ale601"                                           "ale720"                                          
[283] "ale724"                                           "ale740"                                          
[285] "ale801"                                           "ale804"                                          
[287] "ale901"                                           "ale903"                                          
[289] "ale904"                                           "ale905"                                          
[291] "ale906"                                           "ale908"                                          
[293] "all074"                                           "all075"                                          
[295] "all076"                                           "all077"                                          
[297] "all078"                                           "all080"                                          
[299] "all084"                                           "all085"                                          
[301] "all086"                                           "all091"                                          
[303] "all092"                                           "all103"                                          
[305] "all104"                                           "all105"                                          
[307] "all107"                                           "all109"                                          
[309] "all110"                                           "all111"                                          
[311] "all112"                                           "all113"                                          
[313] "all114"                                           "all115"                                          
[315] "all116"                                           "all117"                                          
[317] "all119"                                           "all121"                                          
[319] "all122"                                           "all123"                                          
[321] "all125"                                           "all128"                                          
[323] "all129"                                           "all131"                                          
[325] "all143"                                           "all152"                                          
[327] "all153"                                           "all602"                                          
[329] "all724"                                           "all760"                                          
[331] "all907"                                           "aut001"                                          
[333] "aut071"                                           "aut720"                                          
[335] "bac023"                                           "bac037"                                          
[337] "bac074"                                           "bac075"                                          
[339] "bac076"                                           "bac077"                                          
[341] "bac078"                                           "bac080"                                          
[343] "bac801"                                           "bac903"                                          
[345] "bac904"                                           "bac905"                                          
[347] "bac906"                                           "bnk001"                                          
[349] "cap026"                                           "cap801"                                          
[351] "cru001"                                           "fil001"                                          
[353] "fil023"                                           "fin001"                                          
[355] "fin026"                                           "fin801"                                          
[357] "gbl007"                                           "iln001"                                          
[359] "iln005"                                           "iln006"                                          
[361] "iln026"                                           "iln064"                                          
[363] "iln067"                                           "iln074"                                          
[365] "iln076"                                           "iln077"                                          
[367] "iln078"                                           "iln080"                                          
[369] "iln084"                                           "iln085"                                          
[371] "iln086"                                           "iln103"                                          
[373] "iln104"                                           "iln105"                                          
[375] "iln106"                                           "iln107"                                          
[377] "iln108"                                           "iln109"                                          
[379] "iln110"                                           "iln111"                                          
[381] "iln113"                                           "iln114"                                          
[383] "iln115"                                           "iln116"                                          
[385] "iln117"                                           "iln118"                                          
[387] "iln119"                                           "iln122"                                          
[389] "iln124"                                           "iln125"                                          
[391] "iln128"                                           "iln129"                                          
[393] "iln130"                                           "iln302"                                          
[395] "iln501"                                           "iln504"                                          
[397] "iln703"                                           "iln720"                                          
[399] "iln724"                                           "iln740"                                          
[401] "iln801"                                           "iln904"                                          
[403] "iln905"                                           "iln906"                                          
[405] "lfi801"                                           "rep005"                                          
[407] "rep071"                                           "rep074"                                          
[409] "rep076"                                           "rep077"                                          
[411] "rep078"                                           "rep080"                                          
[413] "rep081"                                           "rep084"                                          
[415] "rep501"                                           "rep901"                                          
[417] "rep903"                                           "rep905"                                          
[419] "rep906"                                           "rev005"                                          
[421] "rev023"                                           "rev044"                                          
[423] "rev064"                                           "rev067"                                          
[425] "rev074"                                           "rev075"                                          
[427] "rev076"                                           "rev077"                                          
[429] "rev078"                                           "rev080"                                          
[431] "rev084"                                           "rev085"                                          
[433] "rev103"                                           "rev104"                                          
[435] "rev105"                                           "rev107"                                          
[437] "rev108"                                           "rev109"                                          
[439] "rev110"                                           "rev111"                                          
[441] "rev112"                                           "rev113"                                          
[443] "rev114"                                           "rev116"                                          
[445] "rev117"                                           "rev118"                                          
[447] "rev119"                                           "rev122"                                          
[449] "rev124"                                           "rev127"                                          
[451] "rev128"                                           "rev129"                                          
[453] "rev404"                                           "rev501"                                          
[455] "rev504"                                           "rev724"                                          
[457] "rev903"                                           "rev905"                                          
[459] "rev906"                                           "rti026"                                          
[461] "rtl005"                                           "rtl026"                                          
[463] "rtl071"                                           "rtl074"                                          
[465] "rtl075"                                           "rtl076"                                          
[467] "rtl077"                                           "rtl078"                                          
[469] "rtl080"                                           "rtl081"                                          
[471] "rtl084"                                           "rtl501"                                          
[473] "rtl502"                                           "rtl503"                                          
[475] "rtl901"                                           "rtl903"                                          
[477] "rtl904"                                           "rtl905"                                          
[479] "rtl906"                                           "rtl908"                                          
[481] "rtr007"                                           "rtr022"                                          
[483] "rtr023"                                           "rtr028"                                          
[485] "rtr031"                                           "rtr035"                                          
[487] "rtr044"                                           "rtr071"                                          
[489] "rtr074"                                           "rtr075"                                          
[491] "rtr076"                                           "rtr077"                                          
[493] "rtr078"                                           "rtr080"                                          
[495] "rtr081"                                           "rtr084"                                          
[497] "rtr584"                                           "rtr585"                                          
[499] "rtr589"                                           "rtr590"                                          
[501] "rtr601"                                           "rtr751"                                          
[503] "rtr752"                                           "rtr901"                                          
[505] "rtr904"                                           "rtr905"                                          
[507] "rtr906"                                           "rtr908"                                          
[509] "monthly_debt"                                     "current_delinquencies"                           
[511] "delinquencies_last7_years"                        "public_records_last10_years"                     
[513] "public_records_last12_months"                     "first_recorded_credit_line"                      
[515] "credit_lines_last7_years"                         "inquiries_last6_months"                          
[517] "amount_delinquent"                                "current_credit_lines"                            
[519] "open_credit_lines"                                "bankcard_utilization"                            
[521] "total_open_revolving_accounts"                    "installment_balance"                             
[523] "real_estate_balance"                              "revolving_balance"                               
[525] "real_estate_payment"                              "revolving_available_percent"                     
[527] "total_inquiries"                                  "total_trade_items"                               
[529] "satisfactory_accounts"                            "now_delinquent_derog"                            
[531] "was_delinquent_derog"                             "oldest_trade_open_date"                          
[533] "delinquencies_over30_days"                        "delinquencies_over60_days"                       
[535] "delinquencies_over90_days"                        "is_homeowner"                                    
[537] "investment_typeid"                                "investment_type_description"                     
[539] "whole_loan_start_date"                            "whole_loan_end_date"                             
[541] "last_updated_date"                        