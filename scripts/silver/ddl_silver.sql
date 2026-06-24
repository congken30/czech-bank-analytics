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

-- ===============================
-- DROP theo thứ tự child → parent
-- ===============================
IF OBJECT_ID ('silver.card', 'U') is not null 
	DROP TABLE silver.card;
IF OBJECT_ID ('silver.disp', 'U') is not null 
	DROP TABLE silver.disp;
IF OBJECT_ID ('silver.loan', 'U') is not null 
	DROP TABLE silver.loan;
IF OBJECT_ID ('silver.orders', 'U') is not null 
	DROP TABLE silver.orders;
IF OBJECT_ID ('silver.trans', 'U') is not null 
	DROP TABLE silver.trans;
IF OBJECT_ID ('silver.account', 'U') is not null 
	DROP TABLE silver.account;
IF OBJECT_ID ('silver.client', 'U') is not null 
	DROP TABLE silver.client;
IF OBJECT_ID ('silver.district', 'U') is not null 
	DROP TABLE silver.district;

 -- ==============================
 -- CREATE TABLE WITH PK
 -- ==============================
Create Table silver.account( 
	account_id					int, 
	district_id					int,
	frequency					nvarchar(50),
	date						date,
	CONSTRAINT PK_account PRIMARY KEY (account_id),

);

Create table silver.card(
	card_id						int,
	disp_id						int,
	type						varchar(50),
	issued						date,
	CONSTRAINT PK_card PRIMARY KEY (card_id)
);

Create table silver.client( 
	client_id					int, 
	district_id					int,
	birth_date					date,
	gender						varchar(10),
	CONSTRAINT PK_client PRIMARY KEY (client_id)
)

Create table silver.disp(
	disp_id						int,
	client_id					int, 
	account_id					int,
	type						varchar(50),
	CONSTRAINT PK_disp PRIMARY KEY (disp_id)
)

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
	crimes_96					int,
	CONSTRAINT PK_district PRIMARY KEY (district_id)
)

Create table silver.loan(
	loan_id						int,
	account_id					int,
	date						date,
	amount						int,
	duration					int,
	payments					int,
	status						varchar(50)
	CONSTRAINT PK_loan PRIMARY KEY (loan_id)
)

Create table silver.orders(
	order_id					int, 
	account_id					int, 
	bank						varchar(50),
	account						int, 
	amount						int,
	k_symbol					nvarchar(50),
	CONSTRAINT PK_orders PRIMARY KEY (order_id)
)

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
	account						int,
	CONSTRAINT PK_trans PRIMARY KEY (trans_id)
) 

-- ============================
-- ADD FK for TABLE had PK
-- ============================

ALTER TABLE  silver.account 
	ADD CONSTRAINT FK_account_district FOREIGN KEY (district_id) REFERENCES silver.district(district_id);

ALTER TABLE silver.card 
	ADD CONSTRAINT FK_card_disp FOREIGN KEY (disp_id) REFERENCES silver.disp(disp_id)

ALTER TABLE silver.client 
	ADD CONSTRAINT FK_client_district FOREIGN KEY (district_id) REFERENCES silver.district(district_id);

ALTER TABLE silver.disp
	ADD CONSTRAINT FK_disp_client	FOREIGN KEY (client_id) REFERENCES silver.client(client_id);

ALTER TABLE silver.disp
	ADD CONSTRAINT FK_disp_account	FOREIGN KEY (account_id) REFERENCES silver.account(account_id);

ALTER TABLE silver.loan
	ADD CONSTRAINT FK_loan_account	FOREIGN KEY (account_id) REFERENCES silver.account(account_id);

ALTER TABLE silver.orders
	ADD CONSTRAINT FK_orders_account	FOREIGN KEY (account_id) REFERENCES silver.account(account_id);

ALTER TABLE silver.trans
	ADD CONSTRAINT FK_trans_account	FOREIGN KEY (account_id) REFERENCES silver.account(account_id);

