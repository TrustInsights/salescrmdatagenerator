# Synthetic CRM and RFM Data Generator

## Overview

This R script generates synthetic CRM (Customer Relationship Management) and RFM (Recency, Frequency, Monetary Value) data. It's a useful tool for:

* **Data Scientists and Analysts:**  Get a realistic dataset for experimenting with CRM analytics, customer segmentation, marketing campaign simulations, and more, without needing to use real (and potentially sensitive) customer data. 
* **Students and Learners:** Practice data analysis techniques on a CRM-like dataset, understand typical CRM data structures, and explore RFM analysis concepts. 
* **Anyone Building CRM Applications:** Use the generated data for testing or prototyping purposes during development.

## Features

* **Synthetic CRM Data:**
    * Generates a configurable number of customer records.
    * Includes fields like first name, last name, gender, job title, company name, annual revenue, number of employees, location, email address, deal size, industry, number of email opens, and days since last contact.
    * Calculates deal status (e.g., Suspect, Prospect, Lead, Opportunity, Closed Won, Closed Lost) based on last contact date.
    * Creates realistic sales notes for each customer, with variations based on deal status and initial outreach method.
* **Synthetic RFM Data:**
    * Extracts relevant fields (email address, number of opens, days since last contact, deal size) to create an RFM dataset.
    * Enables direct application of RFM analysis techniques.
* **Customizable:**
    * Easily adjust parameters to control the number of records, revenue ranges, company sizes, job titles, and more.
    * Add or modify sales note templates to create a wider range of scenarios.

## Getting Started

1. **Prerequisites:**
    * **R:** Ensure that you have R installed on your system.
2. **Clone or Download:** Clone this repository or download the code as a ZIP file.
3. **Set the Output Folder:** Ensure there's a folder named `output` in the script's directory.
4. **Run the Script:** Execute the `generator.R` script in your R environment.
5. **Output:** The generated CRM and RFM data will be saved as CSV files (`synthetic_crm_data.csv` and `synthetic_rfm_data.csv`) in the `output` folder.

## Customization

You can easily tailor the generated data to your needs:

* **Number of Records:** Modify the `n` parameter in the `generate_crm_data()` function.
* **Sales Note Templates:**  Add, edit, or remove note templates in the `initial_contact_notes`, `discovery_notes`, `proposal_notes`, etc., vectors.  
* **Company Attributes:** Adjust revenue ranges, company size parameters, and job title probabilities to reflect your target demographics. 

## Contributing

We welcome contributions! If you have ideas for improvements, new features, or find any issues, please feel free to open an issue or submit a pull request.

## Learn More

Want to learn more about the data science, analytics, and AI services Trust Insights offers? [Visit us on our website](https://www.trustinsights.ai) or check out our [podcast](https://www.trustinsights.ai/tipodcast) or our [YouTube channel](https://www.trustinsights.ai/youtube).
