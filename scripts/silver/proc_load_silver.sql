/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
===============================================================================
*/


Insert into silver.account(
	account_id,
	district_id,
	frequency,
	date
) 
Select 
	account_id,
	district_id, 
	Case	
		when frequency = '"POPLATEK MESICNE"' then 'monthly issuance'
		when frequency = '"POPLATEK TYDNE"' then 'weekly issuance'
		else 'issuance after transaction' 
	End as Frequency,
	convert(varchar(10),cast(date as date),101) as Date
From bronze.account

Insert into silver.card(
	card_id,
	disp_id,
	type,
	issued
)
Select 
	card_id,
	disp_id,
	replace(type,'"',''), 
	convert(varchar(10),cast(issued as date),101) as Issued
From bronze.card

Insert into silver.client(
	client_id,
	district_id,
	birth_date,
	gender
)
Select 
	client_id,
	district_id,
	CASE
		when SUBSTRING(replace(birth_number,'"',''),3,2) >12 
			then RIGHT('0' + CAST(CAST(SUBSTRING(REPLACE(birth_number, '"', ''), 3, 2) AS INT) - 50 AS VARCHAR(2)), 2)
				+ '/' + SUBSTRING(replace(birth_number,'"',''),5,2)
				+ '/19' + SUBSTRING(replace(birth_number,'"',''),1,2)
		else substring(replace(birth_number,'"',''),3,2) 
				+ '/' + SUBSTRING(replace(birth_number,'"',''),5,2)
				+ '/19' + SUBSTRING(replace(birth_number,'"',''),1,2)
	End as birth_date,
	Case 
		when SUBSTRING(replace(birth_number,'"',''),3,2) >12  
			then 'Female'
		else 'Male'
	End as gender
From bronze.client

INSERT INTO silver.disp(
	disp_id,
	client_id,
	account_id,
	type
)
Select 
	disp_id,
	client_id,
	account_id,
	Case when type ='"OWNER"' then 'Owner'
		else 'Disponent' 
	End as type
From bronze.disp
