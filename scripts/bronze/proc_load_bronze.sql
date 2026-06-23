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
Create or alter Procedure bronze.load_bronze AS 
Begin
	DECLARE @start_time Datetime, @end_time Datetime
	Begin try 
	print '====================='
	print 'Loading Bronze Layer'
	print '====================='

	set @start_time = getdate();
	print 'Truncating Table : bronze.account'
	Truncate table bronze.account;

	print 'Loading Table : bronze.account'
	BULK INSERT bronze.account 
			From 'E:\Data_Analysis\CzechBankProject\datasets\account.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'

	set @start_time = getdate();
	print 'Truncating Table : bronze.card'
	Truncate table bronze.card;

	print 'Loading Table : bronze.card'
	BULK INSERT bronze.card
			From 'E:\Data_Analysis\CzechBankProject\datasets\card.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'
	
	set @start_time = getdate();
	print 'Truncating Table : bronze.client'
	Truncate table bronze.client;

	print 'Loading Table : bronze.client'
	BULK INSERT bronze.client 
			From 'E:\Data_Analysis\CzechBankProject\datasets\client.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'
	
	set @start_time = getdate();
	print 'Truncating Table : bronze.disp'
	Truncate table bronze.disp;

	print 'Loading Table : bronze.disp'
	BULK INSERT bronze.disp 
			From 'E:\Data_Analysis\CzechBankProject\datasets\disp.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'
	
	set @start_time = getdate();
	print 'Truncating Table : bronze.district'
	Truncate table bronze.district;

	print 'Loading Table : bronze.district'
	BULK INSERT bronze.district 
			From 'E:\Data_Analysis\CzechBankProject\datasets\district.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'

	set @start_time = getdate();
	print 'Truncating Table : bronze.loan'
	Truncate table bronze.loan;

	print 'Loading Table : bronze.loan'
	BULK INSERT bronze.loan 
			From 'E:\Data_Analysis\CzechBankProject\datasets\loan.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'

	set @start_time = getdate();
	print 'Truncating Table : bronze.orders'
	Truncate table bronze.orders;

	print 'Loading Table : bronze.orders'
	BULK INSERT bronze.orders 
			From 'E:\Data_Analysis\CzechBankProject\datasets\orders.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'

	set @start_time = getdate();
	print 'Truncating Table : bronze.trans'
	Truncate table bronze.trans;

	print 'Loading Table : bronze.trans'
	BULK INSERT bronze.trans 
			From 'E:\Data_Analysis\CzechBankProject\datasets\trans.csv'
			WITH (
				FIRSTROW = 2 ,
				FIELDTERMINATOR  = ';',
				TABLOCK
			)
	set @end_time = getdate() 
	Print '>> Load Duration : ' + cast(datediff(second,@start_time, @end_time) as nvarchar) + 'seconds' 
	Print '                    '
	Print '>>------------------'

	End Try
	Begin Catch 
		Print '==============================='
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_Message();
		print 'Error Message' + CAST (ERROR_NUMBER() as nvarchar);
		print 'Error Message' + CAST (ERROR_NUMBER() as nvarchar);
		print '==============================='
	END CATCH
END
