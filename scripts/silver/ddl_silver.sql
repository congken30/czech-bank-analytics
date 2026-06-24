/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/


--Create schema silver;
IF OBJECT_ID ('silver.account', 'U') is not null 
	DROP TABLE silver.account;
Create Table silver.account( 
	account_id					int, 
	district_id					int,
	frequency					nvarchar(50),
	date						date
);

IF OBJECT_ID ('silver.card', 'U') is not null 
	DROP TABLE silver.card;
Create table silver.card(
	card_id						int,
	disp_id						int,
	type						varchar(50),
	issued						date
);


IF OBJECT_ID ('silver.client', 'U') is not null 
	DROP TABLE silver.client;
Create table silver.client( 
	client_id					int,
	birth_date					date,
	gender						varchar(10),
	district_id					int
)

IF OBJECT_ID ('silver.disp', 'U') is not null 
	DROP TABLE silver.disp;
Create table silver.disp(
	disp_id						int,
	client_id					int, 
	account_id					int,
	type						varchar(50)
)

IF OBJECT_ID ('silver.district', 'U') is not null 
	DROP TABLE silver.district;
Create table silver.district(
	district_id					int,
	district_name				nvarchar(50),
	region						nvarchar(50),
	population					int,
	municipalities_1t500		int, 
	municipalities_500t1999		int,
	municipalities_2000t9999	int, 
	municipalities_gt10000		int, 
	num_cities					int, 
	urban_ratio					decimal(5,2),
	avg_salary					int, 
	unemployment_rate_95		decimal(5,2),
	unemployment_rate_96		decimal(5,2),
	entrepreneurs_per_1000		int,
	crimes_95					int,
	crimes_96					int
)

IF OBJECT_ID ('silver.loan', 'U') is not null 
	DROP TABLE silver.loan;
Create table silver.loan(
	loan_id						int,
	account_id					int,
	date						date,
	amount						decimal(19,2),
	duration					int,
	payments					decimal(19,2),
	status						varchar(50)
)

IF OBJECT_ID ('silver.orders', 'U') is not null 
	DROP TABLE silver.orders;
Create table silver.orders(
	order_id					int, 
	account_id					int, 
	bank						varchar(50),
	account						int, 
	amount						decimal(19,2),
	k_symbol					nvarchar(50)
)

IF OBJECT_ID ('silver.trans', 'U') is not null 
	DROP TABLE silver.trans;
Create table silver.trans(
	trans_id					int, 
	account_id					int, 
	date						date,
	type						nvarchar(50),
	operation					nvarchar(50),
	amount						decimal(19,2), 
	balance						decimal(19,2), 
	k_symbol					nvarchar(50),
	bank						nvarchar(50),
	account						int
) 
