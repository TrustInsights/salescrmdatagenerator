#############################################
#                                           #
# Sales CRM Dummy Data Generator            #
# Created by Trust Insights, 2018-2024      #
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
# https://trustinsights.ai/                 #
#                                           #
#############################################

#############################################
# SYSTEM AND LIBRARIES
#############################################

library(pacman)
p_load(
  lubridate,
  janitor,
  randomNames,
  stringi,
  tidyverse
)

#############################################
# CONFIGURATION
#############################################


#############################################
# FILE BASED DEPENDENCIES
#############################################


#############################################
# FUNCTIONS
#############################################

# Define sales note components (mad-lib style)
initial_outreach_methods <- c(
  "Initial outreach via LinkedIn.",
  "Initial outreach via email.",
  "Prospect contacted us through the contact form on our website.",
  "Initial outreach via phone call.",
  "Initial connection made via direct message.",
  "Initial contact via text message.",
  "Contact originated from our call center."
)

initial_contact_notes <- c(
  "{outreach_method} Prospect expressed interest in our {service}. Scheduled a discovery call for {date} to discuss their specific needs.",
  "{outreach_method} Cold call to {title} at prospect company. Confirmed they're the decision-maker for consulting engagements. Brief discussion about their current challenges with {challenge}.",
  "{outreach_method} Attended {event} and met with {title}. They're exploring options to improve their {area_of_improvement} and mentioned our competitor, {competitor}. Follow-up email sent."
)

# Define sales note components (mad-lib style)
initial_contact_notes <- c(
  "Initial outreach via LinkedIn. Prospect expressed interest in our {service}. Scheduled a discovery call for {date} to discuss their specific needs.",
  "Cold call to {title} at prospect company. Confirmed they're the decision-maker for consulting engagements. Brief discussion about their current challenges with {challenge}.",
  "Attended {event} and met with {title}. They're exploring options to improve their {area_of_improvement} and mentioned our competitor, {competitor}. Follow-up email sent."
)

discovery_notes <- c(
  "Discovery call completed. Key takeaways: Prospect company is facing {challenge}. They seem open to a strategic assessment.",
  "Shared our company overview and case studies relevant to their industry. {title} is particularly interested in understanding how we measure ROI on our engagements.",
  "Sent a proposal request template for them to fill out to get a better sense of the scope of the project they envision and their budget."
)

proposal_notes <- c(
  "Proposal for {project_name} sent. Highlighted our experience in {industry} and the value proposition of our data-driven approach. Awaiting feedback by {date}.",
  "Follow-up call after proposal submission. {title} had some questions about the pricing model and deliverables timeline. Addressed their concerns and will revise the proposal accordingly.",
  "Second proposal iteration sent with adjusted pricing and timeline. Meeting scheduled for {date} to discuss next steps."
)

challenge_notes <- c(
  "Call with {title} to address their concerns about {specific_concern}. Reassured them about our commitment to delivering results and agreed on a plan of action.",
  "Competitor, {competitor}, is also bidding for this project. We need to emphasize our unique strengths and tailor our approach to win this deal.",
  "Budget constraints are a major concern. Exploring alternative solutions and scoping options to fit their financial limitations."
)

positive_notes <- c(
  "Strong buy-in from the prospect team. They're impressed with our consultant's expertise and proactive communication.",
  "{title} requested a meeting to discuss expanding the project scope to include {new_area}.",
  "Positive feedback received on the latest deliverables. Prospect is seeing tangible improvements in {area_of_improvement}."
)

