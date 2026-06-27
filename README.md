# czech-bank-analytics
End-to-end data analytics project built on the Berka dataset (PKDD'99 Discovery Challenge) — a real, anonymized Czech bank dataset covering accounts, transactions, loans, and demographics from 1993–1998.

The project simulates a retail banking analytics engagement: from raw data ingestion through a medallion architecture (Bronze → Silver → Gold) in SQL Server, to interactive Power BI dashboards answering stakeholder-driven business questions.

### Tech stack: SQL Server · SSMS · T-SQL · Power BI · DAX


### Business Context

Instead of exploring data aimlessly, this project starts from stakeholder requirements. Three personas drive the analysis:

PersonaFocus AreaRetail Banking DirectorRegional portfolio overview, account growth, product penetrationCredit Risk DirectorLoan default patterns, risk segmentation by district and demographicsMarketing DirectorCustomer segmentation, cross-sell opportunities, campaign targeting

These personas generate 12 business questions documented in [Xem tài liệu hướng dẫn]([docs/stakeholder-requirements.md](https://github.com/congken30/czech-bank-analytics/blob/main/docs/stakeholder_requirements.md))
, which serve as the project's analytical roadmap.

## Data Architecture

The pipeline follows a medallion architecture to separate concerns and ensure data quality at each stage:

Raw CSVs ──► Bronze (staging) ──► Silver (cleaned) ──► Gold (analytics-ready)

### Bronze Layer


Raw data loaded as-is from 8 CSV files (account, client, disp, district, trans, loan, order, card)
No transformations — preserves source fidelity for auditability


### Silver Layer


Data type corrections (dates, numerics)
Czech-to-English column/value translations
Null handling and deduplication
Referential integrity validation

### Gold Layer 
<img width="960" height="672" alt="image" src="https://github.com/user-attachments/assets/acc313ca-2eb9-4ece-a1f3-ccadda206626" />


