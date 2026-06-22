/* 
=========================================================================
Stored Procedure : Load Bronze Layer ( Source -> Bronze ) 
=========================================================================
Script Purpose 
      This stored procedure loads data into the bronze schema from external CSV files . 
      It perfroms the following actions : 
      - Truncates the bronze tables before loading data 
      - Uses the ' BULK INSERT; command to load data from csv files to bronze tables 
=========================================================================
*/

BULK INSERT bronze.account 
		From 'E:\Data_Analysis\CzechBankProject\datasets\account.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

BULK INSERT bronze.card
		From 'E:\Data_Analysis\CzechBankProject\datasets\card.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

BULK INSERT bronze.client 
		From 'E:\Data_Analysis\CzechBankProject\datasets\client.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

BULK INSERT bronze.disp 
		From 'E:\Data_Analysis\CzechBankProject\datasets\disp.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

Truncate table bronze.district;
BULK INSERT bronze.district 
		From 'E:\Data_Analysis\CzechBankProject\datasets\district.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)


BULK INSERT bronze.loan 
		From 'E:\Data_Analysis\CzechBankProject\datasets\loan.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

BULK INSERT bronze.orders 
		From 'E:\Data_Analysis\CzechBankProject\datasets\orders.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)

BULK INSERT bronze.trans 
		From 'E:\Data_Analysis\CzechBankProject\datasets\trans.csv'
		WITH (
			FIRSTROW = 2 ,
			FIELDTERMINATOR  = ';',
			TABLOCK
		)
