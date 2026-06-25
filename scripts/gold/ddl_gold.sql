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
	a.account_id	as AccountID,
	dp.disp_id		as DispositionID,
	a.district_id	as DistrictID,
	cd.card_id		as CardID,
	dp.client_id	as ClientID,
	a.frequency		as Frequency,
	a.date			as Date,
	dp.type			as DispositionType,
	cd.type			as CardType
FROM silver.account a
LEFT JOIN silver.disp dp
ON a.account_id = dp.account_id
LEFT JOIN silver.card cd
ON dp.disp_id = cd.disp_id
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
	district_id		as DistrictID,
	district_name	as DistrictName,
	region			as Region,
	population		as Population,
	avg_salary		as AverageSalary
FROM silver.district
GO

-- =============================================================================
-- Create Fact Table : gold.fact_trans
-- =============================================================================
CREATE VIEW gold.fact_trans AS 
SELECT 
	tr.trans_id			as TransactionID,
	tr.account_id		as AccountID,
	ddt.DistrictName,
	ddt.Region,
	ddt.AverageSalary,
	tr.date				as TransactionDate,
	tr.type				as TypeOfTransaction,
	tr.operation		as Operation,
	tr.amount			as Amount,
	tr.balance			as Balance,
	tr.k_symbol			as CharacterizationOfTransaction,
	tr.bank				as BankOfPartner,
	tr.account			as AccountOfPartner,
	da.Frequency,
	da.DispositionType,
	da.CardType,
	da.Date
FROM silver.trans tr
LEFT JOIN gold.dim_account da
ON tr.account_id = da.AccountID
LEFT JOIN gold.dim_district ddt
ON da.DistrictID = ddt.DistrictID
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
	l.status				as LoanStatus,
	ddt.DistrictName,
	ddt.Region,
	ddt.AverageSalary,
	da.Frequency,
	da.DispositionType,
	da.CardType,
	da.Date
FROM silver.loan l
LEFT JOIN gold.dim_account da
ON l.account_id = da.AccountID
LEFT JOIN gold.dim_district ddt
ON da.DistrictID = ddt.DistrictID	
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
	o.k_symbol			as CharacterizationOfPayment,
	ddt.DistrictName,
	ddt.Region,
	da.Frequency,
	da.DispositionType,
	da.CardType,
	da.Date
FROM silver.orders o
LEFT JOIN gold.dim_account da
ON o.account_id = da.AccountID
LEFT JOIN gold.dim_district ddt
ON da.DistrictID = ddt.DistrictID
GO





