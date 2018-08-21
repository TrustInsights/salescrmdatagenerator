#############################################
#                                           #
# Sales CRM Dummy Data Generator            #
# Created by BrainTrust Insights, 2018      #
# Licensed under the GNU General Public     #
# License, Version 3.0 US. Full license is  #
# in the LICENSE file. Downloading or using #
# this software constitutes acceptance of   #
# the license in whole.                     #
#                                           #
# This software is provided as-is with      #
# absolutely no warranty or promise of...   #
# well, anything. Use at your own risk. No  #
# support of any kind is included.          #
#                                           #
# Author: Christopher S. Penn               #
# https://braintrustinsights.com/           #
#                                           #
#############################################

gc()
library(randomNames)

## Specify output file
salesfile <- "/PATH/TO/YOUR/DESKTOP/salesfile.csv" ## Configure for your machine
numRecords <-  as.integer(5000)
numReps <- as.integer(8)
numDays <- as.integer(50)

## Generate list of dummy companies first
company1 <- c("Great", "Popular", "Wonderful")
company2 <-
  c("Goods", "Services", "Products", "Enterprises", "Partners")
company3 <- c("Inc.", "LLC", "LLP")
companies <- expand.grid(company1, company2, company3)
companies$company <-
  paste(companies$Var1, companies$Var2, companies$Var3, sep = " ")
companylist <- as.character(companies$company)

## Create list of sales rep names
reps <-
  randomNames(
    numReps,
    which.names = "first",
    sample.with.replacement = FALSE,
    return.complete.data = FALSE
  )

## Create 500 rows of names
salesdatadf <- as.data.frame(
  randomNames(
    numRecords,
    sample.with.replacement = TRUE,
    return.complete.data = FALSE
  )
)

## Create CRM-like IDs
salesdatadf$userid = sample.int(100000000, numRecords)

## Create deal sizes in tens of thousands
salesdatadf$dealbasic = sample.int(10, numRecords, replace = TRUE)
salesdatadf$dealamount = as.integer(salesdatadf$dealbasic * 10000)
salesdatadf$dealbasic <- NULL

## Create prospect last Names
salesdatadf$lastname <-
  randomNames(
    numRecords,
    which.names = "last",
    sample.with.replacement = TRUE,
    return.complete.data = FALSE
  )

## Create prospect first Names

salesdatadf$firstname <-
  randomNames(
    numRecords,
    which.names = "first",
    sample.with.replacement = TRUE,
    return.complete.data = FALSE
  )

## Create random lead sources
salesdatadf$source <-
  sample(
    c(
      "Web",
      "Social",
      "Webinar",
      "Email",
      "Conference",
      "Trade Show",
      "Referral",
      "Paid Ads"
    ),
    numRecords,
    replace = TRUE
  )

## Create CRM-like sales statuses
salesdatadf$status <-
  sample(
    c(
      "Prospect",
      "Lead",
      "Opportunity",
      "Proposal",
      "Closed Won",
      "Closed Lost",
      "Negotiation",
      "Suspect"
    ),
    numRecords,
    replace = TRUE
  )

## Assign random reps
salesdatadf$rep <-
  sample(reps,
         numRecords,
         replace = TRUE)

## Assign random companies
salesdatadf$company <-
  sample(companylist,
         numRecords,
         replace = TRUE)

## Assign sales dates
salesdatadf$firstcontact <-
  sample(seq(as.Date('2012/01/01'), as.Date('2018/01/01'), by = "day"), numDays)

## Quantify closed won deals
salesdatadf$won <- ifelse(salesdatadf$status == "Closed Won", 1, 0)

## Eliminate first column (redundant)
salesdatadf[1] <- NULL

## Write output file
write.csv(salesdatadf, salesfile)
