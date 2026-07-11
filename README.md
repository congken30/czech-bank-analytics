# Czech Bank Analytics - Credit Risk & Customer Intelligence Platform 
End-to-end banking analytics project: SQL Server medallion architecture (Bronze → Silver → Gold) feeding a 12-page Power BI dashboard that answers 12 real business questions from 3 executive stakeholders — covering NPL monitoring, behavioral early-warning for loan default, customer segmentation, and cross-sell targeting.

## Dashboard  
<img width="45%" height="45%" alt="customer_lifetime_value" src="https://github.com/user-attachments/assets/6219e03b-e699-4da0-b84d-b3ea85651121" />
<img width="45%" height="45%" alt="regional_portfolio_overview" src="https://github.com/user-attachments/assets/9198f125-6d4b-4430-82cf-4c129c0d9acf" />
<img width="45%" height="45%" alt="loan_penetration" src="https://github.com/user-attachments/assets/cfc7e889-701d-4dcb-af7b-55aea4068ee8" />
<img width="45%" height="45%" alt="product_holding_ratio" src="https://github.com/user-attachments/assets/d5d3949d-bedb-4b5f-82dc-1c5dd214003b" />.
[View all 12 dashboard pages](dashboard/dashboard_image.md).

## Key Insights 
- Czech Bank has 4500 Account, but Top-100 lifetime value accounts for ($612M) nearly 10% of total volume ($6,361M).
- Only 15.6% of accounts hold a loan; loan uptake peaked at 4.36% in 1997, coinciding with the surge in new account openings.
- Just Top 50 High-Risk Borrowers accounted for 12.5% ($10M) of Total Loan Amount ($80M).

## Data Model - Galaxy Schema 
<img width="60%" height="60%" alt="image" src="https://github.com/user-attachments/assets/20008287-b28d-4f15-91b4-0a406525d62e" />.

Three fact tables (fact_trans,fact_loan, fact_orders) share conformed dimensions (dim_account, dim_client, dim_district, dim_date, dim_disp) - a galaxy schema. dim_account acts as a bridge enables cross-fact analysis.

## Stakeholders & Business Questions 
#### Q1-Q4 : regional MIS, product holding, dormancy detection, abnormal balance decline
#### Q5–Q8: NPL by segment, good-vs-bad loan comparison, concentration risk, behavioral distress flags
#### Q9–Q12: behavioral quadrant segmentation, Gold card target list, loan penetration, CLV top-100
Full requirement document with personas requests : [Full Requirement](docs/stakeholder_requirements.md).

## Repository Structure 
```
czech-bank-analytics/
├── [dashboard/]
│   ├── dashboard_image.md            # Exports of all 12 dashboard
│   └── czech_bank_analytics.pbix     # Power BI file
├── [datasets/](datasets/)            # Berka source CSVs
├── docs/
│   ├── stakeholder_requirements.md   # 3 personas, 12 business questions
│   └── Berka Data dictionary.pdf     # data dictionary
├── scripts/
│   ├── init_database.sql             # Create DB + bronze/silver/gold schemas
│   ├── bronze/                       # DDL + BULK INSERT load procedure
│   ├── silver/                       # DDL (PK/FK) + cleansing procedure
│   └── gold/                         # Galaxy schema views + dim_date
│   └── DAX_measure/                  # All 8 Table files TMDL DAX measures
```









