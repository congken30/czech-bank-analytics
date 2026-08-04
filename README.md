# Czech Bank Analytics - Credit Risk & Customer Intelligence Platform 
End-to-end banking analytics project: SQL Server medallion architecture (Bronze → Silver → Gold) feeding a 12-page Power BI dashboard that answers 12 real business questions from 3 executive stakeholders — covering NPL monitoring, behavioral early-warning for loan default, customer segmentation, and cross-sell targeting.

## Dashboard  
<img width="45%" height="45%" alt="Screenshot 2026-08-04 081650" src="https://github.com/user-attachments/assets/61a5db0e-75b1-4e70-9865-24d247d81d4c" />
<img width="45%" height="45%" alt="Loan Penetration" src="https://github.com/user-attachments/assets/37b66626-ee99-4e77-8c94-a8cc60c5706c" />
<img width="45%" height="45%" alt="Customer Lifetime Value" src="https://github.com/user-attachments/assets/75ea0388-e011-45f1-853e-927f3796b7c9" />
<img width="45%" height="45%" alt="Product Holding Ratio" src="https://github.com/user-attachments/assets/7d2e3d30-1cc2-47d5-8239-e4fef13866fb" />

→ [View all 12 dashboard pages](dashboard/dashboard_image.md)

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









