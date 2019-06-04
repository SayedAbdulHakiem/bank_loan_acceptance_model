############# Data Processing Phase 
############# 1- load the table 
path <- "C:/Users/SAY_ED/Desktop/project_ERP/WorkFlow1.txt"
path <- "D:/work/FacultyMatrial/level4/second term/IS_DS - ERP & Big Data/Project/WorkFlow1.txt"
wf1<-read.table(file = path ,header = TRUE ,sep = "|")

############# 2- turn variables columns into factors
# 
loan_type<- as.factor(wf1$loan_type)
plot(loan_type)

loan_purpose<- as.factor(wf1$loan_purpose)
plot(loan_purpose)

preapproval<- as.factor(wf1$preapproval)
plot(preapproval)

action_type<- as.factor(wf1$action_type)
plot(action_type)

county_name<- as.factor(wf1$county_name)
plot(county_name)

applicant_ethnicity<- as.factor(wf1$applicant_ethnicity)
plot(applicant_ethnicity)

applicant_race_1<- as.factor(wf1$applicant_race_1)
plot(applicant_race_1)

applicant_sex<- as.factor(wf1$applicant_sex)
plot(applicant_sex)

lien_status<- as.factor(wf1$lien_status)
plot(lien_status)

############# 3- how many people were accepted in the adams county

#sum((wf1$county_name=="Adams")&( wf1$action_type=="Approved Not Accepted"))
sum((wf1$county_name=="Adams")&( wf1$action_type=="Originated"))
# = 2661 "Orginated" before remove income[NA] rows
# = 2531 "Orginated" after remove NA rows
# = 242 "Accepted And Nor Approved" before remove income[NA] rows
# = 228 "Accepted And Nor Approved" after remove NA rows

############# 4- convert needed columns to numeric instead of varchar

# columns must be numeric :? ashok an de m3ahom ? rate_spre ad
#loan_amount_ink|applicant_income_ink|hoepa_status|minority_population_pct|hud_median_family_income|rate_spre|tract_to_msamd_income_pct|number_of_owner_occupied_units
numeric_loan_amount_ink<- as.numeric(wf1$loan_amount_ink)
print(is.numeric(numeric_loan_amount_ink))

numeric_applicant_income_ink<- as.numeric(wf1$applicant_income_ink)
print(is.numeric(numeric_applicant_income_ink))

numeric_hoepa_status<- as.numeric(wf1$hoepa_status)
print(is.numeric(numeric_hoepa_status))

numeric_minority_population_pct<- as.numeric(wf1$minority_population_pct)
print(is.numeric(numeric_minority_population_pct))

numeric_rate_spread<- as.numeric(wf1$rate_spread)
print(is.numeric(numeric_rate_spread))

numeric_hud_median_family_income<- as.numeric(wf1$hud_median_family_income)
print(is.numeric(numeric_hud_median_family_income))

numeric_tract_to_msamd_income_pct<- as.numeric(wf1$tract_to_msamd_income_pct)
print(is.numeric(numeric_tract_to_msamd_income_pct))

numeric_number_of_owner_occupied_units<- as.numeric(wf1$number_of_owner_occupied_units)
print(is.numeric(numeric_number_of_owner_occupied_units))

############# 5- Remove records without income info (applicant_income_ink)

print(nrow(wf1))
#wf1<- subset(wf1,!is.na(numeric_applicant_income_ink ))
#wf1<-subset(wf1,wf1$applicant_ethnicity !="No Info")
wf1<-subset(wf1,wf1$applicant_income_ink !="NA  " )
print(nrow(wf1))


############# 6- Remove records with NA (tract_to_msamd_income_pct, minority_population_pct)
#wf1<- subset(wf1,!is.na(numeric_tract_to_msamd_income_pct ))
#wf1<- subset(wf1,!is.na(numeric_minority_population_pct  ))
wf1<- subset(wf1,wf1$tract_to_msamd_income_pct !="NA    " & wf1$minority_population_pct !="NA    "  )
print(nrow(wf1))
View(wf1)
sum((wf1$county_name=="Adams")&( wf1$action_type=="Approved Not Accepted"))
sum((wf1$county_name=="Adams")&( wf1$action_type=="Originated"))
####################################################################################
############# Data Analysis Phase 
############# 1- visualize 5 variables 
# 1st: numeric_loan_amount_ink 
plot(numeric_loan_amount_ink) 
# there is an extereme values is greater than 10000 at 1e+05 index 
plot(log10(numeric_loan_amount_ink))
# the values is spread over all the graph when using log10 
plot(hist(numeric_loan_amount_ink))
# the values of frequency is all in the 0 loan amount index
plot(density(numeric_loan_amount_ink))
# there is a right skewed in the density of the data  N=445633 , bandwidth = 6.675