# Function to generate a random sales note
generate_sales_note <- function(deal_status) {
  # Avoid notes for closed won deals
  if (deal_status == "Closed Won") {
    return("")
  }
  
  # Combine note components randomly
  note_components <- c(
    sample(initial_contact_notes, 1),
    sample(initial_contact_notes, 1),
    if (runif(1) < 0.6)
      sample(discovery_notes, 1),
    # 60% chance of discovery note
    if (runif(1) < 0.5)
      sample(proposal_notes, 1),
    # 50% chance of proposal note
    if (runif(1) < 0.3)
      sample(challenge_notes, 1),
    # 30% chance of challenge
    if (runif(1) < 0.7)
      sample(positive_notes, 1)  # 70% chance of positive note
  )
  
  # Fill in the blanks (mad-lib style)
  note <- glue::glue_collapse(note_components, sep = " ")
  note <- glue::glue(
    note,
    outreach_method = sample(initial_outreach_methods, 1),
    # Add outreach method
    service = sample(
      c(
        "digital transformation services",
        "supply chain optimization",
        "customer experience design",
        "change management consulting",
        "AI consulting",
        "analytics consulting",
        "data science consulting",
        "marketing strategy",
        "product market fit"
      ),
      1
    ),
    date = sample(seq(Sys.Date() + 7, Sys.Date() + 30, by = "day"), 1),
    title = sample(c(
      "CEO", "CFO", "CTO", "VP", "Director", "Manager"
    ), 1),
    challenge = sample(
      c(
        "declining sales",
        "high employee turnover",
        "supply chain disruptions",
        "difficulty adapting to remote work",
        "increased competition",
        "shortage of qualified workers",
        "cost reduction",
        "market expansion",
        "digital transformation",
        "merger"
      ),
      1
    ),
    event = sample(
      c(
        "Industry Conference",
        "Networking Event",
        "Webinar",
        "Trade Show",
        "Coregistration Event",
        "Sales Sinner"
      ),
      1
    ),
    area_of_improvement = sample(
      c(
        "customer experience",
        "operational efficiency",
        "data analytics capabilities",
        "profit margins",
        "AI implementation",
        "change management"
      ),
      1
    ),
    competitor = sample(c(
      "McKinsey", "BCG", "Bain", "Deloitte", "KPMG", "IBM IX"
    ), 1),
    project_name = sample(
      c(
        "Strategic Assessment",
        "Digital Transformation Roadmap",
        "Customer Journey Optimization",
        "AI Roadmap",
        "Analytics Audit",
        "Exploratory Data Analysis"
      ),
      1
    ),
    industry = sample(
      c(
        "Technology",
        "Financial Services",
        "Healthcare",
        "Manufacturing",
        "Defense",
        "SaaS Software",
        "Agriculture",
        "Construction",
        "Engineering",
        "Retail",
        "Insurance",
        "Real Estate",
        "Education",
        "Hospitality"
      ),
      1
    ),
    specific_concern = sample(
      c(
        "project timeline",
        "budget allocation",
        "team's availability",
        "team's skills'",
        "our qualifications",
        "testimonials"
      ),
      1
    ),
    new_area = sample(
      c(
        "market research",
        "process automation",
        "data visualization",
        "generative AI",
        "large language models",
        "AI image generation",
        "product market fit",
        "change management"
      ),
      1
    )
  )
  return(note)
}


#############################################
# START CODE HERE
#############################################

