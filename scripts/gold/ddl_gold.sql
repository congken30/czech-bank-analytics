/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

IF OBJECT_ID ('gold.dim_date','V') is not null 
	DROP VIEW gold.dim_date;
IF OBJECT_ID ('gold.dim_account','V') is not null 
	DROP VIEW gold.dim_account;
IF OBJECT_ID ('gold.dim_client','V') is not null 
	DROP VIEW gold.dim_client;
IF OBJECT_ID ('gold.dim_district','V') is not null 
	DROP VIEW gold.dim_district;
IF OBJECT_ID ('gold.fact_trans','V') is not null 
	DROP VIEW gold.fact_trans;
IF OBJECT_ID ('gold.fact_loan','V') is not null 
	DROP VIEW gold.fact_loan;
IF OBJECT_ID ('gold.fact_orders','V') is not null 
	DROP VIEW gold.fact_orders;
GO 

-- =============================================================================
-- Create Dimension: gold.dim_account
-- =============================================================================
CREATE VIEW gold.dim_account AS 
SELECT 
	account_id	as AccountID,
	district_id	as DistrictID,
	frequency		as Frequency,
	date			as Date
FROM silver.account a
GO

-- =============================================================================
-- Create Dimension: gold.dim_disp
-- =============================================================================
CREATE VIEW gold.dim_disp AS 
SELECT 
	dp.disp_id		as DispositionID,
	dp.client_id	as ClientID,
	dp.account_id	as AccountID,
	dp.type			as DispositionType,
	c.card_id		as CardID,
	c.type			as CardType,
	c.issued		as IssuedDate
FROM silver.disp dp
LEFT JOIN silver.card c
ON dp.disp_id = c.disp_id
GO

-- =============================================================================
-- Create Dimension: gold.dim_client
-- =============================================================================
CREATE VIEW gold.dim_client AS 
SELECT 
	client_id		as ClientID,
	birth_date		as BirthDate,
	gender			as Gender,
	district_id		as DistrictID
FROM silver.client
GO

-- =============================================================================
-- Create Dimension: gold.dim_district
-- =============================================================================
CREATE VIEW gold.dim_district AS 
SELECT 
    district_id                 AS DistrictID,
    district_name               AS DistrictName,
    region                      AS Region,
    population                  AS Population,
    num_cities                  AS NumCities,
    urban_ratio                 AS UrbanRatio,
    avg_salary                  AS AverageSalary,
    unemployment_rate_95        AS UnemploymentRate95,
    unemployment_rate_96        AS UnemploymentRate96,
    entrepreneurs_per_1000      AS EntrepreneursPer1000,
    crimes_95                   AS Crimes95,
    crimes_96                   AS Crimes96
FROM silver.district
GO

-- =============================================================================
-- Create Fact Table : gold.fact_trans
-- =============================================================================
CREATE VIEW gold.fact_trans AS 
SELECT 
	tr.trans_id			as TransactionID,
	tr.account_id		as AccountID,
	tr.date				as TransactionDate,
	tr.type				as TransactionType,
	tr.operation		as Operation,
	tr.amount			as Amount,
	tr.balance			as Balance,
	tr.k_symbol			as TransactionCategory,
	tr.bank				as BankOfPartner,
	tr.account			as AccountOfPartner
FROM silver.trans tr
GO

-- =============================================================================
-- Create Fact Table : gold.fact_loan
-- =============================================================================
CREATE VIEW gold.fact_loan AS 
SELECT 
	l.loan_id				as LoanId,
	l.account_id			as AccountID,
	l.date					as LoanDate,
	l.amount				as LoanAmount,
	l.duration				as LoanDuration,
	l.payments				as LoanPayments,
	l.status				as LoanStatus
FROM silver.loan l
GO

-- =============================================================================
-- Create Fact Table : gold.fact_orders
-- =============================================================================
CREATE VIEW gold.fact_orders AS 
SELECT 
	o.order_id			as OrderID,
	o.account_id		as AccountID,
	o.bank				as BankOfRecipient,
	o.account			as AccountOfRecipient,
	o.amount			as AmountOfMoney,
	o.k_symbol			as PaymentType
FROM silver.orders o
GO

-- =============================================================================
-- Create Dimension Table : gold.dim_date
-- =============================================================================
CREATE VIEW gold.dim_date AS
SELECT DISTINCT
    CAST(date AS DATE)                          AS Date,
    YEAR(date)                                  AS Year,
    MONTH(date)                                 AS Month,
    FORMAT(date, 'yyyy-MM')                     AS YearMonth,
    DATENAME(MONTH, date)                       AS MonthName,
    DATEPART(QUARTER, date)                     AS Quarter
FROM (
    SELECT date FROM silver.trans
    UNION
    SELECT date FROM silver.account
    UNION
    SELECT date FROM silver.loan
) AS all_dates




