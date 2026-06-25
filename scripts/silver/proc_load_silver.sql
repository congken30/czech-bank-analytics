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


Create or Alter Procedure silver.load_silver AS
Begin 
	Declare @start_time Datetime, @end_time Datetime
	Begin Try 
		print '============================================='
		print 'Deleting all Silver Layer (child -> parent)'
		print '============================================='
		DELETE FROM silver.card;
		DELETE FROM silver.disp;
		DELETE FROM silver.loan;
		DELETE FROM silver.orders;
		DELETE FROM silver.trans;
		DELETE FROM silver.account;
		DELETE FROM silver.client;
		DELETE FROM silver.district;
        PRINT '>> All tables deleted'
		
		print '============================================='
		print 'Loading Silver Layer (parent -> child)'
		print '============================================='

		print '                                           '
		print '-------------------------------------------'
	
		set @start_time = getdate();
		print '>> Inserting table : silver.district'
		Insert INTO silver.district(
			district_id,
			district_name,
			region,
			population,
			municipalities_1t500,
			municipalities_500t1999,
			municipalities_2000t9999,
			municipalities_gt10000,
			num_cities,
			urban_ratio,
			avg_salary,
			unemployment_rate_95,
			unemployment_rate_96,
			entrepreneurs_per_1000,
			crimes_95,
			crimes_96
		) 
		Select 
			A1									as district_id,
			REPLACE(A2,'"','')					as district_name,
			REPLACE(A3,'"','')					as region,
			A4									as population,
			A5									as municipalities_1t500,
			A6									as municipalities_500t1999,
			A7									as municipalities_2000t9999,
			A8									as municipalities_gt10000,
			A9									as num_cities,
			A10									as urban_ratio,
			A11									as avg_salary,
			TRY_CAST(A12 as decimal(5,2)) 		as unemployment_rate_95,
			A13									as unemployment_rate_96,
			A14									as entrepreneurs_per_1000,
			TRY_CAST(A15 as decimal(5,2))		as crimes_95,
			A16									as crimes_96
		From bronze.district
		set @end_time = getdate()
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		set @start_time = getdate()
		print '>> Inserting table : silver.account'
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
			date
		From bronze.account
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Inserting table : silver.client'
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
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Inserting table : silver.disp'
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
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Inserting table : silver.card'
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
			issued
		From bronze.card
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Loading table : silver.loan'
		INSERT INTO silver.loan (
			loan_id,
			account_id,
			date,
			amount,
			duration,
			payments,
			status
		) 
		Select 
			loan_id,
			account_id,
			date ,
			TRY_CAST(TRY_CAST(amount AS DECIMAL(18,2)) AS INT) AS amount,
			duration,
			TRY_CAST(TRY_CAST(payments AS DECIMAL(18,2)) AS INT) AS payments,
			Case
				When status = '"A"' then 'finished, no problems'
				When status = '"B"' Then 'finished, loan not payed'
				When status = '"C"' Then 'running, Ok so far'
				else 'running, in debt'
			End as status
		From bronze.loan
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Loading table : silver.orders'
		INSERT INTO silver.orders( 
			order_id,
			account_id,
			bank,
			account,
			amount,
			k_symbol
		) 
		Select 
			order_id,
			account_id,
			UPPER(replace(bank_to,'"',''))						as bank,
			replace(account_to,'"','')							as account,
			try_cast(try_cast(amount as decimal(10,2)) as int)	as amount,
			Case 
				When k_symbol = '"POJISTNE"' Then 'inssurrance payment'
				When k_symbol = '"SIPO"'	Then 'household'
				When k_symbol = '"LEASING"' Then 'leasing'
				When k_symbol = '"UVER"' Then 'loan payment'
				Else 'n/a'
			END
		From bronze.orders
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

		set @start_time = getdate();
		print '>> Loading table : silver.trans'
		INSERT INTO silver.trans(
			trans_id,
			account_id,
			date,
			type,
			operation,
			amount,
			balance,
			k_symbol,
			bank,
			account
		) 
		Select 
			trans_id,
			account_id,
			date,
			Case 
				When type = '"PRIJEM"' Then 'credit'
				Else 'withdrawal'
			End as type,
			Case operation	
				When '"VYBER"'			Then 'withdrawal in cash'
				When '"PREVOD NA UCET"'	Then 'remittance to another bank'
				When '"PREVOD Z UCTU"'	Then 'collection from another bank'
				When '"VKLAD"'			Then 'credit in cash'
				When '"VYBER KARTOU"'	Then 'credit card withdrawal'
				Else 'unkhown'
			END as operation,
			amount,
			balance,
			CASE k_symbol
				When '"DUCHOD"'			Then 'old-age pension'
				When '"SLUZBY"'			Then 'payment for statement'
				When '"UROK"'			Then 'interest credited'
				When '"UVER"'			Then 'loan payment'
				When '"SANKC. UROK"'	Then 'penalty Interest'
				When '"SIPO"'			Then 'household'
				When '"POJISTNE"'		Then 'insurrance payment'
				ELSE 'n/a'
			END as k_symbol,
			Case 
				WHEN bank = '""' then 'unknown'
				WHEN bank is null then 'unknown'
				ELSE replace(bank,'"','')
			END as bank,
			replace(account,'"','') as account
		From bronze.trans
		set @end_time = getdate();
		print '>>Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds'
		print '-------------------------------------------'

	END TRY
	BEGIN CATCH 
		Print '==============================='
		print 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message : ' + ERROR_Message();
		print 'Error Message : ' + CAST (ERROR_NUMBER() as nvarchar);
		print '==============================='
	END CATCH 
End
