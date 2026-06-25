# czech-bank-analytics

## Stakeholder Business Questions

### Stakeholder 1: Director of Retail Banking — Nguyen Van Hung

**Context**: Owns KPIs for customer acquisition, product holding ratio, and fee-based revenue. Non-technical — consumes dashboards and summary reports only.
##### Q1 — Regional Portfolio Overview (Monthly MIS Report)
"I need a regional breakdown of our account portfolio: total accounts, new accounts opened per year, average account balance, and average monthly transaction frequency. I want to see which regions are growing and which ones are flatlining."

#### Q2 — Product Holding Ratio by Age Group
"Out of our entire customer base, what percentage currently holds a card? What percentage has an active loan? What percentage has set up standing orders? Break this down by age group — I need to see where our cross-sell gaps are."

#### Q3 — Dormant Account Detection
"How many accounts have had zero transaction activity in the last 90 days? Break it down by region and statement frequency type. I need this number for the Board report on active account ratio."

#### Q4 — Abnormal Balance Decline (Attrition Early Warning)
"Pull me a list of accounts where the current balance has dropped more than 50% compared to their 6-month rolling average. I suspect some customers are moving their deposits to competitors."

### Stakeholder 2: Director of Credit Risk — Tran Thi Mai

**Context**: Responsible for NPL ratio management, early warning model development, and regulatory reporting to the State Bank. Data-literate — needs the analytics team to prepare datasets and flag anomalies.
#### Q5 — NPL Ratio Overview by Segment
"What is the current non-performing loan ratio across the entire loan book? Break it down by region and by loan tenor. Specifically, I need a separate view for matured loans (status A and B) versus outstanding loans (status C and D) — I want to see the asset quality of the current live portfolio, not just the historical average."

#### Q6 — Risk Factor Comparison: Good vs. Bad Loans
"Run a comparative analysis between non-performing loans (status B and D) and performing loans. I need the following metrics compared side by side: average account balance prior to disbursement, payment-to-income ratio (use district average salary as an income proxy), average monthly transaction count, card ownership, and standing order activity. Give me a clean two-column comparison table."

#### Q7 — Portfolio Concentration Risk
"Show me the top 10 districts by total outstanding loan exposure, along with each district's NPL ratio and unemployment rate. I'm concerned about concentration risk — if we're overexposed to an economically distressed area, that's a problem waiting to happen."

#### Q8 — Behavioral Early Warning for Active Loans
"For all currently outstanding loans (status C and D), flag borrowers showing distress signals: account balance on a declining trend for 3 consecutive months, OR a sudden spike in the withdrawal-to-total-transaction ratio. These are leading indicators of potential default."

### Stakeholder 3: Director of Marketing & Customer Development — Le Minh Duc
Context: Needs customer segments for targeted campaigns, cross-sell pipeline, and marketing ROI optimization. Asks questions in the format "who are the right customers for product X."

#### Q9 — Behavioral Customer Segmentation
"Segment our customer base by transaction behavior into four quadrants: high-frequency high-balance (VIP), high-frequency low-balance (mass active), low-frequency high-balance (sleeping affluent), low-frequency low-balance (dormant). For each segment, give me the headcount, age distribution, gender split, and regional breakdown."

#### Q10 — Gold Card Cross-Sell Target List
"I'm launching a Gold credit card upgrade campaign. Pull me a list of customers who either have no card or currently hold a Junior or Classic card, but whose transaction behavior qualifies them for an upgrade. Qualification criteria: average balance above the system-wide median, at least 10 transactions per month, and no history of loan default."

### Q11 — Loan Penetration by Demographics
"Which customer segment has the highest loan uptake rate? Break it down by gender, age group (18–25, 26–35, 36–45, 46–60, 60+), and region. I need this to decide the target audience for next quarter's consumer lending campaign."

### Q12 — Customer Lifetime Value Proxy and Top-100 Profile
"Calculate a lifetime value proxy for each customer based on total transaction volume and outstanding loan balance. Rank the top 100 most valuable customers and give me their profile: age, gender, region, and number of products held. I want to understand the common characteristics of our highest-value customers."

