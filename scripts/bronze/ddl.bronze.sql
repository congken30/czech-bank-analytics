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

Create schema bronze;
go
IF OBJECT_ID ('bronze.account', 'U') is not null 
	DROP TABLE bronze.account;
Create Table bronze.account( 
	account_id		nvarchar(50), 
	district_id		nvarchar(50),
	frequency		nvarchar(50),
	date			nvarchar(50)
);

IF OBJECT_ID ('bronze.card', 'U') is not null 
	DROP TABLE bronze.card;
Create table bronze.card(
	card_id			nvarchar(50),
	disp_id			nvarchar(50),
	type			nvarchar(50),
	issued			nvarchar(50)
);


IF OBJECT_ID ('bronze.client', 'U') is not null 
	DROP TABLE bronze.client;
Create table bronze.client( 
	client_id		varchar(50),
	birth_number	nvarchar(50),
	district_id		varchar(50)
)

IF OBJECT_ID ('bronze.disp', 'U') is not null 
	DROP TABLE bronze.disp;
Create table bronze.disp(
	disp_id			nvarchar(50),
	client_id		nvarchar(50), 
	account_id		nvarchar(50),
	type			varchar(50)
)

IF OBJECT_ID ('bronze.district', 'U') is not null 
	DROP TABLE bronze.district;
Create table bronze.district(
	A1				nvarchar(50),
	A2				nvarchar(50),
	A3				nvarchar(50),
	A4				nvarchar(50),
	A5				nvarchar(50), 
	A6				nvarchar(50),
	A7				nvarchar(50), 
	A8				nvarchar(50), 
	A9				nvarchar(50), 
	A10				nvarchar(50),
	A11				nvarchar(50), 
	A12				nvarchar(50),
	A13				nvarchar(50),
	A14				nvarchar(50),
	A15				nvarchar(50),
	A16				nvarchar(50)
)

IF OBJECT_ID ('bronze.loan', 'U') is not null 
	DROP TABLE bronze.loan;
Create table bronze.loan(
	loan_id			nvarchar(50),
	account_id		nvarchar(50),
	date			nvarchar(50),
	amount			nvarchar(50),
	duration		nvarchar(50),
	payments		nvarchar(50)
)

IF OBJECT_ID ('bronze.orders', 'U') is not null 
	DROP TABLE bronze.orders;
Create table bronze.orders(
	order_id		nvarchar(50), 
	account_id		nvarchar(50), 
	bank_to			varchar(10),
	account_to		nvarchar(50), 
	amount			nvarchar(50),
	k_symbol		varchar(50)
)

IF OBJECT_ID ('bronze.trans', 'U') is not null 
	DROP TABLE bronze.trans;
Create table bronze.trans(
	trans_id		nvarchar(50), 
	account_id		nvarchar(50), 
	date			nvarchar(50),
	type			varchar(50),
	operation		varchar(50),
	amount			nvarchar(50), 
	balance			nvarchar(50), 
	k_symbol		nvarchar(50),
	bank			varchar(10),
	account			nvarchar(50)
) 
