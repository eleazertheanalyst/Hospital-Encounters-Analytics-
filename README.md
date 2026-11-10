# Hospital Encounters Analytics Dashboard Using SQL & Power BI

### Dashboard Link : https://app.powerbi.com/view?r=eyJrIjoiYmExN2JlOWItZDZlZS00YWVjLThkZTItNjM0N2RmODc5NmIxIiwidCI6ImViOGQyOTdiLTQyNWYtNDcyNy05N2QzLTkzNWE3NjlkNDhmOCJ9

## Project Overview

This project analyzes hospital encounter data to uncover trends in patient visits, healthcare costs, insurance coverage, and medical procedure utilization. The objective was to transform raw healthcare data into meaningful insights that support operational monitoring and financial decision-making.

Using MySQL for exploratory analysis and Power BI for reporting, I designed a two-page interactive dashboard that enables stakeholders to evaluate encounter duration, payer performance, high-cost procedures, and geographic distribution.

The final output provides clear, data-driven insights to support healthcare administrators in optimizing hospital operations, resource allocation, and revenue cycle management.

# Business Objective
The primary objective of this analysis was to:
- Analyze hospital encounter trends over time
- Understand the distribution of encounter types and duration (Over 24 Hours vs Under 24 Hours)
- Identify counties and cities with the highest patient activity
- Analyze healthcare claim costs and payer coverage gaps
- Identify the most frequently performed and highest-cost procedures
- Provide actionable recommendations to optimize hospital operations and healthcare spending


### Steps followed 
- Step 1 : **Data Loading:** Imported the hospital dataset into MySQL for initial query development and connected Power BI to the database to pull fact and dimension tables.
- Step 2 : Reviewed the dataset using column profiling tools to inspect encounters, patients, procedures, payers, and organization structures.
- Step 3 : **Data Cleaning:** Removed duplicate records where necessary, validated primary keys, and ensured data consistency across related tables.
- Step 4 : **Data Type Validation:** Verified that date, numerical, and categorical fields were correctly formatted (e.g., encounter start/stop timestamps, claim amounts).
- Step 5 : **SQL Data Exploration:** Executed exploratory queries in MySQL to analyze encounter counts, class distributions, average costs, and procedure frequencies.
- Step 6 : **Business Query Development:** Formulated structured SQL queries to answer core operational and financial performance questions.
- Step 7 : **Data Integration & Modeling:** Established relationships between fact and dimension tables within Power BI to build a scalable star-schema model.
- Step 8 : **Date Modeling:** Created a dedicated Calendar table to enable dynamic year-over-year trend analysis and time intelligence calculations.
- Step 9 : **Theme Selection:** Applied a clean, executive layout with consistent color palettes and typography to enhance readability across both report pages.
- Step 10 : **KPI Card Visuals:** Placed KPI cards across the top of both pages to highlight critical metrics (Total Encounters, Total Patients, Average Duration, Total Claim Cost, Zero Coverage Encounters).
- Step 11 : **Interactive Slicers:** Added slicers for Year, Encounter Class, Payer, Gender, and State to enable dynamic cross-filtering for deeper segment analysis.
- Step 12 : **Custom Visual Implementation:** Configured line charts for multi-year trends, horizontal bar charts for top procedures and payers, donut charts for coverage splits, and dynamic tooltips.
- Step 13 : **Total Encounters Measure:** Developed a DAX measure to calculate total hospital visit volume.
    ```
    Total Encounters = COUNT(encounters[ID]) 
    ```

- Step 14 : **Total Patients Measure:** Created a DAX measure using DISTINCTCOUNT to evaluate total unique patients.
    ```
    Total Patients = DISTINCTCOUNT(patients[Id])
    ```

        
- Step 15 : **Average Encounter Duration Calculation:** Defined a measure using AVERAGEX and DATEDIFF to calculate average stay duration in hours.

    ```
    Average Encounter Duration = AVERAGEX(encounters, DATEDIFF(encounters[START D], encounters[STOP D], HOUR))
    ```

        
 - Step 16 : **Total Claim Cost Calculation:** Implemented a DAX measure using SUM to calculate total healthcare claim costs.
 
    ```
    Total Claim Cost = SUM(encounters[TOTAL_CLAIM_COST])
    ```

 
 - Step 17 : **Average Claim Cost Calculation:** Implemented a DAX measure using AVERAGE to evaluate mean claim cost per encounter.
 
    ```
    Average Claim Cost = AVERAGE(encounters[TOTAL_CLAIM_COST])
    ```

 
 - Step 18 : **Zero Coverage Encounters Calculation:** Created a measure using CALCULATE and COUNTROWS to flag encounters with zero insurance coverage.
 
    ```
    Zero Coverage = CALCULATE(COUNTROWS(encounters), encounters[PAYER_COVERAGE]=0)
    ```

 
 - Step 19 : **City Patient Summary Calculation:** Engineered a DAX measure using ALL and FORMAT to compute dynamic patient percentages for hover tooltips.
 
    ```
    City Patient Summary = 
    VAR TotalPatientsInCity = DISTINCTCOUNT(patients[Id])
    VAR TotalPatientsOverall = CALCULATE(DISTINCTCOUNT(patients[Id]), ALL(patients))
    VAR PatientPct = DIVIDE(TotalPatientsInCity, TotalPatientsOverall)
    VAR SelectedCityName = SELECTEDVALUE(patients[CITY], "This city")
    RETURN SelectedCityName & " represents " & FORMAT(PatientPct, "0.0%") & " of total unique patients."
    ```

 
 - Step 20 : **Dashboard Layout Design:** Multi-page architecture structured into "Hospital Encounters Overview" for operational metrics and "Cost & Coverage Analysis" for financial performance.
 
 - Step 21 : The report was then published to Power BI Service.