# 2nd: numeric_applicant_income_ink
plot(numeric_applicant_income_ink)
# the density under income 400 is greater than the density upper 400
plot(log10(numeric_applicant_income_ink))
# the density upper 1.0 is greater than under 1.0 
plot(hist(numeric_applicant_income_ink))
# the mos frequent values is less than 200 
plot(density(numeric_applicant_income_ink))
# there is a right skewed 

# 3rd: numeric_hud_median_family_income 
plot(wf1$hud_median_family_income)
#the most greater values is where 88800 and 64000 and 54100 
plot(density(numeric_hud_median_family_income))
# the most peak values is density is 0.4 

# 4th:  numeric_tract_to_msamd_income_pct
plot(numeric_tract_to_msamd_income_pct)
# can't decide
plot(log10(numeric_tract_to_msamd_income_pct))
# the data upper of the 1.5 exists more than the lower of this value
plot(hist(numeric_tract_to_msamd_income_pct))
# the mos frequency data is up to 30000 and this is in the values of 2500 mainly 
plot(density(numeric_tract_to_msamd_income_pct))
# there is a left skewed in the density of the tract to msamd income pct

# 5th:  numeric_rate_spread
plot(numeric_rate_spread)
plot(log10(numeric_rate_spread))
# the data is spread over 1.0 more than less than 1.0
plot(hist(numeric_rate_spread))
# the most of values is around 700 and the frequency of it is 4e+05 
plot(density(numeric_rate_spread))
# the density is symmetric N = 445633 and bandwidth = 4.565

############# 2- relation between the applicant income and the loan amount 
cor.test(numeric_applicant_income_ink,numeric_loan_amount_ink)
# cor = 0.1873834 
# cor > 0 , so there is a small positive correlation between these 2 variables 
# which meaans that the more applicant income the more loan amount "slightly" 

############# 3-  Check whether the loan amount has any odd, multi-modal distribution
plot(as.factor(wf1$loan_amount_ink))
# there is multiple odds at 1 , 100 , 190  and 431 
plot(wf1$loan_amount_ink , wf1$loan_purpose)
# there is multi modals at 1 and 2 and 3 for loan purpose which indicates that we need to 
# a seprate model for each loan purpose
############# 4-  What is the loan purpose type that we need drop to make the experiment cleaner?
plot(hist(as.numeric(test3_wf1$loan_purpose)))

test1_wf1<- subset(wf1,wf1$loan_purpose !="Refinancing")
plot(as.factor(test1_wf1$loan_purpose))
plot(hist(as.numeric(test1_wf1$loan_purpose)))

test2_wf1<- subset(wf1,wf1$loan_purpose !="Home improvement")
plot(as.factor(test2_wf1$loan_purpose))
plot(hist(as.numeric(test2_wf1$loan_purpose)))

test3_wf1<- subset(wf1,wf1$loan_purpose !="Home purchase")
plot(as.factor(test3_wf1$loan_purpose))
plot(hist(as.numeric(test3_wf1$loan_purpose)))

# the data is more clear when we remove the Home improvement from it 

############# 5-  Look for spikes in the outputs
#plot(density(log(numeric_loan_amount_ink)))
#plot(density(log10(wf1$loan_amount_ink)))
#plot(density(log10(wf_test$loan_amount_ink)))

# to detect the spikes we use histogram
plot(hist(log10(numeric_loan_amount_ink)))
# there is a spike at mainly 10^(2.4) = 250 mainly

wf1_below<-subset(wf1,as.numeric(wf1$loan_amount_ink)<250)
plot(hist(log10(as.numeric(wf1_below$loan_amount_ink))))

wf1_beyond<-subset(wf1,as.numeric(wf1$loan_amount_ink)>250)
plot(hist(log10(as.numeric(wf1_beyond$loan_amount_ink))))


