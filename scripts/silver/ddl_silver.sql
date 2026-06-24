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
	account_id		int, 
	district_id		int,
	frequency		nvarchar(50),
	date			date
);

IF OBJECT_ID ('silver.card', 'U') is not null 
	DROP TABLE silver.card;
Create table silver.card(
	card_id			int,
	disp_id			int,
	type			varchar(50),
	issued			date
);


IF OBJECT_ID ('silver.client', 'U') is not null 
	DROP TABLE silver.client;
Create table silver.client( 
	client_id		int,
	birth_number	int,
	district_id		int
)

IF OBJECT_ID ('silver.disp', 'U') is not null 
	DROP TABLE silver.disp;
Create table silver.disp(
	disp_id			int,
	client_id		int, 
	account_id		int,
	type			varchar(50)
)

IF OBJECT_ID ('silver.district', 'U') is not null 
	DROP TABLE silver.district;
Create table silver.district(
	A1				int,
	A2				nvarchar(50),
	A3				nvarchar(50),
	A4				int,
	A5				int, 
	A6				int,
	A7				int, 
	A8				int, 
	A9				int, 
	A10				decimal(5,2),
	A11				int, 
	A12				decimal(5,2),
	A13				decimal(5,2),
	A14				int,
	A15				int,
	A16				int
)

IF OBJECT_ID ('silver.loan', 'U') is not null 
	DROP TABLE silver.loan;
Create table silver.loan(
	loan_id			int,
	account_id		int,
	date			date,
	amount			int,
	duration		int,
	payments		decimal(19,2),
	status			varchar(50)
)

IF OBJECT_ID ('silver.orders', 'U') is not null 
	DROP TABLE silver.orders;
Create table silver.orders(
	order_id		int, 
	account_id		int, 
	bank_to			varchar(50),
	account_to		int, 
	amount			decimal(19,2),
	k_symbol		nvarchar(50)
)

IF OBJECT_ID ('silver.trans', 'U') is not null 
	DROP TABLE silver.trans;
Create table silver.trans(
	trans_id		int, 
	account_id		int, 
	date			date,
	type			nvarchar(50),
	operation		nvarchar(50),
	amount			decimal(19,2), 
	balance			decimal(19,2), 
	k_symbol		nvarchar(50),
	bank			nvarchar(50),
	account			int
) 