<img width="493" height="296" alt="Image" src="https://github.com/user-attachments/assets/b02e5fc0-cf1d-40e0-9fb6-c0acafe3869c" />

# Snapshot of Dashboard (Power BI Service)

<img width="1906" height="935" alt="Image" src="https://github.com/user-attachments/assets/8cc56a57-0b83-48af-9d5f-2a10363181cc" />

 
# Report Snapshot (Power BI DESKTOP)

#### Hospital Encounters Overview
<img width="1158" height="803" alt="hospital encounters" src="https://github.com/user-attachments/assets/fca77ccb-8590-426f-a89e-768fe0e8ff7b" />

#### Cost & Coverage Analysis
<img width="1157" height="815" alt="cost and coverage" src="https://github.com/user-attachments/assets/b7ba014c-35c3-4535-9439-15034f9b8b1a" />

# Key Insights & Analytical Findings
### Overall Workforce & Hospital Metrics
- Total Encounters: 27,674
- Total Patients: 974
- Average Stay Duration: 7 hours (99.7% under 24 hours)

This indicates an operational model overwhelmingly dominated by outpatient, ambulatory, and short-term emergency visits.

### Multi-Year Trend Insights
- Encounter volume peaked in 2014 (3.9K visits) and surged again in 2021 (3.5K visits)
- Total claim costs reached $101M over the analysis period, mirroring encounter volume peaks ($12.0M in 2014)

Inference:
System demand experiences multi-year cyclical surges that directly drive overall financial spend.

### Geographic Distribution Impact
- Suffolk County represents 17,834 encounters (64% of total volume)
- Boston accounts for 541 out of 974 total unique patients (55.5%)
- Secondary hubs include Quincy (80 patients) and Cambridge (45 patients)

Inference: Operational load is highly concentrated within specific urban hubs, requiring targeted resource deployment rather than uniform expansion.

### Procedure Distribution & Utilization
- Behavioral health assessments lead procedure volume, with Depression Screenings totaling 7,192 procedures
- Routine screenings (health/social care, anxiety, substance use) dominate day-to-day operational throughput
- Chronic and specialized procedures like Hospice Care (4,098) and Renal Dialysis (2,715) account for continuous utilization

Inference: Routine assessments drive high volume, whereas specialized care demands higher sustained clinical resources.

### Cost vs Coverage Analysis
- 13,500 encounters (48.78%) received zero payer coverage
- Medicaid ($6.2K) and No Insurance ($5.6K) yield the highest average claim costs per encounter
- Fully covered encounters represent 51.22% (14,174 encounters)

**Inference:** Nearly half of all encounters represent potential uncompensated care risk, creating revenue exposure for the healthcare system.

# Business Recommendations

**Based on the analysis:**
- Implement automated pre-discharge insurance screening to reduce the 48.78% zero-coverage rate by enrolling eligible patients in Medicaid/Medicare
- Digitally standardize high-volume behavioral health screenings into pre-visit intake forms to lower clinical overhead
- Focus capital allocation and staffing expansion specifically on Suffolk County and Boston facilities
- Streamline fast-track triage processes to optimize throughput for short (<24 hr) stays
- Review reimbursement structures for high-cost payers (Medicaid and No Insurance) to safeguard hospital margins

# Technical Skills Demonstrated
- **ETL & SQL Exploration:** MySQL queries for joins, window functions, and business data checks
- **Data Modeling:** Star-schema design, relationship management, and date dimension creation
- **DAX Calculations:** Dynamic KPI measures, context modifiers (`ALL`, `CALCULATE`), and string formatting
- **Data Visualization:** Multi-page executive dashboard layout, slicers, and custom report page tooltips
- **Healthcare Analytics:** Evaluating operational throughput, uncompensated care, and procedure cost distribution
