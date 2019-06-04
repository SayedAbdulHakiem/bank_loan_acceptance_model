# bank_loan_acceptance_model
link to the data >> https://drive.google.com/open?id=18IKqjcUvv7O-ylI0AjZm128MpyQ6BHlO
________________project content _________________
Data processing phase
1- In RStudio , read the file "workflow1.txt" as a table(padat table).
2- In R, turn some of the codes into factors for those variables highlighted in workflow1
(page 144 step 2 in the pdf file of the labs), what is the importance of factorization? Plot
some of the variables you will create.
3- How many people were accepted in the Adams county.
4- From the query in Workflow 1(page 144 step 2 in the pdf file of the labs), we inserted the
income and other variables as VARCHAR , where it should be numeric, convert the needed
variables to numeric. Make sure that they are numeric using a function.
5- Remove records without income info.
6- Remove rows with nulls (NA) in Tract_To_MSAMD_Income_pct, Minority_Population_pct,
Tract_To_MSAMD_Income_pct.
Data Analysis phase
1- Visualize at least 5 variables and elaborate the results for each plot
2- Is there a relation between the applicant income and the loan amount, elaborate?
3- Check whether the loan amount has any odd, multi-modal distribution. This may suggest
to us that we might want to build separate models for the different loan purposes.
4- What is the loan purpose type that we need drop to make the experiment cleaner?
5- Look for spikes in the outputs. You may need to develop one model with all the data
below that spike and develop a separate model with the data beyond that spike ( You can
check this on the loan amount ink variable)
