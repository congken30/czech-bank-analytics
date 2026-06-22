/* 
====================================================================
DDL Script : Create Bronze Tables 
====================================================================
Script Purpose 
    This script create tables in the bronze schema, dropping 
    existing tables if they already exist 
    Run this script to re-define the DDL structure of bronze Tables
====================================================================
*/

IF OBJECT_ID ('bronze.account', 'U') is not null 
	DROP TABLE bronze.account;
Create Table bronze.account( 
	account_id		int, 
	district_id		int,
	frequency		nvarchar(50),
	date			date
);

IF OBJECT_ID ('bronze.card', 'U') is not null 
	DROP TABLE bronze.card;
Create table bronze.card(
	card_id			int,
	disp_id			int,
	type			varchar(50),
	issued			date
);


IF OBJECT_ID ('bronze.client', 'U') is not null 
	DROP TABLE bronze.client;
Create table bronze.client( 
	client_id		int,
	birth_number	date,
	district_id		int
)

IF OBJECT_ID ('bronze.disp', 'U') is not null 
	DROP TABLE bronze.disp;
Create table bronze.disp(
	disp_id			int,
	client_id		int, 
	account_id		int,
	type			varchar(50)
)

IF OBJECT_ID ('bronze.district', 'U') is not null 
	DROP TABLE bronze.district;
Create table bronze.district(
	A1				int,
	A2				nvarchar(50),
	A3				nvarchar(50),
	A4				int,
	A5				int, 
	A6				int,
	A7				int, 
	A8				int, 
	A9				int, 
	A10				float,
	A11				int, 
	A12				float,
	A13				float,
	A14				int,
	A15				int,
	A16				int
)

IF OBJECT_ID ('bronze.loan', 'U') is not null 
	DROP TABLE bronze.loan;
Create table bronze.loan(
	loan_id			int,
	account_id		int,
	date			date,
	amount			int,
	duration		int,
	payments		decimal
)

IF OBJECT_ID ('bronze.orders', 'U') is not null 
	DROP TABLE bronze.orders;
Create table bronze.orders(
	order_id		int, 
	account_id		int, 
	bank_to			varchar(10),
	account_to		int, 
	amount			decimal,
	k_symbol		varchar(50)
)

IF OBJECT_ID ('bronze.trans', 'U') is not null 
	DROP TABLE bronze.trans;
Create table bronze.trans(
	trans_id		int, 
	account_id		int, 
	date			date,
	type			varchar(50),
	operation		varchar(50),
	amount			decimal, 
	balance			decimal, 
	k_symbol		nvarchar(50),
	bank			varchar(10),
	account			int
) 