# Function to generate synthetic CRM data
generate_crm_data <- function(n = 5000) {
  # Generate first names, last names, and genders
  names_gender <- randomNames(n, which.names = "both", return.complete.data = TRUE)
  
  # Generate random company names
  prefixes <-
    c(
      "Info",
      "Techno",
      "Eco",
      "Global",
      "Ultra",
      "Mega",
      "Super",
      "Net",
      "Trans",
      "AI",
      "Farm",
      "High",
      "Edu",
      "Secure"
    )
  roots <-
    c(
      "Sys",
      "Comp",
      "Net",
      "Soft",
      "Hard",
      "Tech",
      "Logix",
      "Solve",
      "Ware",
      "Com",
      "Quest",
      "Mart",
      "Market",
      "Store"
    )
  suffixes <- c("Inc", "LLC", "Corp", "Ltd", "Group", "LLP")
  company_names <- paste0(
    sample(prefixes, n, replace = TRUE),
    sample(roots, n, replace = TRUE),
    " ",
    sample(suffixes, n, replace = TRUE)
  )
  
  # Generate annual revenue and proportional numbers
  annual_revenue <- round(runif(n, 1e6, 1e8), digits = 0)
  num_employees <- pmin(round(annual_revenue / 2e4), 5000)
  deal_size <- pmin(round(annual_revenue / 2e2), 5e5)
  num_opens <- round(runif(n, 1, 80), digits = 0)
  
  # Generate dates
  date_last_contacted <-
    Sys.Date() - sample(7:180, n, replace = TRUE)
  
  # Top 15 nations by GDP in 2021
  countries <-
    c(
      "USA",
      "China",
      "Japan",
      "Germany",
      "India",
      "UK",
      "France",
      "Brazil",
      "Italy",
      "Canada",
      "Ukraine",
      "South Korea",
      "Spain",
      "Australia",
      "Mexico"
    )
  company_location <- sample(countries, n, replace = TRUE)
  
  # ==== ADJUSTED CODE START ====
  
  # Function to sample job titles based on revenue
  sample_title_by_revenue <- function(revenue) {
    if (revenue <= 5e6) {
      # Smaller companies
      job_titles <- c("CEO", "Manager", "Marketing Coordinator")
      title_probs <- c(0.1, 0.3, 0.6)
    } else if (revenue <= 5e7) {
      # Medium companies
      job_titles <- c("CEO", "VP", "Director", "Manager", "Marketing Associate")
      title_probs <- c(0.05, 0.1, 0.15, 0.3, 0.4)
    } else {
      # Larger companies
      job_titles <- c("CEO",
                      "VP",
                      "Director",
                      "Senior Manager",
                      "Manager",
                      "Marketing Coordinator")
      title_probs <- c(0.02, 0.05, 0.1, 0.15, 0.4, 0.28)
    }
    sample(job_titles, 1, prob = title_probs)
  }
  
  # Use purrr::map_chr to apply the function to each revenue value
  title <- purrr::map_chr(annual_revenue, sample_title_by_revenue)
  
  # ==== ADJUSTED CODE END ====
  
  
  
  # Generate email addresses
  email_addresses <-
    tolower(paste0(
      substr(names_gender$first_name, 1, 1),
      names_gender$last_name,
      "@",
      gsub(" ", "", company_names),
      ".com"
    ))
  
  # NAICS top-level industries
  industries <-
    c(
      "Agriculture",
      "Mining",
      "Construction",
      "Manufacturing",
      "Wholesale Trade",
      "Retail Trade",
      "Transportation",
      "Information",
      "Finance",
      "Real Estate",
      "Professional",
      "Management",
      "Education",
      "Health Care",
      "Arts"
    )
  industry <- sample(industries, n, replace = TRUE)
  
  # Create the dataframe
  crm_data <- data.frame(
    FirstName = names_gender$first_name,
    LastName = names_gender$last_name,
    Gender = names_gender$gender,
    Title = title,
    # Use the conditionally generated titles
    CompanyName = company_names,
    AnnualRevenue = annual_revenue,
    NumEmployees = num_employees,
    DateLastContacted = date_last_contacted,
    CompanyLocation = company_location,
    EmailAddress = email_addresses,
    DealSize = deal_size,
    Industry = industry,
    NumOpens = num_opens,
    DaysSince = as.numeric(today() - date_last_contacted)
  )
  
  crm_data$DealStatus <- case_when(
    crm_data$DateLastContacted >= Sys.Date() - 180 &
      crm_data$DateLastContacted <= Sys.Date() - 150 ~ "Suspect",
    crm_data$DateLastContacted > Sys.Date() - 150 &
      crm_data$DateLastContacted <= Sys.Date() - 120 ~ "Prospect",
    crm_data$DateLastContacted > Sys.Date() - 120 &
      crm_data$DateLastContacted <= Sys.Date() - 90 ~ "Lead",
    crm_data$DateLastContacted > Sys.Date() - 90 &
      crm_data$DateLastContacted <= Sys.Date() - 30 ~ "Opportunity",
    crm_data$DateLastContacted > Sys.Date() - 30 &
      crm_data$DateLastContacted <= Sys.Date() - 7 ~ "Closed Won",
    TRUE ~ "Closed Lost"
  )
  
  # Generate sales notes (ensuring no duplicates)
  generate_unique_sales_notes <- function(n, deal_statuses) {
    unique_notes <- character(0)
    while (length(unique_notes) < n) {
      new_notes <- replicate(n - length(unique_notes), generate_sales_note(sample(deal_statuses, 1)))
      unique_notes <- unique(c(unique_notes, new_notes))
    }
    unique_notes
  }
  
  sales_notes <- generate_unique_sales_notes(n, crm_data$DealStatus)
  
  crm_data$SalesNotes <- sales_notes
  
  return(crm_data)
}

# Generate the CRM data
crm_data <- generate_crm_data()

# Write to CSV
write_csv(crm_data, "output/synthetic_crm_data.csv")

## Now let's do synthetic RFM

rfm_df <-  crm_data |>
  select(EmailAddress, NumOpens, DaysSince, DealSize)

write_csv(rfm_df, "output/synthetic_rfm_data.csv")
